Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232ECC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E947820850
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RiwA6Bc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfCUJw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:52:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbfCUJw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:52:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so5810487wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 02:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zeiuNd0X/hU2OqiAp0r4ROe1Degv8ihSLidUCb4EjRM=;
        b=RiwA6Bc8fGiQfcDZ05c137mRUFztOKJu2oKg/ppmmtwsufO1eMvAHRQuFh307BUyai
         vFEgnOAeb+dKiuHkzKjH1/ndkfXyTdgUOmRqbR/ucmLlnbQXP0Nm6/28DhqTM9YdBrei
         vbgW39OeCdicQfH0j/+bj5wRYnkSHNOJELYZ0Kw21pBaSyQP/fPt0gl5ArsZic65l4Sw
         6cZj+AAkjvwpKZkd4wKB/Yz7aSseX2BKlLw58/FXU/iKAxUesCP+i6bSFyZs8S7/FgxE
         2+D7Gg3VYAgScybg/GC0b4NdP9TR8qrVNdk+eaBEKy9zraW9VyKNWWwFsKj021uE9hbT
         f1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zeiuNd0X/hU2OqiAp0r4ROe1Degv8ihSLidUCb4EjRM=;
        b=FK8g7AlYsV8R7vWxmllmf3m6An/qCWM/cgGRvBdlNz2eUvo/Gpr/kIyeNNfLyhREEC
         6uvJ/gw/oHmyG75yRzs391K1XKHcGHQRvrKnPWf82ahU96Oy1xlfuWsYuICSV24NSwOi
         3r98Qy7+S/uzj7LwmuXh78M8zynzjEFDrdS8V8ETZW97Czs8Y5JuoEyxLV32j9Re5CQt
         DeCnJ5m3cSmfuBpiiDup9rumTeQBNGLPnpC1SgqWKkjfLWRyzE52Ed9g9sEh1FuVFKu/
         QMnugrblqcw2ccVYZYeufOhdBdhMVR9L1ctiiZvZNLCYwjJugb1fp9Gurh9UDHDZF25n
         A+OQ==
X-Gm-Message-State: APjAAAXVtVfAQuQRl76OAlXrqS4dviv7gr0QEp03UuzQOsg8sInNEQgq
        RIB3Uuf23e8aKDXlyIFzoAuv0KaDUXo=
X-Google-Smtp-Source: APXvYqzUSI7StPWwTk2mXXlhuoZyGLznUv2/nZqVNVRfJy1WpcI6pvtrshX/kKV3/WazBxjEwVx4aA==
X-Received: by 2002:a5d:62c4:: with SMTP id o4mr1823861wrv.282.1553161976849;
        Thu, 21 Mar 2019 02:52:56 -0700 (PDT)
Received: from [192.168.0.41] (27.78.95.92.rev.sfr.net. [92.95.78.27])
        by smtp.googlemail.com with ESMTPSA id l12sm5825826wrt.31.2019.03.21.02.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 02:52:55 -0700 (PDT)
Subject: Re: [PATCH v12 1/4] PM / Domains: Add a generic data pointer to the
 genpd_power_state struct
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-2-ulf.hansson@linaro.org>
 <11aa2536-9f9c-059d-a4d6-3f683be7caeb@linaro.org>
 <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a750f654-3bc0-f102-245f-fbc8abb08298@linaro.org>
Date:   Thu, 21 Mar 2019 10:52:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoz8d2DTKTtBPn7+1wf_gGsANwU12++Wkb_KKndqGwWZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 10:36, Ulf Hansson wrote:
> On Thu, 21 Mar 2019 at 08:47, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[ ... ]

>>>       cancel_work_sync(&genpd->power_off_work);
>>> -     kfree(genpd->free);
>>> +     if (genpd->free_states)
>>
>> Is this test necessary as the free_states function is initialized with
>> the genpd_set_default_power_state() in any case?
> 
> That's the case when the genpd provider did not allocate states, so
> then we know genpd deals with this properly for us.
> 
> In the other case, when genpd provider has allocates states, then we
> need to check that the provider has assigned the ->free_states()
> callback before we invokes it, as there is no guarantees that it had.
> 
> I was initially tempted to do this check already at pm_genpd_init(),
> as it would allow us to check for the error condition and return an
> error code if it's not been assigned. However, that requires me to
> change all providers that currently "allocates" their states, so that
> isn't really a smooth way forward. Perhaps, we should simply print a
> message to the log about this condition in pm_genpd_init(), as to
> start with!? I can add a patch on top doing that.

Yes, that would make sense to track those providers which do not
initialize the free field.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

