Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D9C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B976D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WBBikcoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfDLI0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:26:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfDLI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:26:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so6114247wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UOW41HO6lrsR+5mvtCNU1KtBZgKhCRxtYa63HbUZJOU=;
        b=WBBikcoZHOSXicIGtDHTwg2RtoqwmlvNRR8voCOgFOeKSjFXhUaAYc0hlVR30kAOE2
         PA0zGiHNtsyhL1McDLJgBWv+ARyItcgfrYFPgn77HX5iUWuYzkZn/WYTxqTA+ZlUwU1h
         qUNhk1PCBt7qepZvER6Tli1XgueXEIHwnYE2P0kml+STzjWIazH82s+fGYUCkC5BKl60
         0B9eeuKca2rgQSwZm0dYrMSEjonFSA8fj1xofijZ4+Ydnd9ZGfnmuYGZ886BfFMLl10F
         51YfyeZSYQx22O0g3I3HGD7nsuVEFsf172MWdN/u1omoEbs5hl6xb2w/nFhx+c96PO2e
         UQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UOW41HO6lrsR+5mvtCNU1KtBZgKhCRxtYa63HbUZJOU=;
        b=rTTr0upo5jupHdxIRABAXx2NxvCI49V857XPYweD8ED2BcG2Nxe2VvT9AzmJnyCorQ
         b1fy9rYa3TnjV62UopyG9lNhvBhiOuOC+MZNVhAf85zW1h0fGwU+5PVxtMWPoXkUCI1D
         mml2bQ6Al8M6TS5+zFCdFjtYp5mA7I2TadU0Tx3aPtKHVubCyDItvOMXSKkGINauf+FU
         SfNkFptwdu5USGSN0QHqLgGe1ZsYwY8yuef2KtuNmEl3IEn7/okhSdlZ69BSUwfpq/Vx
         e2hC3AyVLna2fYckxAauWanTc3SrS9fR6vDp2/hwI8UQOSdnGn1F6FCjo/NCfpxoErbi
         SJiw==
X-Gm-Message-State: APjAAAXrD8SaUyu9/CCYjDoe5v+h36KASETMkOJ/nhnrUwLtEH605ukc
        I0Li27l264NayHAeINQGydy37A==
X-Google-Smtp-Source: APXvYqxXnP+B81+W5eB+L4owjsY8VobAmLyuh5RAdQ9I0t2cV8IAAjIvYGOKGN9XPftPTh3+tAepTQ==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr17178944wrx.76.1555057558348;
        Fri, 12 Apr 2019 01:25:58 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e7sm9375295wme.37.2019.04.12.01.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 01:25:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] clk: meson-g12a: Add Temperature Sensor clock
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, Neil Armstrong <narmstrong@baylibre.com>,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20190411084537.30299-1-glaroque@baylibre.com>
 <20190411084537.30299-3-glaroque@baylibre.com>
 <CAFBinCBVmPa5hi83B1ZTe-guassHxKQFrN5QOyMJc9s95LJ1cg@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <fc4e0fbd-2643-2f37-9cdb-2ec162826e76@baylibre.com>
Date:   Fri, 12 Apr 2019 10:25:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCBVmPa5hi83B1ZTe-guassHxKQFrN5QOyMJc9s95LJ1cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi martin,


On 4/11/19 11:38 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> On Thu, Apr 11, 2019 at 10:46 AM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>> Add TS clock used by two temperature sensor
> thank you for working on this!
>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  drivers/clk/meson/g12a.c | 31 +++++++++++++++++++++++++++++++
>>  drivers/clk/meson/g12a.h |  3 ++-
>>  2 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
>> index 3a3134976534..e6d2af6ee8ea 100644
>> --- a/drivers/clk/meson/g12a.c
>> +++ b/drivers/clk/meson/g12a.c
>> @@ -2335,6 +2335,33 @@ static struct clk_regmap g12a_mali = {
>>         },
>>  };
>>
>> +static struct clk_regmap g12a_ts_div = {
>> +       .data = &(struct clk_regmap_div_data){
>> +               .offset = HHI_TS_CLK_CNTL,
>> +               .shift = 0,
>> +               .width = 7,
> buildroot_openlinux_kernel_4.9_fbdev_20180706 uses ".width = 8".
> That matches with the public S922X datasheet from hardkernel which
> states that HHI_TS_CLK_CNTL[7:0] is "ts_clk clk_div"

sorry for this error i'll fix it

>
> Martin

Thanks

guillqume

