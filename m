Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1DC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D13020870
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="siISpHlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbfHWPGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:06:30 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35392 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732875AbfHWPG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:06:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id n4so5947576pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=br2IEBdfnW2qlqV7gg30Z/xwOIaLVKl9bGEeCZKa9NU=;
        b=siISpHlfibAjTzKXmzvMvdMERCB8h0biNAphsfX2uljz+Okx2iR9rML7xRX4aOLa45
         G2Hej+2b3/xvgrJGt6vMT5MM5nsOSJlENKdRtjHjvUJYWQAlFT+/8pulaatvnRMmo79z
         0vukJARO++UdwvA5MaHWvvNNJIPqDVj0WCKJPkAR+5MH3mym60HW3KXHiGIHzkv05VCZ
         0NxHuTPkQs6KXJ3UTB1TiigWz2Ng1xU/GS8zTf5yLSmcpn+KulnVCOObrJ61y9nmhV9L
         c4l+BHt6kJeYQPHrpEbAmDFvHFLQG3KJB8Tkyo6KKDqpKlSLiWT6xNYcDeeOa/3qsrCT
         BepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=br2IEBdfnW2qlqV7gg30Z/xwOIaLVKl9bGEeCZKa9NU=;
        b=DBQmpVmM8b/Er8ra1RFmyP4WJ+0SE3aY1AH3s2IMIuFUmzdzTGzeHyNPdMwrrdeDoi
         lzq608nT8vT/N8+iTS4iHRt+JrMPxixPU+87/JGSo7PcxZJlRDZjvKGFbGmtG7b81O4w
         gO3cCp9V2RtniovNKEtu96fDd8OjLLOO7wBfzKxnUUeVjcaxRybsfNQsxWhHXfJzVRh2
         YMfm5u5VbnuFcxN81mgAxnbh2UBAWrIesHeN8IPb1c/byCgZxeyMpJtwazvmwHC0VX80
         nGMv8ZIJ5gq/MjfRUYAXwN9tjeEL92uc8t8EOnepxbD97xP1OXXd3t88zRpzvs2llmKT
         tOMA==
X-Gm-Message-State: APjAAAVIVe++EciZ5o7dXPu2Rn014sm522WfH3jHCmpe66GeT96v/Tzs
        40841eXIzqu8IrTGnlrppdfYww==
X-Google-Smtp-Source: APXvYqzhBqSLYP5ApPK5mE0oG+RMyTUh1JqA9ZAmyyVrzxAloBECYA84RJ5XVFzKAvGUUyuOwLrT5w==
X-Received: by 2002:a17:90a:be07:: with SMTP id a7mr5731477pjs.88.1566572788803;
        Fri, 23 Aug 2019 08:06:28 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:89d4:68d1:fc04:721])
        by smtp.gmail.com with ESMTPSA id fa14sm2699525pjb.12.2019.08.23.08.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Aug 2019 08:06:27 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, ulf.hansson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] soc: amlogic: Add support for Everything-Else power domains controller
In-Reply-To: <0ac1cf30-1796-a549-e195-0f94c4a85993@baylibre.com>
References: <20190821114121.10430-1-narmstrong@baylibre.com> <20190821114121.10430-3-narmstrong@baylibre.com> <7hzhk25ct3.fsf@baylibre.com> <b6cfb770-76eb-00b1-e088-1a73b7978f33@baylibre.com> <7hzhk12b6m.fsf@baylibre.com> <0ac1cf30-1796-a549-e195-0f94c4a85993@baylibre.com>
Date:   Fri, 23 Aug 2019 08:06:26 -0700
Message-ID: <7h36hr2a6l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

[...]

>>> It's for legacy when VPU is initialized from vendor U-Boot, look at commit :
>>> 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"
>>>
>>>     In the case the VPU power domain has been powered on by the bootloader
>>>     and no driver are attached to this power domain, the genpd will power it
>>>     off after a certain amount of time, but the clocks hasn't been enabled
>>>     by the kernel itself and the power-off will trigger some faults.
>>>     This patch enable the clocks to have a coherent state for an eventual
>>>     poweroff and switches to the pm_domain_always_on_gov governor.
>> 
>> The key phrase there being "and no driver is attached".  Now that we
>> have a driver, it claims this domain so I don't think it will be
>> powered off:
>> 
>> # cat /sys/kernel/debug/pm_genpd/pm_genpd_summary 
>> domain                          status          slaves
>>     /device                                             runtime status
>> ----------------------------------------------------------------------
>> ETH                             on              
>>     /devices/platform/soc/ff3f0000.ethernet             unsupported
>> AUDIO                           off-0           
>> GE2D                            off-0           
>> PCI                             off-0           
>> USB                             on              
>>     /devices/platform/soc/ffe09000.usb                  active
>> NNA                             off-0           
>> VPU                             on              
>>     /devices/platform/soc/ff900000.vpu                  unsupported
>> 
>> In my tests with a framebuffer console (over HDMI), I don't see the
>> display being powered off.
>
> It's in the case where the driver is a module loaded by the post-initramfs
> system after the genpd timeout, or if the display driver is disabled.
>
> In the later I had some system failures when vendor u-boot enabled the
> display and genpd disabled the power domain later on.

OK, thanks for the explanation.  I get it now.

>> 
>>> I could set always-on governor only if the domain was already enabled,
>>> what do you think ?
>> 
>> I don't think that's necessary now that we have a driver.  We really
>> want to be able to power-down this domain when the display is not in
>> use, and if you use always_on, that will never happen.
>> 
>>> And seems I'm also missing the "This patch enable the clocks".
>> 
>> I'm not sure what patch you're referring to.
>
> It's also added in 339cd0ea082287ea8e2b7e7159a5a33665a2cbe3 "soc: amlogic: meson-gx-pwrc-vpu: fix power-off when powered by bootloader"
>
> I would like to keep the same behavior as meson-gx-pwrc-vpu, since it works fine
> and we debugged all the issues we got.

OK, that's fine with me.

We'll have to revist when we start using runtime PM enabled drviers and
want to power down the display IPs on idle, but that's fine to do later.

Thanks,

Kevin
