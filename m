Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D539FC282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2167208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bzEZfgKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfDWUYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:24:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42996 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfDWUYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:24:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id u23so13540738eds.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNechRkgVW2EOElb/tN6qOonoYKsAlTuRzUZ5rgYqoc=;
        b=bzEZfgKpdodMc0rwRmq/8Vcam1zz6eHpHn+4cBU5QnfVLEgo4CI4SWNXOWywI0QJT5
         DXwQsx53s32d9yjIMMci92FVtwBogkh1YHYCiSvy8n6zc2TRCSL/IUAnt8kkCuFucSFC
         rigxSorQ13wtm906P7XNEGExDPoGztR1GTVC+J8x6npohv90GWktFQCss3pjpBaY2Ey2
         S2ytiZdV8ukd1dBbSvAueMFGsjpwlURSFRYQout8jE/HdoHmQDLY7ppZmRyCfDi6aOXw
         nij47hHNvTEd0/dHM512oc50LqvBs9qC+o1XniQYa2j70WYGy5glhRX4XvyNp3X9Tqgc
         A7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNechRkgVW2EOElb/tN6qOonoYKsAlTuRzUZ5rgYqoc=;
        b=fIGsAWMgeOqGjNYC1dVmZ2XYA/Q7TrAWGQoCtVwIj1juv4KgO+ILMl2nR0yYuKXZ/Q
         8OTt4wkwWFmAFUxwATjiA+hwlYa5h1c4jyF7iCXK59w6WwwZXhwgvLUV0gS4DVsI4K+U
         nyyQnQJzSvHP4XlZ9V45VsC3G7SNXm2Rq3YmtllUjBeCtvzcRGzVOHr1pKoEsxIR5aH3
         vbDwInSb2NzQe+TnOyzWbVGw7Bf1O5uib19+GRTGh/nxNtVIISV8ZVNUm2YaCnNlXqIl
         SdgsirA2NLKpG6Agnta1OWZbWcIqXa3JeWv77CvCSoAvi3wxlIaDetbsZNU8mWXXtW/9
         rKXQ==
X-Gm-Message-State: APjAAAXoazi3eb6TAoBRwLAdH6dLhZLBQwvv73TaTFDpAEP3z6fsqhqu
        u4bSqjMNSiDTFe4yrZ5mUIOh+5HbVM+Ggg==
X-Google-Smtp-Source: APXvYqxw74cEdWMIv39fOcL36Co2hG7gIZ9JWZWT6ToTHUi6vjifesVZB7mFIdRU6u8+jkGisCoIxQ==
X-Received: by 2002:a50:8c24:: with SMTP id p33mr17745067edp.210.1556051048193;
        Tue, 23 Apr 2019 13:24:08 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id d14sm4928682edj.57.2019.04.23.13.24.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Apr 2019 13:24:07 -0700 (PDT)
Date:   Tue, 23 Apr 2019 22:24:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        David Drysdale <drysdale@google.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path
 resolution
Message-ID: <20190423202405.wzs7lkjqgrlzwyu5@brauner.io>
References: <20190320143717.2523-1-cyphar@cyphar.com>
 <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
 <20190325130429.dbrgjxnvq3w5cpb3@yavin>
 <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 01:13:52PM -0700, Kees Cook wrote:
> On Mon, Mar 25, 2019 at 6:05 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2019-03-21, Andy Lutomirski <luto@kernel.org> wrote:
> > > On Wed, Mar 20, 2019 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > > Now that the holiday break is over, it's time to re-send this patch
> > > > series (with a few additions, due to new information we got from
> > > > CVE-2019-5736 -- which this patchset mostly protected against but had
> > > > some holes with regards to #!-style scripts).
> > >
> > > I generally like this, but, as Linus pointed out, it will be
> > > unfortunate if application authors see this as just another
> > > non-portable weird Linux API and don't use it.  Would it be worthwhile
> > > to put some thought into making it an API that other OSes might be
> > > willing to implement?  As it stands, the openat(2) flags are getting
> > > rather crazy in this patch set.
> 
> I think many of the issues are specific to Linux (and Linux containers
> especially), so I'm not sure this should get blocked because we want
> something more portable.
> 
> This series provides solutions to so many different race and confusion
> issues, I'd really like to see it land. What's the next step here? Is
> this planned to go directly to Linus for v5.2, or is it going to live
> in -mm for a while? I'd really like to see this moving forward.

Yeah, it would be good to move this forward. But since this is pretty
much core-vfs we really need Al to take a look at this.

Christian
