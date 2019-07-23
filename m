Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9EDC76190
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9DB22387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 02:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H04dM0Ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732205AbfGWCwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:52:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41341 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbfGWCwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 22:52:21 -0400
Received: by mail-lj1-f196.google.com with SMTP id d24so39511732ljg.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 19:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1etmy9Atvv4SrZGT3oic1ZoFV3GFj3ap7yhS6jSdM8g=;
        b=H04dM0TyEHGefL+muTqXD2UMxoFKeUoxvL9OBTbsBCO39+iSJ+Pb77kXL3xr8zSY5w
         VpFqfrwE2GhKZHKV47aGRDkz1p2TZUhIUQIFUHjN+jmJVGVxDYRrMDsAozWF1AVVdDn6
         ir65d7ldZ6yaO85qkL1pEprDCekw2vro8JHemOYbxuYuHcptswKBde5vffB3MbU7bhv/
         3r4kCvm+21zq80dRa9hl6ap4tKwjQSXIJ1i0TX8M59H7mzaSi26uzP5PS2fBmmmlfMv4
         /aVQqzBSYh6GaD5AHqX3uekducWJvJ4KwQNi4rEnpORsjpVtbbzvTR4nFPdG6AhHXVYP
         PWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1etmy9Atvv4SrZGT3oic1ZoFV3GFj3ap7yhS6jSdM8g=;
        b=OF9UcVbzOlH66OEDPksxF4FTh3cmQTUFHMu0J9B30mkq6BdFYf3FogFX347qHrO4YV
         CbbQb2IXdrBdHWwTtCTuWR7361vB6CI5iOI7i/0b0npwC6rdlQlgtFgjzsFMQVJ5pcsm
         AIta0d0KOGH0SwGz5K1YMjTVBpcWpLaNrGSosdkCAaCZhLCt3t/3hAS/hRJ3rU5UEB6w
         eGoxYGuIUdr1DHork8cljEuPp5L3HYhOs/bTRR0bBBrMXlQP9z/gf+kD2lNqPEAVwTz3
         GkJbqoKjUSUDStE3bqSRo32CUuLaGGnWE/I/VlvB6S5qeEG1J2cF/pgicjK+D8pOXtjz
         0VqA==
X-Gm-Message-State: APjAAAXWXrwI2oDCLSVWHGCMUGZZTO499d8iFQRbUt4PAAzQrR8LuRi4
        UkqAgtmZXGozExys3tReaUweb7+UHh8VboIk1cw=
X-Google-Smtp-Source: APXvYqxGSDenu24FN0scEdpAAj8YhN2o4tukN53N9HrkNsLDNSU+G+t26pL4FlIWhbQMLgeD6sARV0VrP/Et7oXerKc=
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr10610019lji.84.1563850338979;
 Mon, 22 Jul 2019 19:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559129225.git.vpillai@digitalocean.com>
 <CAERHkruDE-7R5K=2yRqCJRCpV87HkHzDYbQA2WQkruVYpG7t7Q@mail.gmail.com>
 <e8872bd9-1c6b-fb12-b535-3d37740a0306@linux.alibaba.com> <20190531210816.GA24027@sinkpad>
 <20190606152637.GA5703@sinkpad> <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com> <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com> <18fdcd2b-9064-6895-5948-feed65f96e35@linux.alibaba.com>
In-Reply-To: <18fdcd2b-9064-6895-5948-feed65f96e35@linux.alibaba.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Tue, 23 Jul 2019 10:52:07 +0800
Message-ID: <CAERHkrsgWh9be6Box_A2eBvKcR9Z5OdGQVDdGovSc7aQkNaGLw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 6:43 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:
>
> On 2019/7/22 18:26, Aubrey Li wrote:
> > The granularity period of util_avg seems too large to decide task priority
> > during pick_task(), at least it is in my case, cfs_prio_less() always picked
> > core max task, so pick_task() eventually picked idle, which causes this change
> > not very helpful for my case.
> >
> >  <idle>-0     [057] dN..    83.716973: __schedule: max: sysbench/2578
> > ffff889050f68600
> >  <idle>-0     [057] dN..    83.716974: __schedule:
> > (swapper/5/0;140,0,0) ?< (mysqld/2511;119,1042118143,0)
> >  <idle>-0     [057] dN..    83.716975: __schedule:
> > (sysbench/2578;119,96449836,0) ?< (mysqld/2511;119,1042118143,0)
> >  <idle>-0     [057] dN..    83.716975: cfs_prio_less: picked
> > sysbench/2578 util_avg: 20 527 -507 <======= here===
> >  <idle>-0     [057] dN..    83.716976: __schedule: pick_task cookie
> > pick swapper/5/0 ffff889050f68600
>
> Can you share your setup of the test? I would like to try it locally.

My setup is a co-location of AVX512 tasks(gemmbench) and non-AVX512 tasks
(sysbench MYSQL). Let me simply it and send offline.

Thanks,
-Aubrey
