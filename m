Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71880C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9AE20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="WQxC4QpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbfDJNeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:34:22 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30568 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbfDJNeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:34:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3ADQ7CG016316;
        Wed, 10 Apr 2019 15:33:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=ofz6Y4mWhvV8B1aWGSsIXOG+H1UEedCYPmtGJsTdmQI=;
 b=WQxC4QpDRSgnh7WflCK16rB6974mrGk5BpX/Lwr9MQs0NkPSeeeVFNgIDWrHtu+3kgZV
 rtOKZIF/qMHM+DaLRwj3ySH+IYzy/2+AbkS76JujvAe4JrGYCxxzlrIPccgRn4lQ5Njv
 kHKBLrwj8NtI4hc1k7FhQBTUNE/ri7eeahKV3kzbacs042FmxQTmwsXCLNWuB3JgztHj
 j6tmVBsiuIN3xvK4phB9IqWlTrYdjEZOtsumoiXUwhlJ9RIy1KTPAGgErI+v3KX75kfx
 APWdpqQrw2hw7hqlPmnDDLYBgjtFVCcppOx1JlxGo1UGQGQE7IB3oH56yv246hN1OWHo Nw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rprcp75ee-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 15:33:32 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3864534;
        Wed, 10 Apr 2019 13:33:30 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F38AE24AC;
        Wed, 10 Apr 2019 13:33:29 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 15:33:28 +0200
Subject: Re: [PATCH v2 0/3] Add support for STPMIC1
To:     Pascal PAILLET-LME <p.paillet@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "biju.das@bp.renesas.com" <biju.das@bp.renesas.com>,
        Yannick FERTRE <yannick.fertre@st.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
References: <1554800820-5412-1-git-send-email-p.paillet@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a4453cb5-dfbd-7c69-b4b6-c3e0d66e95bb@st.com>
Date:   Wed, 10 Apr 2019 15:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1554800820-5412-1-git-send-email-p.paillet@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pascal

On 4/9/19 11:07 AM, Pascal PAILLET-LME wrote:
> Add support for STPMIC1 on:
> - stm32mp157c ed1 board
> - stm32mp157a dk1 board
> - arm multi_v7_defconfig
> 
> Pascal Paillet (3):
> 
> changes in v2:
> * Describe why we disable the DMAs for PMIC
> 
>    ARM: dts: stm32: add stpmic1 support on stm32mp157c ed1 board
>    ARM: dts: stm32: add stpmic1 support on stm32mp157a dk1 board
>    ARM: multi_v7_defconfig: Enable support for STPMIC1
> 
>   arch/arm/boot/dts/stm32mp157a-dk1.dts | 158 
> ++++++++++++++++++++++++++++++++--
>   arch/arm/boot/dts/stm32mp157c-ed1.dts | 156 
> +++++++++++++++++++++++++++++----
>   arch/arm/configs/multi_v7_defconfig   |   4 +
>   3 files changed, 294 insertions(+), 24 deletions(-)
> 
> -- 
> 1.9.1


Series applied on stm32-next.

Linus,
I saw that you made a comment on first version which has been fixed by 
Pascal in v2. Sorry if I don't wait for your ack (I don't have much time 
to finish my PR).

Regards
Alex
