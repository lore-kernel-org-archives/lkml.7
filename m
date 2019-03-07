Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58976C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4ED20643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 12:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XzcJiphy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfCGMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 07:24:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfCGMYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 07:24:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so17182880wrw.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 04:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7veNOkOBMOHYQYQ5qAUsZ4TefU0NoJhPVm2uWK3bSR4=;
        b=XzcJiphy7psG5kJgztpHslGpkdlYbpOo8KRCUwf/kYatg4Z2YslmiRM9ngiwzI9wvD
         v/PIPfh64c8rB9UETONdln7Pp/TCD8kTqv5Z3c0FX8sLXsb/59JLDsvmNxg85KtqoDLU
         jgBxyyL7eJ8hJb2nYSt4EiUqPgYyLw0CmeCvdH2fTibjVFy4M5eoLS2XNBZOC3+gU6OE
         hySBVHxUlVSPYChK550EZyhPfqmnNBdsRliarzEzXhvoYiNAdPY8a2l9comLWeqbWvm7
         izXSZucjYzDHvEjOcGbpdjIM1TeKktphyDgVcMiICtFn91XraPI0xAg8+4KPgyalah+r
         6NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7veNOkOBMOHYQYQ5qAUsZ4TefU0NoJhPVm2uWK3bSR4=;
        b=mJgE4UmTh3rNDRHxeT+EEiwqnM9tfvFqBYaA5vYfjqiLGMCC9yQVeZiBHJA1oa0C4U
         kWUWoO3jcZe70+kYcQkW3i2d21qBV+lbWWL+YsqfPO72nlOqtRstZJHqdNBYL7aFT7eL
         0wtZ9+mWIYHJORtpkDBNdEI15E8/fpt28QfpHN9/sdjNxzuHVHMyhe/Mv/J0we3+l6T0
         MubyhafqENXpgOEPqh0dUgIy3fnZHBLKsQMeawXk+xU7ZgpQOUm6UXvNqo6CvduCza9Q
         3QgiFgtngPVJy2Ps3n+LdLK9FlUCkCWCZTUzDccn6yU4P7DWMoJCj3VHn7/WR/kak4De
         AO4A==
X-Gm-Message-State: APjAAAWb0rTmT+MBROVzxT3AoaEoX/6WTh8kv+Si9BEUCzxXt/VxCsAc
        4HXNVd7M5NmX3tpb5k4OmX9fdw==
X-Google-Smtp-Source: APXvYqzjOy7w+ZiZjoHAzcGbo1pddOqkBpS00tx/1rJWE4gPJXOk81wFw84moR3zLLv6reoBVCRFPw==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr7259095wrr.175.1551961486784;
        Thu, 07 Mar 2019 04:24:46 -0800 (PST)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x6sm8314829wmg.0.2019.03.07.04.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:24:46 -0800 (PST)
Subject: Re: [PATCH v2 2/2] clk: meson: g12a: add cpu clocks
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190304131129.7762-1-narmstrong@baylibre.com>
 <20190304131129.7762-3-narmstrong@baylibre.com>
 <CAFBinCAax7=dbLxTNtSrJJthuFb02+7YMyGwpie28F1bnr0qRw@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <1e0f2d89-7fc1-a2d1-6691-60ff9e1098e8@baylibre.com>
Date:   Thu, 7 Mar 2019 13:24:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCAax7=dbLxTNtSrJJthuFb02+7YMyGwpie28F1bnr0qRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 05/03/2019 22:10, Martin Blumenstingl wrote:
> On Mon, Mar 4, 2019 at 2:12 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> Add the Amlogic G12A Family CPU Clock tree in read/only for now.
>>
>> The CPU clock can either use the SYS_PLL for > 1GHz frequencies or
>> use a couple of div+mux from 1GHz/667MHz/24MHz source with 2 non-glitch
>> muxes.
>>
>> Proper DVFS support will come in a second time.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> in my previous review I criticized that the post-dividers are not
> mentioned in the description.
> it's not part of v2 but after having a closer look again I think it's
> not a big issue:
> these CPU post-dividers are all marked as read-only and have a comment
> that "ROM monitor code" manages them.

Sorry indeed I forgot to say a word about this, but you pointed the right
thing, they are only here to be complete, not to be used (for now).

Neil

> 
> disclaimer for my "reviewed-by":
> - I don't have access to the datasheet so I can't verify if the clock
> tree from this patch is correct
> - the latest buildroot code with G12A support
> (buildroot_openlinux_kernel_4.9_fbdev_20180706) doesn't have proper
> names for all clocks
> - this review is based on my experience with Meson8* (where Linux also
> manages the CPU clock, unlike on the GX SoCs where it's managed in
> firmware)
> 
> 
> Regards
> Martin
> 

