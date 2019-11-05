Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA9CA9ED3
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0632080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eabP7Cc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbfKEAp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:45:27 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34292 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbfKEAp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:45:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id 139so19788358ljf.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 16:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SD2CAIOJ3/A3r/7BnST1o483HsUD8a95doqEbuDoX4g=;
        b=eabP7Cc1OSZCYK99BZ8Mk/YWRPpf0ORUXxuJewmiZn+Cuu9NaobA0eaG1svbcRwFK2
         YwYG3esWLojrz7DAz7Fg3ew5hFapASjaMdLDFTogvyWjqgflf50OZX1Wl3wOpAtitz6g
         ufur5kxRNnQAJsztSQVq6nqyq9tAOsfOdpn5oYuYQDMMpIg5v5s6NxVDkxDlAjDq2cJV
         zuCbKQJ/HL/VpZDywkv34P58pScO19a7jhlfkq62/1yweXxW0IIqrUPGLOG5eTp4o6RN
         wBCJi5gC5gn9kKtfEOWDPXMHI6ESbaMd/ekS9yZLUwvxXUO1hiMAVB2gJj1Io6b6TsDi
         +zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SD2CAIOJ3/A3r/7BnST1o483HsUD8a95doqEbuDoX4g=;
        b=TdzulzcXPg1S40GOLM8l8zVndpe/YmfVA+KknWpWkL1lh54hHKGZYA4b4b3FVmX5M0
         e65++ud2LEZdSFSW4fjv7tSZjbl6ZWmHwyRnrOmna2Ej9e8trFU+WurIkMtgFqX0BP2T
         J0Rh27AKALJsptDjxbLkYLEmLg2P0Pr56PvsB2IQLnVUDVQhB7PCCQz7LuP8nuxkszHj
         dW3LVafoDEv4DthdL3ExZ6+mQ+Rsxyj8Gzg8xwtXGCBleUPuZSNTLm7IvVVHrI9mei2z
         AqV0I8aYLlOQBR92ZfEIqdGVa8Xft9GH+V2NTQUKT1U+GJcxlArV15UPyYM+JAqd6vGw
         3Dzg==
X-Gm-Message-State: APjAAAWmKcJg+hljeKd/SSojxOaHJC4orsUHKGdSN06jwY1DrFVno9W+
        8mAEWd+G+xuGRJw/DDf+LZv8UzcF+kLMUC8HY0WNAZM=
X-Google-Smtp-Source: APXvYqxzmIO2Oxxz9N98p3P82tzxscbhGFfcMIGu27qi4oBiPuTPzzBOd0XTQXumg7HgDXG6Kuzc/ce0WaomFnFFeAk=
X-Received: by 2002:a2e:7811:: with SMTP id t17mr7122741ljc.225.1572914725114;
 Mon, 04 Nov 2019 16:45:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20191031163931.1102669-1-clm@fb.com> <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
 <B63048C4-3158-453B-859A-C5574AACDC36@fb.com> <CAHC9VhR92Ade8_d1UnTy4_hJDxmwZPU31eubnrq=ejPBjkTS4w@mail.gmail.com>
 <5E08422A-BFE2-4515-A804-3DB42B7D8550@fb.com>
In-Reply-To: <5E08422A-BFE2-4515-A804-3DB42B7D8550@fb.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Nov 2019 19:45:13 -0500
Message-ID: <CAHC9VhSX=BN_9hNO3TO-ZBpxqphuM-xVNAQHcqVuO50Yo8C-Rg@mail.gmail.com>
Subject: Re: [PATCH] audit: set context->dummy even when audit is off
To:     Chris Mason <clm@fb.com>
Cc:     Eric Paris <eparis@redhat.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Kyle McMartin <jkkm@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 7:39 PM Chris Mason <clm@fb.com> wrote:
> On 4 Nov 2019, at 19:15, Paul Moore wrote:
>
> > On Fri, Nov 1, 2019 at 9:24 AM Chris Mason <clm@fb.com> wrote:
> >> On 31 Oct 2019, at 19:27, Paul Moore wrote:
> >>> It's been a while, but I thought we suggested Dave try running
> >>> 'auditctl -a never,task' to see if that would solve his problem and
> >>> I
> >>> believe his answer was no, which confused me a bit as the
> >>> audit_filter_task() call in audit_alloc() should see that rule and
> >>> return a state of AUDIT_DISABLED which not only prevents
> >>> audit_alloc()
> >>> from allocating an audit_context (and remember if the audit_context
> >>> is
> >>> NULL then audit_dummy_context() returns true), but it also clears
> >>> the
> >>> TIF_SYSCALL_AUDIT flag (which I'm guessing you also want).
> >>
> >> Thanks for the reminder on this part, I meant to test it.  Yes,
> >> auditctl
> >> -a never,task does stop the messages, even without my patch applied.
> >
> > I'm glad to hear that worked, I was going to be *very* confused if you
> > came back and said you were still seeing NTP records.
> >
> > I would suggest that regardless of what happens with audit_enabled you
> > likely want to keep this audit rule as part of your boot
> > configuration, not only does it squelch the audit records, but it
> > should improve performance as well (at the cost of no syscall
> > auditing).  A number of Linux distros have this as their default at
> > boot.
> >
>
> Definitely, we'll be testing auditctl -a never,task internally.  Before
> we went down that path I wanted to fully understand what was going on,
> but I think all the big questions have been answered at this point.

Yes, that is why we didn't do anything earlier with Dave's reports; we
couldn't reconcile the results with the code, and the lack of other
similar problem reports made me suspicious.  As you said, we
understand things a bit better now.

> I'm happy to try variations on my patch, but if you want to include it,
> please do remember that I've really only tested it with auditing off.

Understood.  FWIW, I'm not overly in love with the approach in the
patch you posted, but I haven't looked too seriously into alternatives
thus far.  I expect with most everyone running with the "never" audit
rule installed this solves this just fine for the time being.

-- 
paul moore
www.paul-moore.com
