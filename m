Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AB7C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECC520692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKZf3dCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAHAk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:40:29 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44739 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:40:28 -0500
Received: by mail-lf1-f68.google.com with SMTP id v201so1081224lfa.11;
        Tue, 07 Jan 2020 16:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AsNSAeUSLEvG8cVF7Bdu6WObY7fwE5EsiO3gQY1hxQk=;
        b=iKZf3dCcAbUmRZ3aakrNgUMaW2Fd9u2iydGCuWnYvubFASburd76XPfbooY+kWI+H2
         ZSoDU59ePTDDS648a/2bkAkIVuzT7AqvcLNIrxMJqeEbLtEzra5LX7dYB+CSCGVF/D9x
         AX9CVcqpAl3fdHXicI/yWGZuOexzr+SwsnKo3pijn6rrxtQqR+VMbJIWK/I7wexAqm9n
         aCbaOysM5VgJ54NuwrWgoK6qSi+FqiMLxTzyAe5lAYVgvGoAhHhZ6fDJ3DFCBFwsWe7n
         k8DQ28e9vcADxPHtj2k4DIDeyWhHZuc33eO1HGjJ6pBT6+QVIdM1wNkuBgLYEsplh5pY
         DZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AsNSAeUSLEvG8cVF7Bdu6WObY7fwE5EsiO3gQY1hxQk=;
        b=MSrUEmA+umfgZ7w6njfMS0zCMEtQfF2eeLKqSryDF9mAwKT/vW2MlVcK6MjKAMdIwG
         YinnfpIdBb101duEiLkxhRZmESCVaGHlsNbFfjlnF4yMbsgOe2oSohikNdkwpnDqSaDU
         1499nb3YXQt3UoiW6Dv4F+ROCocPl/SmpqwqRBh6/phkMHGxaa4eZBycbvdh+B1VRMXO
         ymFUxwea75ytnIxMmBJ0ncwuGYaUNQoUE5NmMkulIGGZGAiJOFhk0j0Vq7bJ349BG5i6
         QPN8zX/ZJ879Uou1Co9X2J0moDuAA7lPTcRwlbHUAZxxTPNPrEwtTDy5hOhoYzOBsZRL
         nY7w==
X-Gm-Message-State: APjAAAVPEW6tutsFAN36kcDjlY0z+bCUhgCXUo+QgPsigqLLRQ5jgfAv
        enN1npcc63b/Af+PQhKQcyCDtOaA
X-Google-Smtp-Source: APXvYqzh7+I6PHukNrguHLcLjjF3rIENdxDgyWXyHV6NTjtp3LKm2Uw1oj1K4SZ/RhS7JhrFlR8fMA==
X-Received: by 2002:ac2:5983:: with SMTP id w3mr1240717lfn.137.1578444025757;
        Tue, 07 Jan 2020 16:40:25 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f30sm451293ljp.31.2020.01.07.16.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 16:40:25 -0800 (PST)
Subject: Re: [PATCH v6 00/19] Move PMC clocks into Tegra PMC driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578370458-3686-1-git-send-email-skomatineni@nvidia.com>
 <20200107122152.GD1964183@ulmo>
 <1f7d3c1e-115c-e08e-240b-c4df9e68543d@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f6a28f8d-5061-0be5-2530-966c3a25aaf4@gmail.com>
Date:   Wed, 8 Jan 2020 03:40:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1f7d3c1e-115c-e08e-240b-c4df9e68543d@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

07.01.2020 19:50, Sowjanya Komatineni пишет:
> 
> On 1/7/20 4:21 AM, Thierry Reding wrote:
>> On Mon, Jan 06, 2020 at 08:13:59PM -0800, Sowjanya Komatineni wrote:
>>> This patch series moves Tegra PMC clocks from clock driver to pmc driver
>>> along with the device trees changes and audio driver which uses one of
>>> the pmc clock for audio mclk.
>>>
>>> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
>>> are currently registered by Tegra clock driver using clk_regiser_mux and
>>> clk_register_gate which performs direct Tegra PMC register access.
>>>
>>> When Tegra PMC is in secure mode, any access from non-secure world will
>>> not go through.
>>>
>>> This patch series adds these Tegra PMC clocks and blink controls to
>>> Tegra
>>> PMC driver with PMC as clock provider and removes them from Tegra clock
>>> driver.
>>>
>>> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru
>>> Tegra210
>>> and clock driver does inital parent configuration for it and enables
>>> them.
>>> But this clock should be taken care by audio driver as there is no need
>>> to have this clock pre enabled.
>>>
>>> So, this series also includes patch that updates ASoC driver to take
>>> care of parent configuration for mclk if device tree don't specify
>>> initial parent configuration using assigned-clock-parents and controls
>>> audio mclk enable/disable during ASoC machine startup and shutdown.
>>>
>>> DTs are also updated to use clk_out_1 as audio mclk rather than extern1.
>>>
>>> This series also includes a patch for mclk fallback to extern1 when
>>> retrieving mclk fails to have this backward compatible of new DT with
>>> old kernels.
>> Hi Sowjanya,
>>
>> this looks like it's almost ready to merge. Can you highlight if there
>> are any build-time or runtime dependencies between the patches? The
>> audio driver changes seem to be mostly isolated from the rest by the
>> fallback implementation for legacy device trees.
>>
>> Is there anything that I need to keep in mind when applying these? And
>> would it be fine for Mark to pick up the ASoC patches separately from
>> the rest?
>>
>> Thierry
> 
> Yes, ASoC patches can be picked separately.
> 
> dependencies are b/w clock and pmc driver patches.

Technically, the ASoC compatibility patches should be applied before the
CaR changes. But perhaps it's not critical if audio fails during git's
bisection.
