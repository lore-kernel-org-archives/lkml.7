Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C26C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CBC206E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573983389;
	bh=pEkw7V4giHDlzaJtTea+TayQZ6pxJ3+LIFR12UxsniE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y/D3nqTbq758wjN28XBsJuWsr7Nao+C+60vslmoexBDautct2nHl3iXbcsCiT+zjC
	 oLZhgaoFY3veYDm4Ob2vX3/9kybZ3/56YUDZWKZaONJFcf8s/a127MDhcOs6rYIqqu
	 25o7CvmWKDg6l8KWac+aHSENm0TM7WcxJL9FZerY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfKQJbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 04:31:17 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:37521 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfKQJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 04:31:17 -0500
Received: by mail-wm1-f43.google.com with SMTP id b17so15434024wmj.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Nov 2019 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cWvzJ7om1V8WUN8ijnW4V8zuQv7vLb5Zag38ZtyS71g=;
        b=Fht4xfA+Qi+y+yqv78RWjxKKEem5Cxc8U6zcplBGME4MoDYOE9/SFuhUQQOn4Tjor2
         LjruUP1y6DemDjkkx57u3wtvBs0RHMQRkeQpnOEyfPzpDyE3J5T9LuC1//uJGX93fVYd
         PrUbkqmLins2bKa82NmNbZW9Q/MOYN/c0JxSPebIh9ZwogQBRPQWsadnsgIRTMIlnAQY
         MzpaPhMOywGQzd1BjIzZAWoRkm23W5nk6Ivh3LbG5MrgshAemcveSjaK1jw+hudLK2ox
         CNsbpsFNoSB5npwCz/VQYgFgAFtFKDvRJdiMGSVoD5AQn4IyMfNZVBXlsh+vPZKYVAbi
         gr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cWvzJ7om1V8WUN8ijnW4V8zuQv7vLb5Zag38ZtyS71g=;
        b=BzfpqIqNS+nh7v9FfW3MKJsii7uI6ylCs4J/yWu+ajjd6jxR6JwKD64vd13fL8mMzz
         1P+Bvj8/6aE1d0KANdmvvyGFqzb+V1WCUQT64LGly3Z5YzcDDfbpZenX8yfQBgeYq1JW
         A2G1CwHTDik6+hvcMnP+RgnJ69jpMcMkAw+kqQfq+4zRhUdKoY6KLfQwN7CS0p93WCN7
         iXXbZGIRTvgauinxGsbpZJSeQrnT6zBizOf5b/FDYemISmLQf54yNH4dIsGHcA6HVn9O
         rHHa9MEGfcZeUQlu9B17OlMPFUgK/0Fe1CDdnaE9LRtJh7OHl1yndFF/IiyzD63dYq6q
         CPcw==
X-Gm-Message-State: APjAAAWq+BKCbgEqMKJ9soU1DkpOQxuWne3nqUOlAgLRqSdt/mYxo3QS
        ZYWUOxHpFIhEMmBv0rhANvU1oUI/
X-Google-Smtp-Source: APXvYqxNXG/oi9CjAKvz0F9ZLtlQK1PYAeacFaINeaA/6z8HtMcvcmV/6bosYzxL1j+gmBwgvDXOHQ==
X-Received: by 2002:a1c:80c7:: with SMTP id b190mr24349421wmd.3.1573983075103;
        Sun, 17 Nov 2019 01:31:15 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w12sm15889312wmi.17.2019.11.17.01.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 01:31:14 -0800 (PST)
Date:   Sun, 17 Nov 2019 10:31:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] scheduler fixes
Message-ID: <20191117093112.GA126325@gmail.com>
References: <20191116213742.GA7450@gmail.com>
 <ab6f2b5a-57f0-6723-c62f-91a8ce6eddac@arm.com>
 <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiFvP0idYrvWVtEwt6FM9jZ9TRF5yQhT1-X3vx31GRHTg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Nov 16, 2019 at 2:44 PM Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > > Valentin Schneider (2):
> > >       sched/uclamp: Fix overzealous type replacement
> >
> > This one got a v2 (was missing one location), acked by Vincent:
> >
> >   20191115103908.27610-1-valentin.schneider@arm.com
> >
> > >       sched/topology, cpuset: Account for housekeeping CPUs to avoid empty cpumasks
> >
> > And this one is no longer needed, as Michal & I understood (IOW the fix in
> > rc6 is sufficient), see:
> >
> >   c425c5cb-ba8a-e5f6-d91c-5479779cfb7a@arm.com
> 
> Ingo, what do you want me to do? Pull it anyway and send updates
> later? Or skip this pull request?
> 
> I'll leave it pending for now,

Yeah, please don't pull - will rework it. Sorry ...

Thanks,

	Ingo
