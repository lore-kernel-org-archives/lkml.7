Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00757C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7F021D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="jV8ptiyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfJCKJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:09:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21934 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727410AbfJCKJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:09:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93A1PIB005807;
        Thu, 3 Oct 2019 12:08:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=zqZUbIdRkbe8zlQ1Xy8C9xxTHAhI4kWKhP2SWMUEemc=;
 b=jV8ptiyJIBOf5cwe8QUXFgXXkKlSgkCTD7XMNZRCvsAPambXB79iNTcO/xnDQ2vyXHss
 Zin4bUODvBTMwAqUzdIO8ZvNTa32yUu/8MDWXryACMgx/Zc35EgfEXFgSNTx2Ozh0egC
 XVopjnZKzXBm+KGG2MQwKBHDvxt05n43FXUOv3p4PRugtLtw5EGBoOu32MF5yBBCGTGS
 +/R/Z4rIs06p6qBDCckX/qa4WZIPKrN301WzF96q9rKHVgvkcQdf6/zvapGFDlY6FuM0
 o2Azs8XkUqpiaNqipN48f/DwHg6I7O8ftUEzsT6JH1V5zQPOqtr4G6nIelDcThOB9wZK zA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com with ESMTP id 2v9w9w3xx1-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Oct 2019 12:08:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3CD5D50;
        Thu,  3 Oct 2019 10:08:52 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 967AD2B5CBF;
        Thu,  3 Oct 2019 12:08:51 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Oct
 2019 12:08:51 +0200
Subject: Re: [PATCH 0/3] Add support for ADC on stm32mp157a-dk1
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mark.rutland@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <4ae1d526-e681-a8e5-925b-ec7a3e28868d@st.com>
Date:   Thu, 3 Oct 2019 12:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568385280-2633-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_04:2019-10-01,2019-10-03 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice

On 9/13/19 4:34 PM, Fabrice Gasnier wrote:
> This series adds support for ADC on stm32mp157a-dk1 board:
> - enable vrefbuf regulator used as reference voltage
> - define ADC pins for AIN connector and USB Type-C CC pins
> - configure ADC1 and ADC2 to use these
> 
> Fabrice Gasnier (3):
>    ARM: dts: stm32: Enable VREFBUF on stm32mp157a-dk1
>    ARM: dts: stm32: add ADC pins used on stm32mp157a-dk1
>    ARM: dts: stm32: enable ADC support on stm32mp157a-dk1
> 
>   arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 16 +++++++++++++++
>   arch/arm/boot/dts/stm32mp157a-dk1.dts     | 34 +++++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
