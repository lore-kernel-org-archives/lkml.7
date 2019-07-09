Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9591EC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A120861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 21:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLgwzCz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfGIVET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 17:04:19 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40424 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGIVET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 17:04:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id s145so227798qke.7;
        Tue, 09 Jul 2019 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aEogp/cBvpbqRpq9HNPTDGBPzInEZSXBFxGFWaMG1AM=;
        b=jLgwzCz9+zRNaNgqU1yTRHMOC0sD/PbzqlpKe1j+xds1BV0y9Eg4wutDD5/kICyDkV
         iIRECLZ0QEtHw+LQc+XPmegDwYs2L3AakvdIHCkQ5oyYscCs7rOcQOLSuMH24DLC3vxR
         v5z9Rxh4CKZpbZ6KstYNFO3BtYNZuJWL9lNLKD8floP78nSvqhHWBt3CupBCnNpgxA+8
         JOHIKNWma5iW+ZKBFulpzZ1JrsA6sD8gU5hjwpBqw3pn4EWN9eyULn4IjR4IYz7KpA07
         fLTPeduBPFNd0DERNjVoaDEPf6tKiPFO0Z/1r1BImMvH2zVoOFcP/l9I1PYr/tsf4Go4
         q9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEogp/cBvpbqRpq9HNPTDGBPzInEZSXBFxGFWaMG1AM=;
        b=L2Go+AalE91hMF+rjfIMWKjM+7aQlm8QKV5Ly9kUE6001wKe3cYnNZXPELFLhT7Thg
         4btaS5YT0VCj3NxEnUfnrInUwvH8YjPTIfE2ISOmjRdBhWSy2TzDTJ5VNWnZPchdLKwg
         hS48mjH/A/7HR2Lnq/NKbelRfJTX6GBJw4E/65cdXy8erA3zqnpXhVeHZwA72yq0WQiO
         zwnNDEFH4v+XUvIHFVCcWiFsb9EL+l4L15oIiIi21OoGkEyN2ejxyAKARTf54Ax4maWQ
         L0ixPouB2QyjwQI1nYfulUU/Z9ohjizXaTSEijre3sz9UG33XoYzqFmeTRs5iQofiwKu
         /HqQ==
X-Gm-Message-State: APjAAAWrUiyeb1zsRrlxMU7avjxmndnLr3nkilS676vaNQ3j9iYAFV+V
        j3DjJp8bHeSZ11gbbhLVITg9nAs4
X-Google-Smtp-Source: APXvYqxsnTsrAhygBiAvta/IeP+a0jcZA//lyzZOvNaMpkQT/ZUsA60EkzdlG2QjXDOIKCdE3A/sGw==
X-Received: by 2002:a05:620a:16d6:: with SMTP id a22mr20551083qkn.414.1562706258071;
        Tue, 09 Jul 2019 14:04:18 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id z1sm98720qkg.103.2019.07.09.14.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 14:04:17 -0700 (PDT)
Subject: Re: [PATCH v1] drm/tegra: Fix gpiod_get_from_of_node() regression
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190705151139.19032-1-digetx@gmail.com>
 <9425f0e8-36ec-76cb-b177-fa486fcafc19@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2a4c63f8-9ea7-a017-57f9-1dec0f178a79@gmail.com>
Date:   Wed, 10 Jul 2019 00:04:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9425f0e8-36ec-76cb-b177-fa486fcafc19@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.07.2019 19:27, Jon Hunter пишет:
> 
> On 05/07/2019 16:11, Dmitry Osipenko wrote:
>> That function now returns ERR_PTR instead of NULL if "hpd-gpio" is not
>> present in device-tree. The offending patch missed to adapt the Tegra's
>> DRM driver for the API change.
>>
>> Fixes: 025bf37725f1 ("gpio: Fix return value mismatch of function gpiod_get_from_of_node()")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/gpu/drm/tegra/output.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
>> index 274cb955e2e1..471d33809cd4 100644
>> --- a/drivers/gpu/drm/tegra/output.c
>> +++ b/drivers/gpu/drm/tegra/output.c
>> @@ -126,8 +126,12 @@ int tegra_output_probe(struct tegra_output *output)
>>  						       "nvidia,hpd-gpio", 0,
>>  						       GPIOD_IN,
>>  						       "HDMI hotplug detect");
>> -	if (IS_ERR(output->hpd_gpio))
>> -		return PTR_ERR(output->hpd_gpio);
>> +	if (IS_ERR(output->hpd_gpio)) {
>> +		if (PTR_ERR(output->hpd_gpio) == -ENOENT)
>> +			output->hpd_gpio = NULL;
>> +		else
>> +			return PTR_ERR(output->hpd_gpio);
>> +	}
>>  
>>  	if (output->hpd_gpio) {
>>  		err = gpiod_to_irq(output->hpd_gpio);
>>
> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
