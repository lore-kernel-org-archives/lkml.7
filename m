Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D246C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF1E206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmKbeIZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDDTcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:32:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfDDTcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:32:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so5262995wrq.1;
        Thu, 04 Apr 2019 12:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ut9ZIcQEIyOfCvwVYiwns6AsZHwULo05/EUMHjy0wrI=;
        b=dmKbeIZkzw/Ft9WcPngeUkMFMnpSwyYVjH3F2qQwp5UtMqsSx86QuJfQv9xsPIgRa5
         48uhOCvvrguaMl3C510eaOgAJQtFu/aRf0BdnR8wwJ3atzFReKtzZGECWtTLFHkTJJ5p
         CIJIVwGv1GTyiG0og7p5t/i9m8TJ6CHFhoSWz2FptiQhC+StKMdznf4P8IbgtBoLWKjd
         WxcZnZRUbfys1xV1PEz1NwLOWw8lNJz8rpQp9p5cLg3BiDGwmkVejY44lNWiGVPoGcYx
         WqEpZQOHZiSCsYYQStuisWhaZJ1bV0VLMbjxzHe7EIlpXAQrWXN8YE53Qb1s8PON0ayV
         aXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ut9ZIcQEIyOfCvwVYiwns6AsZHwULo05/EUMHjy0wrI=;
        b=ZCS+8jlFbh29OFmEySI2hBLr96X5PG8USmv/GP3r8nb6mqWyHjmQUrxFT++CZ/2viL
         XQPcGxEcAhn/KvUA4wV5P+LbjBXQ860RzZwC6Zi1y5SdhUqvLISX9BBIpVhUSpko/ORG
         uRfqcKwAdlRTfhZ/txwe0xW9W+0DBqnb3Q1rd04pSPMU3GwDxja+SyE3eAk+7gLvjeI5
         bNNTHmvCloCGXsZ5gaB8gsretPHTFkQT06BNRLKaToa5A6b6zPLu8czW2+ngENgyX66k
         smioD2UvOD8pbZCOt6CLq3hUos7Xr5rAUlA2d86rtlNXCM9G6vIod9uI6+CxqBK1BHfa
         8dnw==
X-Gm-Message-State: APjAAAXCcnDtuKJ7ILj08b2TWVqcd5+PoaAHWpCzOieQdW6nwzeGJu8g
        TI6uFdHPMC0DWWg99jeu1MUqw7Do
X-Google-Smtp-Source: APXvYqyhnaNAdX/151eu9l/GRRK7l50NFS9BjjX1mGAUtf2JCs2L8MqjS4AzFehh6HU5l5PAgK1AHw==
X-Received: by 2002:a5d:5284:: with SMTP id c4mr5566902wrv.281.1554406319435;
        Thu, 04 Apr 2019 12:31:59 -0700 (PDT)
Received: from [192.168.1.19] (dkj99.neoplus.adsl.tpnet.pl. [83.24.13.99])
        by smtp.gmail.com with ESMTPSA id o130sm32402784wmo.43.2019.04.04.12.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 12:31:58 -0700 (PDT)
Subject: Re: [PATCH 3/5] dt-bindings: ti-lmu: Modify dt bindings for the
 LM3697
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20190325142403.30447-1-dmurphy@ti.com>
 <20190325142403.30447-4-dmurphy@ti.com>
 <4e38128a-fa8f-aa94-284f-2c5a4906e17d@gmail.com>
 <83e31761-714d-db83-8c35-cf45243cb50b@ti.com>
 <4983e0b6-ae2b-9d15-0408-fdb23869711a@gmail.com>
 <28007702-cee0-079b-ccda-864f98a7b520@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <2b80bc24-54dd-16d9-a024-d2340aec6547@gmail.com>
Date:   Thu, 4 Apr 2019 21:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <28007702-cee0-079b-ccda-864f98a7b520@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/19 9:27 PM, Dan Murphy wrote:
[...]
> Maybe I should rename this to ti,brightness-resolution with the same values.
> or ti,brightness-res for short hand.
> 
> Or I could try to figure out the max-microamp but it really does not describe the hardware or
> the configuration.

ti,brightness-resolution sounds good to me.

Rob has the last word, though.

-- 
Best regards,
Jacek Anaszewski
