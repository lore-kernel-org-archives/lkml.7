Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0718C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9AA2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="EQoKN063"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfDJP32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:29:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:32978 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729318AbfDJP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:29:27 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3AFREsD024057;
        Wed, 10 Apr 2019 17:29:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=5QF677DNR8NFyzzy+z9d2PeSsdOK9wNwGJPOinFlhkI=;
 b=EQoKN063RPfScfyaQEoM9+fqwKXOhNF4wptcGV1XGxOt0cbwJz5vD/CdVAk/Za2D14ni
 Xhi2KJqLyTQEoeiSZYPUdc5VpQX0cWPudhOQHImFK/wWiPzGoqK6YUl1QcxdspVcWMuA
 VI8vKppLFIBpam/QJOSKlLdqeQ90J8u/o79dXDS21+3f8puzL2beTSibZ/h7eKwj9QB+
 C6kEbGwTwi072fEnEmXvEiXYZI51G/KHdLoXpcW07WVcnmSK9nxxu5S3tLbiexib2fEc
 5JAOInF6W/hRMwbb+FozNBwsSKhFGGbsqzmGiixiBVPV179hk78VAC7YDDdjBa9zXl5s zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2rpr7wry88-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 10 Apr 2019 17:29:18 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DF2A334;
        Wed, 10 Apr 2019 15:29:16 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A32682673;
        Wed, 10 Apr 2019 15:29:16 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 10 Apr
 2019 17:29:16 +0200
Subject: Re: [PATCH] PM / core: Propagate dev->power.wakeup_path when no
 callbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-pm@vger.kernel.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Loic Pallardy <loic.pallardy@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190410095516.6170-1-ulf.hansson@linaro.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c0e5e074-b0e4-c554-ab50-b04b046a487e@st.com>
Date:   Wed, 10 Apr 2019 17:28:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190410095516.6170-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-10_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf

On 4/10/19 11:55 AM, Ulf Hansson wrote:
> The dev->power.direct_complete flag may become set in device_prepare() in
> case the device don't have any PM callbacks (dev->power.no_pm_callbacks is
> set). This leads to a broken behaviour, when there is child having wakeup
> enabled and relies on its parent to be used in the wakeup path.
> 
> More precisely, when the direct complete path becomes selected for the
> child in __device_suspend(), the propagation of the dev->power.wakeup_path
> becomes skipped as well.
> 
> Let's address this problem, by checking if the device is a part the wakeup
> path or has wakeup enabled, then prevent the direct complete path from
> being used.
> 
> Reported-by: Loic Pallardy <loic.pallardy@st.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 

Thanks Ulf for this patch. It'll avoid to have dirty hack in serial 
suspend callback (at least for stm32). I just tested it on stm32 kernel 
v4.19 (which embeds all our genpd based power features). Replacing
device_may_wakeup(dev) by
device_may_wakeup(dev) || dev->power.wakeup_path) then dirty hack to 
test ttydev wakeup flag in stm32 usart driver is no more needed.

So you can add my Tested-by

Regards
Alex


> More background:
> 
> This problem was reported by Loic Pallardy, offlist, while he was working
> on enabling wakeup for a tty serial console driver.
> 
> When I looked more closely, I noticed that uart_suspend_port() calls
> device_may_wakeup() for the tty child devices, and then also the used serial
> driver check its device (parent) for device_may_wakeup(). To me this looks like
> workarounds to fix a behaviour that really should be dealt with from the PM
> core, no matter of whether the child have PM callbacks assigned or not.
> 
> In other words, it seems like the serial driver(s) should be checking the
> wakeup_path flag for the parent, solely, instead.
> 
> I haven't digested further behaviours for other subsystem, but recently
> reviewed a patch for a gpio driver [1], that seems to be suffering from the
> similar problems.
> 
> Kind regards
> Ulf Hansson
> 
> [1]
> https://lkml.org/lkml/2019/4/4/1283
> 
> ---
>   drivers/base/power/main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 41eba82ee7b9..f9cfdeee8288 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1747,6 +1747,10 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>   	if (dev->power.syscore)
>   		goto Complete;
>   
> +	/* Avoid direct_complete, to let wakeup_path being propagated. */
> +	if (device_may_wakeup(dev) || dev->power.wakeup_path)
> +		dev->power.direct_complete = false;
> +
>   	if (dev->power.direct_complete) {
>   		if (pm_runtime_status_suspended(dev)) {
>   			pm_runtime_disable(dev);
> 
