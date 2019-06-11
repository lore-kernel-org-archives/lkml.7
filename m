Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D2C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C316A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560278707;
	bh=lrKAmFdOU8h66+U4Es5y8xQzLQ2sUZtxRlrzObRJ7II=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CqC/Y3rZeXZ97Q47WJdDXsEAhGgwxhUd8Biy7FIBWaK0zVyc5CCkKXC4Umh6FXSk6
	 FrDIEFW9FppDYw9f+9eIwerIU7RCzR5shZ8eRMCGdFLIVdlLvY4BiBETPRCrwC3aoi
	 QmlhDTSPcKpGKdyEsoYEznUON7A0qmEqR85rOVTY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbfFKSpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392016AbfFKSpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:45:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C329217F4;
        Tue, 11 Jun 2019 18:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560278706;
        bh=lrKAmFdOU8h66+U4Es5y8xQzLQ2sUZtxRlrzObRJ7II=;
        h=Date:From:To:Cc:Subject:From;
        b=UdhhQ3VThGcK+CWp9Hko77z9NA+RloZzgfoAngP0NZl8Y90fNLCCkHKwQ+YvJ89DO
         UZdyCZp1eCnOEKP4XhdEp6ViopxjX+1L0VenIOHT5qISe7gFE3eq2Fyf3wXNHI5cgh
         mO29/+x3pkKY6HBJ52aEYRjknA9Ls7EN3hIH1wpU=
Date:   Tue, 11 Jun 2019 20:45:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ti-st: no need to check return value of debugfs_create
 functions
Message-ID: <20190611184503.GA3212@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/ti-st/st_kim.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/misc/ti-st/st_kim.c b/drivers/misc/ti-st/st_kim.c
index e7cfdbd1f66d..93821c11bff9 100644
--- a/drivers/misc/ti-st/st_kim.c
+++ b/drivers/misc/ti-st/st_kim.c
@@ -761,10 +761,6 @@ static int kim_probe(struct platform_device *pdev)
 	pr_info("sysfs entries created\n");
 
 	kim_debugfs_dir = debugfs_create_dir("ti-st", NULL);
-	if (!kim_debugfs_dir) {
-		pr_err(" debugfs entries creation failed ");
-		return 0;
-	}
 
 	debugfs_create_file("version", S_IRUGO, kim_debugfs_dir,
 				kim_gdata, &version_fops);
-- 
2.22.0

