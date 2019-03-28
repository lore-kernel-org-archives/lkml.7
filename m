Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCE0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02EB6206DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 04:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Ae28Bbbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbfC1ECc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 00:02:32 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:45057 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfC1ECb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 00:02:31 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BB28F806CB;
        Thu, 28 Mar 2019 17:02:29 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1553745749;
        bh=7NBDjca8CqFcBIzIKTpm1tSjsqP/Let6MA2LwzfnQeE=;
        h=From:To:Cc:Subject:Date;
        b=Ae28BbbuNTaxgA8nBhTM7fizpTYIqcS3Izm9jZmEzKtIfM3lNS/Og+6/v/pZtxAQs
         ZlC/AhYciReoGFw21y/eIcapPGZQjAGdiLm+42btNcWaByR9rOyEfSXnwewQaO2z7L
         z5Y+W2ocCOxudnOJU3hWfqMxEULlChKz8Xx8TGr7rpTCppBjT4CiY8Zs78pb+hwV0e
         N/PFYvht2+ijusNOzhzNfbliabVt0DzG/IgsVcwNaNA+fNbTFLYboj62CuLTqOwBoN
         Pu4g8YlX9gGJvCzrbOW6DOpRNe0c9d4D9rUjQO37byqHDy4GHU0hr+aypzmvJk3UCT
         JBab1Gc6CO4xQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c9c47510000>; Thu, 28 Mar 2019 17:02:30 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 9BBBB13EEF7;
        Thu, 28 Mar 2019 17:02:24 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 77BD81E1124; Thu, 28 Mar 2019 17:02:24 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, marek.vasut@gmail.com, richard@nod.at,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] mtd: physmap: Using gpio-addrs
Date:   Thu, 28 Mar 2019 17:02:14 +1300
Message-Id: <20190328040217.1895-1-chris.packham@alliedtelesis.co.nz>
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

