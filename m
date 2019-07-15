Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B134C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4456F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 07:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ifB0nitu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729299AbfGOHjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 03:39:40 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20032 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbfGOHjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 03:39:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6F7au0k024443;
        Mon, 15 Jul 2019 09:39:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=HpVUgrShAgW9vXsEQTQa0RY6pPTPY9FAz9k7Q5LwFKg=;
 b=ifB0nituf9QfJe/DA2FY/drpX/1PbUubcs4dYlZU/B3AgwOG/263reAdB/BBsBE5Hfpk
 3c+j8avUhJyCCwY7msrRFQ95xaumfsuymFpXwQM7Kgn039HGwa/a9oEfRvfWXbnw22Ra
 +q+X6cTRQb2lPccaTqk7x2iRBnwHp0cO/2HSneNCEn+s29z4bVCfzRVcEzzyYF7dFSSo
 i88rSPOB7TJ2Cucx4XcVkKD0+3jEtO3WdIf3peM2X7aAhoETdF8XhlFW3O3+pjNrbJFj
 lPXSvSs1oRaQpdE/J1v7eUa5xPLfecbl3RldgEAhTC5Nwg0h5ousvgqQXm0t8zC49kpe cw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tq4s1c82u-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 15 Jul 2019 09:39:24 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCB6441;
        Mon, 15 Jul 2019 07:39:23 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8A557165F;
        Mon, 15 Jul 2019 07:39:23 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jul
 2019 09:39:23 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1473.003; Mon, 15 Jul 2019 09:39:23 +0200
From:   Ludovic BARRE <ludovic.barre@st.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: RE: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
Thread-Topic: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc
 variant
Thread-Index: AQHVGiTDhxYOagQ32kiKuW56aV8v5aaZnBkA///hwACACwqQAIAnAuIk
Date:   Mon, 15 Jul 2019 07:39:23 +0000
Message-ID: <1563176363071.36427@st.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
 <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
 <CAPDyKFrULRk=cHzVodU9aa6LDX9ip-VPHNwG7QXhmNZrMpPjGw@mail.gmail.com>,<CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
In-Reply-To: <CAPDyKFr_KNpNY-xgGdKXdAnmmD5OD1=wxgs2LmBAUJOn0mZwqg@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf=0A=
=0A=
like scheduled, I send you a "gentleman ping" about this series.=0A=
=0A=
Regards,=0A=
Ludo=0A=
________________________________________=0A=
De : Ulf Hansson <ulf.hansson@linaro.org>=0A=
Envoy=E9 : jeudi 20 juin 2019 15:50=0A=
=C0 : Ludovic BARRE=0A=
Cc : Rob Herring; Srinivas Kandagatla; Maxime Coquelin; Alexandre TORGUE; L=
inux ARM; Linux Kernel Mailing List; DTML; linux-mmc@vger.kernel.org; linux=
-stm32@st-md-mailman.stormreply.com=0A=
Objet : Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc varia=
nt=0A=
=0A=
Hi Ludovic,=0A=
=0A=
On Thu, 13 Jun 2019 at 15:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:=
=0A=
>=0A=
> On Thu, 13 Jun 2019 at 15:02, Ludovic BARRE <ludovic.barre@st.com> wrote:=
=0A=
> >=0A=
> > hi Ulf=0A=
> >=0A=
> > Just a "gentleman ping" about this series.=0A=
> > I know you are busy, it's just to be sure you do not forget me :-)=0A=
>=0A=
> Thanks! I started briefly to review, but got distracted again. I will=0A=
> come to it, but it just seems to take more time than it should, my=0A=
> apologies.=0A=
=0A=
Alright, so I planned to review this this week - but failed. I have=0A=
been overwhelmed with work lately (as usual when vacation is getting=0A=
closer).=0A=
=0A=
I need to gently request to come back to this as of week 28, when I=0A=
will give this the highest prio. Again apologize for the delays!=0A=
=0A=
Kind regards=0A=
Uffe=0A=
=0A=
>=0A=
> Br=0A=
> Uffe=0A=
>=0A=
> >=0A=
> > Regards=0A=
> > Ludo=0A=
> >=0A=
> > On 6/3/19 5:55 PM, Ludovic Barre wrote:=0A=
> > > From: Ludovic Barre <ludovic.barre@st.com>=0A=
> > >=0A=
> > > This patch series adds busy detect for stm32 sdmmc variant.=0A=
> > > Some adaptations are required:=0A=
> > > -Clear busy status bit if busy_detect_flag and busy_detect_mask are=
=0A=
> > >   different.=0A=
> > > -Add hardware busy timeout with MMCIDATATIMER register.=0A=
> > >=0A=
> > > V3:=0A=
> > > -rebase on latest mmc next=0A=
> > > -replace re-read by status parameter.=0A=
> > >=0A=
> > > V2:=0A=
> > > -mmci_cmd_irq cleanup in separate patch.=0A=
> > > -simplify the busy_detect_flag exclude=0A=
> > > -replace sdmmc specific comment in=0A=
> > > "mmc: mmci: avoid fake busy polling in mmci_irq"=0A=
> > > to focus on common behavior=0A=
> > >=0A=
> > > Ludovic Barre (3):=0A=
> > >    mmc: mmci: fix read status for busy detect=0A=
> > >    mmc: mmci: add hardware busy timeout feature=0A=
> > >    mmc: mmci: add busy detect for stm32 sdmmc variant=0A=
> > >=0A=
> > >   drivers/mmc/host/mmci.c | 49 ++++++++++++++++++++++++++++++++++++++=
+++--------=0A=
> > >   drivers/mmc/host/mmci.h |  3 +++=0A=
> > >   2 files changed, 44 insertions(+), 8 deletions(-)=0A=
> > >=0A=
