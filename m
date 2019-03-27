Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A002075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732631AbfC0JeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:34:05 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34353 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfC0JeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:34:05 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h94wX-0005Bg-Da; Wed, 27 Mar 2019 10:33:57 +0100
Message-ID: <1553679236.2561.27.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>, Teo Hall <teo.hall@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 27 Mar 2019 10:33:56 +0100
In-Reply-To: <CAEnQRZCb=rZMdBYyYCSCQ3Dba5Nk43BvV6whHx-vNPmox-OOSw@mail.gmail.com>
References: <20190326094239.5910-1-daniel.baluta@nxp.com>
         <20190326094239.5910-3-daniel.baluta@nxp.com>
         <VI1PR04MB4222A8DBC2312E72AAD3AFAE805F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
         <CAEnQRZCb=rZMdBYyYCSCQ3Dba5Nk43BvV6whHx-vNPmox-OOSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Am Mittwoch, den 27.03.2019, 10:51 +0200 schrieb Daniel Baluta:
[...]
> 
> > or
> > "fsl,imx8qxp-edma", "fsl,imx8qm-edma"?
> 
> One thing that it is not clear for me is why there are places
> where we use two compatible strings?
> 
> I understand the situation where are two distinct drivers, but is there
> any other reason to add multiple compatible strings for a node in dts?

We use 2 compatible string where there should not be any differences
between the IP blocks of this SoC and a version the driver already
supports.

So if the eDMA driver already supports the software interface for
"fsl,imx8qm-edma" and the IP block is compatible with this, we add this
to the DT, so the we don't need any driver changes just to support a
new SoC. But as you can never be sure if there are subtle differences
in the IP block and/or SOC integration when adding the DT support, we
also add a more specific compatible to the DT. If it turns out that
there are software visible differences, we only need to adapt the
driver to check for the more specific compatible to trigger the changed
behavior, allowing to keep the DT stable.

Regards,
Lucas
