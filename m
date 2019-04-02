Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6E0C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B6620857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPjN4L0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfDBItE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:49:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44401 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfDBItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:49:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id v71so3532927lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 01:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oZpD6xg3efy+1LfQsFiFXVAuAOXY3HlZANyPjrgbP3c=;
        b=TPjN4L0A6RpV2nqcTijTCLDabb47FHE8oG76AMyWauwGNDFjCT4WKj9scUJEyGA54+
         fshX74KK4QPJmvxPRQ1x30VxXM8Qj5t9MJc2OzfsnAISCVzkPNUUFD3ao6MYsHbWh3zr
         b7M7BjVhymjLeW6ciA+hUkzGqrcCBP/3c7vxwDdLmKHeK0T0Ucb2YCiTvxpQGgBFW0IX
         32y8XC1091mK8kB5aGD7QAvk0D2xesUqSMw4UTbq8kPzhhj5/NTkjhHCC8INztAEvqrh
         sF/mOs1A94oDiWAb0Xi31XEzljs1IH/fryOk3xWWsJXmZSBtOFsnP3YyE4q6DVT0eVEl
         C0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oZpD6xg3efy+1LfQsFiFXVAuAOXY3HlZANyPjrgbP3c=;
        b=JCfHz2Ay7In6sqNF/fZvD1ZeVcXjJR/JPcX5hjlYrvVs95WgTnWJgVreDv4/MjqHDS
         iqGzLZwaOoK+JRa9rF73bxvWJVmsRgYfZmmzp+6/FFXJiSyAiXwMLLRTbaArc+X02gDh
         VoCHFb5LPK7CEKbk4tC7l/i7MF1MiIpKc9u0aoz9r6GfblHLEKQWh8yk8FCoF9J0o8nD
         OHKR7QmfgmtAbwywXYR1QYApgPQ92IHRNBk0SWVbrpJzU1+2MwA/RqeWpVw0ydGOCrH7
         JfiJe3CXw1PMiVyRM1Jo990b0Wfk+n5M1fX8/JtgzeY45zosEaCJyotnp32sdapJIHkr
         Kvxg==
X-Gm-Message-State: APjAAAUw+4ymRrap/6Z8qd03VPNBnx6sYKzZ2o4WYocCRUkIrnBn/eTC
        U6VdUycahIPIdTUANdxnhgc=
X-Google-Smtp-Source: APXvYqwgOsZRx24mjTnwvSoLCf+v1qUQeKWFfNKmLRSHLhVbBWlkx7FFt2kGR5t/6wIYq498ssGJLA==
X-Received: by 2002:a19:40cc:: with SMTP id n195mr23167947lfa.150.1554194941419;
        Tue, 02 Apr 2019 01:49:01 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id a22sm2369821lfg.37.2019.04.02.01.49.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 01:49:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 2 Apr 2019 10:48:53 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-ID: <20190402084853.5lyaozljrv6rfcog@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
 <20190401110347.aby2v6tvqfvhyupf@pc636>
 <20190401155939.66ad1f8ad999fde514002e66@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401155939.66ad1f8ad999fde514002e66@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 03:59:39PM -0700, Andrew Morton wrote:
> On Mon, 1 Apr 2019 13:03:47 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > Hello, Andrew.
> > 
> > >
> > > It's a lot of new code. I t looks decent and I'll toss it in there for
> > > further testing.  Hopefully someone will be able to find the time for a
> > > detailed review.
> > > 
> > I have got some proposals and comments about simplifying the code a bit.
> > So i am about to upload the v3 for further review. I see that your commit
> > message includes whole details and explanation:
> > 
> > http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git/commit/?id=b6ac5ca4c512094f217a8140edeea17e6621b2ad
> > 
> > Should i base on and keep it in v3?
> > 
> 
> It's probably best to do a clean resend at this stage.  I'll take a
> look at the deltas and updating changelogs, etc.
Will resend then.

Thank you.

--
Vlad Rezki
