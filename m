Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFC1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1820421907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjtPWLGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfIRIIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:08:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35618 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfIRIIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:08:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id a24so3564041pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQbdsmmWxLAMHmcxjS1VEkYRC7qh/5LglHiRmX1QRKk=;
        b=TjtPWLGXOaEKW8ssJzgvSB2n4aJtzX0cjdAOZJcnLI8qci4h1dTkisnVfA4BCjaRev
         48XZfPTGz7NkZZemSYpSm/y491n2jhpolVE4TnhgAHJytfh+rdzXX44pnuenMyWFOMkS
         ig5myx4Uy5ltGzh8hxi10KysoEvbrD+Jk1C6PLEVCX7nnJcmFYcyfhbD58+EEMUGzinJ
         fZ2gU8CZkICUXELUNE+yfedq+rQrfbiA+zK2iFdNYvTd53gOmIfwKi7ZbpIkS6jCQE3V
         ZRbw3DfdyWUxXDJ4HgFhkXqpqcWBrBBhTUn6CrACnoG2CEIkquXPY5DJygjYFu5GOrz8
         +jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQbdsmmWxLAMHmcxjS1VEkYRC7qh/5LglHiRmX1QRKk=;
        b=bZFoZae1XuTZ6O7pq/sJZsakEq9WPaMYvLP+u499YfI+OIcwSXkunCzRTcW53HEJCA
         3Vraju+y57N/6T5fS8Mtaq5bNxGqv6O0OgG9ayPk4IEDXBfJBNKLllKFXdXelJALujaw
         y1M8kGdb4cQHWsIlcB1xpw5UptI27q6nxHbyovmhicU1bnN2jEkbI038l7gxuYxFb2zZ
         Uxr1iPHEqDuKmhjV871Tb1Grbtt2pnTIJJl9ng1Lz1UGBXIZ6tSGR1Z9ng0gF9sAFbOZ
         RiW6O3ZkBNlUJc46kuRIEdna99T4qAcSEQ2vXUnNtPffd5RHDGakVD+2pPt3QYNJAezF
         xjdg==
X-Gm-Message-State: APjAAAWlIs4eMyT6wVbtrdkET29+0vnL/XlpZPiRnM9yaqV5VIJxmKq2
        1tDpVXi6sPqO85W8d+TeXKM=
X-Google-Smtp-Source: APXvYqxOKxyvKh9JbzkoiKD5ns+/J24SNotZhLkmLqIeEKzKYDoNFZdABZFA1ZPBuwCyIQOIlxDimw==
X-Received: by 2002:a17:90a:ae04:: with SMTP id t4mr2424248pjq.52.1568794116915;
        Wed, 18 Sep 2019 01:08:36 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id y28sm8616881pfq.48.2019.09.18.01.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 01:08:36 -0700 (PDT)
Date:   Wed, 18 Sep 2019 17:08:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918080832.GA37041@jagdpanzerIV>
References: <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
 <20190918012546.GA12090@jagdpanzerIV>
 <20190917220849.17a1226a@oasis.local.home>
 <20190918023654.GB15380@jagdpanzerIV>
 <87lfumnjo2.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfumnjo2.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/18/19 09:33), John Ogness wrote:
> 
> I expect sysrq to be the only valid use of "synchronous state" other
> than oops/panic. Although I suppose PeterZ would like a boot argument to
> always run the consoles in this state.

Yes, there might be more cases when we need sync printk(). Like lockdep
splats, KASAN warnings, PM debugging, etc. Those things sometimes come
right before "truly bad stuff".

> > For instance, tty/sysrq must be able to switch printk emergency
> > on/off.
> 
> The switch/flush _will_ be visible. But not the state. So, for example,
> it won't be possible for some random driver to determine if we are in an
> emergency state. (Well, I don't know if oops_in_progress will really
> disappear. But at least the printk/console stuff will no longer rely on
> it.)
[..]
> Thanks for bringing up that RFC thread again. I haven't looked at it in
> over a year. I will go through it again to see if there is anything I've
> overlooked. Particularly the suspend stuff.

That thread most likely is incomplet and incorrekt in some parts;
shouldn't be taken too seriously, I guess.

	-ss
