Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F3CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A362053B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w6FPKVy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632785AbfJRIZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 04:25:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38252 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504964AbfJRIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 04:25:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id w3so2955044pgt.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iWJsJQlGdhboGTRO6xGTgHejOY7YjGnLdBXsR1L3j7U=;
        b=w6FPKVy7rWonAfd5KZIVpxgTdugcdhVUINzZw0AgG1jIVeukQ5Y/Y95/kWPBGYeCJo
         Xt9bP8m5GVL1naqIsho+mbFdm0ifdJM2UsDDB0prC6WgS0R8hy5f7wMSsHxOgEWPjSwv
         8zt8KWFyuiZT0cW6X0g3usA31WWfivnER/bEngzvvNSzs/zAXQgf/DYr0Q8eJjAbRYMo
         2UDO0U6tiJgi1cMKZ7TbCVZzG+zz+bcNM38VAECq/8y8rGWkSSal2Ol5MKl3O1+w+BTy
         FqyruVSuEFD0D1E3bqldXMfLNwK6QcG407xOeS20lpDVlRscspETNy9rmzdndLrt5+iB
         N0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iWJsJQlGdhboGTRO6xGTgHejOY7YjGnLdBXsR1L3j7U=;
        b=Nl/Zyy6ptkeCuoMyWsYO3faxEK0p+ZIqHuiCaYWeeifYAhu31aiNehzHhUdhTU/08X
         W+vxjLSzC66p9zgBbtL5S3ZmyIqgrnPabH8d/a+v63C3wE61udHtVylOT+u35JyDr/nB
         gTS6WTahlVlE9spNgqKjYoMY1DjVESvh5ta0SknkD/bh8DvUvEg16px/OSEwDJotH8kO
         IEYy7150YyWdheHB2hlkzSQSDo5bqD/nb70MGCSaYG7E7+Ay/lPP0aFtMpQ1b3orLCts
         cfIIcxhsYTwBa2Pm1mpUD4tkrZehiQHEhIJzrng9MvM9HZmddtG6oGsElni2MO+hsmU8
         TlDg==
X-Gm-Message-State: APjAAAWgDnqj1guUf6ITUmSgqlnIYaCBzfH/gvTfn+TBwPaUkXEFY2j3
        ZLaYViqNBk5SPpuf29Yrj82mmTm+9EE=
X-Google-Smtp-Source: APXvYqxXpmTDebcgvJtGLDn0gKXe6Y3q+liJmVdqYzb4pUsIh/UAFo4UDPaJGXEawo5GGB2oipJ+AQ==
X-Received: by 2002:a63:3754:: with SMTP id g20mr9170990pgn.349.1571387154351;
        Fri, 18 Oct 2019 01:25:54 -0700 (PDT)
Received: from localhost ([122.172.151.112])
        by smtp.gmail.com with ESMTPSA id ep10sm19456321pjb.2.2019.10.18.01.25.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 01:25:53 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:55:51 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: flush any pending policy update work scheduled
 before freeing
Message-ID: <20191018082551.zz7hazgodwgzaas3@vireshk-i7>
References: <20191017163503.30791-1-sudeep.holla@arm.com>
 <CAJZ5v0gTpK0cJhsWGVvs-=Sbgcia0jz2j5QNYRL+1wOz=2xkJQ@mail.gmail.com>
 <CAJZ5v0h0ioEZqLuaW1jz_8jRuGYZLQS3fbpv9ctyV9ucXb1WiA@mail.gmail.com>
 <20191018055533.GC31836@e107533-lin.cambridge.arm.com>
 <20191018060247.g5asfuh3kncoj7kl@vireshk-i7>
 <CAJZ5v0h0vY9OBYg-_pR-hu_TJkE0odf5Nnd8qnJc17+8NQo=7w@mail.gmail.com>
 <20191018080338.vbgnrt3i6epkrx3u@vireshk-i7>
 <CAJZ5v0gctj2QuEgq1Q3hoVbv=krw3ub4wcMt4vZ6=DxdDpVYcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gctj2QuEgq1Q3hoVbv=krw3ub4wcMt4vZ6=DxdDpVYcQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-19, 10:19, Rafael J. Wysocki wrote:
> On Fri, Oct 18, 2019 at 10:03 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 18-10-19, 09:32, Rafael J. Wysocki wrote:
> > > Well, the policy is going away, so the governor has been stopped for
> > > it already.  Even if the limit is updated, it will not be used anyway,
> > > so why bother with updating it?
> >
> > The hardware will be programmed to run on that frequency before the
> > policy exits,
> 
> How exactly?
> 
> The policy is inactive, so refresh_frequency_limits() won't even run
> cpufreq_set_policy() for it.

Ahh, yes. We won't change the frequency, this is all useless in that
case.

-- 
viresh
