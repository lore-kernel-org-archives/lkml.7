Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14651C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16072147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl6hAIuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfHELDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:03:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34092 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfHELDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:03:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id b29so50354511lfq.1;
        Mon, 05 Aug 2019 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8clQkiU/I7HnZXUjryNFZFlElLbT4vOfdQOCFEa8wnM=;
        b=Bl6hAIuBRXebtJ9xa0g037Wb2AhwLUDgn7Ap2L++6xNWb1IRiacTSZSNg0APry1BWs
         /2b30k3gOSKvoHMP52RfV1fhzAf5+0nrQAWZmZzjN4tyISdw/OGXVCM5gXhhU51tORRE
         LAi6Sq5IzAmjsNm3nzRJHXUNtPd701Md18HkTcwPd5zg8iR3FuRQLMzVXV7lqh7QJyJ6
         XoJsGkW96r2rNBrXrM70ZUiZRD09Xx7xvT5M8Ygtu+/bRGRE4Q7bgNkQzyoslCqZd3Y0
         Tq2iCXBhnA1/LnvqnffAsMJqpHhy3+aw80pY5A8V41he9vpQWA2q+FjPedR0EJKHDh9G
         CpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8clQkiU/I7HnZXUjryNFZFlElLbT4vOfdQOCFEa8wnM=;
        b=VU93t/YdJ3Mek6hcd8TvGP3+f5ikGqAN3wHzxEZq8deaEbs4l/Vz93Lj9ePEUh5HxG
         xa3PVKp/vGgsxCFZsC3ZtBSx+YucAMpgHyb/xhotvdQyXYM7Bv1wQ3d0fKqQcXQ+lUZK
         2mkDwVGg1V/9ey/bNgqIt1cnK4dh1NvseBygh+uh7olDUS615NikemsGD3en4ESRpype
         nlHkX3iyTjeyNvSY3Bz90/8H/igkUXfJlS19rnyPAnwufiCmGu8wuRNhejDV7XRGNwHs
         T4TLadKHGXFv65LwjJ7VNgUP6ttbqpXaIdrorO7kLUMfkq+CKWaZ1Q24J9MuCVsdOzt/
         o+HQ==
X-Gm-Message-State: APjAAAVv3jBBp5j7vr1uDR9N8Iskp6EcZqe8zRoFlnI0XnBHodEaibuE
        naz/Awu9kHY96LU2TtDhD2Mg6pZV
X-Google-Smtp-Source: APXvYqxsNjF6vpxNkUXlWNulq8BHbEh9xA35Zc5sybCSXzClhyk2tP/4ZK7S+YpArTye0ZH8LJOBqQ==
X-Received: by 2002:a19:234c:: with SMTP id j73mr27288659lfj.96.1565003011200;
        Mon, 05 Aug 2019 04:03:31 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id v14sm17197288ljh.51.2019.08.05.04.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 04:03:30 -0700 (PDT)
Subject: Re: [PATCH v2 3/3] soc/tegra: regulators: Add regulators coupler for
 Tegra30
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190725151832.9802-1-digetx@gmail.com>
 <20190725151832.9802-4-digetx@gmail.com>
 <20190802140512.GD3883@pdeschrijver-desktop.Nvidia.com>
 <c537fbea-5884-03db-305f-6ab3d553f7ab@gmail.com>
 <20190805083325.GE3883@pdeschrijver-desktop.Nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1a9464b3-6e0e-00ff-64d8-b3abf7982dfb@gmail.com>
Date:   Mon, 5 Aug 2019 14:03:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190805083325.GE3883@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

05.08.2019 11:33, Peter De Schrijver пишет:
> On Fri, Aug 02, 2019 at 05:39:23PM +0300, Dmitry Osipenko wrote:
>> 02.08.2019 17:05, Peter De Schrijver пишет:
>>> On Thu, Jul 25, 2019 at 06:18:32PM +0300, Dmitry Osipenko wrote:
>>>> Add regulators coupler for Tegra30 SoCs that performs voltage balancing
>>>> of a coupled regulators and thus provides voltage scaling functionality.
>>>>
>>>> There are 2 coupled regulators on all Tegra30 SoCs: CORE and CPU. The
>>>> coupled regulator voltages shall be in a range of 300mV from each other
>>>> and CORE voltage shall be higher than the CPU by N mV, where N depends
>>>> on the CPU voltage.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/soc/tegra/Kconfig              |   4 +
>>>>  drivers/soc/tegra/Makefile             |   1 +
>>>>  drivers/soc/tegra/regulators-tegra30.c | 316 +++++++++++++++++++++++++
>>>>  3 files changed, 321 insertions(+)
>>>>  create mode 100644 drivers/soc/tegra/regulators-tegra30.c
>>>>
>>> ...
>>>
>>>> +
>>>> +static int tegra30_core_cpu_limit(int cpu_uV)
>>>> +{
>>>> +	if (cpu_uV < 800000)
>>>> +		return 950000;
>>>> +
>>>> +	if (cpu_uV < 900000)
>>>> +		return 1000000;
>>>> +
>>>> +	if (cpu_uV < 1000000)
>>>> +		return 1100000;
>>>> +
>>>> +	if (cpu_uV < 1100000)
>>>> +		return 1200000;
>>>> +
>>>> +	if (cpu_uV < 1250000) {
>>>> +		switch (tegra_sku_info.cpu_speedo_id) {
>>>> +		case 0 ... 1:
>>> Aren't we supposed to add /* fall through */ here now?
>>
>> There is no compiler warning if there is nothing in-between of the
>> case-switches, so annotation isn't really necessary here. Of course it
>> is possible to add an explicit annotation just to make clear the
>> fall-through intention.
>>
> 
> Ah. Ok. Whatever you want then :)

I'll add the comments if there will be a need to re-spin this series.

>>>> +		case 4:
>>>> +		case 7 ... 8:
>>>> +			return 1200000;
>>>> +
>>>> +		default:
>>>> +			return 1300000;
>>>> +		}
>>>> +	}
>>>> +
>>>
>>> Other than that, this looks ok to me.
>>
>> Awesome, thank you very much! Explicit ACK will be appreciated as well.
> 
> Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Thank you again! Could you please also clarify whether the ACK is for
this patch only or for all of three patches?
