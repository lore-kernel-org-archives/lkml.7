Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFF3C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EE82339E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="njj8mem6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfIDL7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:59:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44926 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:59:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id u40so15392048qth.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzmtWTnPA/Rbfge1TYPgG0Lbp66UuiOz5rFkcfZw1kw=;
        b=njj8mem6vJfmq4pdvzZq+AulBtyhhVvxbaq2IXq+U7h6WByiSYLEHMrTGozZi/KDm+
         mceeQ4vkauRV+W9XWixw/9a7PNat5fu0CkDi5v0fC1eq2FgYXq6GS2sNSeeUizW1IvSn
         nuvoCy1VC2b/TcEgM5cwMaTNzWEPLjy4+GLIXtD1+mC3tP50+W29mQLPw6fuiGMVjKbs
         n0uBWjzpeDBixBG7DN45Pp1+FFz+ivhGiXn3SJhHo6Rxc77tj0Fw5zhnNmR9nfGH45Nc
         JMbFHhQixIEDyJLrntrvAVUFSkwpD3/AFyHO2VuEzf9fSX3C/BPmEjjFbhImPFIS25sn
         2p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzmtWTnPA/Rbfge1TYPgG0Lbp66UuiOz5rFkcfZw1kw=;
        b=kITcJOEGjy4c0iS0ph8kUN+Z2LsvL/khl85exUELbO6kCXXIYm0nB0lq/HDwe8QizY
         kiw6pyxAlFrG2uL7GBs7imsWVAOIXRlM8CUi7AJAw+pQtC8rjBXCEvfnc5fWwAJi13Nv
         lqTO4+9RN+9GrG68y9pLwSdEJs1DR/Eb2cyRo2XvE3ihbi2EArYothMsNdROLNrTwiHt
         QHFIDsVbaC4t3IWtkoVxvxyVnSYZnMZsxWOSwOI9DDCZ0mABh5Z49brSvfcZ6rz0DpPO
         NL45yKqtqTW2Cm2UZ2gBsceaqnzJIlgODx1RKvKOje1Yhhhuwfvbv+Hm0KJsQRsLJx7I
         zTIA==
X-Gm-Message-State: APjAAAWHUyGT/IC7KzRCGrL9AoeMxgJitrVnR16WkgrRID9e+CKrIqOP
        UgvVt3F+Z3n9wunbr6ZqNvD+DA==
X-Google-Smtp-Source: APXvYqwBujPYNce+YzJGAMVB6jlwmaXEMKMVVywasNvBcbco1B+mrLeGqShd67/QcMdrc2hQmNl7eg==
X-Received: by 2002:a0c:8402:: with SMTP id l2mr10541155qva.201.1567598359802;
        Wed, 04 Sep 2019 04:59:19 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t17sm202689qtt.57.2019.09.04.04.59.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 04:59:19 -0700 (PDT)
Message-ID: <1567598357.5576.70.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 04 Sep 2019 07:59:17 -0400
In-Reply-To: <20190904082540.GI3838@dhcp22.suse.cz>
References: <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
         <1567178728.5576.32.camel@lca.pw>
         <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
         <20190903132231.GC18939@dhcp22.suse.cz> <1567525342.5576.60.camel@lca.pw>
         <20190903185305.GA14028@dhcp22.suse.cz> <1567546948.5576.68.camel@lca.pw>
         <20190904061501.GB3838@dhcp22.suse.cz> <20190904064144.GA5487@jagdpanzerIV>
         <20190904070042.GA11968@jagdpanzerIV>
         <20190904082540.GI3838@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 10:25 +0200, Michal Hocko wrote:
> On Wed 04-09-19 16:00:42, Sergey Senozhatsky wrote:
> > On (09/04/19 15:41), Sergey Senozhatsky wrote:
> > > But the thing is different in case of dump_stack() + show_mem() +
> > > some other output. Because now we ratelimit not a single printk() line,
> > > but hundreds of them. The ratelimit becomes - 10 * $$$ lines in 5 seconds
> > > (IOW, now we talk about thousands of lines).
> > 
> > And on devices with slow serial consoles this can be somewhat close to
> > "no ratelimit". *Suppose* that warn_alloc() adds 700 lines each time.
> > Within 5 seconds we can call warn_alloc() 10 times, which will add 7000
> > lines to the logbuf. If printk() can evict only 6000 lines in 5 seconds
> > then we have a growing number of pending logbuf messages.
> 
> Yes, ratelimit is problematic when the ratelimited operation is slow. I
> guess that is a well known problem and we would need to rework both the
> api and the implementation to make it work in those cases as well.
> Essentially we need to make the ratelimit act as a gatekeeper to an
> operation section - something like a critical section except you can
> tolerate more code executions but not too many. So effectively
> 
> 	start_throttle(rate, number);
> 	/* here goes your operation */
> 	end_throttle();
> 
> one operation is not considered done until the whole section ends.
> Or something along those lines.
> 
> In this particular case we can increase the rate limit parameters of
> course but I think that longterm we need a better api.

The problem is when a system is under heavy memory pressure, everything is
becoming slower, so I don't know how to come up with a sane default for rate
limit parameters as a generic solution that would work for every machine out
there. Sure, it is possible to set a limit as low as possible that would work
for the majority of systems apart from people may complain that they are now
missing important warnings, but using __GFP_NOWARN in this code would work for
all systems. You could even argument there is even a separate benefit that it
could reduce the noise-level overall from those build_skb() allocation failures
as it has a fall-back mechanism anyway.
