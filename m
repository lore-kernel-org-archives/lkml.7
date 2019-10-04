Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E207C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155242133F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 20:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSCRHQ56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfJDUD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 16:03:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38273 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfJDUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 16:03:27 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so16194075iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=O+TCr5SG4kChCyM+zaHk2lgF+HdV26aL5mQf8M42AdE=;
        b=VSCRHQ56c4XhzYv7CLTfM3OnNPdD5OVtmS7+kY1Lw6oeHDfHshmI2nap1B80XFNMCn
         s4yaCW8Ww/ZssupTKdWYV6BNP4fZwnBPRmT+XhDDEPNVUx+EBIZD07jZXw4MzRuwOV8m
         yblCCDRx8rhOTtEGC8TiCrQ7GdF68IL4Wb8KWXXp4ilPcII9og79AFjT+gJE0k2Se2GE
         4n5s2HjTD0kZZrqKMvsU+Ol+jY0j46ZrSd3DjZPNlUkK1sQrdb9stJkb7sMvX1ZkShR4
         MOcuT6pMlKcOHzkgxS4oG/DuvINmOX8e9bos1sTOKwOmaduRUERmJpPQM//O8b1/EInh
         HMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O+TCr5SG4kChCyM+zaHk2lgF+HdV26aL5mQf8M42AdE=;
        b=gjsj0yujjQZO5GZcM3DxyhbcrIgAPG9XAo+iIJHnZ35cfhUkrISt9xxX/+oxY4HHps
         +CZIiQ1DhmbNaE0llbBK/enHI3th7OGOraJZ2KzOHQ11kxEipcx6h8+65KCMiQVrDYY9
         9ljgZM1UwFSIXc3EMmw02ZP7Oc4GTYbUEkCMsC2dGzm0jEyVgam2wIXdCojuKCxe7jfp
         EaOD3zfBxgWaZ12OA/de5sKHmzin2KgBooyGfOxqLUNnM5Zeq8twD/np8UFwoTXzM0Jx
         1cckB8tMZLSMW95RC2AFESonldGlucsYCERdtDRavj15ElXWrDqh7HFtCKZqjMig/mZF
         8yRA==
X-Gm-Message-State: APjAAAU4GGBTYfGyb8QaXwNbAXJd9E4Q1VuZwRfxYBshD81rwL37wvgV
        KZ5SIpOB/EJCgXxnJFq6QLE=
X-Google-Smtp-Source: APXvYqxjDwU/P4QSCXivlvgCVOFCH3GdEh3D94AO3mK9ZY40YftqgS+Czs7elZIkIojhic/PNi4gqw==
X-Received: by 2002:a92:c806:: with SMTP id v6mr17304830iln.147.1570219406760;
        Fri, 04 Oct 2019 13:03:26 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id t9sm2429900iop.86.2019.10.04.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 13:03:26 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Fix memory leak in vt6655_probe
Date:   Fri,  4 Oct 2019 15:03:15 -0500
Message-Id: <20191004200319.22394-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vt6655_probe, if vnt_init() fails the cleanup code needs to be called
like other error handling cases. The call to device_free_info() is
added.

Fixes: 67013f2c0e58 ("staging: vt6655: mac80211 conversion add main mac80211 functions")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index c6bb4aaf9bd0..082302944c37 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1748,8 +1748,10 @@ vt6655_probe(struct pci_dev *pcid, const struct pci_device_id *ent)
 
 	priv->hw->max_signal = 100;
 
-	if (vnt_init(priv))
+	if (vnt_init(priv)) {
+		device_free_info(priv);
 		return -ENODEV;
+	}
 
 	device_print_info(priv);
 	pci_set_drvdata(pcid, priv);
-- 
2.17.1

