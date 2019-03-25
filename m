Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F59DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6656E2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BThurLjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfCYRhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:37:17 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39939 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbfCYRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:37:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id p64so7675287ywg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WxoUsmPwyK1IBH8uKnC+MfHwcWYXzZuIGR2L0W6IfFA=;
        b=BThurLjCqtieSEwWuIB/bMWgmg8xO/9FOm69avdgl0K+P+Uq2VRzEW+6dHsxa+28xQ
         kuse844Lb6BCVsqJ1Em2FghM9LiTKCtLj+xuBjeemgv2/2uNxCsC3wLUxNeAV1UyP10W
         NkPI2rP2Q9HgPNz144XP3UJecuv0RflLx9v3PHdUHl2lgpifsBGlxU1hRo5i+RmUQABc
         wDXlmU9pLHqgtFWmiFJT1k9RBlT7M22Bo6RoTH2rbPODM8wYevr5tkira5kEpwTqrBAQ
         ZdxAnVRda4MiRJZX8/MePDy1rBabEneMgwdO85F/6b6JGlSvpc+dyLHi6jS8Bizv/GbY
         HFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WxoUsmPwyK1IBH8uKnC+MfHwcWYXzZuIGR2L0W6IfFA=;
        b=Z0uCBK+KBf2zwz8n3hGs66gQsBAflJNzge+HM8JskOG/MPHdIrQIfPcJKkINStqg73
         iHrH5MHdFabYNTsHUd7OzCBptcRHC2fOgjky3MlCM6RN+TxYpJu8bZUwDPeRKLf+NKR0
         K1CY8460KA7wTFg+cqUMfxq7Cc4RAkudRutWPf+Tt+GqXLKYUJ8qOJGxCTiUpYpDwiXN
         XGoZZ5JzXNxauXxrYKDvrh/i/y/nS6jNDRjbzsUje/443iYr5q2bCWupnd3n5T0oWfKp
         6I2ph3JzrTg6MkKuteJmeUcu/wTKtUZ93NR4vsKfLU2ISg49aSsMAqh+4ydXxolSKMUI
         znuw==
X-Gm-Message-State: APjAAAV9dtaEsBK4BwiR5ZqnNBfMlS4FfgtkEqDtfcd5FRUNcABTLTvm
        RTamcd5VsJfFQX1OqpWEUho=
X-Google-Smtp-Source: APXvYqwD7G27tXXAwStYbN3TcOO7uasAMmj2p7eZdA4Pj00XB9k+PvF9YBCUgp4HbRpjDloW4INn1g==
X-Received: by 2002:a25:d394:: with SMTP id e142mr20731934ybf.190.1553535436501;
        Mon, 25 Mar 2019 10:37:16 -0700 (PDT)
Received: from centos-dev.localdomain (pool-173-66-89-81.washdc.fios.verizon.net. [173.66.89.81])
        by smtp.gmail.com with ESMTPSA id l123sm6087537ywe.85.2019.03.25.10.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 10:37:15 -0700 (PDT)
Date:   Mon, 25 Mar 2019 13:36:58 -0400
From:   Ryan Thibodeaux <thibodux@gmail.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Dario Faggioli <dfaggioli@suse.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        oleksandr_andrushchenko@epam.com, tglx@linutronix.de,
        jgross@suse.com, ryan.thibodeaux@starlab.io
Subject: Re: [PATCH] x86/xen: Add "xen_timer_slop" command line option
Message-ID: <20190325173658.GA46618@centos-dev.localdomain>
References: <1553279397-130201-1-git-send-email-ryan.thibodeaux@starlab.io>
 <abf65a68-9463-0f0e-1f51-6eefd3cacc88@oracle.com>
 <52bfeae7c256faec444b69efe58d363ad60c3fc5.camel@suse.com>
 <20190323114151.5cebf31b@sweethome>
 <20190325130530.56603806@luca64>
 <69e40698-f7ae-11c3-e4b7-dda4f1fadcf6@oracle.com>
 <20190325141138.GA44413@centos-dev.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325141138.GA44413@centos-dev.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 10:11:38AM -0400, Ryan Thibodeaux wrote:
> > > [...]
> > >>>> Is there any data that shows effects of using this new parameter?
> > >>>> 

Continuing with the experimental data conversation (thanks to Luca and
Dario for being so generous), I am providing more results from quick
tests this morning.

I ran the same sequence of tests four times with the same hardware,
hypervisor, and Linux guest setup. Only changes between runs was 
adjusting the slop settings in Xen and Linux. This was on a 
build of Xen 4.10 and a Linux guest running the current Xen 
tip.git kernel with my patch.

For each sequence, I ran two variations of cyclictest on an isolated
processor. The first test used an interval of 50 microseconds and
second test used an interval of 1000 microseconds, passing "-i50"
and "-10000" arguments to cyclictest respectively.

The variations of the sequences are as follows:
#1 - default slops:  Xen@50000, Linux@100000
#2 - lowering Linux: Xen@50000, Linux@5000
#3 - lowering Xen:   Xen@5000,  Linux@100000
#4 - lowering both:  Xen@5000,  Linux@5000

The cleaned up test output is below. Only showing the total
stats for each run and the number of spikes / samples that went 
over 100 microseconds. I do not record each sample value like
Luca and Dario, because I want to eliminate as many variables as
possible, e.g., eliminating overhead of writing out raw results.

Looking at the results, you can see that only lowering the Linux
slop (with my proposed patch) does reduce the overall PDL stats for
the shorter interval, but it especially lowers the spikes, in both
cases. Even in test #3 where the Xen slop was lowered, the spikes 
are a problem at the default Linux slop.

Reiterating what Luca and Dario said, lowering both slops is the 
way to consisten results for both interval configurations.

Note: even better stats can likely be achieved with more tuning
and using the RT patchset. These results were just focusing on
a non-specialized configuration.

...
##############################

# Timer Slop: Xen (default, 50000) | Guest (default, 100000)

# Cyclictest Interval (-i50)
Min: 62
Avg: 127
Max: 212
Spikes (over 100): 3892034

# Cyclictest Interval (-i1000)
Min: 24
Avg: 45
Max: 156
Spikes (over 100): 27


##############################

# Timer Slop: Xen (default, 50000) | Guest (5000)

# Cyclictest Interval (-i50)
Min: 25
Avg: 78
Max: 230
Spikes (over 100): 274549

# Cyclictest Interval (-i1000)
Min: 37
Avg: 45
Max: 82
Spikes (over 100): 0


##############################

# Timer Slop: Xen (5000) | Guest (default, 100000)

# Cyclictest Interval (-i50)
Min: 61
Avg: 126
Max: 226
Spikes (over 100): 3877860

# Cyclictest Interval (-i1000)
Min: 37
Avg: 45
Max: 74
Spikes (over 100): 0


##############################

# Timer Slop: Xen (5000) | Guest (5000)

# Cyclictest Interval (-i50)
Min: 13
Avg: 30
Max: 150
Spikes (over 100): 120

# Cyclictest Interval (-i1000)
Min: 37
Avg: 45
Max: 97
Spikes (over 100): 0
...

- Ryan
