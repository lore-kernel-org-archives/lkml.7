Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FA4C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C55D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rtxKJXtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfCNV1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:27:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46247 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfCNV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:27:38 -0400
Received: by mail-qt1-f196.google.com with SMTP id z25so7838862qti.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GywYO3Sx7pjw4OVRZOdEhfaoJTRL6Z5Vllt+5Wi6JAM=;
        b=rtxKJXtDeencaCdnl1LfEVoUp+lNG2z6E/ycc5A7T0noPMGFNoGpmimr8HR85gz1OU
         zuQhtO0DxJ9PThr+8dyWAFnw80Kr0eVnzIxBJnX5daM2KlKOdlqmQBLqs/Pr9eflsDH7
         uxxrSCLrmTx3I/TW7XXt3Tl0ABLffhrJV3104=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GywYO3Sx7pjw4OVRZOdEhfaoJTRL6Z5Vllt+5Wi6JAM=;
        b=Ot4xMmE/vEuFVc3bwGFpEeM4pFi5oU3oOUCUHLuLzJYcKpwP+DLwDf0f2WBqx4SqBP
         4XV+i0HwK0tQR8MIc1B4ybsll2wV5+LiQBMb6X2tDXh60TZUaR+/0h5gUT6Ow4D0kq+x
         x4KxgaYta4aTynVCLr21JB7zNhypbmo/FhFyg4PLwXZv9KkDjD92RJkINN16yaWgeWl5
         Nqey3xCnD/M5BsDANxVHi1fcgEDXhPCeZK1h3p8z0RpV8uH5/v4o2es5HlntS89EUQa7
         +gQEFA3Ze2NHmGvjfhncj+eKx+Pw2WswuNhbwdFnVsO8Fj78du3vvvgwv6dj5jZ5nba0
         vSAA==
X-Gm-Message-State: APjAAAXzqKDT+tu83dRxgYZFTi4cyA/FbBnRe66HSvATmR9dsB1vQkeQ
        M7pwbJUt1Caa+eSd770U7fA4Lg==
X-Google-Smtp-Source: APXvYqxSmI5j2pho9SeyC5yaPdAUCmWuVDhcUBxuJN7g7lJkkwP2+ObbEjQTFoQJogk2X6+eJMMPrw==
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr155326qtj.349.1552598856543;
        Thu, 14 Mar 2019 14:27:36 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id g123sm217467qkg.0.2019.03.14.14.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 14:27:35 -0700 (PDT)
Date:   Thu, 14 Mar 2019 17:27:34 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190314212734.GB104720@google.com>
References: <20190312150514.GB249405@google.com>
 <20190312152034.GZ13351@linux.ibm.com>
 <20190313150948.GA84821@google.com>
 <20190313112726.01d974fc@gandalf.local.home>
 <20190313155155.GN13351@linux.ibm.com>
 <20190313125125.1a1fb2f3@gandalf.local.home>
 <20190313180730.GU13351@linux.ibm.com>
 <20190314123159.GB101545@google.com>
 <20190314093657.2c1a3485@gandalf.local.home>
 <20190314093746.028e57f1@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314093746.028e57f1@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 09:37:46AM -0400, Steven Rostedt wrote:
> On Thu, 14 Mar 2019 09:36:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 14 Mar 2019 08:31:59 -0400
> > Joel Fernandes <joel@joelfernandes.org> wrote:
> > 
> > > Oh thanks for pointing that out. Yes it does work for me. I agree with the
> > > lockdep API addition and others could benefit from it too. I will incorporate
> > > the lockdep API addition into the RCU patch, but let me know if I should
> > > rather split it.  
> > 
> > I'd recommend splitting it (adding the lockdep_assert in a patch by
> > itself), but make sure that patch Cc's the lockdep maintainers and
> > explains the reason for adding it. Might as well Cc the lockdep
> > maintainers on the entire series too.
> >
> 
> Feel free to add "Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>"
> on that patch too.

Will definitely split it and add your tag. Thanks!

 - Joel

