Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B805EC072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922EC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ2irMJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfE0OCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:02:51 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33901 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE0OCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:02:50 -0400
Received: by mail-lj1-f196.google.com with SMTP id j24so14807381ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nCMqcLWyCA+4Q/MEIIgUaDC50B6QNtxtBMlc97ZOozY=;
        b=CJ2irMJKh684KUcwCc9e3mRWyJ3si0NiJuPS8075E4MvXvGMVcYFMOXShhgQ6jQ65m
         5ZT8nQuRaOztT3vV1jR1mOBIKUw3uFP111pf95gc1AWajJpwzTjYYE3a8pNrNFx8YM3G
         qF+VgZDKakhfXS6vsoAA15xxhlI70teCFJXoQOhdt+aB+nwDh+M1AUnaMOaH2u4iowZF
         M9RDJ51+OJf4FjpByIo02Fg5yIq6EfeQVZk5SdkqFnA4eQFbHfJ3XquqOWlYbMC024Gc
         vgdX3QYfA4UtbUxk8wiLe15FW8s3SdFjoTNbTQfmI/ASsEOrqluE4QTc3bmQiVdMTCm3
         diYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nCMqcLWyCA+4Q/MEIIgUaDC50B6QNtxtBMlc97ZOozY=;
        b=bpH0tE5BSzWdw1tBM4NgdGFmHAhNnyUjF/zAQZ+hfyHzzIsFI6d0KAtZLGYeKHnNlp
         No6URwB4L4gHEkah5OmPMPzEyNfdhuN5/uPAaspKkJjVi6hpjxpKXrAha2ttnYZRZk/8
         sUkeTLXyW5dNCKe33KezVJdQbKdS7zBJclMEeCE+LJ4sp4wZGbmB62OQfff4jaq9ox9x
         mw+M1mhKUtf4VL1Y3/RKv2KFj145dfR7qbaXqqFX9c+1I2VNmgcRxJ/Gr1NRSPmvWjQl
         r4QlaESJ4CDDYzXd14Zzg9jW5nbImXZij2O7at+ZBcqKYv+QKUchvek/w64yKAinOvxP
         2mLg==
X-Gm-Message-State: APjAAAX3somZB3VMRqLJ2R38lE+GdBNv4Wkd+YIZehvCuLtYBKDU4fk/
        lVALLZVcDh8QmLIkUYjPySA=
X-Google-Smtp-Source: APXvYqzXY+tlQxq7QCiBnJ+JYYpe6XAxMrsHVoWpLgb9r76XvPQ1r14R5z8LOJLwEgnfZ3qF0GJRWg==
X-Received: by 2002:a2e:81d9:: with SMTP id s25mr21926270ljg.139.1558965768729;
        Mon, 27 May 2019 07:02:48 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id r62sm2335963lja.48.2019.05.27.07.02.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 07:02:47 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 27 May 2019 16:02:40 +0200
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Message-ID: <20190527140240.6lzhunbc4py573yl@pc636>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-5-urezki@gmail.com>
 <20190527085927.19152502@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527085927.19152502@gandalf.local.home>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > function, it means if an empty node gets freed it is a BUG
> > thus is considered as faulty behaviour.
> 
> Can we switch it to a WARN_ON(). We are trying to remove all BUG_ON()s.
> If a user wants to crash on warning, there's a sysctl for that. But
> crashing the system can make it hard to debug. Especially if it is hit
> by someone without a serial console, and the machine just hangs in X.
> That is very annoying.
> 
> With a WARN_ON, you at least get a chance to see the crash dump.
Yes we can. Even though it is considered as faulty behavior it is not
a good reason to trigger a BUG. I will fix that.

Thank you!

--
Vlad Rezki 
