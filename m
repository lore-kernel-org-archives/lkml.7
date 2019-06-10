Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E92EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608132085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gWnTJIR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391282AbfFJPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:48:11 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:10168 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390335AbfFJPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:48:10 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AFfYgf026022;
        Mon, 10 Jun 2019 17:47:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=LgERwqK45s8WxfYNJ2p/eCQHczqBFZZAr61TGRo2H+4=;
 b=gWnTJIR+98UCSxymsNwMRkgV+9V4yBZI5+4O8squ/S1WPag/BNss5IcSulDOH8T/qMqy
 q5rRWgjZh1+axSfpm4jGFsbHUXiEKvFm5yX1fVKRlgcGeUpMJ1UiBH3GQvUc006KNBYZ
 aaQBMZ5CoapQhFeAG4Xy6KLHH7l+oOyLUCEOe/V+gwEP4isq8+XLC7bW/5by5lGiK/x3
 XouigYxflqzytqopMhVNGFhEgQPEP7iffCr4OeoYE1zREws/pzQJfakAvhXlF3eR6ezU
 fzZSs6CeFFZkIWOMuauXgOa/ZhjVDilHLoY4vc8Z7eatw46qhvqsNEfDqCLJJMojWq9G AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2t0256a973-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 10 Jun 2019 17:47:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B078D34;
        Mon, 10 Jun 2019 15:47:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7E94F4F1D;
        Mon, 10 Jun 2019 15:47:30 +0000 (GMT)
Received: from SFHDAG3NODE3.st.com (10.75.127.9) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 17:47:30 +0200
Received: from SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476]) by
 SFHDAG3NODE3.st.com ([fe80::3507:b372:7648:476%20]) with mapi id
 15.00.1347.000; Mon, 10 Jun 2019 17:47:30 +0200
From:   Erwan LE RAY <erwan.leray@st.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        "Kevin Hilman" <khilman@baylibre.com>
CC:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Clement Peron <clement.peron@devialet.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Stefan Agner <stefan@agner.ch>,
        Biju Das <biju.das@bp.renesas.com>,
        "Gerald BAEZA" <gerald.baeza@st.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bich HEMON <bich.hemon@st.com>,
        "Fabrice GASNIER" <fabrice.gasnier@st.com>
Subject: Re: [PATCH] ARM: debug: stm32: add UART early console configuration
Thread-Topic: [PATCH] ARM: debug: stm32: add UART early console configuration
Thread-Index: AQHU73OP100nvdfkikCtYg1KY+YHZqY1DV8AgC1naoCAMtJmgA==
Date:   Mon, 10 Jun 2019 15:47:30 +0000
Message-ID: <ff48768c-83e3-55dc-16a0-bd0af4133c7c@st.com>
References: <1554883239-12051-1-git-send-email-erwan.leray@st.com>
 <CAJiuCcd9884Kn2MAtLMzZpdSa-=xpCDKRLQSVC6NmRNC+YFtaA@mail.gmail.com>
 <deebc332-277b-76b9-421f-7f67c6bdacc8@st.com>
In-Reply-To: <deebc332-277b-76b9-421f-7f67c6bdacc8@st.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <70F78C8ABFDF92458A8685FA5F79E676@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-10_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgT2xvZiwgQXJuZCBhbmQgS2V2aW4sDQoNCkdlbnRsZSByZW1pbmRlciBvbiBteSBmZWVkYmFj
ayByZXF1ZXN0Lg0KDQpCZXN0IHJlZ2FyZHMsIEVyd2FuLg0K
