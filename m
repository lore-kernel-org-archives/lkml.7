Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A1A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WI0Ab/Ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfCNMcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:32:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37055 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfCNMcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:32:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id z17so5767223qtn.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O66kdQXOarCKUq+1dTsJapp3SRZV9kBKqR1827U6s04=;
        b=WI0Ab/DsGrEhdwbVVwi0LnEbCEhAoOtBS3VOhkq741c/7SSDRV1FAlGiMpb0HDNzGe
         8kns1g5wLVWmszHIfIIy7Hn4GCTz81I1NDfxjnDroXIj9xzWRTHyaHlSm0CmtUjztynZ
         J64v7JmeQrFkDvsmLbZLKtHi0WMdXNELq81Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O66kdQXOarCKUq+1dTsJapp3SRZV9kBKqR1827U6s04=;
        b=VxxpuUawZmlfMv9dbNrek8zDBQzSm9q/o9vpJBtGYll/pM5M/1H6UcmLxvaUjujjHz
         DkWbYV3N3i71hk8eZYOb8J4MH+JstaLVtfLFAMHIR0IwNP12Y797T4a0+857mvb5k+MD
         /nmxF6VCH/sKaxd/iX7p+FZ47XLVlyZqwVwM/wC/odBBzbgG1ivbIvogI+OKc16BCysm
         QQ5UMZSXLCj9V+cgA5Ynu6MDpbNIbuH+US4mzaFwjWp6KhuOV+rK9AbkSK27iyPSbxmL
         zjRzVM+DLIlsJIvQNdnb9J6tLJep+yJUXNfqzkvd9HACjZrT3oQkjRMuIzWkfjcTcljV
         1UMg==
X-Gm-Message-State: APjAAAUoZhCF4pyCkQBEs1/9fBwkivThENDZ7lrNwL3iVjpRQ9ol7mx3
        lTN1C5ISmKNg76NW7p2w/4u9oA==
X-Google-Smtp-Source: APXvYqwL9lUL+sTLRKEWufOOXJfW6YUstHLVnX1fX6aoBXUgJcvUI8dZ83WCuv99Sspr7G16nx85ZA==
X-Received: by 2002:aed:3c75:: with SMTP id u50mr16356617qte.128.1552566721707;
        Thu, 14 Mar 2019 05:32:01 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id y11sm11872148qky.2.2019.03.14.05.32.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 05:32:00 -0700 (PDT)
Date:   Thu, 14 Mar 2019 08:31:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        luto@kernel.org, byungchul.park@lge.com
Subject: Re: [PATCH tip/core/rcu 06/19] rcu: Add warning to detect
 half-interrupts
Message-ID: <20190314123159.GB101545@google.com>
References: <20180829222047.319-6-paulmck@linux.vnet.ibm.com>
 <20190311133939.GA29747@google.com>
 <20190311222903.GR13351@linux.ibm.com>
 <20190312150514.GB249405@google.com>
 <20190312152034.GZ13351@linux.ibm.com>
 <20190313150948.GA84821@google.com>
 <20190313112726.01d974fc@gandalf.local.home>
 <20190313155155.GN13351@linux.ibm.com>
 <20190313125125.1a1fb2f3@gandalf.local.home>
 <20190313180730.GU13351@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313180730.GU13351@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:07:30AM -0700, Paul E. McKenney wrote:
> On Wed, Mar 13, 2019 at 12:51:25PM -0400, Steven Rostedt wrote:
> > On Wed, 13 Mar 2019 08:51:55 -0700
> > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > 
> > > Does this mean that there is a better approach that Joel's suggestion?
> > > I believe he would end up with something like this:
> > > 
> > > 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_RCU) && !in_irq());
> > > 
> > > It would be nice if there is something like this:
> > > 
> > > 	lockdep_assert_in_irq_handler();
> > > 
> > > But I haven't seen this.  (Not that I have looked particularly hard for
> > > such a thing, mind you!)
> > 
> > That would be trivial to implement:
> > 
> > #define lockdep_assert_in_irq() do {
> > 		WARN_ON(debug_locks && !current->hardirq_context);
> > 	} while (0)
> 
> Looks good to me!
> 
> Joel, does this work for you?  I could be wrong, but I suspect that Steve
> is suggesting that you incorporate the above into your eventual patch.  ;-)

Oh thanks for pointing that out. Yes it does work for me. I agree with the
lockdep API addition and others could benefit from it too. I will incorporate
the lockdep API addition into the RCU patch, but let me know if I should
rather split it.

thanks!

 - Joel

