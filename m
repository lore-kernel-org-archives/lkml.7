Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B5CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C9D206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 09:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBegs+cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfECJPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 05:15:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35514 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECJPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 05:15:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id y197so5839614wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 02:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4MP2EuBBV8F+L87gAV+VVeC6FuZ7A9Ie58x77Jd4DA=;
        b=fBegs+czbUd4cenk25abmkj/0agBb3A83K482HJH/V539eZouzfSyBycDHcXG4dfu0
         P/5c2oTcJixd570WZfnszYWUsYnJKTyZ8XtuP/ADUHh557rpY0x6CteczGxL/DvIQLZB
         9N97pJ5rwot575rN64NnzcJJndxpDpkDolnmtmQC9WSKsKlpjbXBSZKWRTEeYQ5JynJr
         XGV6qA6W29e48iQ3QNeQHeY/IHOi0wbIkptlir4ym0Hg9MsD/DXk6bODFuquvHIhrmv3
         xucbWDEm1HJpQnLolIlb8fH+MJSF7K2P/cd/sbC6u3QXlmVh98SBRtU7yF6BVLSPW2cT
         Mabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H4MP2EuBBV8F+L87gAV+VVeC6FuZ7A9Ie58x77Jd4DA=;
        b=SvM146aMiXMD2lDczzs7QMtQdBNttiFUfbs8OPwS8RC2/XhIErfE2F88K7c5pSavu3
         HtXr2fLQLc2cY/yTiQtINK6dCdnZD1rxTa+xx2gFkiP9FANG5aj0Ox6HP9nitlKSbhnt
         vmPeGgUZuNN7eP9c33mbYbQd0ww0ZANv1AJcRULLvrVlCSqd6NQ6lv26an70NA3NRN9N
         Xjc49DF+V14bl9RG3yiinmb5/HmxY35R4Qx1uU3FiwUcAFQkGCWyR3jqpgHz/5jX+QoS
         +zm8ZTRKBxT9/XZArD/I7ILLUCPulGnAxvjJAyuCv1BLiCStF9EfRQRAvMFVI6KzsQBh
         l1YQ==
X-Gm-Message-State: APjAAAVf9qKaOgj76ImhPEW0srP6BKR+QW3Z81ThtbckcM9XvLuBVNOk
        ZIdERX2n5yUmlHYKF+xZ6bc=
X-Google-Smtp-Source: APXvYqzKgaVg7lZU8MuOZ4oIJ3hk0VTUHGSAvvSxK3pM6tKCiX+o0c0tdOPuyhL2EZAzTQj9BIXXaQ==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr5385920wmz.103.1556874932134;
        Fri, 03 May 2019 02:15:32 -0700 (PDT)
Received: from SiBook.guest.pepperl-fuchs.local ([80.150.243.190])
        by smtp.gmail.com with ESMTPSA id v184sm2346870wma.6.2019.05.03.02.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 02:15:31 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Dalon Westergreen <dalon.westergreen@linux.intel.com>,
        Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm: socfpga: execute cold reboot by default
Date:   Fri,  3 May 2019 11:15:07 +0200
Message-Id: <20190503091507.6159-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This changes system reboot for socfpga to issue a cold reboot by
default instead of a warm reboot.

Warm reboot can still be used by setting reboot_mode to
REBOOT_WARM (e.g. via kernel command line 'reboot='), but this
patch ensures cold reboot is issued for both REBOOT_COLD and
REBOOT_HARD.

Also, cold reboot is more fail safe than warm reboot has some
issues at least fo CSEL=0 and BSEL=qspi, where the boot rom does
not set the qspi clock to a valid range.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

See discussion in this thread on the u-boot ML:
https://lists.denx.de/pipermail/u-boot/2019-April/367463.html
---
 arch/arm/mach-socfpga/socfpga.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-socfpga/socfpga.c b/arch/arm/mach-socfpga/socfpga.c
index 816da0eb6..6abfbf140 100644
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@ -85,10 +85,10 @@ static void socfpga_cyclone5_restart(enum reboot_mode mode, const char *cmd)
 
 	temp = readl(rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 
-	if (mode == REBOOT_HARD)
-		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
-	else
+	if (mode == REBOOT_WARM)
 		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
 	writel(temp, rst_manager_base_addr + SOCFPGA_RSTMGR_CTRL);
 }
 
@@ -98,10 +98,10 @@ static void socfpga_arria10_restart(enum reboot_mode mode, const char *cmd)
 
 	temp = readl(rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
 
-	if (mode == REBOOT_HARD)
-		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
-	else
+	if (mode == REBOOT_WARM)
 		temp |= RSTMGR_CTRL_SWWARMRSTREQ;
+	else
+		temp |= RSTMGR_CTRL_SWCOLDRSTREQ;
 	writel(temp, rst_manager_base_addr + SOCFPGA_A10_RSTMGR_CTRL);
 }
 
-- 
2.20.1

