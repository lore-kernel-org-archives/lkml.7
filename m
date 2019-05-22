Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B78C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029742081C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BMZCSEeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbfEVVCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:02:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45920 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfEVVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:02:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id s11so1946237pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 14:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dfPhqSj5GoutjL8OYgGz/mFeuNds5pa0KChYPD50pF0=;
        b=BMZCSEeU6msJt6HuJ1UYwI+gkuc/fjVhfZKr3PsGQP21L/kvLgCVwriHm2YPPM7wf0
         0gU8gcmH7adK+VUNUzXfJ3RADWtEZuEYr06Uc2YrUmM10kYoy4mdshXi3WbZodJfhjZR
         MLxS1EfGyFa/4bc/sOROgZ4EiTrjbVWXHJj1vItQPzmTAU/+qtSivT0TxWXdhBMCGJth
         cdcH9C9yU5vgTIXzQ/RUfCLb+AGdLx893c5oXqcBqQTkYUdYKAuUz8kOJ50GIMuac1CW
         RXus6jZGcxl1DwnCKsagq/WFuEjsCjpZ54Z/RdAXPt/15dr/usvv6Zu8LqHAXorSRfoZ
         SYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dfPhqSj5GoutjL8OYgGz/mFeuNds5pa0KChYPD50pF0=;
        b=X/HH9YkMfpeHJb+ADyeHtArF6b49BEebt+/Di7lmfEelvPgcHTMSFQcqF5rMXxsOLp
         PseolNmemdPjLS1HvhT7plbo82q2QQQPFTP9zrDuNQISH03gOuFD9AHplndMh73tdcRu
         2+vMNxVIRaxW7kR6qht6x2YCdKNiXrW/cFOLlEDxFEAK4hSxFjAMhMskK04zzCGJlpRl
         RgyzIMWejS/oqtSbFN1ec4nat29NnuzQ2bPX32ubQ40Wgheg/uqnbubuW1iMU3AJWtpn
         c1uHzJJ2fKqIssW2rN/0f4l7vk0Q+Nbwe7S+8KOPlYqreG8J1Hp/e1JoLY2xxWAPu3Tf
         t5vA==
X-Gm-Message-State: APjAAAUdHlz4EvPY+x7r0TSTAJRmSEowI1MowF2fUPJ0/i3V3S78U3qH
        ezuEshgQVOB+6E7tSfLkNc122A==
X-Google-Smtp-Source: APXvYqzTpsGT1skaisuHAQW/D6mn5QrNgqS8lK66pFqnpleaxepnykkkoGufu8prPPom+WVpBykcCg==
X-Received: by 2002:a63:2118:: with SMTP id h24mr93566652pgh.320.1558558957573;
        Wed, 22 May 2019 14:02:37 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id s137sm39041525pfc.119.2019.05.22.14.02.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 22 May 2019 14:02:36 -0700 (PDT)
Date:   Wed, 22 May 2019 14:02:31 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     shuah <shuah@kernel.org>, Dhaval Giani <dhaval.giani@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
Subject: Re: Linux Testing Microconference at LPC
Message-ID: <20190522210231.GA212436@google.com>
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
 <3c6c9405-7e90-fb03-aa1c-0ada13203980@kernel.org>
 <20190516003649.GS11972@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516003649.GS11972@sasha-vm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 08:36:49PM -0400, Sasha Levin wrote:
> On Wed, May 15, 2019 at 04:44:19PM -0600, shuah wrote:
> > Hi Sasha and Dhaval,
> > 
> > On 4/11/19 11:37 AM, Dhaval Giani wrote:
> > > Hi Folks,
> > > 
> > > This is a call for participation for the Linux Testing microconference
> > > at LPC this year.
> > > 
> > > For those who were at LPC last year, as the closing panel mentioned,
> > > testing is probably the next big push needed to improve quality. From
> > > getting more selftests in, to regression testing to ensure we don't
> > > break realtime as more of PREEMPT_RT comes in, to more stable distros,
> > > we need more testing around the kernel.
> > > 
> > > We have talked about different efforts around testing, such as fuzzing
> > > (using syzkaller and trinity), automating fuzzing with syzbot, 0day
> > > testing, test frameworks such as ktests, smatch to find bugs in the
> > > past. We want to push this discussion further this year and are
> > > interested in hearing from you what you want to talk about, and where
> > > kernel testing needs to go next.
> > > 
> > > Please let us know what topics you believe should be a part of the
> > > micro conference this year.
> > > 
> > > Thanks!
> > > Sasha and Dhaval
> > > 
> > 
> > A talk on KUnit from Brendan Higgins will be good addition to this
> > Micro-conference. I am cc'ing Brendan on this thread.
> > 
> > Please consider adding it.
> 
> FWIW, the topic of unit tests is already on the schedule. There seems to
> be two different sub-topics here (kunit vs KTF) so there's a good
> discussion to be had here on many levels.

Cool, so do we just want to go with that? Have a single slot for KUnit
and KTF combined?

We can each present our work up to this point; maybe offer some
background and rationale on why we made the decision we have and then we
can have some moderated discussion on, pros, cons, next steps, etc?

Cheers
