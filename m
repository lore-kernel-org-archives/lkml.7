Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA00C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F37820863
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="N6/cibxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfEXS1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:27:34 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46321 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:27:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id o11so863518pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=KBFXSMu5iFYrk4qlfdMwTaqYNBRexORCw0HxEB88ViI=;
        b=N6/cibxJqoyRlASaCOA2LueJDOi4C9QLztjn5TkmTwrk0rGe/Hoq1gXbJIJJQSo4cN
         lWVbWl0eDEcbzHHgLZG5pa0XA2F6zW039A5KfSwxiWBSGlBzt4heC6aPO5KZYaABaPeU
         rzmSWyJABn1huhi+0Og2D9yy63uFN1xpEuKeVK7Sv6slAGO2a3+DY6mR3r1ClotkmfA3
         OidS9rX7ynb06yrKIKqeVbvVf+a6ZPmxyB7CleU7/AeQpch9cRjJPqNbI5xAFDnGWqNc
         iRqeZfjTs8EYih/Bha5dKtUbhVYimXhuxx7zUS+hcME/M80tEUxh8cdCOzrlBWfdx23E
         /3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=KBFXSMu5iFYrk4qlfdMwTaqYNBRexORCw0HxEB88ViI=;
        b=RGFIP9KJ2cqVkwmxM48qokid+CMqcPP9QZMvDEoRmZ268dm5IlyJ93hYfEAC+9re2C
         8LEtU2CLv84RAJuA2szDLdssH0N8rCjo8YW25TbXPW/083Pfj22oSJzDvOl1FqLJpxy1
         vxmxPwc8vEcChdrvo/oYiaaoHJl/LRowwT3SY3SRhlSPjwtkGP1mw1WD5NcVN2D7L+sv
         aIiV1vqDRzd3qikoggrSz3Iu08+ZC3Kcs8lxRkGCxl7p1lhz2Ke1oU2AL9cZdlhssPGQ
         ei+yzIqCuo1gkBSk6DPzAtrnKJYnTkWZM/rVo0gO9Gt3DKbfnrWXIM7aB9KY5A2I8o6k
         Rk7A==
X-Gm-Message-State: APjAAAUsfu8dsl4h9+zpOD9x5vaEjU/9JDd2y27OlgIJdemgXa7kKMEa
        xS/9Z/kVyqEa3WnOlqCZ3dUMCQ==
X-Google-Smtp-Source: APXvYqzA1SAKKSIPwwZfDByTrKcnhebFoSdI+UmO8LD/ZPqhT5EFhsWiDk0n/ghktX76tHjhcfRtcg==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr108309512pgc.140.1558722453153;
        Fri, 24 May 2019 11:27:33 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:ed4f:2717:3604:bb3f])
        by smtp.googlemail.com with ESMTPSA id 85sm4639910pgb.52.2019.05.24.11.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 11:27:32 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     tomeu.vizoso@collabora.com, mgalka@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>, broonie@kernel.org,
        matthew.hart@linaro.org, enric.balletbo@collabora.com,
        Jerome Brunet <jbrunet@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on meson-g12a-x96-max
In-Reply-To: <f01b812e-ee18-528b-1859-620dd8f0fb53@collabora.com>
References: <5ce78689.1c69fb81.58097.eacf@mx.google.com> <7hmujc0xnp.fsf@baylibre.com> <f01b812e-ee18-528b-1859-620dd8f0fb53@collabora.com>
Date:   Fri, 24 May 2019 11:27:31 -0700
Message-ID: <7hh89j1ze4.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume Tucker <guillaume.tucker@collabora.com> writes:

> On 24/05/2019 14:50, Kevin Hilman wrote:
>> "kernelci.org bot" <bot@kernelci.org> writes:
>> 
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>> * This automated bisection report was sent to you on the basis  *
>>> * that you may be involved with the breaking commit it has      *
>>> * found.  No manual investigation has been done to verify it,   *
>>> * and the root cause of the problem may be somewhere else.      *
>>> * Hope this helps!                                              *
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>
>>> mainline/master boot bisection: v5.2-rc1-172-g4dde821e4296 on meson-g12a-x96-max
>>>
>>> Summary:
>>>   Start:      4dde821e4296 Merge tag 'xfs-5.2-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
>>>   Details:    https://kernelci.org/boot/id/5ce72c6259b514ed817a3640
>>>   Plain log:  https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.txt
>>>   HTML log:   https://storage.kernelci.org//mainline/master/v5.2-rc1-172-g4dde821e4296/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-baylibre/boot-meson-g12a-x96-max.html
>>>   Result:     11a7bea17c9e arm64: dts: meson: g12a: add pinctrl support controllers
>> 
>> False alarm.
>> 
>> This one is failing in one lab but passing in another:
>> https://kernelci.org/boot/all/job/mainline/branch/master/kernel/v5.2-rc1-172-g4dde821e4296/
>> 
>> I'll look into what's the difference between labs.
>
> Thanks for clarifying this.  I guess we should fix the logic
> which detects regressions to discard cases where there is a
> conflict between results in different labs.

Yes, we should.  If there are conflicts between labs, it's almost
certainly not worth the effort to automatically bisect (or at least not
worth it to send out the email.)

Kevin
