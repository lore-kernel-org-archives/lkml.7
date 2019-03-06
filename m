Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85374C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E4E20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQmC5+1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfCFCMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:12:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42262 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfCFCMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:12:52 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so7024159pgl.9;
        Tue, 05 Mar 2019 18:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Z6v6bDAYwichAnuEc7vStabgiv6BkmrMebYmVYFex4=;
        b=tQmC5+1s55Yvp2TC5tQHCbsksrAj68xUi/8teC/ZAMTcXVUapSD0+brG147QgyL0Y7
         6AKj4EFkbMogGufSDgGVSVfppH92nuF5i/y2hYgbcSQ3aH0kUlbmEqCuBhb/RhQBuFoK
         uNeXANDvKdWj136dxewUykiC3e42yv/lIh2OlBuhNP85yI+FKDcSN33UfkFqVcvYl+VM
         7k+mXnDHBGx4+jsU/IM/W75OqAc0fvICmWW2r8IjWHyriwiCxDEDDfy2+jHjr3ZUpniN
         p2JR9H6UrluCLhbS3ItT9MgB0Hx6bPPvlF9alF0NCvgOZssxFifIP70T9j3DtY8rxCmX
         2Pow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Z6v6bDAYwichAnuEc7vStabgiv6BkmrMebYmVYFex4=;
        b=n2VrFH/gD+vXyZOs3lU9LbPXKbXUSL4tP+8aRGjfIFFIYBy+7GmVsvQ+X20ThOQKBU
         58ctPMn5YrjOcW531tIMDHpYi45b7a3W4pJetV4kMLcdavPFSjGY3tnG6tCbf36kNL7v
         MEPxm84b2JZATWF4e0zTm3pDmHR7L7XOWqb5ttRXX6w77nxcTmQvWfrHBB5QF3+syGFx
         7gYnGb5jFrQOEMGJUQtQOHnecLniOvEEVoPW7pBPFDn9yN1XxOISWnnWs12A2Tbg+VaM
         k7m0ICQ25fn4CwMSihFQrkBoSWg+rrfLFuwRYKZN9rzZ3SJu8Ms9GscPXWpYCWIWhJGP
         lePw==
X-Gm-Message-State: APjAAAXQ8Dkm2ILI8xa/u2eiPqTbo20svpfGU/AYt90Cgqz9GaSuPC5e
        q/fZ5HmNbwgZBk93QyTVFK8=
X-Google-Smtp-Source: APXvYqxLF9WNxX9Z4OkCB3x+R7MIPgFudMtbUzTG7daAGmuHOhvva2vIpv8tI+wRnGVpLKq5FVr/gQ==
X-Received: by 2002:a17:902:1a9:: with SMTP id b38mr4393594plb.37.1551838371514;
        Tue, 05 Mar 2019 18:12:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v15sm437411pfa.75.2019.03.05.18.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 18:12:50 -0800 (PST)
Date:   Tue, 5 Mar 2019 18:12:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in
 early memory reservation
Message-ID: <20190306021248.GA17298@roeck-us.net>
References: <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
 <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
 <617e0d57-342d-4162-bd21-ece18e481d87@free.fr>
 <CAL_JsqKbCg-rGmLoA3mPv54=LMuQBfevfzL8f2QPVyjN-sNk8w@mail.gmail.com>
 <20190213085028.6199594b@canb.auug.org.au>
 <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK-cC6oVZ9MkP+ExOGjCRhA0XxGSgqGKL3W9bFF3rKAgA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:12:24PM -0600, Rob Herring wrote:
> On Tue, Feb 12, 2019 at 3:50 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > On Tue, 12 Feb 2019 10:03:09 -0600 Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Mon, Feb 11, 2019 at 10:47 AM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
> > > >
> > > > On 04/02/2019 15:37, Marc Gonzalez wrote:
> > > >
> > > > > Cc: stable@vger.kernel.org # 3.15+
> > > > > Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
> > > > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > Acked-by: Prateek Patel <prpatel@nvidia.com>
> > > > > Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> > > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > > > ---
> > > > > Resend with DT CCed to reach robh's patch queue
> > > > > I added CC: stable, Fixes, and Prateek's ack
> > > > > Trim recipients list to minimize inconvenience
> > > >
> > > > I'm confused over commit 3532b3b554a216f30edb841d29eef48521bdc592 in linux-next
> > > > "memblock: drop __memblock_alloc_base()"
> > > >
> > > > It's definitely going to conflict with the proposed patch
> > > > over drivers/of/of_reserved_mem.c
> > > >
> > > > Rob, what's the next step then?
> > >
> > > Rebase it on top of what's in linux-next and apply it to the tree
> > > which has the above dependency. I'm guessing that is Andrew Morton's
> > > tree.
> >
> > Yeah, that is in Andrew's "post linux-next" patch series, so if you
> > rebase it on top of linux-next and then send it to Andrew with some
> > explanation.
> >
> > ...
> >
> > Actually, if it is intended for the stable trees, then presumably it is
> > intended to go to Linus for the current release?  In which case, the
> > patch in Andrew's tree will have to be changed to cope after your patch
> > appears in Linus' tree (and therefore, linux-next).
> 
> At this point in the cycle, I wasn't planning to send this for 5.0.
> It's not fixing something introduced in 5.0 and it is a debug feature.
> 
Hi Rob,

this may be a debug feature, but we do test our kernels with it enabled,
and the problem does affect our 4.19 branch (chromeos-4.19). Are you
suggesting that we should backport the fix into our branch and not send
the backport to -stable ?

No problem, just trying to avoid wasting our time.

Thanks,
Guenter
