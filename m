Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459ECC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E9402173C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="j+fC+evh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfDKTjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:39:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50454 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfDKTjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:39:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3BJco8o097024;
        Thu, 11 Apr 2019 14:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555011530;
        bh=5G6Ljq4Dr2dteCKjHGZ3Qf2Oc7FENGSX4rNStT8Zc+Q=;
        h=From:To:CC:Subject:Date;
        b=j+fC+evhSfWnrL7bkKa9xP0xJGPlM9A2OSD47dBqKotLkW1w4gwlr2kJ3EL9N9gEN
         COy9p0n71R7UKP4R6E3OkkCetuM8MvZJSc3h8+CwyNBPLgpUdnjyMERCVTdKwdmTp+
         fHifg7XbINXnAnlgAJ1dSPB4OJ+TrlE5YCR3oJlk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3BJcnQW105850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Apr 2019 14:38:50 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 11
 Apr 2019 14:38:49 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 11 Apr 2019 14:38:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3BJcnhn082059;
        Thu, 11 Apr 2019 14:38:49 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <marek.behun@nic.cz>, <rdunlap@infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v2 0/7] Multicolor Framework
Date:   Thu, 11 Apr 2019 14:38:41 -0500
Message-ID: <20190411193848.23140-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.21.0.5.gaeb582a983
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have updated the patchset for the multicolor framework and scrubed the base
code.  I have incoroporated the minor changes that were asked for.  But I still
have not added any code for the brightness models as this is still in discussion.

I have also included the TI LP50xx driver that demonstrates how to use the
Multicolor framework.

Finally I have built this on top of Jacek's LED name composition patchset
https://lore.kernel.org/patchwork/project/lkml/list/?series=388765

The MC FW will leverage the COLOR_ID and led_colors definitions provided there.
And I have added a new COLOR_ID to support this framework because with multicolor
having to declare a top level color for the directory just did not make sense

So the directory would be appended with multicolor which would denote that this
directory supports the MC FW
multicolor:activity  multicolor:standby   multicolor:status 

Dan

Dan Murphy (7):
  leds: multicolor: Add sysfs interface definition
  dt: bindings: Add multicolor class dt bindings documention
  documention: leds: Add multicolor class documentation
  dt-bindings: leds: Add multicolor ID to the color ID list
  leds: multicolor: Introduce a multicolor class definition
  dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers
  leds: lp50xx: Add the LP50XX family of the RGB LED driver

 .../ABI/testing/sysfs-class-led-multicolor    |  91 +++
 .../devicetree/bindings/leds/common.txt       |   2 +
 .../bindings/leds/leds-class-multicolor.txt   | 142 ++++
 .../devicetree/bindings/leds/leds-lp50xx.txt  | 142 ++++
 Documentation/leds/leds-class-multicolor.txt  |  99 +++
 Documentation/leds/leds-lp50xx.txt            |  36 +
 drivers/leds/Kconfig                          |  17 +
 drivers/leds/Makefile                         |   2 +
 drivers/leds/led-class-multicolor.c           | 401 ++++++++++
 drivers/leds/led-class.c                      |   1 +
 drivers/leds/leds-lp50xx.c                    | 716 ++++++++++++++++++
 include/dt-bindings/leds/common.h             |   3 +-
 include/linux/led-class-multicolor.h          |  74 ++
 13 files changed, 1725 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-multicolor
 create mode 100644 Documentation/devicetree/bindings/leds/leds-class-multicolor.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lp50xx.txt
 create mode 100644 Documentation/leds/leds-class-multicolor.txt
 create mode 100644 Documentation/leds/leds-lp50xx.txt
 create mode 100644 drivers/leds/led-class-multicolor.c
 create mode 100644 drivers/leds/leds-lp50xx.c
 create mode 100644 include/linux/led-class-multicolor.h

-- 
2.21.0.5.gaeb582a983

