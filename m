Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5969AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB44218DE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PzAJzkrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfJCKW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:22:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34545 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:22:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so2366048wrx.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1jR6Vlrhk5n8xdNCiK+AfK7Qyv9fHZ3u4P5zPUviBBA=;
        b=PzAJzkrwyJdxr7vpeDPwT6M7e45aC+OHAA+kuLA4A0Vzohz/oWf1Ujiym2yaZdRo7C
         MI/wP8eM9cQJP36FyFTYeZes55Sh0K9j6SyLAiMXCzd0+mIXlecFqVpBu1KediWDR8O7
         ty6GSsTwOgwfULvypBuhnYFcfLrLZ2O7dBP9uF9KW1WO2hjQrfpcsiKPeEC32mQjEZMm
         6oxffSXFSCT7anOV7AjhAX+cpqJbK2LVjwB2ZCCsohc9+5AOqrmxubhevbMm9p6qOYv2
         5YR23WtUCknr8nE3RDSAR332Gv8Jw1oC1Veo2IcSTZg8jr7ZYen/y5kV3YXTDrpr4fVL
         ERcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1jR6Vlrhk5n8xdNCiK+AfK7Qyv9fHZ3u4P5zPUviBBA=;
        b=c8XB05v5WyjaafSsgvHob0ZnfXoI6Uv7knTccl13XJiNf3+8+BXnnzX1RzMPxmdyCn
         Njj1WmhIFvKZRGR2K+4Ah8/wt28M/oNW16DItA28FVV5h38sMADRDjAdvRquZ/fdXsoP
         lAJZb6rEOaz9j4FDloqmW3PWmzE6qUAUhf8LXsKBB/HHS5Fp0sCIHsmddUZbJJAr7Za1
         LVULSDF8NVC66rgU7jNm5JdJs1IP2cAPXuARbVjbCDLKcZ4jx2754iMKpW59Pi9j1CsF
         nSMWSZMF5ILCrPMMGB6lUbBBK7qaC4va/22rhD7Jf8nyftsCI2XB5EMEASMVtl2fRzFu
         FktQ==
X-Gm-Message-State: APjAAAXgTHWGuX0/dZyIe1uAJJTZ2bEn9wuex/I23MKyx2qVB0vA267h
        Pwf4NiQUUj40N4U9CVyCEIJE+w==
X-Google-Smtp-Source: APXvYqzGJWrEvT2IWWZZL9JYJSB1703dS2++pm8TSNDU1dHt3ZiFaN4rX/fBHhbqLudcii3fH7HH6w==
X-Received: by 2002:adf:e64e:: with SMTP id b14mr6952182wrn.16.1570098176821;
        Thu, 03 Oct 2019 03:22:56 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id d193sm2240931wmd.0.2019.10.03.03.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:22:56 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:22:54 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Mat King <mathewk@google.com>,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        Ross Zwisler <zwisler@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: New sysfs interface for privacy screens
Message-ID: <20191003102254.dmwl6qimdca3dbrv@holly.lan>
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <20191002094650.3fc06a85@lwn.net>
 <87muei9r7i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muei9r7i.fsf@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 11:19:13AM +0300, Jani Nikula wrote:
> On Wed, 02 Oct 2019, Jonathan Corbet <corbet@lwn.net> wrote:
> > On Tue, 1 Oct 2019 10:09:46 -0600
> > Mat King <mathewk@google.com> wrote:
> >
> >> I have been looking into adding Linux support for electronic privacy
> >> screens which is a feature on some new laptops which is built into the
> >> display and allows users to turn it on instead of needing to use a
> >> physical privacy filter. In discussions with my colleagues the idea of
> >> using either /sys/class/backlight or /sys/class/leds but this new
> >> feature does not seem to quite fit into either of those classes.
> >
> > FWIW, it seems that you're not alone in this; 5.4 got some support for
> > such screens if I understand things correctly:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=110ea1d833ad
> 
> Oh, I didn't realize it got merged already, I thought this was
> related...
> 
> So we've already replicated the backlight sysfs interface problem for
> privacy screens. :(

I guess... although the Thinkpad code hasn't added any standard
interfaces (no other laptop should be placing controls for a privacy
screen in /proc/acpi/ibm/... ). Maybe its not too late.


Daniel.
