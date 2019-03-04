Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AC3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EE120823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="UyPCFC2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfCDQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:58:05 -0500
Received: from imap.cs.msu.ru ([188.44.42.39]:58351 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfCDQ6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yqyfnkyE0jfpy0CabglIOwvEgtafMN5RypkZTK+XvVY=; b=UyPCFC2yYgUgG895CwrV9xiMZS
        EX/9kB/Q5iuvUCLmJU642MP2r3Ce2IfzejYzsRc1Fmu9P/GBU1pT0EnWSkMCq4FfML5VI3NceVh2I
        JHmam0bIWh42kOlvTpJEF1cu4Fk+cADALscFNKDx2mNtgf8xz+pos/3SBG6ruchvq/ZFD+cL03NV7
        Fy4pVPvIMhVjRlsCpoGh6gE1GHVMQf9N6rLod8LidlH0oMl1grn+0Fbi5BbvQbiLVY7qLONxq5j2i
        D2h66EgxZYMVV/885axnICD/eVPB7WHZOm+Z5rF/la+oPZdmUtlJVpcH9X99gr2ZOsdxff9gq7dGA
        X+djvTJg==;
Received: from [10.7.4.141] (port=59860 helo=cello.cs.msu.ru)
        by mail.cs.msu.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1h0quO-000JP0-Sp; Mon, 04 Mar 2019 19:57:44 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Arseny Maslennikov <ar@cs.msu.ru>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Date:   Mon,  4 Mar 2019 19:57:32 +0300
Message-Id: <20190304165732.24043-4-ar@cs.msu.ru>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190304165732.24043-1-ar@cs.msu.ru>
References: <20190304165732.24043-1-ar@cs.msu.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 10.7.4.141
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH 3/3] arch/um/kernel/Makefile: use KCONFIG_CONFIG
X-SA-Exim-Version: 4.2
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the config file is reassigned through the KCONFIG_CONFIG
makeflag/envvar, this rule still attempts to use the wrong, possibly
nonexistent file.
Let's fix that.

Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 arch/um/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 2f36d515762e..f5afd186a0ab 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -35,7 +35,7 @@ targets := config.c config.tmp
 # Be careful with the below Sed code - sed is pitfall-rich!
 # We use sed to lower build requirements, for "embedded" builders for instance.
 
-$(obj)/config.tmp: $(objtree)/.config FORCE
+$(obj)/config.tmp: $(objtree)/$(KCONFIG_CONFIG) FORCE
 	$(call if_changed,quote1)
 
 quiet_cmd_quote1 = QUOTE   $@
-- 
2.20.1

