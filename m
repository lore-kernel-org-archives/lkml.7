Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FC7C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED222190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHdt0j1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfGYSoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:44:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56059 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:44:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so45874525wmj.5;
        Thu, 25 Jul 2019 11:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eZg2XLH1NHBQ2/38DmwmZR58KK7aQy+03e1hk0T/aU8=;
        b=fHdt0j1mU6u18B9UpKdbWWXcrUmxKHxSnJK2qj2AtahBcQ2kkpQi5mBTMrl1ToshDG
         HNtMLtmQxXNqU6uVfLThbs4azb5dFOZKvtUTOteqjHmzb/vanxWLJXg7CHvZVGy4wx+x
         zrOup6AqzggKk8SbQjRMHWFoa/OV9Or9SCygHdZq6Bcy9cDZmTTggE0Vmonh9Ao3APCx
         7BwodfYbnQdyf8v96LgI9LQt8571kqbgrM1eCQ90862ZT4ncpmasiBqObBPIZBuWJGse
         pWQWa0SKcjK52oxNmZG5CY44CU+87z1nPVLgxeMcrBFDW6eUlqtWMKnhXr9C5d8aZ7J0
         0raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eZg2XLH1NHBQ2/38DmwmZR58KK7aQy+03e1hk0T/aU8=;
        b=Ncze/bFVXQZ/OlQo4rqG4OiDfdA64bNxZUv9TtQOhBKZcBRdYcB5/zhLBSJDFhppwf
         HBXHkQbUcRmTy+6Rtz/0AvKT8+CCkXxA7j9iXgsb+o9hYQqdRKdgAnNsat85iNxLfqDo
         yQiFbmrFw27gPYApOyR/9qo97dkvABeplCPkma1VcL9VGVL/aD1w+68Oq2aWSymsUbk3
         /bG8ivCVBiVVrBVScTZj40vbV9vke1bGDiG6V38PrIO9laL6mi6n0kdAJe3pEu2wkFBs
         DMfX549pBF97fBKujhexxVHJkimAofjChXPq9nJUyjBj9tc871jefobT8qNjLS03o4tM
         j6lA==
X-Gm-Message-State: APjAAAUJe7/axdcS6Khc/xUvs5MWjsUsn8dWDhQBexhdDLg0pnYr5Ept
        xojzn1CuI81NK/kPZqVLLDs=
X-Google-Smtp-Source: APXvYqx6ItHV8J09Lfes5gWvz63TwgEX+Xp+lIEqJnWhFjtWiWdNHfJ4618A5m6VSL7qumFylYg6TQ==
X-Received: by 2002:a1c:a909:: with SMTP id s9mr80151705wme.20.1564080275478;
        Thu, 25 Jul 2019 11:44:35 -0700 (PDT)
Received: from [192.168.1.19] (bdr31.neoplus.adsl.tpnet.pl. [83.28.3.31])
        by smtp.gmail.com with ESMTPSA id u186sm85701772wmu.26.2019.07.25.11.44.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 11:44:34 -0700 (PDT)
