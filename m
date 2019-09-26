Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ADAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6348222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="MD/lsc1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfIZPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:50:22 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44822 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfIZPuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:50:22 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so2680533ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC2Nd1YvSxVp+ypAR2gexRbTcYIPCDvOfmcETC4TvmY=;
        b=MD/lsc1PmexES60c5rwL/OcBjrXwSz+Zd/Dyiw/BmhqrVGdAPVejWwpWFQZCxnohBY
         sKYYSS7tPVopGEri512NtdRXaUfp7jscCaKwH2AQ5qLtTH6twvJCi3MTYUnuxv8BvoCC
         +daFYXmUTObudzykh3SlU6XWdXdXFfXFAo7x+0wszhIsJ+763FC5SCikMynoiMKhlcOc
         MPgqEn3P6uPJxR1dCT6z24WKbo8twiPXl5Qps05rbju6prC3YWZe2/qSm8ZVOOR+voDU
         AT1glNxlOWUPILa45m4wCMjQpzTb8PR1MLnMTAkcRXF2tqKzRjr88Qy5sSJ0fdEGZYSn
         ubpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC2Nd1YvSxVp+ypAR2gexRbTcYIPCDvOfmcETC4TvmY=;
        b=GY1gxJXoDTRApYFP6dByez27w5I1vB/5oZyMuKNIijVDYwWv68mdrsWtl186grVr5O
         B2GxQiAvEoWMv0H/lcj3lJF5HS5Zwcm8FKQCwX4rdIRk7wZF41tzCO87hdHX6SVFGzMb
         6uPFNGypq/xci0gISsOWhFaTHcj1ic0qQ0i+Xs5tbrOzroSOPz1gpk1+hfJ3Hmf5MAFH
         LMJFnpvKtsVTQx3o2JdEmRVrrF3lPTlDs10Ii8wB7st9v1yZzGZp/KUTJ9Ll7fKtgUmi
         czf7UZSI8ZE8Fw8zmNBglQ77XNaDtG77Mzlp+8HTjPZugyMKt/oD6l0qOKy8Qa132f/R
         r0FA==
X-Gm-Message-State: APjAAAULUhj4lfhc5j4fV2hVmUR+Vv07XMGwnLCNw2iNW/xJ8GeJUo77
        5fQn5Xkz9xXMM/B3FfYZNCeJi3L8HEy9R1HZP+sJ
X-Google-Smtp-Source: APXvYqwKu4fciwYEt6TOg/srlHAm83IQFpaVp2G+beVrOZfwuEzktvoUMGhPu3LUbb6KCfuBRjg4qp7vZ/wj1k2Hq7o=
X-Received: by 2002:a2e:9b5a:: with SMTP id o26mr3112055ljj.158.1569513018927;
 Thu, 26 Sep 2019 08:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk> <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20190923210021.5vfc2fo4wopennj5@madcap2.tricolour.ca> <CAHC9VhQPvS7mfmeomRLJ+SyXk=tZprSJQ9Ays3qr=+rqd=L16Q@mail.gmail.com>
 <20190924135046.kkt5hntbjpcampwr@madcap2.tricolour.ca> <CAHC9VhTJ53OSpNDLHMMrv65NFv7MK1XQt1zXPwd7nnAPo3rG0Q@mail.gmail.com>
In-Reply-To: <CAHC9VhTJ53OSpNDLHMMrv65NFv7MK1XQt1zXPwd7nnAPo3rG0Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 26 Sep 2019 11:50:07 -0400
Message-ID: <CAHC9VhR+iWur_0T06=Y0Cxn6HG16NOLUiNo3yyyNo_6bkCNFXQ@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Dave Jones <davej@codemonkey.org.uk>
Cc:     linux-audit@redhat.com, Richard Guy Briggs <rgb@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 1:05 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Sep 24, 2019 at 9:50 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2019-09-23 23:01, Paul Moore wrote:
> > > On Mon, Sep 23, 2019 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > On 2019-09-23 12:14, Paul Moore wrote:
> > > > > On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
> > > > > >
> > > > > > I have some hosts that are constantly spewing audit messages like so:
> > > > > >
> > > > > > [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
> > > > > > [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
> > > >
> > > > Odd.  It appears these two above should have the same serial number and
> > > > should be accompanied by a syscall record.  It appears that it has no
> > > > context to update to connect the two records.  Is it possible it is not
> > > > being called in a task context?  If that were the case though, I'd
> > > > expect audit_dummy_context() to return 1...
> > >
> > > Yeah, I'm a little confused with these messages too.  As you pointed
> > > out, the different serial numbers imply that the audit_context is NULL
> > > and if the audit_context is NULL I would have expected it to fail the
> > > audit_dummy_context() check in audit_ntp_log().  I'm looking at this
> > > with tired eyes at the moment, so I'm likely missing something, but I
> > > just don't see it right now ...
> > >
> > > What is even more confusing is that I don't see this issue on my test systems.
> > >
> > > > Checking audit_enabled should not be necessary but might fix the
> > > > problem, but still not explain why we're getting these records.
> > >
> > > I'd like to understand why this is happening before we start changing the code.
> >
> > Absolutely.
> >
> > This looks like a similar issue to the AUDIT_NETFILTER_CFG issue where
> > we get a lone record unconnected to a syscall when one of the netfilter
> > table initialization (ipv4 filter) is linked into the kernel rather than
> > compiled as a module, so it is run in kernel context at boot rather than
> > in user context as a module load later.  This is why I ask if it is
> > being run by a kernel thread rather than a user task, perhaps using a
> > syscall function call internally.
>
> I don't see where in the code that could happen, but I agree that it
> looks like it; maybe I'm just missing a code path somewhere.
>
> Is anyone else seeing these records?  Granted my audit test systems
> are running chrony, not ntp, but the syscalls/behaviors should be
> similar and I can't seem to recreate this.

Dave, can you provide any additional information on the systems where
you are seeing this?  Kernel, userspace, distro, relevant configs,
etc.

-- 
paul moore
www.paul-moore.com
