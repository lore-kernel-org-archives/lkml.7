Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B54C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B565A207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TPrScBUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbfDBJmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:42:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:33279 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfDBJmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:42:50 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190402094246epoutp0496c81e936c4baa51f7c096829bb650a6~Rnv_PI0yr1465314653epoutp04M;
        Tue,  2 Apr 2019 09:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190402094246epoutp0496c81e936c4baa51f7c096829bb650a6~Rnv_PI0yr1465314653epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1554198166;
        bh=sV+wHCIx2omDN0w8NI11YAW5YNllVBoH56lTezfI8F8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TPrScBUA989c2YHZrxs2c7rdIZqaCER7E7RdawsA+XD9sgUDO+LBWCQkFMd8mzfLT
         uikvAn2dvlThXwaYb8xX0nZA4gdhfNEpBfFa+lXR2c0kjrGyJmAlpN4HXSmMxCW19w
         ggsArMMD3h35MO9MR0RZRj+RbvQgOAlCxs+eK4ok=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190402094246epcas1p358f76052d9ac8112b189f2bb6f2d1a41~Rnv_BJZvN1616816168epcas1p3p;
        Tue,  2 Apr 2019 09:42:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5B.8D.04257.69E23AC5; Tue,  2 Apr 2019 18:42:46 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89~Rnv90CZKu0669806698epcas1p1y;
        Tue,  2 Apr 2019 09:42:46 +0000 (GMT)
X-AuditID: b6c32a38-5e3ff700000010a1-6f-5ca32e96f7b3
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 29.3E.03598.69E23AC5; Tue,  2 Apr
        2019 18:42:46 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net ([107.116.255.97]) by
        mmp2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PPB003NUUZ2H540@mmp2.samsung.com>;
        Tue, 02 Apr 2019 18:42:46 +0900 (KST)
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        jingoohan1@gmail.com, krzk@kernel.org, mgautam@codeaurora.org,
        robin.murphy@arm.com, felipe.balbi@linux.intel.com,
        Sriram Dash <sriram.dash@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH] usb: xhci: inherit dma_mask from bus if set correctly
Date:   Tue, 02 Apr 2019 15:10:11 +0530
Message-id: <1554198011-24342-1-git-send-email-pankaj.dubey@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmru40vcUxBt8OKVvMv5lk0bx4PZvF
        ii8z2S3On9/AbnF51xw2i0XLWpktmjdNYbX4/HESkLv1C7vFwQ9PWC1urGd34PZYM28No8fl
        vl4mj52z7rJ7LN7zkslj06pONo95JwM99s9dw+7Rt2UVo8fnTXIBnFFcNimpOZllqUX6dglc
        Gf2XzrMW7OOsuN5e28D4gr2LkZNDQsBEYva+VsYuRi4OIYEdjBIn/h9hhnC+M0os3f0QrmrP
        tGUsILaQwAZGid/f3SGKOpkkXj1vZQZJsAnoSjx5PxfI5uAQEbCW6DsYBFLDLNDAJPF9Whcb
        SI2wgJvE83X9YINYBFQljvz/wQRi8wp4SGxYc5MVYpmcxM1znWBXSAisYJOYNnEu1BUuEmsO
        n2YEWSAhIC1x6agtRDhf4sfiSVD1LYwSk4/PhRpkL3HgyhywZcwCfBLvvvawQvTySnS0CUGU
        eEj87HjBCPFYrETT2YvsExjFFzAyrGIUSy0ozk1PLTYsMNErTswtLs1L10vOz93ECI5JLYsd
        jHvO+RxiFOBgVOLhjRBaFCPEmlhWXJl7iFGCg1lJhPdM/4IYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzrHZxjhATSE0tSs1NTC1KLYLJMHJxSDYy61/cpRl1UlA2Qd985O8VQf8X1QE3HoG8v
        X2Uvv5xvZeTDcUdU5+R7gdVH8+wV/zsycd+Ywcmx9/WBzjPS+5ibnQT+ioVVG2RmLXu1Vowl
        aW+F8XG/9fPkby1qypmSaPlGI3FzXd//gLWuVfNsji3+avLXbgJTuZEuq9lDJ4XoR61XtbfN
        3K/EUpyRaKjFXFScCAAqn3KIxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsVy+t9jQd1peotjDHr/iljMv5lk0bx4PZvF
        ii8z2S3On9/AbnF51xw2i0XLWpktmjdNYbX4/HESkLv1C7vFwQ9PWC1urGd34PZYM28No8fl
        vl4mj52z7rJ7LN7zkslj06pONo95JwM99s9dw+7Rt2UVo8fnTXIBnFFcNimpOZllqUX6dglc
        Gf2XzrMW7OOsuN5e28D4gr2LkZNDQsBEYs+0ZSxdjFwcQgLrGCV+7GtghnC6mSR+vukDq2IT
        0JV48n4uUIKDQ0TAWqLvYBBIDbNAA5PEh54PzCA1wgJuEs/X9bOA2CwCqhJH/v9gArF5BTwk
        Nqy5yQqxTU7i5rlO5gmMXAsYGVYxSqYWFOem5xYbFRjmpZbrFSfmFpfmpesl5+duYgSG17bD
        Wn07GO8viT/EKMDBqMTDmyC5KEaINbGsuDL3EKMEB7OSCO+Z/gUxQrwpiZVVqUX58UWlOanF
        hxilOViUxHlv5x2LFBJITyxJzU5NLUgtgskycXBKNTDmVhz8LHrmyCIjx/TqJb+8w1JFI6cu
        P8pSczX1t352zoMN4WkvF2+Nqb0msnjeGo3vt14+iruzqXaDSXOC1QS79s1MZ5e7ONd83Vay
        iE1U7h2X14/MMmtvw6Vy5hWyZ3l5FH9OXRJye+cDi8eH/Cf6ZxW9CfzLsHGze9Fq71fGz67q
        P9jRLdagxFKckWioxVxUnAgAAEykaysCAAA=
X-CMS-MailID: 20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89
CMS-TYPE: 101P
X-CMS-RootMailID: 20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89
References: <CGME20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriram Dash <sriram.dash@samsung.com>

The xhci forcefully converts the dma_mask to either 64 or 32 and the
dma-mask set by the bus is somewhat ignored. If the platform  sets the
correct dma_mask, then respect that.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
---
 drivers/usb/host/xhci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 005e659..55cf89e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5119,6 +5119,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 		dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	}
 
+	/*
+	 * A platform may require coherent masks other than 64/32 bit, and we
+	 * should respect that. If the firmware has already requested for a
+	 * dma-range, we inherit the dma_mask presuming the platform knows
+	 * what it is doing.
+	 */
+
+	if (dev->bus_dma_mask)
+		dma_set_mask_and_coherent(dev, dev->bus_dma_mask);
+
 	xhci_dbg(xhci, "Calling HCD init\n");
 	/* Initialize HCD and host controller data structures. */
 	retval = xhci_init(hcd);
-- 
2.7.4

