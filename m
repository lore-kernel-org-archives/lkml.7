Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CE0C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9450E2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414056;
	bh=hOChTwOSOH99NKlZRnGJVBGGtiLC3hRZj54IEM5GvXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ChOC3QKOqHd8URy+SEQrMcnrP9IhMQJ7vXGjYxCftFKNyOFP+XBDqeqkHTqT5JKg5
	 fmk/tfEfXPTCYQcdk3Ch7YrXfiDJH16XYI3BSi5mATU9RB+vR0T0bz8neXEv3bmgW+
	 Wtj6+AEFxR0cAubjQhrlVK0ghBYlo7le4Qmo0Ac0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfLCW47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730491AbfLCW44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:56:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F1B420803;
        Tue,  3 Dec 2019 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413816;
        bh=hOChTwOSOH99NKlZRnGJVBGGtiLC3hRZj54IEM5GvXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZL3/R51+Fm3n4ej3POLTb8nW7IAL1cD4f89tDcYaz9XyIOsz/Zx7po/L3LZz7T+o
         V703LimqMPcQR4RcHV+Ru9szkUG4FIzKZ2z1H5Kd/WuNJsURczvTvJYzVWhkv6FWtg
         UZAlN7eQr1MHNbAhOIVMAW2QKtRKdeSwbwRpE0tQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.19 273/321] mei: bus: prefix device names on bus with the bus name
Date:   Tue,  3 Dec 2019 23:35:39 +0100
Message-Id: <20191203223441.330721776@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 7a2b9e6ec84588b0be65cc0ae45a65bac431496b upstream.

Add parent device name to the name of devices on bus to avoid
device names collisions for same client UUID available
from different MEI heads. Namely this prevents sysfs collision under
/sys/bus/mei/device/

In the device part leave just UUID other parameters that are
required for device matching are not required here and are
just bloating the name.

Cc: <stable@vger.kernel.org>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20191105150514.14010-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/bus.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -883,15 +883,16 @@ static const struct device_type mei_cl_d
 
 /**
  * mei_cl_bus_set_name - set device name for me client device
+ *  <controller>-<client device>
+ *  Example: 0000:00:16.0-55213584-9a29-4916-badf-0fb7ed682aeb
  *
  * @cldev: me client device
  */
 static inline void mei_cl_bus_set_name(struct mei_cl_device *cldev)
 {
-	dev_set_name(&cldev->dev, "mei:%s:%pUl:%02X",
-		     cldev->name,
-		     mei_me_cl_uuid(cldev->me_cl),
-		     mei_me_cl_ver(cldev->me_cl));
+	dev_set_name(&cldev->dev, "%s-%pUl",
+		     dev_name(cldev->bus->dev),
+		     mei_me_cl_uuid(cldev->me_cl));
 }
 
 /**


