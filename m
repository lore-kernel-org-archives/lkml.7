Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED14CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CB620830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141099;
	bh=o6x2mj/rbjsGf5WNDcbNjeRE/U9FTuXTJlQxV5OU3/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zV3M325tHMC+lyVgS/V6lnjbHLaRmTqtEVMKEtXQxs6c04A8bu8jQDzXf/vKtwpnp
	 Zftf2VR19W6c2QPDPQlcDOqVFtCt4Pd4XZhJouk9KsfLt1k0Tm59uve18NuZ/LgzSz
	 oqvCEwOvie9rMYd8GMzqztWolkhR3ElfHQ98RoUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbfDARvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:32924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731930AbfDAR1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:27:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41CD620830;
        Mon,  1 Apr 2019 17:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139654;
        bh=o6x2mj/rbjsGf5WNDcbNjeRE/U9FTuXTJlQxV5OU3/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o+CmP/2oA/F5SjAz+802OgEq8powNUty2FMpMftmkJQ+Ki4vMqPltTXql3QjVOCBy
         9OIjqDqe8UBZuvUN6zsLJJVPWL+DYMxAYYO8jaVp8Df96to56ImAAT78Nx1mGPVYKk
         I1hJ8l3bPdBerOKlZ5SMZXHo4FCZ33iEWp7DFH/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 30/56] scsi: zfcp: fix rport unblock if deleted SCSI devices on Scsi_Host
Date:   Mon,  1 Apr 2019 19:02:46 +0200
Message-Id: <20190401170105.585503424@linuxfoundation.org>
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

From: Steffen Maier <maier@linux.ibm.com>

commit fe67888fc007a76b81e37da23ce5bd8fb95890b0 upstream.

An already deleted SCSI device can exist on the Scsi_Host and remain there
because something still holds a reference.  A new SCSI device with the same
H:C:T:L and FCP device, target port WWPN, and FCP LUN can be created.  When
we try to unblock an rport, we still find the deleted SCSI device and
return early because the zfcp_scsi_dev of that SCSI device is not
ZFCP_STATUS_COMMON_UNBLOCKED. Hence we miss to unblock the rport, even if
the new proper SCSI device would be in good state.

Therefore, skip deleted SCSI devices when iterating the sdevs of the shost.
[cf. __scsi_device_lookup{_by_target}() or scsi_device_get()]

The following abbreviated trace sequence can indicate such problem:

Area           : REC
Tag            : ersfs_3
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x40000000     not ZFCP_STATUS_COMMON_UNBLOCKED
Ready count    : n		not incremented yet
Running count  : 0x00000000
ERP want       : 0x01
ERP need       : 0xc1		ZFCP_ERP_ACTION_NONE

Area           : REC
Tag            : ersfs_3
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x41000000
Ready count    : n+1
Running count  : 0x00000000
ERP want       : 0x01
ERP need       : 0x01

...

Area           : REC
Level          : 4		only with increased trace level
Tag            : ertru_l
LUN            : 0x4045400300000000
WWPN           : 0x50050763031bd327
LUN status     : 0x40000000
Request ID     : 0x0000000000000000
ERP status     : 0x01800000
ERP step       : 0x1000
ERP action     : 0x01
ERP count      : 0x00

NOT followed by a trace record with tag "scpaddy"
for WWPN 0x50050763031bd327.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Fixes: 6f2ce1c6af37 ("scsi: zfcp: fix rport unblock race with LUN recovery")
Cc: <stable@vger.kernel.org> #2.6.32+
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/scsi/zfcp_erp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1306,6 +1306,9 @@ static void zfcp_erp_try_rport_unblock(s
 		struct zfcp_scsi_dev *zsdev = sdev_to_zfcp(sdev);
 		int lun_status;
 
+		if (sdev->sdev_state == SDEV_DEL ||
+		    sdev->sdev_state == SDEV_CANCEL)
+			continue;
 		if (zsdev->port != port)
 			continue;
 		/* LUN under port of interest */


