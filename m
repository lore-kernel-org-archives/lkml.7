Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B956CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3DE214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="mm2aIeha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfJJPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:16:45 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52808 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbfJJPQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:16:44 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9AFBKhQ025036;
        Thu, 10 Oct 2019 17:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=WdF442jlxXHtW99D7VXviowbwCBFKKqETJKUfQQ750w=;
 b=mm2aIehas26Nib8HsLOMFdpsO23R7o8VnUJ+GWdEZjSLZR9ZOFAHky36iI4Br1lxJ3Sk
 avwn9mmM/xIpqctgJhEm9dhtDoAAVur2AUA24mzmir1bc7GfdSSENlTsoxZSjM1Hwdhc
 Y9/ElLzy6dDdBMiJdyB5L0mLKFzGbnEPa5jMvbKMsKX5r6+Bfg/UXc6AmbV6JqTQO4AY
 8Jklj38blZDBAAgFPOruDqxcjSdUcSJEi4/Uo81ZOOIsbQpsCxarYtqW4GV0lYAl2b/e
 mDwA9H2Ajdi8ApxoA9I0ppL9aM69bXJCPv2By43adSY7PAYuJiqsDgbVSOi3MgUE7bl7 3g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2vej2pmt2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Oct 2019 17:16:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 40B5A10002A;
        Thu, 10 Oct 2019 17:16:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9391E2B433F;
        Thu, 10 Oct 2019 17:16:19 +0200 (CEST)
Received: from SFHDAG5NODE3.st.com (10.75.127.15) by SFHDAG7NODE2.st.com
 (10.75.127.20) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 10 Oct
 2019 17:16:19 +0200
Received: from SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47]) by
 SFHDAG5NODE3.st.com ([fe80::7c09:5d6b:d2c7:5f47%20]) with mapi id
 15.00.1473.003; Thu, 10 Oct 2019 17:16:19 +0200
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>
CC:     Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: RE: [PATCH 0/2] remoteproc: stm32: allow wdg irq to be a wakeup
 source
Thread-Topic: [PATCH 0/2] remoteproc: stm32: allow wdg irq to be a wakeup
 source
Thread-Index: AQHVXCRbzfqre7GQVUu6MRQERXnqfqdUQtwQ
Date:   Thu, 10 Oct 2019 15:16:19 +0000
Message-ID: <1bef12295e864dfa90edfa495803167f@SFHDAG5NODE3.st.com>
References: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
In-Reply-To: <1566833923-16718-1-git-send-email-fabien.dessenne@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_05:2019-10-10,2019-10-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I Got Rob's Reviewed-by for the bindings. Any further comments for the driv=
er part?

Fabien

> -----Original Message-----
> From: Fabien DESSENNE <fabien.dessenne@st.com>
> Sent: lundi 26 ao=FBt 2019 17:39
> To: Rob Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>=
;
> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre TORGUE
> <alexandre.torgue@st.com>; Ohad Ben-Cohen <ohad@wizery.com>; Bjorn
> Andersson <bjorn.andersson@linaro.org>; devicetree@vger.kernel.org; linux=
-
> stm32@st-md-mailman.stormreply.com; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; linux-remoteproc@vger.kernel.org
> Cc: Fabien DESSENNE <fabien.dessenne@st.com>; Loic PALLARDY
> <loic.pallardy@st.com>; Arnaud POULIQUEN <arnaud.pouliquen@st.com>
> Subject: [PATCH 0/2] remoteproc: stm32: allow wdg irq to be a wakeup sour=
ce
>=20
> The watchdog IRQ which notifies the remote processor crash is used by the
> remoteproc framework to perform a recovery procedure.
> Since this IRQ may be fired when the Linux system is suspended, this IRQ =
may
> be configured to wake up the system.
>=20
> Fabien Dessenne (2):
>   dt-bindings: remoteproc: stm32: add wakeup-source
>   remoteproc: stm32: wakeup the system by wdg irq
>=20
>  .../devicetree/bindings/remoteproc/stm32-rproc.txt |  3 ++
>  drivers/remoteproc/stm32_rproc.c                   | 47 ++++++++++++++++=
++++++
>  2 files changed, 50 insertions(+)
>=20
> --
> 2.7.4

