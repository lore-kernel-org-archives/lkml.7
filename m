Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911BACA9EC9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D78720717
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 00:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="X0ORt4ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbfKEAPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 19:15:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36209 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729607AbfKEAPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:15:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so7570127lja.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QMuC3tr/0UBfYG4ZEfeYIEAvWDx3av1aIgwA3EiGrEs=;
        b=X0ORt4ZCPoQz/B0zCqSQ5sZlrzsa41IzaFmvSlpkLQqPL7H1WSbkvONwt6Y3RG4sUE
         DteCh0InBFu4jV6bXDKszdtkS4AvO6Rnr+R2nfiB4NifikDN1VfzDtSrGnUkBRWC5RZo
         WdXIGCa+60551Jpc7yYMB4QQZg2/hsjkoD/iAni3/ZGZnch8IEf4I69UAwtyyES4PqvV
         qkJQmqz/8NYfEPkTDvKkZzIAqC72wqqL2h7YptjWzz3VTHRjl8acrFvaiYxjanDNxlpX
         +alc1AJqBtu18gOUjxTK+6u1hPSIt1V5qhkKqqQyyspd6Rpz0uAfIhj6JaVC2sTyevie
         mGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QMuC3tr/0UBfYG4ZEfeYIEAvWDx3av1aIgwA3EiGrEs=;
        b=Y9Qd9AZK10RjGE9VbgX//RnuxK8pmtuwvu4uVM+7hGn3DLKGqHfbwR/C9inm72fB7d
         B00HPqGm2NhHMsWvApXX38GhcpJVjsX4hVGYbpmXqkL9tfVUVArZHKXnCPsosSiVkJhh
         vg8ZlkQPfJPrhFFL5pVXAWkXVBKu5a0L9p6AlttKPSqOelidSucz0d9Yc8e+j0mcIQhe
         aGtsqODIBMyrtwDuDPkcBzfm0aamIbOZiRpUKiQmGuPjv92nlMY7Qqyt/3wqGmvsudBo
         sozUiyd51XxT4HtSoifLPnOjxkpaKrpOjba8P7Y8CH+UvbGlvv7jR8sDxEvvqc6gqQPF
         Ma0w==
X-Gm-Message-State: APjAAAVUIVMrv4QkQEUSizGrZ3132Aa/VacsF1PdV860jIGR9PW1Wql/
        Npa2k2Yvn6szQPpfrDYNFVWdDpAf5A4bDm+ZrHDt
X-Google-Smtp-Source: APXvYqzQ3F0w1LnoBKtNmYA7UzzirU/5+6urePX+H2cel1miQ1FMYk5R2ZZ10jmWs8tjnDlAZ1A+l79gr8sx5vOrqA0=
X-Received: by 2002:a2e:898d:: with SMTP id c13mr17354236lji.54.1572912940893;
 Mon, 04 Nov 2019 16:15:40 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
 <20191031163931.1102669-1-clm@fb.com> <CAHC9VhRwRSGa5JSL0=cXxG-oOg9jUve9OEYyTCqTxzr=aMdGxg@mail.gmail.com>
 <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
In-Reply-To: <B63048C4-3158-453B-859A-C5574AACDC36@fb.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 4 Nov 2019 19:15:29 -0500
Message-ID: <CAHC9VhR92Ade8_d1UnTy4_hJDxmwZPU31eubnrq=ejPBjkTS4w@mail.gmail.com>
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

On Fri, Nov 1, 2019 at 9:24 AM Chris Mason <clm@fb.com> wrote:
> On 31 Oct 2019, at 19:27, Paul Moore wrote:
> > It's been a while, but I thought we suggested Dave try running
> > 'auditctl -a never,task' to see if that would solve his problem and I
> > believe his answer was no, which confused me a bit as the
> > audit_filter_task() call in audit_alloc() should see that rule and
> > return a state of AUDIT_DISABLED which not only prevents audit_alloc()
> > from allocating an audit_context (and remember if the audit_context is
> > NULL then audit_dummy_context() returns true), but it also clears the
> > TIF_SYSCALL_AUDIT flag (which I'm guessing you also want).
>
> Thanks for the reminder on this part, I meant to test it.  Yes, auditctl
> -a never,task does stop the messages, even without my patch applied.

I'm glad to hear that worked, I was going to be *very* confused if you
came back and said you were still seeing NTP records.

I would suggest that regardless of what happens with audit_enabled you
likely want to keep this audit rule as part of your boot
configuration, not only does it squelch the audit records, but it
should improve performance as well (at the cost of no syscall
auditing).  A number of Linux distros have this as their default at
boot.

-- 
paul moore
www.paul-moore.com
