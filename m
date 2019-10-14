Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E60872133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JIVsIOWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfJNNxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:53:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50787 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731092AbfJNNxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:53:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so17404468wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DbMU9RPCntfZSoUp0kmD7kMs8Ccruo+x2SMQzLE6AvM=;
        b=JIVsIOWBuLmB3PaIM7QP1ZcewvV3mVfo7Ya+I0XajhKTSF8oG7+VZseicRzsAOzDy6
         gCP7WjIYmufUr8Et3/y8mQ41bQIpb47kx9otlxu2lmhaHk77QUT7X7xStQKHJi0cKXs3
         SmfCixBJA9p5WqJ47RRm7pNoCEB0gMUoej70mB6R7I0JxM+FUBtE24V73B2mXnHwM/zx
         26P2bu2BIFPRPVNlUjUWEzZXaB8WfqG7n0H3gUVFBamhVYsTifhLIqFGWER3/Svys4SG
         M3ujx9R0v9awUzUop55GNEUBjoTtNcaVzpO0S/SHD45VxpUwiflzSaiq1keFejFNZbm5
         8WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbMU9RPCntfZSoUp0kmD7kMs8Ccruo+x2SMQzLE6AvM=;
        b=uF6dKvbwbFyruZWQG/rnw0evX8l20UK0OwormSMvhYiF92AgIkL9rF4twnJKe/zmr9
         QDsOU0JoWQxtpUkS5VkE1uwlPs1faUMamT1SFUxWOzbCFGJe8dblf+MU1ExM8dLGQB5l
         UM5Thw7JRVuSitMKl0JjiIlIArDK+E41rbiQ9ncJcU3aOKnADSXSe7E5BoK2OZAMWH88
         wP6HtT+L2i6soHoUAiS1+n4Qtxz6cmKFiIYIGHC0055z+kbRO8P+qiPVOJOyb95e6l4w
         rWkC+sR6kb23x9ES7W+mlQ2qMVXZ/2P3F/qlHdK5iDTvR9b41X004WeilQRX8SHcRSOI
         qwWw==
X-Gm-Message-State: APjAAAUmNC4/tbOyG9s61zwpnRt17Qzzp3re6OOkscal9DSpbbI4QeL2
        cSGTfpbJVwiqBwKw6OevnM+iNw==
X-Google-Smtp-Source: APXvYqyXOLvjYOs2m47oj9Ddg1YMyBiA/mG9zoRtk3XJWMw7YIOTI4YF86fWND1xRqTPtoEnkcJL5g==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr11649644wmk.83.1571061180187;
        Mon, 14 Oct 2019 06:53:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7687:11a4:4657:121d])
        by smtp.gmail.com with ESMTPSA id y186sm36262088wmb.41.2019.10.14.06.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 06:52:59 -0700 (PDT)
Date:   Mon, 14 Oct 2019 14:52:56 +0100
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "# v4 . 16+" <stable@vger.kernel.org>
Subject: Re: [PATCH] sched/topology: Disable sched_asym_cpucapacity on domain
 destruction
Message-ID: <20191014135256.GA85340@google.com>
References: <20191014114710.22142-1-valentin.schneider@arm.com>
 <20191014121648.GA53234@google.com>
 <CAKfTPtDoBrE=npY_Ay1pucdXsW1yQr1UiaCGq1DXKa2VmNqcUg@mail.gmail.com>
 <fe5977ab-0a70-e705-fcca-246c7dc3d23f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5977ab-0a70-e705-fcca-246c7dc3d23f@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 Oct 2019 at 14:46:58 (+0100), Valentin Schneider wrote:
> (Replying to the reply because for some reason my mail client never got
> your reply?!)
> 
> On 14/10/2019 14:29, Vincent Guittot wrote:
> > On Mon, 14 Oct 2019 at 14:16, Quentin Perret <qperret@google.com> wrote:
> >> FWIW we already clear the EAS static key properly (based on the sd
> >> pointer, not the static key), so this is really only for the
> >> capacity-aware stuff.
> >>
> 
> Ah, right.
> 
> >> So what happens it you have mutiple root domains ? You might skip
> >> build_sched_domains() for one of them and end up not setting the static
> >> key when you should no ?
> >>
> >> I suppose an alternative would be to play with static_branch_inc() /
> >> static_branch_dec() from build_sched_domains() or something along those
> >> lines.
> >>
> 
> Hmph, so I went with the concept that having the key set should mandate
> having a non-NULL sd_asym_cpucapacity domain, which is why I unset it as
> soon as one CPU gets attached to a NULL domain.
> 
> Sadly as you pointed out, this doesn't work if we have another root domain
> that sees asymmetry. It also kinda sounds broken to have SDs of a root
> domain that does not see asymmetry (e.g. LITTLEs only) to see that key 
> being set. Maybe what we want is to have a key per root domain?

Right, but that's not possible by definition -- static keys aren't
variables. The static keys for asym CPUs and for EAS are just to
optimize the case when they're disabled, but when they _are_ enabled,
you have no choice but do another per-rd check.

And to clarify what I tried to say before, it might be possible to
'count' the number of RDs that have SD_ASYM_CPUCAPACITY set using
static_branch_inc()/dec(), like we do for the SMT static key. I remember
trying to do something like that for EAS, but that was easier said than
done ... :)

Thanks,
Quentin
