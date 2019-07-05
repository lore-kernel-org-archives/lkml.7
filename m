Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17464C4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEA521850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLz12Z3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfGEMXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:23:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37596 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfGEMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:23:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so170982ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMOP1SZiM/P5HMKjCBaRnHatjj2wsJD/Tm46fmI570I=;
        b=BLz12Z3G6vvR53jFRfvipY16RzdCd/7kvfb6A44TKo74zhLiKkfHHzb4KoYJnPdHX6
         A8N7IPapsypdSwFJdPMo7opvMAzBL3ihPIj+IjkhS56MshqQpCqXV2v31E4FstTRdUPe
         su4OfvWNFMrDj2oSVL8rt7QjLVNHRR03b8ASL+apuXLVwBOo1V1pA+hX7aohYWCTq/Oa
         9aUQEpp/uXsWQ8oSTwKpOYwvv0ri9Sz/20pbHok9egqL1DEpaQL5Tfi3203GKiqWPySG
         VgZoSkuD0ZF/C0YMsFi3QHdRDVqXxEiut/u+fV5XqqQZJcwYvlCPDAklPLjE9jxWWIyQ
         /FeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMOP1SZiM/P5HMKjCBaRnHatjj2wsJD/Tm46fmI570I=;
        b=WWr1hxl6sL6m9LyMMCLb3LjNZhUUqt9zuy3JzZfwcr9kIJqjmEdjX4hjNV96sQ5R+9
         j4+xtkvgPHbQefDkMh0n4X2wfM9kiSDFpXpgig/XshBzgLW1/WrJbcBRIW375AzzlKxu
         kli21cKdp67x5HrDMZcTxZQiNHMneljZs6Ukl+GMcxZTAhQTltyPvhRny+hSV4lFbItM
         UOqx10yDmQapCTEmMYp757Q2AXVro2xOe1X4S/c057ZuyMuqKJGlBPT0kQDGPht1q743
         RrpU8cbP0Q56pXj2uOh4pCFDr5KFc5DuABw3KE7ct/pMfXZsjoFOFjmvQJm31J6kOvXp
         EfCg==
X-Gm-Message-State: APjAAAVu5YEfyU7gUWWWq1Vraox8vG0k9LGadPmh4sQhNQlYMDVCabs+
        vC+IXA+c+582tJzw9uwHTXj4wDBLaofMiYS/yPTX7800
X-Google-Smtp-Source: APXvYqyzV/ahvwcrWfq9HpHICapUuZrfXxe66+3eauCq07GQzKyYRFPir9aisrQOz1sxAoMqj7U6tW32DeoEa/8OOU4=
X-Received: by 2002:a2e:995a:: with SMTP id r26mr2005651ljj.107.1562329408837;
 Fri, 05 Jul 2019 05:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <1561996022-28829-1-git-send-email-vincent.guittot@linaro.org>
 <7111f9d1-62f2-504c-a7ba-958b1c659cc8@arm.com> <CAKfTPtBGDZ5P91hwGdHADYpcbOPeniDLE7x3-U9dXDvFVMAi1w@mail.gmail.com>
 <d71ab6f7-3aab-adb3-f170-7757bde94f7c@arm.com>
In-Reply-To: <d71ab6f7-3aab-adb3-f170-7757bde94f7c@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 5 Jul 2019 14:23:18 +0200
Message-ID: <CAKfTPtDE6OuTcjOROoxd_KSLERsFEowjxGodL9J+64bgUscocA@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: fix imbalance due to CPU affinity
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jul 2019 at 16:29, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
>
> On 02/07/2019 11:00, Vincent Guittot wrote:
> >> Does that want a
> >>
> >> Cc: stable@vger.kernel.org
> >> Fixes: afdeee0510db ("sched: Fix imbalance flag reset")
> >
> > I was not sure that this has been introduced by this patch or
> > following changes. I haven't been able to test it on such old kernel
> > with my platform
> >
>
> Right, seems like
>
>   65a4433aebe3 ("sched/fair: Fix load_balance() affinity redo path")
>
> also played in this area. From surface level it looks like it only reduced
> the amount of CPUs the load_balance() redo can use (and interestingly it
> mentions the exact same bug as you observed, through triggered slightly
> differently).
>
> I'd be inclined to say that the issue was introduced by afdeee0510db, since
> from looking at the code from that time I can see the issue happening:

I agree that the patch seems to be the root cause when reading code.
But it also means that the bug is there for almost  5 years and has
never been seen before I did some functional tests on my rework of the
load balance
That's why a real test would have confirmed that nothing else happens
in the meantime

>
> - try to pull from a CPU with only tasks pinned to itself
> - set sgc->imbalance
> - redo with a CPU that sees no big imbalance
> - goto out_balanced
> - env.LBF_ALL_PINNED is still set but we clear sgc->imbalance
>
> >>
> >> ?
> >>
