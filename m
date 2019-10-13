Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062DDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2F3206A3
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 12:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="SBN5REzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfJMMor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 08:44:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38789 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfJMMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 08:44:46 -0400
Received: by mail-oi1-f196.google.com with SMTP id m16so11657053oic.5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3US1YpCNnCbUgNT1GPpUvzikfVR1h1FRwVNOVDSOqE=;
        b=SBN5REzkBXcLX9aBB3cOWFxG8TFRqF94/v5HDsN2Jc6svbAljItH5wBkpBGF6p0sUA
         aihBnsfukVp8zN4L5SUQb0CSqyOspBrzLCLCNaDSeIBP9mvFeICK4C9Y1jrOjpWr48fH
         87VW0dkx/zo48Y5721wltuECedzkKawxW+HZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3US1YpCNnCbUgNT1GPpUvzikfVR1h1FRwVNOVDSOqE=;
        b=f5MhPqev7r676CTYJR1SDFtNeAM81P+gtwIHz0UlYu7BCU/ejCyRVjcfwY8KDmhAvF
         sCROcKPmd/U5HNu4MxuMvE3nq365ZYCQRIQWwQoABj7t76cFK6hVQPVErdQDX1Z4mzaq
         Ch2KSR1oGSlHG5Nh5+JMvuC17PLcqACxHRaOv9qNDJGZ/7u6OJJyksrAfaJO5NRC0zHc
         zj0Nh9lEFjuGZ7d6461HxQ3On9ImwUpDRj6VHgySNEwFan7GRn4CJLW7AnrSVmaoFqBp
         T2ejH5GOYgc2gaeoTNEIpTXHY4edVQavSEYtXvsqSDz24uy6/UoN5LDe2cjdI51ykrhV
         JAXw==
X-Gm-Message-State: APjAAAUCpEY+b1cqdyTtpQ+OYlpQiFIlIK53sQD9Bs2/F9ET4kew65Z2
        Bk7vjfqL37jlA3T5Lzze2MchOgkykZyDgP9dOqWlVg==
X-Google-Smtp-Source: APXvYqya3OtEXasVVETftjDyEQYGKCPbuj2gbeKb4qt4ILEj/4iBe7c71rkU0QsY2zwlLl4diUiM2oIEoXITNVS2ong=
X-Received: by 2002:aca:a9ca:: with SMTP id s193mr5974772oie.85.1570970683812;
 Sun, 13 Oct 2019 05:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <CANaguZCH-jjHrWwycU3vz6RfNkW9xN+DoRkHnL3n8-DneNV3FQ@mail.gmail.com>
 <20190912123532.GB16200@aaronlu> <CANaguZBTiLQiRQU9MJR2Qys8S2S=-PTe66_ZPi5DVzpPbJ93zw@mail.gmail.com>
 <CANaguZDOb+rVcDPMS+SR1DKc73fnctkBK0EbfBrf90dztr8t=Q@mail.gmail.com>
 <20191010135436.GA67897@aaronlu> <CANaguZDCtmXpm_rpTkjsfPPBscHCwz4u1OHwUt3XztzgLJa_jA@mail.gmail.com>
 <20191011073338.GA125778@aaronlu> <CANaguZCkKQTmgye+9nQhzQqYBrsnCmcjA46TPmLwN60vvMQ_7w@mail.gmail.com>
 <20191011114851.GA8750@aaronlu> <CANaguZBgv5N2Spv-Ldio5Umn6qU7dC0Px66sL9s11W7SK3f4Hg@mail.gmail.com>
 <20191012035503.GA113034@aaronlu>
In-Reply-To: <20191012035503.GA113034@aaronlu>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Sun, 13 Oct 2019 08:44:32 -0400
Message-ID: <CANaguZBevMsQ_Zy1ozKn2Z5Uj6WBviC6UU+zpTQOVdDDLK6r2w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
To:     Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Dario Faggioli <dfaggioli@suse.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Fri, Oct 11, 2019 at 11:55 PM Aaron Lu <aaron.lu@linux.alibaba.com> wrote:

>
> I don't think we need do the normalization afterwrads and it appears
> we are on the same page regarding core wide vruntime.
>
> The intent of my patch is to treat all the root level sched entities of
> the two siblings as if they are in a single cfs_rq of the core. With a
> core wide min_vruntime, the core scheduler can decide which sched entity
> to run next. And the individual sched entity's vruntime shouldn't be
> changed based on the change of core wide min_vruntime, or faireness can
> hurt(if we add or reduce vruntime of a sched entity, its credit will
> change).
>
Ok, I think I get it now. I see that your first patch actually wraps
all the places
where min_vruntime is accessed. So yes, the tree vruntime updation is needed
only one time. From then on, since we use the wrapper cfs_rq_min_vruntime(),
both the runqueues would self adjust from then on based on the code wide
min_vruntime. Also by the virtue that min_vruntime stays min from there on, the
tree updation logic will not be called more than once. So I think the
changes are safe.
I will do some profiling to make sure that it is actually called once only.

> The weird thing about my patch is, the min_vruntime is often increased,
> it doesn't point to the smallest value as in a traditional cfs_rq. This
> probabaly can be changed to follow the tradition, I don't quite remember
> why I did this, will need to check this some time later.

Yeah, I noticed this. In my patch, I had already accounted for this and changed
to min() instead of max() which is more logical that min_vruntime should be the
minimum of both the run queue.

> All those sub cfs_rq's sched entities are not interesting. Because once
> we decided which sched entity in the root level cfs_rq should run next,
> we can then pick the final next task from there(using the usual way). In
> other words, to make scheduler choose the correct candidate for the core,
> we only need worry about sched entities on both CPU's root level cfs_rqs.
>
Understood. The only reason I did the normalize is to get both the runqueues
under one min_vruntime always. And as long as we use the cfs_rq_min_vruntime
from then on, we wouldn't be calling the balancing logic any more.

> Does this make sense?

Sure, thanks for the clarification.

Thanks,
Vineeth
