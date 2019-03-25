Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91BEF20828
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfCYQT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:19:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23379 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726743AbfCYQT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:19:58 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PGGoBN032425;
        Mon, 25 Mar 2019 17:19:46 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rddht4s2a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 25 Mar 2019 17:19:46 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3776E3D;
        Mon, 25 Mar 2019 16:19:46 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node1.st.com [10.75.127.16])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0C2EEE93;
        Mon, 25 Mar 2019 16:19:46 +0000 (GMT)
Received: from [10.48.0.237] (10.75.127.45) by SFHDAG6NODE1.st.com
 (10.75.127.16) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Mar
 2019 17:19:45 +0100
Subject: Re: [PATCH 1/2] spi: stm32-qspi: add spi_master_put in release
 function
To:     Mark Brown <broonie@kernel.org>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <1553265354-16433-1-git-send-email-ludovic.Barre@st.com>
 <1553265354-16433-2-git-send-email-ludovic.Barre@st.com>
 <20190325160313.GJ7284@sirena.org.uk>
From:   Ludovic BARRE <ludovic.barre@st.com>
Message-ID: <7742cae8-3fcf-a3ba-2807-d5ed100cd8a4@st.com>
Date:   Mon, 25 Mar 2019 17:19:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325160313.GJ7284@sirena.org.uk>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE1.st.com
 (10.75.127.16)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Mark

On 3/25/19 5:03 PM, Mark Brown wrote:
> On Fri, Mar 22, 2019 at 03:35:53PM +0100, Ludovic Barre wrote:
>> From: Ludovic Barre <ludovic.barre@st.com>
>>
>> This patch adds spi_master_put in release function
>> to drop the controller's refcount.
> 
> I'm getting build errors with this:
> 
>    CC      drivers/spi/spi-stm32-qspi.o
> drivers/spi/spi-stm32-qspi.c: In function ‘stm32_qspi_probe’:
> drivers/spi/spi-stm32-qspi.c:430:8: error: ‘struct stm32_qspi’ has no member named ‘phys_base’; did you mean ‘io_base’?
>    qspi->phys_base = res->start;
>          ^~~~~~~~~
>          io_base
> 

I was sure I built each patch, but the fact is there an error :-(
I resend a serie with this line in the second patch

Regards
Ludo
