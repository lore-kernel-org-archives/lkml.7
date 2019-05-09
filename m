Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C8C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BDF20675
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr2gDwCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEIRtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:49:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32828 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEIRtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:49:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so4265285wrs.0;
        Thu, 09 May 2019 10:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0/UR7KuBk7jn3GdiXeodrKFMGjiBmRvYd8mwzpA5/pQ=;
        b=Lr2gDwCHh+okjR5BMJoyAUcTWx2e7xJCBSFaC2JjpvhMZiM7r0e3wgnMGmmTUWVCeG
         Zv8nRv/DH1GU3rCUBk71aYdRxzDHb0L67ODR1lbZSr30yncbPJzsTXMTKASFdt/le1f0
         5DTT4izNgzSVdFjb/EyfnmphquHq6Z+D71PAJsxsGDj8xVc5tE40SrYHHkF7VA2a6ozG
         068Q3H2JF/0Cak9ac+8L5fVCxB+WmdWXVU0+a8XbVtrSKMIzWTt69AZCXLR1glOXWwEo
         7hn9l2SkHAtVG1iDv6sPJHk0HTSCkRCCTlCp0ONX5Y6XSD+1JcxuOjEGk8fw1yHvsD3R
         a5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0/UR7KuBk7jn3GdiXeodrKFMGjiBmRvYd8mwzpA5/pQ=;
        b=jKBYkcvP9HTc/+ythuAEjaTSV36C+OoIedS7hvuFHgOSTAHsHx/LmbmFZeHvuA53zZ
         9FxaEiG8zEMJQ4Xb2judJ7qzsQWM8Y5ARiBgrHhSD/CTKotSNAIZynSLgToQXkD6ST6O
         prK5ntQVqx4bJ7Vh8X+xq5Ps2HWXDiSnwwgIgG+eGpNhsHRLb/kbKZ+h3Tt0FIH0pw1i
         aw96YOShMNaXn5yB5ESrSndF/CbRzhNcluj7ECntXrWtXaMFzdLMSr8R6C40Qgb11iqk
         iYoCI+rRuBI7hYZmzAJYNUzlfVjlfdtRQgtphig9yt6lzraHhrjH+WUULJSPpuXFlqHI
         Dm9A==
X-Gm-Message-State: APjAAAU2dl77m88PUUPMg6iTXjeerCRQPxMcO2GfpS1ZIpzkcLqQniIr
        mylUM4stR9E+tFWnQxBItxvKxi7O
X-Google-Smtp-Source: APXvYqxpxT5uCg6dRjinbTiAzLimF39CcpccN2MoM68JfAIz692dZPSLjbsqHgk/WZQBZKtsxMVxsQ==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr4144109wrw.3.1557424150632;
        Thu, 09 May 2019 10:49:10 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id k67sm4474383wmb.34.2019.05.09.10.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:49:10 -0700 (PDT)
Subject: Re: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
 <CAHp75VdE7MBjyLj=9bS6oc5jc8+BC_hftWUJgZGG02iDd=saiQ@mail.gmail.com>
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Message-ID: <0d7f6a9e-d508-65ba-9646-39f1d1a42a13@gmail.com>
Date:   Thu, 9 May 2019 19:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdE7MBjyLj=9bS6oc5jc8+BC_hftWUJgZGG02iDd=saiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.05.19 15:58, Andy Shevchenko wrote:
> On Fri, Apr 19, 2019 at 1:12 PM Yurii Pavlovskyi
> <yurii.pavlovskyi@gmail.com> wrote:
> 
>> -               if (value == ASUS_WMI_UNSUPPORTED_METHOD || value & 0xFFF80000
>> +               if (value == ASUS_WMI_UNSUPPORTED_METHOD || (value & 0xFFF80000)
> 
> Seems like a bug fix and thus should be a separate commit predecessing
> the series.
The previous one should theoretically work as well, just thought that would
help readability, will revert this.

>> -       else if (attr == &dev_attr_temp1_input.attr)
>> -               dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;
>
> I don't see how this change affects the user output or driver
> behaviour. Why is it done?
> 
>> -       } else if (dev_id == ASUS_WMI_DEVID_THERMAL_CTRL) {
> 
>> +       } else if (attr == &dev_attr_temp1_input.attr) {
> 
> So, I don't see why you change this line.
> 
Yes, looking at this patch now I'd guess the refactoring there is really
misguided as it adds a lot more code than it removes, will drop it
completely and just add a new condition to the current check instead in
next version:
-		/* If value is zero, something is clearly wrong */
-		if (!value)
+		if (!value || value == 1)

Thanks,
Yurii
