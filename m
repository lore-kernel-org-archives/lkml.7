Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3407C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9A21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254157;
	bh=ve1CPQXxMolq+3dhYLCIFSrl5uGb5cXVgOJvhWsZBxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYRiFdI3vE3qxnLWv7saGb18la0K904laqHgqGZThleitpLfIkv0DhOKqUvyWSiA+
	 VK12COrxCpFc+96NVlxrAPuMusZTlMjRFZrGUa86ql2K9xB6yvZEFQMlY/IZwPP48j
	 ys+opnRUyxna9sWnXGbaP6pNLz/1AdylXXzioSfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfCVL3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfCVL3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:29:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2CE9218B0;
        Fri, 22 Mar 2019 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254150;
        bh=ve1CPQXxMolq+3dhYLCIFSrl5uGb5cXVgOJvhWsZBxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=neURsAQ9BXcseFWPznVvB4P6bb8ruRHDvQisPU7tf2qeYvl7bQiUGiOwR8lh9jvJR
         e25sDXR7qdfodkVpHoG/k1oIRWXrWsL131m1QuYFC1MUTRsGYaTbDvBXh4C8a0ZX6M
         SH8hoTczIbCCWh/Q49fqo41TK6VP/yIc0uQkmjPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, dann frazier <dann.frazier@canonical.com>,
        John Garry <john.garry@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 031/230] scsi: libsas: Fix rphy phy_identifier for PHYs with end devices attached
Date:   Fri, 22 Mar 2019 12:12:49 +0100
Message-Id: <20190322111238.882936562@linuxfoundation.org>
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

From: John Garry <john.garry@huawei.com>

commit ffeafdd2bf0b280d67ec1a47ea6287910d271f3f upstream.

The sysfs phy_identifier attribute for a sas_end_device comes from the rphy
phy_identifier value.

Currently this is not being set for rphys with an end device attached, so
we see incorrect symlinks from systemd disk/by-path:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root 10 Feb 13 12:26 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy0-lun-0-part3 -> ../../sdc3

Indeed, each sas_end_device phy_identifier value is 0:

root@localhost:/# more sys/class/sas_device/end_device-0\:0\:2/phy_identifier
0
root@localhost:/# more sys/class/sas_device/end_device-0\:0\:10/phy_identifier
0

This patch fixes the discovery code to set the phy_identifier.  With this,
we now get proper symlinks:

root@localhost:~# ls -l /dev/disk/by-path/
total 0
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy10-lun-0 -> ../../sdg
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy11-lun-0 -> ../../sdh
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0 -> ../../sda
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy2-lun-0-part1 -> ../../sda1
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0 -> ../../sdb
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part1 -> ../../sdb1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy3-lun-0-part2 -> ../../sdb2
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0 -> ../../sdc
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part1 -> ../../sdc1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part2 -> ../../sdc2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy4-lun-0-part3 -> ../../sdc3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy5-lun-0 -> ../../sdd
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0 -> ../../sde
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part1 -> ../../sde1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part2 -> ../../sde2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy7-lun-0-part3 -> ../../sde3
lrwxrwxrwx 1 root root  9 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0 -> ../../sdf
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part1 -> ../../sdf1
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part2 -> ../../sdf2
lrwxrwxrwx 1 root root 10 Feb 13 11:53 platform-HISI0162:01-sas-exp0x500e004aaaaaaa1f-phy8-lun-0-part3 -> ../../sdf3

Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
Reported-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
Tested-by: dann frazier <dann.frazier@canonical.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/libsas/sas_expander.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -818,6 +818,7 @@ static struct domain_device *sas_ex_disc
 		rphy = sas_end_device_alloc(phy->port);
 		if (!rphy)
 			goto out_free;
+		rphy->identify.phy_identifier = phy_id;
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
@@ -845,6 +846,7 @@ static struct domain_device *sas_ex_disc
 
 		child->rphy = rphy;
 		get_device(&rphy->dev);
+		rphy->identify.phy_identifier = phy_id;
 		sas_fill_in_rphy(child, rphy);
 
 		list_add_tail(&child->disco_list_node, &parent->port->disco_list);


