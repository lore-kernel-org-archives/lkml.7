Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FDC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087072175B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="p2Ijvnhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbfFMPTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:19:08 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39380 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732141AbfFMNCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:02:22 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5DCuqlD015993;
        Thu, 13 Jun 2019 15:02:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Dn/GSx8oOSdqicVsHAm1fovUZXgcL2YgME4MVY/Qjls=;
 b=p2IjvnhiN/FcNRbhaIg1lhrdvfWacg0fAHNZsSLbHECrbVZ+DKSOAZHrDmSfGyeGbXTz
 cbulaWATzSgherwadBy2cvsyIcGcn0HOr/dJr5/BbQXQcPMQ/m2MUT3WoKmzsIR1qNC1
 HTDu/W0jH7vSHEdtIjtvdRQnq8vEuCapW9IeRhn4orunu2XSaz7pVmzPUcukjR8mVyxa
 ox2Y0H/mHPtYpawdV5uOL7yTyjjzAM+e2TICpftmQb6QSATdKH6kCjv10WM9KCi26EWM
 0GJtfsjIHqUkRpiVWzKC9QIvFeu4SwaxIc67s0qgq/3zthgCSlNTEs2RhWlp1ZPTFeFX 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t2gxebr13-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 13 Jun 2019 15:02:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91CA534;
        Thu, 13 Jun 2019 13:02:04 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5FCD72AC5;
        Thu, 13 Jun 2019 13:02:04 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 13 Jun
 2019 15:02:03 +0200
Subject: Re: [PATCH V3 0/3] mmc: mmci: add busy detect for stm32 sdmmc variant
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <5b7e1ae5-c97e-5a21-fc3e-7cc328087f04@st.com>
Date:   Thu, 13 Jun 2019 15:02:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559577325-19266-1-git-send-email-ludovic.Barre@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf

Just a "gentleman ping" about this series.
I know you are busy, it's just to be sure you do not forget me :-)

Regards
Ludo

On 6/3/19 5:55 PM, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series adds busy detect for stm32 sdmmc variant.
> Some adaptations are required:
> -Clear busy status bit if busy_detect_flag and busy_detect_mask are
>   different.
> -Add hardware busy timeout with MMCIDATATIMER register.
> 
> V3:
> -rebase on latest mmc next
> -replace re-read by status parameter.
> 
> V2:
> -mmci_cmd_irq cleanup in separate patch.
> -simplify the busy_detect_flag exclude
> -replace sdmmc specific comment in
> "mmc: mmci: avoid fake busy polling in mmci_irq"
> to focus on common behavior
> 
> Ludovic Barre (3):
>    mmc: mmci: fix read status for busy detect
>    mmc: mmci: add hardware busy timeout feature
>    mmc: mmci: add busy detect for stm32 sdmmc variant
> 
>   drivers/mmc/host/mmci.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
>   drivers/mmc/host/mmci.h |  3 +++
>   2 files changed, 44 insertions(+), 8 deletions(-)
> 
