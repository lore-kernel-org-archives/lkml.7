Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D94C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B97620657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfCKJeQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:34:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18796 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727101AbfCKJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:34:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2B9R5ZD008919;
        Mon, 11 Mar 2019 10:34:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2r43gdbcs8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Mar 2019 10:34:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7FB2E3D;
        Mon, 11 Mar 2019 09:34:01 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 442EB295E;
        Mon, 11 Mar 2019 09:34:01 +0000 (GMT)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 Mar
 2019 10:34:00 +0100
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1347.000; Mon, 11 Mar 2019 10:34:00 +0100
From:   Bich HEMON <bich.hemon@st.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Pierre Yves MORDRET <pierre-yves.mordret@st.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Thread-Topic: [PATCH] i2c: i2c-stm32f7: Fix SDADEL minimum formula
Thread-Index: AQHU1C78TFNtpaUoH0S1cdbw5UeFxaYDCGcAgAAKP4CAAw9TAA==
Date:   Mon, 11 Mar 2019 09:34:00 +0000
Message-ID: <36e0aec2-8fb8-d584-daee-1b3427f1067e@st.com>
References: <1551885125-22295-1-git-send-email-bich.hemon@st.com>
 <20190309101340.GH1340@kunai> <20190309105021.GI1340@kunai>
In-Reply-To: <20190309105021.GI1340@kunai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CAB849C8628AE3419068CD4964787227@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/19 11:50 AM, Wolfram Sang wrote:
> On Sat, Mar 09, 2019 at 11:13:40AM +0100, Wolfram Sang wrote:
>> On Wed, Mar 06, 2019 at 03:12:16PM +0000, Bich HEMON wrote:
>>> From: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>>>
>>> It conforms with Reference Manual I2C timing section.
>>>
>>> Signed-off-by: Nicolas Le Bayon <nicolas.le.bayon@st.com>
>>> Signed-off-by: Bich Hemon <bich.hemon@st.com>
>>
>> Applied to for-current, thanks!
> 
> Do you have a Fixes tag for this?
> 
Hi Wolfram,

Fixes: aeb068c57214858b638d5ee627bb4a831f98771e ("i2c: i2c-stm32f7: add 
driver")

Will you change the commit message or do you want me to resend the patch?

BR,

Bich
