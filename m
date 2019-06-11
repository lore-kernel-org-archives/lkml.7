Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A71C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9CF2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560277025;
	bh=e1oTDI3Pejj9+0XFK80nYazQL/qYQ/BR/K6hwnplwzQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=e3MvlnZF4mlboR4rKwMXu7nElkNK68HI5f9Rg2qtZu7vLYEOE95ySIyHPQp2DA0PM
	 LTHjvEWmJhh69v5hOOOJTmiFeRskX5dHZfK2ffuE9AZ0MT6UExXSM4L5xGq0P8LM/7
	 Jl7TpsJu6FuXkn5wUI5yz+lnbdGTVVlgC0kgKilA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406987AbfFKSRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405802AbfFKSRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:17:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8972421734;
        Tue, 11 Jun 2019 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560277023;
        bh=e1oTDI3Pejj9+0XFK80nYazQL/qYQ/BR/K6hwnplwzQ=;
        h=Date:From:To:Cc:Subject:From;
        b=FqzF+nr1P6cjQPxoxmO2J/gPGs4v0/DYxqHZvkWcfIreJ52wzBYDiqGyTH95U/a6v
         0kWiW656tTbyQnYv7GBtOdhhUIefhShFMAi1AMF6i+cSMJrxxt4+xWD2hrzaKOUYov
         OHrkaUf+thNK0FgyxagL3749YmtX+ZTWsQVDrJms=
Date:   Tue, 11 Jun 2019 20:17:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: idt_89hpesx: remove unneeded csr_file variable
Message-ID: <20190611181700.GA18599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The csr_file variable was only ever set, never read.  So remove it from
struct idt_89hpesx_dev as it is pointless to keep around.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/eeprom/idt_89hpesx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/idt_89hpesx.c b/drivers/misc/eeprom/idt_89hpesx.c
index 8a4659518c33..81c70e5bc168 100644
--- a/drivers/misc/eeprom/idt_89hpesx.c
+++ b/drivers/misc/eeprom/idt_89hpesx.c
@@ -115,7 +115,6 @@ static struct dentry *csr_dbgdir;
  * @client:	i2c client used to perform IO operations
  *
  * @ee_file:	EEPROM read/write sysfs-file
- * @csr_file:	CSR read/write debugfs-node
  */
 struct idt_smb_seq;
 struct idt_89hpesx_dev {
@@ -137,7 +136,6 @@ struct idt_89hpesx_dev {
 
 	struct bin_attribute *ee_file;
 	struct dentry *csr_dir;
-	struct dentry *csr_file;
 };
 
 /*
@@ -1378,8 +1376,8 @@ static void idt_create_dbgfs_files(struct idt_89hpesx_dev *pdev)
 	pdev->csr_dir = debugfs_create_dir(fname, csr_dbgdir);
 
 	/* Create Debugfs file for CSR read/write operations */
-	pdev->csr_file = debugfs_create_file(cli->name, 0600,
-		pdev->csr_dir, pdev, &csr_dbgfs_ops);
+	debugfs_create_file(cli->name, 0600, pdev->csr_dir, pdev,
+			    &csr_dbgfs_ops);
 }
 
 /*
-- 
2.22.0

