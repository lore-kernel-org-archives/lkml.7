Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041EFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD88D222CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 04:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZHIdB58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfKMEiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 23:38:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfKMEiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 23:38:22 -0500
Received: by mail-wr1-f67.google.com with SMTP id i10so688717wrs.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 20:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6Rb656liMW5iqgFRm8uCYcs0BBDjpFH5RMQxLc43FYg=;
        b=MZHIdB583lS1DUJ5f2Yk9eJgKd1TaKCH7MP2vBYjr53qWrEglioVmlCfFNu8r/Leix
         joVMrtCtCuIsPrGbtuk5QNiOrtaoqsFXxVBYJQ/Mt212sWIuOTPsS+VZ20l4TiZjnhPC
         lLspqlbgHrQ0Kj7eu+uMZAl2+ogz//tg7iV/sMl9lgHrfj5nQ3N1+E1Tis2y0/q8n9IN
         mTwKjJc9HIV7oMYzWROYF5krcFKCsyh+anaNc0EUs6cAGKECZ1k+LwoN2ukEnAkd5NOb
         q6+ValHnC3ou62E/Gz4TarLDdG2EwhRezd+61L3GoA5m+AeL+a1Gq46Vo1kksZQMtjKg
         eQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=6Rb656liMW5iqgFRm8uCYcs0BBDjpFH5RMQxLc43FYg=;
        b=c79WRF8p2kjc8QXGLFI9pH0DSrpADfnZG2+kNPbwOElVVSMt/u4YyOtMcEut4Dy0jl
         2QWqTtYB+S2VGUpQn+0ZshQolLsz2MAf/jrrHMA8ohz0gUAAZRE0wG9JINU0rjn1f0cs
         mHMID4RP+BWMGgyfEoysPX3+Z3CJ/LO/4ndWSVP588kgFYkCGz/xjNq1v5ZVv4Wov7iW
         Ft7H+pJg/M7s2qmsXAUjeSHhZWO6t/hhUplvM/IUIIYtsK719IHIweqfxLlTL/VZtkNe
         +e4w76ZOpzn5lmRTf7AX1MuJOxWXvAguHn7xKqhVdDgOcTbRGXpeklyfrHcp7yoeIAH+
         LtUA==
X-Gm-Message-State: APjAAAWNMH8i2PhdIUx24jraT5y+mTn5ZsVtie2BXtd9GsOnvQf34YGo
        8LZVsNKzAxuddRBQZ+8UXv1YoGCiP8g=
X-Google-Smtp-Source: APXvYqz9J5U4F6/xJm+zDtXlYuJstE1JdYLst91hk210PVFcyd3/3d9oj8mbIs8r/VyDDtSwIAbmOQ==
X-Received: by 2002:adf:c401:: with SMTP id v1mr691909wrf.375.1573619900605;
        Tue, 12 Nov 2019 20:38:20 -0800 (PST)
Received: from wambui.local ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id p4sm1322221wrx.71.2019.11.12.20.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 20:38:19 -0800 (PST)
From:   Wambui Karuga <wambui@karuga.xyz>
X-Google-Original-From: Wambui Karuga <wambui@wambui>
Date:   Wed, 13 Nov 2019 07:38:00 +0300 (EAT)
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
cc:     daniel@ffwll.ch
Subject: Re: [PATCH] drm/print: add DRM_DEV_WARN macro
In-Reply-To: <20191112182705.GL23790@phenom.ffwll.local>
Message-ID: <alpine.LNX.2.21.99999.375.1911130736490.2567@wambui>
References: <20191112170909.13733-1-wambui.karugax@gmail.com> <20191112182705.GL23790@phenom.ffwll.local>
User-Agent: Alpine 2.21.99999 (LNX 375 2019-10-29)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Nov 2019, Daniel Vetter wrote:

> On Tue, Nov 12, 2019 at 08:09:09PM +0300, Wambui Karuga wrote:
>> Add the DRM_DEV_WARN helper macro for printing warnings
>> that use device pointers in their log output format.
>> DRM_DEV_WARN can replace the use of dev_warn in such cases.
>>
>> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
>
> Can you pls include this in the patch to add the first user with rockchip?
> Otherwise always a bit awkward when we add functions without callers.
>
Okay, I'll send that as well.
Thought it'd be better to get this accepted first.

wambui
> lgtm otherwise.
> -Daniel
>
>> ---
>>  include/drm/drm_print.h | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
>> index 5b8049992c24..6ddf91c0cb29 100644
>> --- a/include/drm/drm_print.h
>> +++ b/include/drm/drm_print.h
>> @@ -329,6 +329,15 @@ void drm_err(const char *format, ...);
>>  #define DRM_WARN_ONCE(fmt, ...)						\
>>  	_DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
>>
>> +/**
>> + * Warning output.
>> + *
>> + * @dev: device pointer
>> + * @fmt: printf() like format string.
>> + */
>> +#define DRM_DEV_WARN(dev, fmt, ...)					\
>> +	drm_dev_printk(dev, KERN_WARNING, fmt, ##__VA_ARGS__)
>> +
>>  /**
>>   * Error output.
>>   *
>> --
>> 2.17.1
>>
>
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
>
