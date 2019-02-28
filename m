Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C83C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702602133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSLLfCka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfB1Wlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:41:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41033 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfB1Wlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:41:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id n2so23760428wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VBe4FUsL1XFgwiT4hNs82n3hJ6g3oftAeOVJHGw7Vdo=;
        b=mSLLfCkaFfsoboAo8H+00qNiRplE64ekIFSd6WHe88N6uv4A/DlR6waGsPWJsJ+YaX
         GCTLejrcwQFH8DAJjxuOpeS1NZJ22TLexspeJ9qQ5+DlW1ArsQZabFGNa86vwgX/sbha
         SWArQr5aURAMPu4J+4yu2iyEdI2CTbNAd7hwTqYlsUFApWcqq8FqsUumCYVJ0Wgi291W
         Ym/A73kZzIkWWxH4cguCwmzyue8yJb5kde9JEx26vo9oYP+ytKTBAgSyHdMGY2vvD2tD
         dT5kytr7Qn37sOsVUSykSprHzH9cJvnoWVz5ojalkrEAiVfIS78GWAz77y8AvHRPml83
         x6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VBe4FUsL1XFgwiT4hNs82n3hJ6g3oftAeOVJHGw7Vdo=;
        b=jyMXtt4hWGzc8lH46NcQK82CMT8tgdMtyDtACOiY87UK1UitKQHi2Y9tnkZPAylJxG
         5Q0iFQz5OSMh14lXXyjUbnsbVSLo05jh77JsoIdXMWD47LVIua1rvbtl8/m7SskCs5hN
         ruKGTxnY/y3BHDF1u6Op/IdRVgpgbnm+RYmi8doM1t4SIqAV7982j61S5wEUrf0XdqzZ
         1+wCTMKDik8Y2M8HbTrlTCiPH0EpKnFEg+p8XEyPZHEdba9hmtmm/HP16nBdGjIbw/72
         wHQYFE10j4Q8SFSjR9H808f7vy7W96/Zol6KXCRYSPdUNjT6zoCRRQsGgDxnh1yyBB/v
         OAPw==
X-Gm-Message-State: APjAAAWJWeU4hc1BAQLOUmtzhGckn7HROIZOBONeeNyvLirUh5uJrIH1
        2eulpuZAPFYr7DE5S9rX01qq/Ac6OGU=
X-Google-Smtp-Source: APXvYqy8fbUN5sE1Bka8Z5KZkRLanevE2Nt2N1JR/tEA+qmtSgSpypHcSv1aqxWxiSVTWdOPGwZ+Hg==
X-Received: by 2002:a5d:548f:: with SMTP id h15mr1119558wrv.238.1551393696465;
        Thu, 28 Feb 2019 14:41:36 -0800 (PST)
Received: from [192.168.0.41] (243.212.132.77.rev.sfr.net. [77.132.212.243])
        by smtp.googlemail.com with ESMTPSA id f4sm20151885wrx.68.2019.02.28.14.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 14:41:35 -0800 (PST)
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
 <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
 <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ca30d998-2fe1-7ec9-8387-99c8d3e313bc@linaro.org>
Date:   Thu, 28 Feb 2019 23:41:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 23:26, Ulf Hansson wrote:
> On Thu, 28 Feb 2019 at 16:40, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/02/2019 14:59, Ulf Hansson wrote:
>>> Instead of iterating through all the state nodes in DT, to find out how
>>> many states that needs to be allocated, let's use the number already known
>>> by the cpuidle driver. In this way we can drop the iteration altogether.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
>>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
>>> index d50b46a0528f..cbfc936d251c 100644
>>> --- a/drivers/firmware/psci/psci.c
>>> +++ b/drivers/firmware/psci/psci.c
>>> @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
>>>  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
>>>                       struct device_node *cpu_node, int cpu)
>>>  {
>>> -     int i, ret = 0, count = 0;
>>> +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
>>
>> why -1 ?
> 
> Because of the WFI state. The cpuidle-arm driver always carries this
> state at index 0, which also is never used in
> psci_cpu_suspend_enter(), where the similar is taken into account.
> 
> It's a bit of magic, so perhaps someone should post a patch that
> documents this a bit better in the code, wherever it makes sense.

Ah yes, right. The first state is already filled with the WFI state in
the cpuidle-arm.c driver and we must infer the index passed to
dt_init_idle_driver is 1 because of that.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


[ ... ]


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