Subject: Re: linux-next: build failure after merge of the leds tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20190725123126.725c77c8@canb.auug.org.au>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jacek.anaszewski@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFWjfaEBEADd66EQbd6yd8YjG0kbEDT2QIkx8C7BqMXR8AdmA1OMApbfSvEZFT1D/ECR
 eWFBS8XtApKQx1xAs1j5z70k3zebk2eeNs5ahxi6vM4Qh89vBM46biSKeeX5fLcv7asmGb/a
 FnHPAfQaKFyG/Bj9V+//ef67hpjJWR3s74C6LZCFLcbZM0z/wTH+baA5Jwcnqr4h/ygosvhP
 X3gkRzJLSFYekmEv+WHieeKXLrJdsUPUvPJTZtvi3ELUxHNOZwX2oRJStWpmL2QGMwPokRNQ
 29GvnueQdQrIl2ylhul6TSrClMrKZqOajDFng7TLgvNfyVZE8WQwmrkTrdzBLfu3kScjE14Q
 Volq8OtQpTsw5570D4plVKh2ahlhrwXdneSot0STk9Dh1grEB/Jfw8dknvqkdjALUrrM45eF
 FM4FSMxIlNV8WxueHDss9vXRbCUxzGw37Ck9JWYo0EpcpcvwPf33yntYCbnt+RQRjv7vy3w5
 osVwRR4hpbL/fWt1AnZ+RvbP4kYSptOCPQ+Pp1tCw16BOaPjtlqSTcrlD2fo2IbaB5D21SUa
 IsdZ/XkD+V2S9jCrN1yyK2iKgxtDoUkWiqlfRgH2Ep1tZtb4NLF/S0oCr7rNLO7WbqLZQh1q
 ShfZR16h7YW//1/NFwnyCVaG1CP/L/io719dPWgEd/sVSKT2TwARAQABtC1KYWNlayBBbmFz
 emV3c2tpIDxqYWNlay5hbmFzemV3c2tpQGdtYWlsLmNvbT6JAj4EEwEIACgCGwMHCwkIBwMC
 AQYVCAIJCgsDFgIBAh4BAheABQJVo39tBQkJZgNMAAoJEL1qUBy3i3wmxLQQAK8QEQ0JqZEv
 5hrxiwT+Qtkx1TULYriK9sYcY9zbi18YxbKB0C4Znh5iP5o7k26WnPGLM+w4qWvTAkHjuAI7
 aBrvb4nGRvE5s14PQ9IHgL7iL3zAAHT1azIZng9dUCCSontB+vQZu1x/Un0lVlVCvsvO7QVt
 hAZUlT3iucNMO0jpCiS3raZkNfab8M+JWP/iplaV0Kn+O7LX3A/RdLmx5ZhuT+zvyHwl2c3K
 T56UHaQnjkuHB2Ytk8HtOjNXGNYnm4nLx3ok3jEN1nWDRV/DeiPn8zz4Zebsp686OH9vvX/0
 R4dk2YEjUCY/S7CbJxXzUnLjboUAGmtTVOu/uJ7y11iS9XEoJ09HEzijQwWctJXLojcTXCFw
 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
 eGGiEQ==
Message-ID: <bf55a00a-18f5-d7c4-cae1-8c110b9f0e13@gmail.com>
Date:   Thu, 25 Jul 2019 20:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725123126.725c77c8@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/19 4:31 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the leds tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/leds/leds-max77650.c: In function 'max77650_led_probe':
> drivers/leds/leds-max77650.c:121:8: error: implicit declaration of function 'devm_of_led_classdev_register'; did you mean 'devm_led_classdev_register'? [-Werror=implicit-function-declaration]
>    rv = devm_of_led_classdev_register(dev, child, &led->cdev);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         devm_led_classdev_register
> 
> Caused by commit
> 
>   4eba5b82096e ("leds: class: Improve LED and LED flash class registration API")
> 
> interacting with commit
> 
>   5be102eb161a ("leds: max77650: Add LEDs support")
> 
> I have used the leds tree from next-20190724 for today.
> 

I forgot about this driver jumping in lately.

But here is the fixup and the rationale:

devm_of_led_classdev_register() API has been useless from the beginning,
since it was just an initial portion of work aiming at adding some
generic DT parser. The actual parser had not been added up to this
commit which also switches the API:

devm_of_led_classdev_register(struct device *parent,
                              struct device_node *np,
                              struct led_classdev *led_cdev);

to:

devm_led_classdev_register_ext(struct device *parent,
                               struct led_classdev *led_cdev,
                               struct led_init_data *init_data)

To not break the bisectibility The remaining users of
devm_of_led_classdev_register are being fixed by this commit to use the
wrapper:

+#define devm_led_classdev_register(parent, led_cdev)           \
+       devm_led_classdev_register_ext(parent, led_cdev, NULL)


leds-max77650.c is the one that was omitted, so I've just applied
the following fix to this commit:

diff --git a/drivers/leds/leds-max77650.c b/drivers/leds/leds-max77650.c
index 04738324b3e6..5a14f9775b0e 100644
--- a/drivers/leds/leds-max77650.c
+++ b/drivers/leds/leds-max77650.c
@@ -118,7 +118,7 @@ static int max77650_led_probe(struct platform_device
*pdev)
                of_property_read_string(child, "linux,default-trigger",
                                        &led->cdev.default_trigger);

-               rv = devm_of_led_classdev_register(dev, child, &led->cdev);
+               rv = devm_led_classdev_register(dev, &led->cdev);
                if (rv)
                        goto err_node_put;

and melded it with the original one to not break the bisect.

If you have any doubts please let me know.


Best regards,
Jacek Anaszewski
