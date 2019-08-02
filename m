Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C6C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8791A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPOtpmT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436689AbfHBOja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:39:30 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46334 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404220AbfHBOj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:39:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id z15so48835671lfh.13;
        Fri, 02 Aug 2019 07:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SpNFo9StfmwwHxpdy9OKgPMJoL/SjVvfZYNNHX88rJw=;
        b=QPOtpmT3sc6xjB4gDOxj9miQ/x3G/LgS39VjsELPa71DYtG+tFNXMqX9s+7fcEJfJf
         VYwbaO4yrMQcjFwCKESj1OYt5VvTMkXM2/mnNxLQCEvgpfCgpbXOO8uoKOsS4UVHwgi4
         t+updFHtg680hN9BOyEmdettYP06MNUthz/QpYGLsMaA6AflYiYWH3yRfv32vyZOII+F
         fZcatd1GIWmbwA6xBE2wOgQOCZ+M5LB6dK8I3Iw0JP9anUqcIFZg4XzQwWcVPwPbbnNi
         5iXtaRvfxenOAkVk0YFUzheKbsfmvwMU3R4quQWT502/JnXb4660jdzHYICxDrpuA/ZF
         mK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SpNFo9StfmwwHxpdy9OKgPMJoL/SjVvfZYNNHX88rJw=;
        b=KlJQ5gebA0P2c44UtF4Yjbp5FqBq7TBLealTMIZPEQJLxUR8YI84MBMkjI611C+Rl9
         V/qTRc7RoeymLjwZ3lFuA0/G+k5TzwMAaGU56xGgCILjuRXDO6JUqbJ2mZzT+kg2qcg7
         kx3qceuPv4MabNKWt1Xrtu4jPB3xOCYDhGy98ktZCKYxjNRnR/RuyX17QsMCjG19YIKA
         UwR6BQPjRG1NftkyPc2eA58iQnnNHMp5JkdOjUSC5YiNYAaBmASWH4LAiUsA0W1hK0OG
         SJI5RmKJO/vfniC8/ZTqqEv7jsR3Dw4HZik5TRLiQcOkvZKelU8xOjgF3PW0rOC3rdIr
         LEGA==
X-Gm-Message-State: APjAAAUnbhCUQYi8y04VcZpusX16EPyuGPLv6DrIxHUI4z622QcChBiS
        XtHqAjHgPPFV3dNSQhmpMXzJwJeL
X-Google-Smtp-Source: APXvYqwok89bRyI+iWSvz2czFFM3YXHk+pef6YyvCjiXtiyXhcYcEfD3Zep26M3u5pT6DWSi9v4NIA==
X-Received: by 2002:a19:ca1e:: with SMTP id a30mr63329282lfg.163.1564756765327;
        Fri, 02 Aug 2019 07:39:25 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.googlemail.com with ESMTPSA id a15sm12868970lfl.44.2019.08.02.07.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:39:24 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c537fbea-5884-03db-305f-6ab3d553f7ab@gmail.com>
Date:   Fri, 2 Aug 2019 17:39:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802140512.GD3883@pdeschrijver-desktop.Nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

02.08.2019 17:05, Peter De Schrijver пишет:
> On Thu, Jul 25, 2019 at 06:18:32PM +0300, Dmitry Osipenko wrote:
>> Add regulators coupler for Tegra30 SoCs that performs voltage balancing
>> of a coupled regulators and thus provides voltage scaling functionality.
>>
>> There are 2 coupled regulators on all Tegra30 SoCs: CORE and CPU. The
>> coupled regulator voltages shall be in a range of 300mV from each other
>> and CORE voltage shall be higher than the CPU by N mV, where N depends
>> on the CPU voltage.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/soc/tegra/Kconfig              |   4 +
>>  drivers/soc/tegra/Makefile             |   1 +
>>  drivers/soc/tegra/regulators-tegra30.c | 316 +++++++++++++++++++++++++
>>  3 files changed, 321 insertions(+)
>>  create mode 100644 drivers/soc/tegra/regulators-tegra30.c
>>
> ...
> 
>> +
>> +static int tegra30_core_cpu_limit(int cpu_uV)
>> +{
>> +	if (cpu_uV < 800000)
>> +		return 950000;
>> +
>> +	if (cpu_uV < 900000)
>> +		return 1000000;
>> +
>> +	if (cpu_uV < 1000000)
>> +		return 1100000;
>> +
>> +	if (cpu_uV < 1100000)
>> +		return 1200000;
>> +
>> +	if (cpu_uV < 1250000) {
>> +		switch (tegra_sku_info.cpu_speedo_id) {
>> +		case 0 ... 1:
> Aren't we supposed to add /* fall through */ here now?

There is no compiler warning if there is nothing in-between of the
case-switches, so annotation isn't really necessary here. Of course it
is possible to add an explicit annotation just to make clear the
fall-through intention.

>> +		case 4:
>> +		case 7 ... 8:
>> +			return 1200000;
>> +
>> +		default:
>> +			return 1300000;
>> +		}
>> +	}
>> +
> 
> Other than that, this looks ok to me.

Awesome, thank you very much! Explicit ACK will be appreciated as well.
