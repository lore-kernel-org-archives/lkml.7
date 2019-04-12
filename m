Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64BEC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0B2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555087290;
	bh=U0/3Gt8Nqbtr4PYmYAR7A3b9JUrPp1j2ud+Xvcd/8qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GSq7SkcmsD4YybhydsdKWHMMsE8+5npjeHG1z7arz1HnoRC6/T3gmbEpIrZBY/2DI
	 BJYUkDOM4NuWhYhOeYqVSsK9v2w5A8SWNPEIeh6FmtKbTp1HPFyeJMQg3prps4f8Te
	 x1jUw/81NMFO7jE0ST4wketRYSuQ7pZuSb3rNhsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLQl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:41:29 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52792 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfDLQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:41:28 -0400
Received: by mail-wm1-f42.google.com with SMTP id a184so12043328wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 09:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t6yzjDtN2Fn/HTsGWkZL1vKyHofGtCvbLOlR24+N7ls=;
        b=eyczWnuXY8HID4MBJjEFBoto6hgZ0mMMBED5LkX44OLOz9JyS4uXlLcL2mur6t7Wf0
         fq8cLlmus3KFKlXRLAyrDM3PXgiZ4KLj8oLKEO8qO0/XXgpnT+QRA1/VpkXg6Sf1s8Jr
         weGGClrlLFNxQSVrXRrWQAxmkUmKOWuMM3EkneAasyts5o3ZyRFvaCvL1d6lVzyJDwJU
         aIYnLgCTMf087o3vTCXPnENT/wyzQRDPAwsyFRTGLCYyodVsQvA9Q5+QBRRrGbjxRQ7V
         tVtPf7FOUBX5uMjkisg+DnH8CHep87qrV9lnCHun6OpNzeQ3144xy6iNBKcsNgeftCNK
         D2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t6yzjDtN2Fn/HTsGWkZL1vKyHofGtCvbLOlR24+N7ls=;
        b=LphPkJM6Uv8JycL1D8qr+T11kZaBc0eb9RSsWuqsOiOLsNi+3DIMTLe9LUGzd08fuh
         iUd7JzE+ZLc42DziWL9t7Dt/liKZ6V5B6Kzhv10AfI0Z51+6TiVt/Ky+OaI9rcBaAV2e
         iHxcTjYd4zkPlvk+M1j2iRFpMdCJ15mm7p/0kGesNchsHjfUpqfuR/NIv02s4EQLfNn6
         b7e2BvuM/orCXm1SPCtwhDHam9TBr7WQuQo1Awzzls373ARwYQ9ge1TWsfYc4YD86Fp3
         UR3rApAqR1DcI+2eb5SwsYwCW2FPQD/oKjnmama8epPJitHGELE+JDcP9BSCeyhcMw/v
         /jcA==
X-Gm-Message-State: APjAAAXH9u6Zs6okMY2ruuqLFsaJ5WA55JwkDbi506CALq+/Hu6lPuPW
        Uxp5ilzIc7Suihd2MuOKSbc=
X-Google-Smtp-Source: APXvYqwulH9bgbJtZ55LVy6uxI3PcuCQ9R9dYqTs3kRG3SNpABh3BpFbUo2R+ld9pJa8asgKX9MA4g==
X-Received: by 2002:a1c:b646:: with SMTP id g67mr12494307wmf.125.1555087287030;
        Fri, 12 Apr 2019 09:41:27 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j9sm48869748wrr.93.2019.04.12.09.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 09:41:26 -0700 (PDT)
Date:   Fri, 12 Apr 2019 18:41:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH-tip v3 02/14] locking/rwsem: Make owner available even if
 !CONFIG_RWSEM_SPIN_ON_OWNER
Message-ID: <20190412164123.GA119547@gmail.com>
References: <20190410184231.6748-1-longman@redhat.com>
 <20190410184231.6748-3-longman@redhat.com>
 <20190411081224.GB4038@hirez.programming.kicks-ass.net>
 <29aca54a-536e-6e46-7e18-658914c34548@redhat.com>
 <20190412070209.GC129493@gmail.com>
 <20190412070545.GF11158@hirez.programming.kicks-ass.net>
 <20190412070904.GA45214@gmail.com>
 <b97eb5d5-1658-c405-e52e-2d20c4840948@redhat.com>
 <33b0111b-fe0f-eefc-59f4-f06d84d9cacc@redhat.com>
 <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277e9c8e-8913-b251-4c98-dd2d4997d643@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> > BTW, the v3 patch that I posted yesterday should work fine as long as
> > CONFIG_RWSEM_SPIN_ON_OWNER is defined.
> >
> > Cheers,
> > Longman
> >
> Oh, I see that the WIP.locking/core is currently merged into master. I
> would say rwsem part1 patchset and patch 1 of part2 are stable. So I
> would suggest merging those into the the master will be good. The rests
> are still under review until I get an OK from Peter. If they miss the
> next merge window and have to postpone to 5.3, I am fine with that.

So beyond the primary constraint of PeterZ OK-ing it all, there's also 
these two scalability regression reports from the ktest bot:

 [locking/rwsem] 1b94536f2d: stress-ng.bad-altstack.ops_per_sec -32.7% regression
 [locking/rwsem] adc32e8877: will-it-scale.per_thread_ops -21.0% regression

Thanks,

	Ingo
