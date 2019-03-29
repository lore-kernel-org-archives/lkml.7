Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ADC10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2945D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="BVqEHbX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfC2CNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:13:40 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46939 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbfC2CNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:13:39 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0D027806CB;
        Fri, 29 Mar 2019 15:13:35 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553825615;
        bh=7NBDjca8CqFcBIzIKTpm1tSjsqP/Let6MA2LwzfnQeE=;
        h=From:To:Cc:Subject:Date;
        b=BVqEHbX7T+G4H9rkif2z5q90e33vt6sRRDIzdillvHDLGmvVKNoznFPGF82Tvii8g
         Ul1EieSw1MTpyIZCs1qUO/Vp1vJsHSzCmP4UcEGw+DJq48wIFd7Ui/ZbYKDdkJv/yO
         tbONob6hBON/2MHIqLiwGo31z3TksweLNdlfVPh0M0fAHkhOCP8GxL+6sbuZfSO85l
         Kz1DGI0q6e6Shae+aP/+YSjayFNk8GgKA1pGzEj1HwbE2fYiATz9vD9Tv2bSMlu9LQ
         mgiFJKBk56/Ai+7dMDVpel0WivHw0KHeYlvUvXE3HMiZDoNxnTbFozpJFxOW2rKyuH
         OVLzdQo+EZwcQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9d7f4d0000>; Fri, 29 Mar 2019 15:13:33 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id E1C0A13EC56;
        Fri, 29 Mar 2019 15:13:34 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id C09C21E1124; Fri, 29 Mar 2019 15:13:34 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] mtd: physmap: Using gpio-addrs
Date:   Fri, 29 Mar 2019 15:13:20 +1300
Message-Id: <20190329021322.6833-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a system with ADDR24 of the flash chip connected to a gpio pin. Th=
is
series fixes a bug in physmap-core.c and adds an example for using gpio-a=
ddrs
to the dt-binding based on the system I'm using.

Chris Packham (2):
  mtd: maps: physmap: Store gpio_values correctly
  dt-binding: mtd: physmap: Add example using addr-gpios property

 .../devicetree/bindings/mtd/mtd-physmap.txt      | 16 ++++++++++++++++
 drivers/mtd/maps/physmap-core.c                  |  2 ++
 2 files changed, 18 insertions(+)

--=20
2.21.0

