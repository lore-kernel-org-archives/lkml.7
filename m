Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C7CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E5D2133D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="dOIYfjg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbfCRUjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:39:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:31288 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbfCRUjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552941582;
        s=strato-dkim-0002; d=goldelico.com;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=FpLcXXgjhB0Nq7Ef4DEJHTwPb2IbK1p9ddEH3G+5TaQ=;
        b=dOIYfjg/yEcLQIFe/ngIvXgSR/hJdvHy9JoXjV4sP3hwkxtSeTF+9Ey36eL0hBqd3l
        x9V0cF8ibUrdn0DlrbE1uAUuysjyvLmA+S4Jq/yHnEMOG47DFuX+y/btbSAyqsldP9TV
        G8pTEeLHBVoF5WOISyhwkBEUxaPpBgmmYJRRX0hHhDgKJSl/YpqS/Fcm3UdfsUetZlVo
        ST+8dY75ZaOPARjQu+YF/j3CfxaBxeXvBNnqeZRmKOqqBj17LxVmAYFfjWY0vT1d7c0E
        CmVgkSxIOL4ls7YJBpgu930lXN7KM+YW8656wCWLaIviJQg9RKg3IAWYsjLerUh8wo5Z
        VLiw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IKdZFyl
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 21:39:35 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 3/4] iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
Date:   Mon, 18 Mar 2019 21:39:33 +0100
Message-Id: <290e3d7ff2a55281cd29bc48ac75cce0bd4e9af0.1552941573.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1552941573.git.hns@goldelico.com>
References: <cover.1552941573.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the iio-input-bridge to the Kconfig.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d08aeb41cd07..d85afe002613 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -68,6 +68,13 @@ config IIO_TRIGGERED_EVENT
 	help
 	  Provides helper functions for setting up triggered events.
 
+config IIO_INPUT_BRIDGE
+	bool "Enable accelerometer bridge to input driver"
+	help
+	  Provides a /dev/input/event* device for accelerometers
+	  to use as a 3D input device, e.g. for gaming or auto-rotation
+	  of screen contents.
+
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
 source "drivers/iio/afe/Kconfig"
-- 
2.19.1

