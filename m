Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73898C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D37208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 15:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikGOtCEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfFGP7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 11:59:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42656 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730071AbfFGP7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:59:06 -0400
Received: by mail-io1-f67.google.com with SMTP id u19so1786962ior.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ewMHrbrVvN4gVJpFfne3Ko4Ig9zBbFgoDweVZi80Iis=;
        b=ikGOtCEI2xkGJiF/rscqmIZGgmjsg2cG96nsYnWF+sShH8/2RPNrrxDEzNKw5puBJr
         CLnGqRjFGkyn7RGCJNhNxASebmtvirIhbTGFy8yS8IHJlPT1QYZkh3YI/fnCzw3C3oXE
         f3zJsVCqynVuZvcKa3O2bzpUsWxceyOPmQaQllIEX2yNH5I7Zj9/HcFMj7HbHPFEpwnG
         xbZ9PFiITzvbQARLu7xHvWWMXXixHxg1c8wkFzVpkPv/K2baTapbCa7nUoSVsxFPrOwY
         AZzZF1hlR0aZP0pb91FILI3U5DLWoL9NX6ga0IYnsPws9Y9Uhxpl/G21jCOVJ5hoORYA
         1W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ewMHrbrVvN4gVJpFfne3Ko4Ig9zBbFgoDweVZi80Iis=;
        b=epvts2z6DCuKzCjVq5lUkdqAftjUerMxV5Mz0rCUZo8ShUEj8WDl8+BgYmCGdGghfR
         7IINTyV9gz6AjYsbmzqqc0ZgGVBhyqdPNCA5Gu6hL60VsHiT+iJfKQ1CLUpGOFycZyFR
         tf7Pa6VdyHudMP7dS4oLPnbBFhJ2VX9jNLvz41+JntO0bjNcXuWoijlPhN/fjaYJxpj0
         P3+D5uLpYv+dzkTUzCArOYEDaoaV9z2TIxlGd+b3RuyqxGvMh35jgNRydtBj6cYWJz2u
         qNHqvoDaOg5ynK5Qc/ZqOIzDY4pFD9wpZl+8NwZuV3OqNfUNRCfsblUrazY8rslwQEfJ
         VlWA==
X-Gm-Message-State: APjAAAUa3RsQYSg/EepfFIOdilPgro6yMfaa6T29eGsUfA372mghDpdR
        QWECEATq5Cpu2xoqXWVhOfQWdY4MauxQ5ZzQUs4/rhDy
X-Google-Smtp-Source: APXvYqwzayJ8qqte/5dnP1Isc+20qODkQw4i0F2UFenu7Y84bawQ8IDq2LnGM+SqRLI+C7+It91yrOyydVLiIKYpWj8=
X-Received: by 2002:a6b:2c96:: with SMTP id s144mr19148570ios.57.1559923145932;
 Fri, 07 Jun 2019 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <1559229077-26436-1-git-send-email-suzuki.poulose@arm.com>
 <20190603190133.GA20462@xps15> <99055755-6525-694e-a15d-5de7318a80da@arm.com>
 <20190607022136.GE5970@leoy-ThinkPad-X240s> <78c98c28-4f3f-825b-18e1-c71fb63a80eb@arm.com>
In-Reply-To: <78c98c28-4f3f-825b-18e1-c71fb63a80eb@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 7 Jun 2019 09:58:54 -0600
Message-ID: <CANLsYkxMeYK+XJYHRvixRL6pwfhP8KjMTi6i1syMEvwNbi5vkg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: coresight: Update the generic device names
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Jon Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jun 2019 at 02:40, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Leo,
>
> >>>>    A Coresight PMU works the same way as any other PMU, i.e the name of the PMU is
> >>>>    listed along with configuration options within forward slashes '/'.  Since a
> >>>>    Coresight system will typically have more than one sink, the name of the sink to
> >>>> -work with needs to be specified as an event option.  Names for sink to choose
> >>>> -from are listed in sysFS under ($SYSFS)/bus/coresight/devices:
> >>>> +work with needs to be specified as an event option.
> >>>> +On newer kernels the available sinks are listed in sysFS under:
> >>>> +($SYSFS)/bus/event_source/devices/cs_etm/sinks/
> >>>> -  root@linaro-nano:~# ls /sys/bus/coresight/devices/
> >>>> -          20010000.etf   20040000.funnel  20100000.stm  22040000.etm
> >>>> -          22140000.etm  230c0000.funnel  23240000.etm 20030000.tpiu
> >>>> -          20070000.etr     20120000.replicator  220c0000.funnel
> >>>> -          23040000.etm  23140000.etm     23340000.etm
> >>>> +  root@localhost:/sys/bus/event_source/devices/cs_etm/sinks# ls
> >>>> +  tmc_etf0  tmc_etr0  tpiu0
> >>>> -  root@linaro-nano:~# perf record -e cs_etm/@20070000.etr/u --per-thread program
> >>>> +On older kernels, this may need to be found from the list of coresight devices,
> >>>> +available under ($SYSFS)/bus/coresight/devices/:
> >>>> +
> >>>> +  root@localhost:/sys/bus/coresight/devices# ls
> >>>> +  etm0  etm1  etm2  etm3  etm4  etm5  funnel0  funnel1  funnel2  replicator0  stm0 tmc_etf0  tmc_etr0  tpiu0
> >>>> +
> >>>> +  root@linaro-nano:~# perf record -e cs_etm/@tmc_etr0/u --per-thread program
> >>>
> >>> On the "older" kernels you are referring to one would find the original naming
> >>> convention.  Everything else looks good to me.
> >>
> >> True, but do we care what we see there ? All we care about is the location,
> >> where to find them. I could fix it, if you think thats needed.
> >
> > IIUC, either the old kernel or newer kernel, both we can find the event
> > from ($SYSFS)/bus/event_source/devices/cs_etm/sinks/; the only
> > difference between them is the naming convention.
>
> The cs_etm/sinks was only added with the CPU-wide trace support. So, if someone
> refers to this document alone and then tries to do something on on older kernel,
> which is quite possible for a production device running a stable kernel, {s,}he
> might be surprised.
>
> >
> > So the doc can use the same location to find event for both new and
> > old kernel, and explain the naming convention difference?
>
> My question is really, does the naming convention matter ? What you see
> under the directory is the name. But yes, I am open to add a section to
> explain the fact that we changed the naming scheme, if everyone agrees
> to it.

I think it would be preferable to mention the change - just a small
section that describes what happened and the reason for doing so will
be fine.

>
> Cheers
> Suzuki
