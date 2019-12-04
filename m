Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F8FC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23410205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483956;
	bh=Y0kHN/yCMJoaVEoGcMqdRgaZCfLMz1Xn6hUpYTgCTZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sIYrV95Bdx3zxz0dBbSLWiiYjNVuqW83wz9pRt4z130pmi0nIekXJHlI/BKUaksim
	 jk4V6n/asJjLqhOT5M15nrpYQXaBCIJcO7eXxgnzUDKMiHqCErHLE1NZHZI6nnMe8W
	 GQyrKEy4uV2L/MlVjWgZNiGyYcxaUjccqXtqF3iY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfLDSAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:00:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:38646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfLDSAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:00:19 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BD912081B;
        Wed,  4 Dec 2019 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482418;
        bh=Y0kHN/yCMJoaVEoGcMqdRgaZCfLMz1Xn6hUpYTgCTZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CRoaCjuRnRXjiSKLv+c/8mUB0bnRGBxhBuKfq+AiL0mEkju7E4jhEugo6G3J0zsJi
         P8/0yGclDgQRiqkpazAqmOAlR2uwUzzIqFsU8kt+qB4eZr42TaG237pdyX43CC8Dn2
         +kRiVwmYNINvw2zXa/di1OYr56Pg34aC4jCKHZLQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.4 79/92] mei: bus: prefix device names on bus with the bus name
Date:   Wed,  4 Dec 2019 18:50:19 +0100
Message-Id: <20191204174334.981267051@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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
@@ -761,15 +761,16 @@ static struct device_type mei_cl_device_
 
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


