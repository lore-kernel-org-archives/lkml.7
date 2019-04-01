Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD6C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678A920896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141012;
	bh=WrzdGvbdP2fgSiUUJ4pbWs+CePiO2B392Vg5i0+UIC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hLGZbynJ+ojoVeyXSerLmeG8PY2aN7RkvIXFBuqJ3YEf9pSX4F3JOCtqUWYd++11c
	 NIP8Atk9670o8Q3wK3C+Mz2wKUeRnCJDhjgBxic4XHBu/FemsGZFuIQqiGozAtLZQJ
	 l8rYFvfwYBKRtippFOwEvAm6ozEZE5/nOWTp2oOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732881AbfDAR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732869AbfDAR25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E451E2063F;
        Mon,  1 Apr 2019 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139737;
        bh=WrzdGvbdP2fgSiUUJ4pbWs+CePiO2B392Vg5i0+UIC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lKTJ2vXsgPdfgMY8YaVs34OJxUMwbDJ5rKkaGY9rm2sp+0M6Ez3wIkZpBQIBr82Rt
         vF4FGALJm5+sAn7j8s2J2vtJYyaCazape5lEc0ItQfdbEA/10b3yJeCNWYjXQddhxJ
         MkNaU/pCTJko43DnjvYvhvIanjMEOcfJqBKiR6/s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 56/56] arm64: support keyctl() system call in 32-bit mode
Date:   Mon,  1 Apr 2019 19:03:12 +0200
Message-Id: <20190401170106.939490935@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5c2a625937ba49bc691089370638223d310cda9a ]

As is the case for a number of other architectures that have a 32-bit
compat mode, enable KEYS_COMPAT if both COMPAT and KEYS are enabled.
This allows AArch32 programs to use the keyctl() system call when
running on an AArch64 kernel.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3e43874568f9..2eb8ae1b2d03 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1079,6 +1079,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 endmenu
 
 menu "Power management options"
-- 
2.19.1



