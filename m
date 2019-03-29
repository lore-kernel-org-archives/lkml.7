Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A48C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A199F2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="oDLeOZt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfC2CNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:13:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46940 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfC2CNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:13:39 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 10645886BF;
        Fri, 29 Mar 2019 15:13:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553825615;
        bh=qXin5++Sh+VhWuTQR9KLZkGJA2wyYE/7eLeYglda5aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oDLeOZt70VOuvpqL7FxS1O9nQi262UStlswTF/hZgw51g+YxYk0gbRexJCCSv0JMV
         2wBuP2dWjtLhjgigKGq+qWgpPZfQHwK9kN0id8rxh5HjExa7sy8kReFY0GOedbDFMR
         F9BJsep35W7LEFAZUQ89i+Yo79cpX+4izCzMcZVBv3Nvek3M7QmjyUQPzVfCGHKUfw
         nMlGoRDhHxXCMBlMdqHtn7SH6gIMniB6tRQhkJt1Zko1u0soUSQy9esU1rSFogLfja
         Q0iKJaowMHRYtaa8Z69bwZ2Kq7WMD0ytJ8D2tXS1t9kOK+lQSKMQXIp4zahIWQQ2hP
         lUbdQblsYZG/A==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9d7f4d0001>; Fri, 29 Mar 2019 15:13:33 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id F1B4913EC56;
        Fri, 29 Mar 2019 15:13:34 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id D7AFA1E1124; Fri, 29 Mar 2019 15:13:34 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 1/2] mtd: maps: physmap: Store gpio_values correctly
Date:   Fri, 29 Mar 2019 15:13:21 +1300
Message-Id: <20190329021322.6833-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190329021322.6833-1-chris.packham@alliedtelesis.co.nz>
References: <20190329021322.6833-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the gpio-addr-flash.c driver was merged with physmap-core.c the
code to store the current gpio_values was lost. This meant that once a
gpio was asserted it was never de-asserted. Fix this by storing the
current offset in gpio_values like the old driver used to.

Fixes: commit ba32ce95cbd9 ("mtd: maps: Merge gpio-addr-flash.c into phys=
map-core.c")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v2:
- Cc stable, add Boris' review

 drivers/mtd/maps/physmap-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-c=
ore.c
index d9a3e4bebe5d..21b556afc305 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -132,6 +132,8 @@ static void physmap_set_addr_gpios(struct physmap_fla=
sh_info *info,
=20
 		gpiod_set_value(info->gpios->desc[i], !!(BIT(i) & ofs));
 	}
+
+	info->gpio_values =3D ofs;
 }
=20
 #define win_mask(order)		(BIT(order) - 1)
--=20
2.21.0

