Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F11C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5170B214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfCLIIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:08:36 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:42927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfCLIIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:08:36 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1pk0-1h5oJT2lI0-002Cd7; Tue, 12 Mar 2019 09:08:15 +0100
Subject: Re: [PATCH 09/42] drivers: gpio: sprd: use
 devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        andrew@aj.id.au, f.fainelli@gmail.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, hoan@os.amperecomputing.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, keguang.zhang@gmail.com,
        vz@mleia.com, matthias.bgg@gmail.com,
        Thierry Reding <thierry.reding@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        ssantosh@kernel.org, khilman@kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        jun.nie@linaro.org, shawnguo@kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mips@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1552330521-4276-1-git-send-email-info@metux.net>
 <1552330521-4276-9-git-send-email-info@metux.net>
 <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <38a0ea2f-2324-ab21-b43f-bb3b883c1422@metux.net>
Date:   Tue, 12 Mar 2019 09:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7kp3CTNIjP8fQZihDt/5NEvRYsUQk+F2Del87vNTmG6InfLB8n/
 nYxO59Bvt6L4LSVhczvjU/Zpm1pbcLZfYE3pZBu0tS/P1k+Qhw2MD/SXVAzZqy9+KCzwBBP
 ocBc1Wq6IJ7EvLm/7Zb9WbYTEgwZFbHUGTZPeBLSW5fPE+emyflt2sGbO8ZvYeno0MOoqQl
 ZiIV14ccCpjX614dtd7JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RCwlRC2elJM=:vJrfOit/IJULJq+HqQcjUv
 Ivl+ayL/io9sW40Coh3s/iuXGqey8e1HzTBlTEjk1x0P4MqZJPsPDHXAaH+/RKCkT+/5ZNY0N
 NxRc0Sd0AwFyhTIUSPXlsxFG8MwogIN3hQa1yxnMSJ4h1Q5g4vuWE25PHv0n1eNa/YAdB+4Yy
 rov2jUMHlRw/1Nlk6XddE/0fOMRJSsatqwXbLNd0oy6jeYVwas0bStk+KsVbRsGJg8Tx8Hpqb
 M++jXJTl3rzQtEeYYK2QkTFS4eBedEqijyDVoZkrRKE0CU+WctdZsmfKsqScP7XN0Htl7MMBv
 02rMy35uPQTQHy5KuViWQ6+M6mEI+5YBYv8nzYGPHt3lOZzScUdLrz3l3arfn0te8nwLsHwvw
 pljZu34bvx2HZrj8rsgrUnEvWr/tE46OO3ynzxJSN9l6HNKt8lz7SxmINWNhXuwZw4IJCtAvl
 octi6lXkLdQg5Lt2TCVQDnfqrN4Om3fePSAVGjSfUlFl6Z4K4ZJJXOa7hCdr9sf6kv03uJ0la
 dcfYiEirlNiWHDTZMB/aXB1v3qP76ICSUF7Sbb8mhHuvcE+CjAe+hNS/P7o6pxqf2OIZ3axou
 cfbKcDK/8u8bGNJT7zEY7GaWoP22D/k6wmx8DWvSSclc4bOB68fFFUxdnhwyWaXvdOzVYxWEi
 bSt6Uwcp5iRDG41HC59J6i6s3mvfkhyps4T5iRWO3RE/hGfHRuccZCXoFxzF2lC5knw2Ze9Hn
 /KWKolSmkBkUo5cAPqbM3BlCdFhvH+iw8TQdRqy75phOQ9TQYNmWmNW5uaU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 03:38, Baolin Wang wrote:
> On Tue, 12 Mar 2019 at 02:55, Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Use the new helper that wraps the calls to platform_get_resource()
>> and devm_ioremap_resource() together.
>>
>> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
>> ---
>>  drivers/gpio/gpio-eic-sprd.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
>> index f0223ce..c12de87 100644
>> --- a/drivers/gpio/gpio-eic-sprd.c
>> +++ b/drivers/gpio/gpio-eic-sprd.c
>> @@ -567,7 +567,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
>>         const struct sprd_eic_variant_data *pdata;
>>         struct gpio_irq_chip *irq;
>>         struct sprd_eic *sprd_eic;
>> -       struct resource *res;
>>         int ret, i;
>>
>>         pdata = of_device_get_match_data(&pdev->dev);
>> @@ -596,13 +595,9 @@ static int sprd_eic_probe(struct platform_device *pdev)
>>                  * have one bank EIC, thus base[1] and base[2] can be
>>                  * optional.
>>                  */
>> -               res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> -               if (!res)
>> -                       continue;
>> -
>> -               sprd_eic->base[i] = devm_ioremap_resource(&pdev->dev, res);
>> +               sprd_eic->base[i] = devm_platform_ioremap_resource(pdev, 0);
> 
> This is incorrect, since we can have multiple IO resources, but you
> only get index 0.

ah, right, it has to be i instead of 0. thanks for pointing that out.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
