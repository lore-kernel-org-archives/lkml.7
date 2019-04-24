Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0CEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C562218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="PRJhisyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfDXP2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:28:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37275 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfDXP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:28:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so14038712wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9kzDA8V6Uz+l28kyAJYpVzfWGDcT7GA5gjS0BJvhacI=;
        b=PRJhisyHQZ64UzAo5zvvJNZRGzwRbj2BsBWtviZVOOnhElo1TxHdIXiEEYNnogomCu
         +OPvtkTAn7QVeEqLYP827Z+unSXTrhpgw71UNnY04NSb/Q5VZKHP+Q5Q1KvUMbVqrrgW
         5B/9IMTHygy8YAzjvFh24mPC+rMghuBf+RqlhZ2oxZfAFKgJXJkbgJspGsD/udpLCGD7
         Oti2IjTHuqMu74GMxsBZPzYA8WxS1f5OAS9FMgWiGK/UwItWyAHMnDpwc3ZlU4QDZ5m1
         PF+BrtU2o0nZHKzG6sksSjhWKDo8QzncDzXSQ7shPLtsPPWqvyq+/tdM1EHT8JmYBgF6
         KRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kzDA8V6Uz+l28kyAJYpVzfWGDcT7GA5gjS0BJvhacI=;
        b=KeYo/HyWrCmv1YkpmA1EzBKq+bu+G36guLPqUpLlXuQVB8UeVedy1eZj0/h7/Xei5G
         Xt7eMz6yBBP5nEWK6VxnPYp1w6VZ0nioxMwZLAFXRsYQaKZz5dHOVrDVQcdG15VxqQhq
         GBWkJTcDthXIcYmx4HjTfpnR7mw4T6e7fxVWQ5iMBnf87Hw7Sf/P3ZNhaCfWVRfSy4MH
         OnslZPNwSJfoqas4KrgDuG/pYxdlb8dW5QYlmI9mbxqhVw0q/zp6ZdPa4B0AOuvu+xY7
         9e52HEs+mQijac6FVLjRf/UuT0R0sbc1njFy6G+POnenEVAMmq6+RmaNcvVUSWqGUhQ5
         q9fw==
X-Gm-Message-State: APjAAAUSHxe6tFWUdqPCt9vB0r99kY3BgqKz+0uxSzms/pkGiA3sc1Qb
        yorEI2lNI5VBn2paxP5gpiShdA==
X-Google-Smtp-Source: APXvYqxtsvr/bJf4sKtGrTjYewNva9VCZV6PN4DhgWnCaoAk0S2fEQE0gT/gDNJ7vNwI+z4PkwpMlA==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr12759904wro.206.1556119679743;
        Wed, 24 Apr 2019 08:27:59 -0700 (PDT)
Received: from brauner.io (p4FC0A32E.dip0.t-ipconnect.de. [79.192.163.46])
        by smtp.gmail.com with ESMTPSA id j190sm23318472wmb.19.2019.04.24.08.27.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Apr 2019 08:27:59 -0700 (PDT)
Date:   Wed, 24 Apr 2019 17:27:58 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     keescook@chromium.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, stgraber@ubuntu.com
Subject: Re: SECCOMP_RET_USER_NOTIF: listener improvements
Message-ID: <20190424152757.o5dtrajmg33563x4@brauner.io>
References: <20190424150423.k3embc2vkho2kixp@brauner.io>
 <20190424152001.GL3758@cisco>
 <20190424152305.32znd5t7r3d3hedj@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190424152305.32znd5t7r3d3hedj@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:23:05PM +0200, Christian Brauner wrote:
> On Wed, Apr 24, 2019 at 09:20:01AM -0600, Tycho Andersen wrote:
> > On Wed, Apr 24, 2019 at 05:04:26PM +0200, Christian Brauner wrote:
> > > Hey everyone,
> > > 
> > > So I was working on making use of the seccomp listener stuff and I
> > > stumbled upon a problem. Imagine a scenario where:
> > > 
> > > 1. Task T1 installs Filter F1 and gets and listener fd for that filter FD1
> > > 2. T1 sends FD1 via SCM_RIGHTS to task T2
> > >    T2 now holds a reference to the same underlying struct file as FD1 via FD2
> > > 3. T2 registers FD2 in an event loop and starts listening for events
> > > 4. T1 exits and wipes FD1
> > > 
> > > Now, T2 still holds a reference to the filter via FD2 which references
> > > the same underlying file as FD1 which has the seccomp filter stashed in
> > > private_data.
> > > So T2 will never get notified that the filter is essentially unused and
> > > doesn't know when to exit, i.e. it has no way of telling when T1 and all
> > > of its children using the same filter are gone.
> > > 
> > > I think we should have a way to do this
> > 
> > Since the only way we ever allow creating a struct file * that points
> > to a struct seccomp_filter *, if there is a notifier attached, the
> > number of tasks still being monitored by a particular filter should be
> > filter->usage - 1 (assuming there is a notifier attached). So we could
> > augment __put_seccomp_filter() to check for this and send out a
> > message with a SECCOMP_NOTIF_FLAG_DEAD flag or something.
> > 
> > > *or* alternatively have a way to attach a process to an existing
> > > filter.
> > 
> > I also think this wouldn't be too hard, since the struct file * has a
> > reference to the filter. So I guess the question is: which of these
> > makes more sense?
> 
> Or we do both... But overall I'm very much in favor of the option to

The reason why I say both is that you might not always want to join an
filter and also you still want a way to hand-off listener fds. My main
scenario is a single watcher that watches listener fds from multiple
processes each potentially with a different filter.

> attach a task to an existing filter. Re-creating a seccomp context is
> extremely brittle and error-prone. This would take a way a major pain
> point.
> 
> Christian
