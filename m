Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0A1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02242089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CMclCEjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfG3HQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:16:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37840 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfG3HQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:16:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so55588720wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CJsSNfY0mqrUC/YwU9xthUF4qULj3egsKAW0izWqbew=;
        b=CMclCEjk0ZwGT0UKhUhteWTHe+Ssve3/diYK0hb0jopkULcSn6hYPcrFB3JAA1RGFu
         759vTHQhFDBVGXHh7bSEoU1TxNSzrKuYqY6SZRN65IlQ5SHj9DWv1cvcTZL/ksKksoSr
         WhRZpBkGY1m7Of8SsJeLq4YNzrTpSSnLvY9QOwWGoSXwwg0ZL0k5ghdCWTnJZaz1BsFC
         2+AYQHH61QBZwT72zlCMlC54F5asO1+hBFVNw9M3m0JpXL4Wj5mfJiHmcL6zEntvu+hM
         dQ/Rvd13FdzX1IXFVu/IPHC6hyyIMOMUZDzzCCmVVTZUZngoznNsOXSVbAbnSmucvs/T
         4WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CJsSNfY0mqrUC/YwU9xthUF4qULj3egsKAW0izWqbew=;
        b=p9gfuFehcoKw07l/CltiXyeaowF/eIB/dbkN6DZdW5BWQ/Y8P0z8jlfavMft8OqG88
         dBmCUxhdGjTs9JXmfirhermK9ElmtOSTCCHe+oyAKIEQm4NygVQwkiDIZegVnJJrwaNJ
         pJwXMJiaau4JaT8QaHPu4bqZRWx87LpG3FgpFwo1izgU6GugML3ZCTW+/QkoTK9NBrIR
         shhpb8wK+741Zqeaa8zr0ExVPYVHuq7ypvAPBl2biVcknDeg7YkvBX5ZymaICQmDxxnV
         CwMKjp9J3hRS2X1KJQcQ8lIji54kyDWJTbJKXPmgshxU5WYoT+xt4mqTtD5TMuw+mKhj
         CAhw==
X-Gm-Message-State: APjAAAXOYeEEzA4QelFGxtkzluylzpwLiydPWADzhmGNF6NdVIKrA8hB
        9XuGwPWQpi6jR6cUCfpXqyEpPcGXjE4=
X-Google-Smtp-Source: APXvYqzNdHpUKuNShIQ7fuZIz7FKvr2+m6gWQ/l+o20rxgU0SEoN5hvd9TKY8jVLr6hYGYOcQotSgA==
X-Received: by 2002:a1c:f914:: with SMTP id x20mr25700078wmh.142.1564470999447;
        Tue, 30 Jul 2019 00:16:39 -0700 (PDT)
Received: from localhost ([2a01:e34:eeb6:4690:ecfa:1144:aa53:4a82])
        by smtp.gmail.com with ESMTPSA id w7sm73283967wrn.11.2019.07.30.00.16.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 00:16:38 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] clk: meson: axg-audio: add g12a reset support
In-Reply-To: <20190729222944.116DF2070D@mail.kernel.org>
References: <20190703122614.3579-1-jbrunet@baylibre.com> <20190703122614.3579-3-jbrunet@baylibre.com> <20190729222944.116DF2070D@mail.kernel.org>
Date:   Tue, 30 Jul 2019 09:16:37 +0200
Message-ID: <1jk1c0uh4a.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jul 2019 at 15:29, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2019-07-03 05:26:14)
>> @@ -1005,8 +1087,27 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
>>                 }
>>         }
>>  
>> -       return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> -                                          data->hw_onecell_data);
>> +       ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> +                                       data->hw_onecell_data);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Stop here if there is no reset */
>> +       if (!data->reset_num)
>> +               return 0;
>> +
>> +       rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
>> +       if (!rst)
>> +               return -ENOMEM;
>> +
>> +       rst->map = map;
>> +       rst->offset = data->reset_offset;
>> +       rst->rstc.nr_resets = data->reset_num;
>> +       rst->rstc.ops = &axg_audio_rstc_ops;
>> +       rst->rstc.of_node = dev->of_node;
>> +       rst->rstc.owner = THIS_MODULE;
>> +
>> +       return ret = devm_reset_controller_register(dev, &rst->rstc);
>
> IS this a typo? Just return devm instead?

Typo it is. Thanks for pointing it out.

>
>>  }
>>  
>>  static const struct audioclk_data axg_audioclk_data = {
