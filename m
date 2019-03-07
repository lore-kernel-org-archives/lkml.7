Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401B4C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1720684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTcXLLpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfCGJ54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:57:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:57:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id e74so8621497wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 01:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6O/hrXgCUFEfRoCkgUP54ao5UiSOZEgH6FVXCv4fBBM=;
        b=nTcXLLpvwm1wdn/AvhEFtxM+Y9Bc59jD9upIQgl1RJv2+IY3swrcaQJyrbRR/eTpV2
         F0rfhFp8wgnDmT09ER/joq5rU7whPlV/Kzi2rgIlIWuOUPQ8QUs5ILls6e0Sd5/dXCHD
         IMuAqnmnCstbutVnZIPbLInUWuL3FLMUSsaLf00s7npFzxWPPhoMQePvQmZfLlUFYRuT
         u21uwg4UqR+PjYSme18Uj37CepsmmdcrPH/h5g3WTvqWhkMkZUtnJdcD3Y8MKhQRn9Rv
         oDbMzMoc6PiKvQb/VD7r8vXE0rXDVfKR3KRRPzOGBrA11wzLFb040CZW2Nk9AMF6az8D
         cDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6O/hrXgCUFEfRoCkgUP54ao5UiSOZEgH6FVXCv4fBBM=;
        b=e+iIi7nyCh9NPSyoqM0f1ImRjM9RxekbmYFHo7piteACiHe8jLS2BjZI/HcE5fVkFi
         Z9CT4pSzv5Qw3Fh/cleTMypvN2mM0X/H/vgQjWo71g6EoNQPx1wu3UaJfZryYBg9hbtL
         cx3k7tFZlVewe1wgYYMYos9IKJSWlZVY8HCrOPQ2MJl3B2dPv1kAOlIXNWDupFW7DRzw
         adA44pLFl7Sfu4+tfOdK0hl9tgYU+aGnlGv19l2hqTfvJVGcI6Iae3PMTvVRG9DRF7BU
         OZbjVhf0JbWokGAeN7wdicWMvy493KTLiuY9I9VfzwhJyD0On4PweTZwSKATpt8gg/HQ
         HonA==
X-Gm-Message-State: APjAAAVAm7/uYKIpROae6kZp4ER19NumsfkSssPXdw7xTnNhE5NSurOn
        7FA1Q4dRnQKjstGy0iwzk1U=
X-Google-Smtp-Source: APXvYqwi51pBvpZbhiTjbDooYsRubPkdwpMBOynXDzZiiCxcUbXivCVJuck4eliTnrwPEQi8debVXg==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr5368712wmh.38.1551952673869;
        Thu, 07 Mar 2019 01:57:53 -0800 (PST)
Received: from localhost.localdomain ([151.15.252.68])
        by smtp.gmail.com with ESMTPSA id d24sm11183179wrb.47.2019.03.07.01.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:57:53 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:57:50 +0100
From:   Juri Lelli <juri.lelli@gmail.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        gregkh@linuxfoundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190307095750.GD29753@localhost.localdomain>
References: <20190306152254.GB19434@e105550-lin.cambridge.arm.com>
 <1551886073-16217-1-git-send-email-clingutla@codeaurora.org>
 <20190307072856.GC29753@localhost.localdomain>
 <20190307093116.slvugyeos46kl3et@queper01-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307093116.slvugyeos46kl3et@queper01-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/03/19 09:31, Quentin Perret wrote:
> Hi Juri,
> 
> On Thursday 07 Mar 2019 at 08:28:56 (+0100), Juri Lelli wrote:
> > There are cases in which this needs to be RW, as recently discussed
> > https://lore.kernel.org/lkml/20181123135807.GA14964@e107155-lin/
> 
> Yeah there's that problem when you can't fix your DT ... But I guess
> this is a problem for _all_ values in the DT, not just capacities right ?
> But these other values, I'd expected they just can't be fixed from
> userspace most of the time, you just have to live with sub-optimal
> values. So I don't find it unreasonable to do that for capacities too.
> 
> > IMHO, if the core_sibling assumption doesn't work in all cases, one
> > should be looking into fixing it, rather than making this RO.
> 
> It's just that this thing keeps causing more harm than it helps IMO.
> It's quite severely broken ATM, and it prevents us from assuming
> 'stable' capacity values in places were we'd like to do so (e.g. EAS).
> 
> And I'm not aware of a single platform where this is used. So, I'm
> personally all for removing the write capability if we can.

If people think it's best to simply make this RO, I won't be against it.
Just pointed out a conversation we recently had. Guess we could also
make it RW again (properly) in the future if somebody complains.

Best,

- Juri
