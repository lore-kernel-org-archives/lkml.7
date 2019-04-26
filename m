Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC3DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C20206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxxQ4rEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfDZEdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:33:06 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33773 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfDZEdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:33:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id k19so976124pgh.0;
        Thu, 25 Apr 2019 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=9hkrdUZwWqTiPriAP4+hzIlVI3ze7sEIgtQrzRmmKw8=;
        b=lxxQ4rEM5pzoAujII8IvdS/DcKe58Pmct9RjpVMGLiz9xlGTxl3/ww611iMfOQQiet
         QTzTHit37Qn04vT0dya+oHuTv3LUSb3d8hmgyUI+d1mbQk/MLPyeDPCPi8npSRyVYeOu
         Xzb6UxDo9SpMWaOMUDeojvGHMSZGO8cClSzMtREdVUrle9w9nrNBiVWHUfHCfTXL7hPk
         wgKvwPgEhB0OZmlaBrKv/RT5bG9H/ghVjFwzH7smHk8VglTeW2tQKG48JzPtKZLP+dom
         VGlhkT7E3Va9CIYMi67VNjusNZDPqJPgVPPTnEJUaZ5dW7DRhvymxARRybM2Xfo3qXMg
         c4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=9hkrdUZwWqTiPriAP4+hzIlVI3ze7sEIgtQrzRmmKw8=;
        b=d8dultzv8hbsyTViHsbLk3R+SCuZGzNoVn3+3qPfhzp2H+RBGFqz7TzUEB8q6m5D5y
         Zklw8rVR7fec8Y9bQfoxGO2eUG5lV3yt90yAcDh0kGX8qcaBPL1c9uWz/tUbUpCwQV2G
         h4JWiK8M0OfXBIBRmS3aTQA8D9hjdwTZo9aHOwtO0MvKupaUUA+wd1mEshXXQG6kjDjd
         wJOMBudJojlLZEisqShEp/PXkMloOuQjqQtuKU1TAz894SaBooDcN/xaVMGK/EknMidq
         1Io74k66LqAZIWOxJ+vmmNGbesM8rRCou01KR9qe0izUSM3tYyuZ0BPy0AtPOfESFZz8
         oyvA==
X-Gm-Message-State: APjAAAUk6L6/J9GHOPC0dtlACz8pNuPpEiSUQ4E0PR0bKgEesvarmzWo
        G0goBxMOd2weC8HnKq6J94E=
X-Google-Smtp-Source: APXvYqxWJwSV34YiqjYhJ4T4cYqioPlTB9FvF3G0vXhjr4CH46GNbMVzpO9OF1VcyFxPWr5gDV0XrA==
X-Received: by 2002:a63:1e12:: with SMTP id e18mr10712817pge.87.1556253184913;
        Thu, 25 Apr 2019 21:33:04 -0700 (PDT)
Received: from localhost ([203.63.161.26])
        by smtp.gmail.com with ESMTPSA id t82sm62440023pfa.153.2019.04.25.21.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 21:33:03 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:32:56 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 3/5] kernel/cpu: Allow non-zero CPU to be primary for
 suspend / kexec freeze
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190411033448.20842-1-npiggin@gmail.com>
        <20190411033448.20842-4-npiggin@gmail.com>
        <20190425120221.GR4038@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425120221.GR4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1556252469.19vbob4hqp.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra's on April 25, 2019 10:02 pm:
> On Thu, Apr 11, 2019 at 01:34:46PM +1000, Nicholas Piggin wrote:
>> This patch provides an arch option, ARCH_SUSPEND_NONZERO_CPU, to
>> opt-in to allowing suspend to occur on one of the housekeeping CPUs
>> rather than hardcoded CPU0.
>>=20
>> This will allow CPU0 to be a nohz_full CPU with a later change.
>>=20
>> It may be possible for platforms with hardware/firmware restrictions
>> on suspend/wake effectively support this by handing off the final
>> stage to CPU0 when kernel housekeeping is no longer required. Another
>> option is to make housekeeping / nohz_full mask dynamic at runtime,
>> but the complexity could not be justified at this time.
>=20
> Should we not tie this into whatever already allows an achitecture to
> hotplug CPU-0? For instance, x86 default disallows this but has
> cpu0_hotpluggable to allow this.
=20
I didn't know about that option, but I see it still has the suspend
/ hibernate restriction though, which is what this patch is breaking
from.

If we are to prevent suspend completely at boot time, then it's no
problem to run cpu0 with nohz_full, but TPTB decided that's a bad
thing.

But I have no problem with an arch adding another boot time option
or hook into cpu0_hotpluggable that allows you to force nohz_full.

> Presumably POWER already allows hotplugging CPU-0 ?

Yeah it does. Suspend in pseries is actually really just used for
some proprietary hypervisor partition migration scheme where you
suspend, image gets saved, then resume it somewhere else. So that's
easy, it's just a hypercall that appears to return exactly as it was
called. No restriction on CPU number.

Thanks,
Nick
=
