Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEAAC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4FB2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 05:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="O+tpvtQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfDLFCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 01:02:35 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40507 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfDLFCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 01:02:35 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7E0C5886BF;
        Fri, 12 Apr 2019 17:02:31 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1555045351;
        bh=Ls2tXwAMaV7wyywwyHomFSGRAS+Typ9HE+EUMymXylw=;
        h=From:To:Cc:Subject:Date;
        b=O+tpvtQmhDfTWfUGOJw/Rg5Eu72dA4GBEf0mRa0z/EvIdKVLig+gmCKCYE+V6Em9b
         nsIKqHjucdfGSpr8VrhKC2uw+axB3DY1k8WOOLKevgrhSOPExnhOvWwGKHqy6nNkkK
         xwry6solroVu8vvHoa1p9XRiaXTv4a5G6AoiN/X3o/BHjKOMwfT0U5sty96BPQ71Mf
         jSGoPR7mmXEH3N4KzJK+8Xy6Sqwa7Rv28/RbQtYGK/WjqPmVyIVkJ6rxIVdfk89V/9
         xrzCB50J1nWuHWosUtJlell0HGo5CvcqoXgdMLcn4S4QbtZTiM0gHz3+vVhfdYcH/f
         MhgQL2V+noiMw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5cb01be20000>; Fri, 12 Apr 2019 17:02:31 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 7CEE513ED56;
        Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3CA6F1E1D9C; Fri, 12 Apr 2019 17:02:26 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/3] spi: SPI bus multiplexer
Date:   Fri, 12 Apr 2019 17:02:10 +1200
Message-Id: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a hardware design where a single SPI chip select is steered by a
GPIO being asserted or de-asserted. On older kernels I was able to
(ab)use a gpio-hog and cs-gpios to deal with this.

Unfortunately recent changes have stopped my hacks from working. I've
tried adapting cs-gpios to work with my particular hardware but I came
to the realisation that the current cs-gpios support assumes a 1:1
mapping of gpio to SPI device whereas my hardware used the state of the
gpio selecting the device i.e. a 1:2 mapping.

This is my attempt to implement a driver to deal with this. One nice
property is that it is pretty much self contained. The only change to
the core SPI infrastructure is exposing a function I needed to lookup
the spi_controller instance.

Chris Packham (3):
  dt-bindings: spi: Add spi-mux-gpio
  spi: Make of_find_spi_controller_by_node visible
  spi: Add SPI bus gpio multiplexer

 .../devicetree/bindings/spi/spi-mux-gpio.txt  |  46 +++++
 drivers/spi/Kconfig                           |   7 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux-gpio.c                    | 169 ++++++++++++++++++
 drivers/spi/spi.c                             |   7 +-
 include/linux/spi/spi.h                       |   7 +
 6 files changed, 234 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.tx=
t
 create mode 100644 drivers/spi/spi-mux-gpio.c

--=20
2.21.0

