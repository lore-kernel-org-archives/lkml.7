Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350C1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A76214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239649;
	bh=2mGqoX6FAGM5sBwdslHPp6bbqh5CBhXcNDWgI5fLKL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tEqGzOC2yQ6MfLMfxXshQTSQi19k8koOl5lAsozS/ZCdwCT8hK+qBsQnIr8CP3iUL
	 HKoOsmYyBmbJgkTwsS5rwZ8mKaHHWbb5mZ8kYUd3Pfp9GuMwz8f+eolfxjkm21EFlt
	 aTBxW6IXpzRXNKzaWzuwo1TQhxa6rwUslKKRG81Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389945AbfKHTAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389769AbfKHTAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0C32067B;
        Fri,  8 Nov 2019 19:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239633;
        bh=2mGqoX6FAGM5sBwdslHPp6bbqh5CBhXcNDWgI5fLKL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neaSXm3/igqg0/FQfvetPdTHpDeiPFbPUrxY+dBrCp8PXMdAX8rVD5VSAh4b0DzH+
         8MA5Tclx0a3lt8Z1avy5pUi5GZLvER/zkICXBieJotUO23A2xwJZmJBaNOqpiBNQHU
         JWr/zKcrqVJXT33yS01HtpYlABAMAYj0REfPoj8o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 01/79] kbuild: add -fcf-protection=none when using retpoline flags
Date:   Fri,  8 Nov 2019 19:49:41 +0100
Message-Id: <20191108174746.110230059@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seth Forshee <seth.forshee@canonical.com>

[ Upstream commit 29be86d7f9cb18df4123f309ac7857570513e8bc ]

The gcc -fcf-protection=branch option is not compatible with
-mindirect-branch=thunk-extern. The latter is used when
CONFIG_RETPOLINE is selected, and this will fail to build with
a gcc which has -fcf-protection=branch enabled by default. Adding
-fcf-protection=none when building with retpoline enabled
prevents such build failures.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 6af1c13d8753b..729467fe0933f 100644
--- a/Makefile
+++ b/Makefile
@@ -835,6 +835,12 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 # change __FILE__ to the relative path from the srctree
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
+# ensure -fcf-protection is disabled when using retpoline as it is
+# incompatible with -mindirect-branch=thunk-extern
+ifdef CONFIG_RETPOLINE
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+endif
+
 # use the deterministic mode of AR if available
 KBUILD_ARFLAGS := $(call ar-option,D)
 
-- 
2.20.1



