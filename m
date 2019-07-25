Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76201C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C646229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="W8nZcCuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbfGYLvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:51:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46089 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGYLvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:51:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so49996325edr.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 04:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qb0U4o7YT9U0VbrF0QHOhn7J92nY/IJnK+dtiIpPk2s=;
        b=W8nZcCuIC42LTrQ+cXgC4rxIwaAgupXOYclF8q9Uu2sxmkv1TzOar8yCZb7d9cQj+L
         qb65n8bo59k4q9hp/sekLL69Gy+kti/bnHpRcw2CQknDwHyoxGOfvszmlujPCoAJvMzd
         hDvWBRn2M9oAlz8ZVK+DWvKczNPv0mEyebMimsuzoX89P2SR30WuY3RQqvu78hAY5NE/
         01wwwmr1XenQs8XxVBJiHfvWKhUs0UL8awthAA43ims7jr9gWaSZmU/HsKtHX2vDCUQK
         gSPnY6wRmn/lTk2DTSjusR1dLjqOFFXjnrZtaMhICzk4Ot3QgUeZhyIWyMxZTzYXpngk
         j3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qb0U4o7YT9U0VbrF0QHOhn7J92nY/IJnK+dtiIpPk2s=;
        b=uAwchXEO4TFwpBf24co9su8qbrQoPbfi6tLUm4ywHkrSzA4+fdiIp2NkNKfJGxZMTp
         k/MzpSdkCl+atyjaMfbRqSXKwjyveUP/ZuVPRHQGw/1kaZBjBvR2u4XKbb+j/K5Rmd4K
         PlL9g1Z2UuBgpRSvmo8L1/FQKzX+evYoul2shGaBxeFw3NITTElcJ2i8cf6cXU5rffQe
         LBBMYaQyBGtcxtTXMIzjQyTSBJK2I3luccPCnljSwnPQwmChSaYjrXzB89nx7sDX0/Io
         vdbHMeVlXljMEXGl2lXXdHDj5Ex9glD8rPKO5+PUUluxwh9AFu4Tizp7DUcJTI95nYeB
         uvhQ==
X-Gm-Message-State: APjAAAWaY1cdwfGhWZ+HXy3Y2HNaYSvdYjzVBTcxGsdbo5o/7bmcUv6k
        p4pR++fpd0pz9pfGGX45rn8=
X-Google-Smtp-Source: APXvYqzta/C7mytsF/sYtTrTny6c5TAQI5i2DpRjUhOVT1P3aLCxDWl2HWiq25oPh0cTbNwujbNFTg==
X-Received: by 2002:a50:871c:: with SMTP id i28mr76751011edb.29.1564054911890;
        Thu, 25 Jul 2019 04:41:51 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id r10sm13245342edp.25.2019.07.25.04.41.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:41:50 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:41:49 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, tglx@linutronix.de,
        tj@kernel.org, dhowells@redhat.com, jannh@google.com,
        luto@kernel.org, akpm@linux-foundation.org, cyphar@cyphar.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 4/5] pidfd: add CLONE_WAIT_PID
Message-ID: <20190725114148.bgm37lpiqli7g3ti@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-5-christian@brauner.io>
 <20190725103543.GF4707@redhat.com>
 <20190725104006.7myahvjtnbcgu3in@brauner.io>
 <20190725112503.GG4707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725112503.GG4707@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 01:25:03PM +0200, Oleg Nesterov wrote:
> On 07/25, Christian Brauner wrote:
> >
> > On Thu, Jul 25, 2019 at 12:35:44PM +0200, Oleg Nesterov wrote:
> > >
> > > I have to admit this feature looks a bit exotic to me...
> >
> > It might look like it from the kernels perspective but from the feedback
> > on this when presenting on this userspace has real usecases for this.
> 
> OK...
> 
> but then perhaps we can make PF_WAIT_PID more flexible.

I've changed this to be a property on signal_struct, i.e. a bitfield
entry following the {is,has}_child_subreaper entries.

> 
> Say, we can add the new WXXX wait option and change eligible_child()
> 
> 	if ((p->flags & PF_WAIT_PID) && (wo->options & WXXX))
> 		return 0;
> 
> this way the parent can tell waitid() whether the PF_WAIT_PID tasks should
> be filtered or not.
> 
> And if we do this we can even add PR_SET_WAIT_PID/PR_CLR_WAIT_PID instead
> of the new CLONE_ flag.

Hm, I prefer to not do this.
The idea is that this is a property of the pidfd itself and not of the
waitid() call. And currently, I don't think it makes sense to change
this property at runtime.
What might make sense is to remove this property when a task gets
reparented, i.e. when its parent has died.
