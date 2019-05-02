Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE83C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467DA2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bsHHJYVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEBTfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:35:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40767 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEBTfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:35:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id e56so3170220ede.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=odIetb1els/jvXDHDGUMS/oa2CaqqVlxMP0+xlzywv8=;
        b=bsHHJYVcI0Qp7q2g/0MnFAnP2XdgO+s4OnXJUz1ilz/HeIx6MFO8iBg+7x6H9HWWxm
         BtWu1EC3QltUp+eDQ/i3iKcqUnqNeElHC49AkCvqi6HVr2m1DTn1buJUt2TCgCpFyq7p
         /igmbALiHipVcQl4FjiteqhUqDGcXV3Tu8r19SQMGMf2o9V3YJDV74eUsvK2DkWgbilb
         W+gTuAeQoU9RSEDINzzKMDg4gScIocy9v56jOmBZQvi7bICxpPpPgRf01MRR+bDBtBnE
         F6+G0Hb24awyZy3mWFG0IDf7L1moYeR8duzR4akQitXWC2Stqwr5MgRbMeXvwjEnMSii
         ow+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=odIetb1els/jvXDHDGUMS/oa2CaqqVlxMP0+xlzywv8=;
        b=th+LQ81yjlA3WzdmSP8aKP/kxbkTaD5Sm/SOuKnmsGNIjPuXqtAwnBkF7vtaFA7Xx0
         ubF4iuHPe9SSlALHnRm7z680ILb/Q+BhO6cUi16Ahg2WTShdolUwW/ZQyMbXtTTXcBQg
         Mc2RpeCvZ0X/NTiyIuQOweeaSQ+3RTSyCvL6RKJj5a+rX6C/GLbJiv8EX/e6mzb0X/2l
         Q9sP0YLYRBUQS3kIfiOKS8ue0ww6nlBWktAPi1TWj5B2qdgai/BQp7qpRYhYANz3Xn8U
         EYbh2R+Nxetd8ul+Te7a3yHMOIVA8+tRX9ypzcVtHo0iJ9/Qv1UFnZXkghXtdmjNnieo
         zZTw==
X-Gm-Message-State: APjAAAVlB7zqNjk+1doAEOaJQs55LC6Hx2Mfr6IoVhoo7h+GAIPmI/ea
        yu+Zflh1Tqpvv97s1SudR4w3wQ==
X-Google-Smtp-Source: APXvYqzwkvBhlR8S8SS+Zq5LsiZ1ME/oWfT80c4yCOGOM9PinHseBUshBiumSZNNq/U7qxiolxTz+g==
X-Received: by 2002:a17:906:7b58:: with SMTP id n24mr2745635ejo.224.1556825712661;
        Thu, 02 May 2019 12:35:12 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z3sm32010eja.32.2019.05.02.12.35.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 02 May 2019 12:35:11 -0700 (PDT)
Date:   Thu, 2 May 2019 21:35:10 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Tim Murray <timmurray@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>, kernel-team@android.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 1/2] Add polling support to pidfd
Message-ID: <20190502193509.poponmy3j67xjxth@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190501151312.GA30235@redhat.com>
 <20190502151320.cvc6uc3b4bmww23k@brauner.io>
 <20190502160247.GD7323@redhat.com>
 <20190502191437.GA103213@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190502191437.GA103213@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 03:14:37PM -0400, Joel Fernandes wrote:
> On Thu, May 02, 2019 at 06:02:48PM +0200, Oleg Nesterov wrote:
> > On 05/02, Christian Brauner wrote:
> > >
> > > On Wed, May 01, 2019 at 05:13:12PM +0200, Oleg Nesterov wrote:
> > > >
> > > > Otherwise I see no problems.
> > >
> > > I'll remove the WARN_ON() check when applying this. Can I get your
> > > Acked/Review, Oleg?
> 
> Oh, ok. Good point about the de_thread race. Agreed with you.
> 
> > Yes, feel free to add
> > 
> > 	Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > 
> > Hmm. Somehow I didn't read the changelog before, I just noticed
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Please remove ;) Thanks Joel, I appreciate it, but it is not my idea.
> 
> Ok no problem. You have been very helpful so thank you for that!

Yep, big thank you, Oleg! :)

Christian
