Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638FE20821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbfDRKf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:35:28 -0400
Received: from ns.iliad.fr ([212.27.33.1]:33184 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388369AbfDRKf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:35:27 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 6B34720E2E;
        Thu, 18 Apr 2019 12:35:25 +0200 (CEST)
Received: from [192.168.108.49] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 54A8D20D88;
        Thu, 18 Apr 2019 12:35:25 +0200 (CEST)
Subject: Re: Issues with i.MX SPI DMA transfers
To:     Igor Plyatov <plyatov@gmail.com>
References: <08fcbd65-510f-84f8-d6d6-ff56aa9ca9ad@gmail.com>
 <20190328065247.uz73lap7ljf5q3tb@pengutronix.de>
 <b8e80127-e377-9ef9-2447-b0126fdad7dc@gmail.com>
 <VI1PR04MB45438E01D91829849A4E0BB289590@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <d7a2e5c5-4ee0-8c89-1bab-654db0ae38dd@gmail.com>
 <VI1PR04MB4543B1708FA151EED0CB722A89550@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <95df9334-3d0c-7d13-e431-5a4aa2b9907e@gmail.com>
 <VI1PR04MB454305A56372466A38E9F81989560@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <197990d4-b1e2-8db9-0cb7-87b860f23bd7@gmail.com>
 <VI1PR04MB4543DEA3C0CED159C472E85F89570@VI1PR04MB4543.eurprd04.prod.outlook.com>
 <fbb4850d-f63f-d384-1a85-1f4c5c077af6@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <dca134ca-044e-fd67-6568-02932be209e0@free.fr>
Date:   Thu, 18 Apr 2019 12:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fbb4850d-f63f-d384-1a85-1f4c5c077af6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Apr 18 12:35:25 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Trimming recipients list ]

On 03/04/2019 17:51, Igor Plyatov wrote:

> 2) I want to improve description and replace magic numbers by constants 
> in Device Tree for SDMA. I mean strings like "dmas = <&sdma 11 7 1>, 
> <&sdma 12 7 2>;"?
> 
> So, finally Device Tree will have strings like
> 
> dmas = <&sdma SOME_DEF_A IMX_DMATYPE_.. DMA_PRIO_..>, <&sdma SOME_DEF_B 
> IMX_DMATYPE_.. DMA_PRIO_..>;
> 
> I think, this will stop black magic manipulations for SDMA in Device 
> Tree, by various developers.
> 
> Does first digit means "DMA request/event ID"? Where to find more info 
> about this?
> 
> Does second digit means "enum sdma_peripheral_type"?
> 
> Does third digit means "enum imx_dma_prio"?

Start at Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
Documentation/devicetree/bindings/dma/dma.txt.
- dma-names: DMA request names, if present, should include "tx" and "rx".


Client drivers should specify the DMA property using a phandle to the controller
followed by DMA controller specific data.

Required property:
- dmas:			List of one or more DMA specifiers, each consisting of
			- A phandle pointing to DMA controller node
			- A number of integer cells, as determined by the
			  #dma-cells property in the node referenced by phandle
			  containing DMA controller specific information. This
			  typically contains a DMA request line number or a
			  channel number, but can contain any data that is
			  required for configuring a channel.
- dma-names: 		Contains one identifier string for each DMA specifier in
			the dmas property. The specific strings that can be used
			are defined in the binding of the DMA client device.
			Multiple DMA specifiers can be used to represent
			alternatives and in this case the dma-names for those
			DMA specifiers must be identical (see examples).


Turning our attention to Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt

- #dma-cells : Must be <3>.
  The first cell specifies the DMA request/event ID.  See details below
  about the second and third cell.

The second cell of dma phandle specifies the peripheral type of DMA transfer.
The full ID of peripheral types can be found below.

	ID	transfer type
	---------------------
	0	MCU domain SSI
	1	Shared SSI
	2	MMC
	3	SDHC
	4	MCU domain UART
	5	Shared UART
	6	FIRI
	7	MCU domain CSPI
	8	Shared CSPI
	9	SIM
	10	ATA
	11	CCM
	12	External peripheral
	13	Memory Stick Host Controller
	14	Shared Memory Stick Host Controller
	15	DSP
	16	Memory
	17	FIFO type Memory
	18	SPDIF
	19	IPU Memory
	20	ASRC
	21	ESAI
	22	SSI Dual FIFO	(needs firmware ver >= 2)
	23	Shared ASRC
	24	SAI

The third cell specifies the transfer priority as below.

	ID	transfer priority
	-------------------------
	0	High
	1	Medium
	2	Low

