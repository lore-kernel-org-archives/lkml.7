Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336DAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039B121916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254063;
	bh=pqNrOKLHXu85Zm58OEulXS69y81Wuf7zf0GOnx9SY9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0JheHzEp5bMVLMkmHmyeYXUdzuxmsHvNx5gmBp2YqjzaFP3KY0ym99xIYwSLsVs73
	 kEwcatU2PeKh1R/bk9chHj+uMBxsK72ofP9fGbBYgXMAnhEGQ9vLAgtYxqOrD7f63H
	 9OlLGKZVgvQUOf7aXUDdFoqUXWOOZeWeS1lcLjFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfCVL1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbfCVL1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:27:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E562183E;
        Fri, 22 Mar 2019 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254057;
        bh=pqNrOKLHXu85Zm58OEulXS69y81Wuf7zf0GOnx9SY9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQfL8fZwyYpftQWCBWWhph58zuWbBqxKItuIth8yY0jHk1HaAdpDrerHyslBMBwj8
         XHQmCYRnMOBiQuvifQI920vNQ7dg/yHInDeoqBAt05t8nV6fZ/x4A/K0CNY/08Jlna
         ko/70ZsahSMt00Zg9vJK3lmlNa0EaXMdajBl3Uro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 019/230] isdn: avm: Fix string plus integer warning from Clang
Date:   Fri, 22 Mar 2019 12:12:37 +0100
Message-Id: <20190322111238.090739217@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7afa81c55fca0cad589722cb4bce698b4803b0e1 ]

A recent commit in Clang expanded the -Wstring-plus-int warning, showing
some odd behavior in this file.

drivers/isdn/hardware/avm/b1.c:426:30: warning: adding 'int' to a string does not append to the string [-Wstring-plus-int]
                cinfo->version[j] = "\0\0" + 1;
                                    ~~~~~~~^~~
drivers/isdn/hardware/avm/b1.c:426:30: note: use array indexing to silence this warning
                cinfo->version[j] = "\0\0" + 1;
                                           ^
                                    &      [  ]
1 warning generated.

This is equivalent to just "\0". Nick pointed out that it is smarter to
use "" instead of "\0" because "" is used elsewhere in the kernel and
can be deduplicated at the linking stage.

Link: https://github.com/ClangBuiltLinux/linux/issues/309
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/hardware/avm/b1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/avm/b1.c b/drivers/isdn/hardware/avm/b1.c
index 4d9b195547c5c..df2a10157720a 100644
--- a/drivers/isdn/hardware/avm/b1.c
+++ b/drivers/isdn/hardware/avm/b1.c
@@ -423,7 +423,7 @@ void b1_parse_version(avmctrl_info *cinfo)
 	int i, j;
 
 	for (j = 0; j < AVM_MAXVERSION; j++)
-		cinfo->version[j] = "\0\0" + 1;
+		cinfo->version[j] = "";
 	for (i = 0, j = 0;
 	     j < AVM_MAXVERSION && i < cinfo->versionlen;
 	     j++, i += cinfo->versionbuf[i] + 1)
-- 
2.19.1



