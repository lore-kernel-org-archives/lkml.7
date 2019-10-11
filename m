Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D28ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30790206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570812741;
	bh=riC6/nqA7kgSGJCCMP5su4G0ZkQMoidyeWYJvvwwhT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZO5MrUBjgpWBPcwnlQqVJ2Ma7Z2M1s45UitiOOnt1bJkY6lMG9niscap09hivf4v
	 vU9ZKGWvOgjNhReavxBk4AaOiCgKce/+xQ0UZDljZvcjoRVGJDAoc40LriwIk3zbZG
	 d5Lo8+3TRODpFNu1pV23lilaBhJgPZQ8i/vxhUB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbfJKQwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:52:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42720 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbfJKQwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:52:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id w14so14767217qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 09:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ik7esxKqQ0mCGJAgwQWKpkG5b7ss9ViVqj809ayACJg=;
        b=ftuaXNGdkFZBYx2lEqoYHGXjsPV4yrnzEH1Eljs7OEMLXdjJcSZShneEp9z7v6gYXJ
         FTazdMvRU09ypUwEjIA4dXstaMHCQSawNuSFPJwo0UdsrlsYHIrOY2ixo6NpH0i786wk
         o08eK8Cx7i141+ldh59j4eOD2sLEZUHcm7B6Oj8zBRXVRm31fnvCxG8JzbIbfyXT8orx
         pYGR8VeIdH+Nhh7js5RK/Has0rORGjTZ0VhhmKkVlLDEpX9zGvhsHM9Y3/zBQp/7Qw5g
         4uxICTkCEQsaz9hesFafMfNL11KLnNB9ASVXnru0BpBuNP04uVOI2Sr5d7sEugHh1m8E
         /0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ik7esxKqQ0mCGJAgwQWKpkG5b7ss9ViVqj809ayACJg=;
        b=f1pQFNiJBzIbhFgsCf/LaxUE9RP1+Ks/ODQrCzwC5MsNeGOaxdNYTSNX8vkErZHX1m
         KouM+q1aTiNwpkcL5nKbczMZtv9dhBNc42t1upCFVlAQRiS3nKFnHAcPGoIzGF1y1K5m
         aZUPzS92TKaBTDMOFzw/Jyhs1aZ8m56ilAWLXzdZaF1xmLAnUBKLqxag+2/lE8rqTre7
         4Q0V2+HotCbedGUlbRB4+wzhP/Hp1FXKRit8G1EIVcUkbIyrCmvvNXaD8s6EFXSEeK3w
         hji2W8RaJE6TnFYuGYF0BaGMMO21Llcdno7RLvA2E1r/RiA1hsAO1POlop/fd9A4/KJj
         Vvng==
X-Gm-Message-State: APjAAAWuxVXmk7b4qwWdyF4JF8e4yN1axAU78nu+zevvYWjEpFNLoF1r
        bh3fT/tuC9GvxjfqwTZQmFg=
X-Google-Smtp-Source: APXvYqzo9PLo8WMPJCqHlTnbsPp09wKKrhzZUeiLA5xY5uh8XxM4xyMQLWtxOEjcb8Ol6Ic9uu4Mdg==
X-Received: by 2002:ac8:36f4:: with SMTP id b49mr17831196qtc.31.1570812737374;
        Fri, 11 Oct 2019 09:52:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3741])
        by smtp.gmail.com with ESMTPSA id q6sm3932678qkj.108.2019.10.11.09.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 09:52:16 -0700 (PDT)
Date:   Fri, 11 Oct 2019 09:52:13 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>
Subject: Re: [PATCH] cgroup: freezer: call cgroup_enter_frozen() with
 preemption disabled in ptrace_stop()
Message-ID: <20191011165213.GB18794@devbig004.ftw2.facebook.com>
References: <CADkTA4PBT374CY+UNb85WjQEaNCDodMZu=MgpG8aMYbAu2eOGA@mail.gmail.com>
 <20191009150230.GB12511@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009150230.GB12511@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 05:02:30PM +0200, Oleg Nesterov wrote:
> ptrace_stop() does preempt_enable_no_resched() to avoid the preemption,
> but after that cgroup_enter_frozen() does spin_lock/unlock and this adds
> another preemption point.
> 
> Reported-and-tested-by: Bruce Ashfield <bruce.ashfield@gmail.com>
> Fixes: 76f969e8948d ("cgroup: cgroup v2 freezer")
> Cc: stable@vger.kernel.org # v5.2+
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Applied to cgroup/for-5.4-fixes.

Thanks.

-- 
tejun
