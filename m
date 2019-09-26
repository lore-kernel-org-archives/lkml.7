Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F9C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3315222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iKB8iMMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfIZNCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:02:30 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34884 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZNCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:02:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so2756795qtq.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dtv5V4xuAX2qubER6XZTSCZ8MR1PT0yb6P2Q568+EKA=;
        b=iKB8iMMpiJyB+hlUoNXrd6ToWzpKLma9R4tAfHJh0IkC/bXzbeYt5q6OBSZe3i26i3
         xd+cxHbW2vayKi6d9RrulvbyR95zphMHepSdsLyTif+yj6AfLQwL8FC23oSTXvlTp6wE
         oxodMwRJ7n+JfUy3B6JLXD+t4YwX/ZbaSh1CE7UgzIUB+WRH4S5zdoUEOYSxNl7+ncj3
         m5LXWhHugHAa/bWTu7uqeP7w4GQe74SsLIoVP4rbAMC4hOMH2BCJwgelF7Lx0meJ45XL
         +RfsgcxvGt33v1zO3xXY79HBeL5MDGMtd4QeBhMShoVWnEgH/9P3fnFTPYWGe4OrLwpM
         v3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dtv5V4xuAX2qubER6XZTSCZ8MR1PT0yb6P2Q568+EKA=;
        b=FDvwULRffEkqhKLOXPsnKOrv0QeWRmowoAbgmogbeTlInatCt0rwsSU0s/jgDC4Ght
         v/i0/ffayT0+JKSKGCX1nKUwHglxjYOhGDWaWa9mxFCWa138RjKxd16kHKpf9bUq1aA2
         QsAbQiPADEoWyuKyvy4vToLf1TtBJwpa8hEnUzft1UXBRzFvViO8sTa82GNFbvG0FFJ1
         DMsrkPt/HBWiLr5wo5++mvFqgkrNLm4iIh2xl2XT7Z5ET+Eqo7/5YFEjFAiwo4rKqvOx
         jRJOiI73+jOcKlOXSi/MJx3SiyDMX4PmqY2HVlxsElKuvpxaTRefOS26ByFLFW9TrHJX
         FQyQ==
X-Gm-Message-State: APjAAAWW4GjQk6nFgggTlAdchddzUZ3k5MCba9V+rpJPWLKvNu0uuaYR
        G6gqkpef91QcAe/mZXJh/Ehf7A==
X-Google-Smtp-Source: APXvYqxtQJ9FJHaGp6hMrrPUUV4eHNQC2OttRZ8hWWRAnvvoWTeWkWAxAzFN1A4nP65N541R1qH5LA==
X-Received: by 2002:ac8:1cf:: with SMTP id b15mr3685424qtg.56.1569502949510;
        Thu, 26 Sep 2019 06:02:29 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u11sm940642qtg.11.2019.09.26.06.02.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 06:02:28 -0700 (PDT)
Message-ID: <1569502946.5576.237.camel@lca.pw>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 26 Sep 2019 09:02:26 -0400
In-Reply-To: <20190926115258.GH20255@dhcp22.suse.cz>
References: <20190926072645.GA20255@dhcp22.suse.cz>
         <C8DA5249-2DEB-47D5-937E-5A774B1CB08B@lca.pw>
         <20190926115258.GH20255@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-09-26 at 13:52 +0200, Michal Hocko wrote:
> On Thu 26-09-19 07:19:27, Qian Cai wrote:
> > 
> > 
> > > On Sep 26, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > > 
> > > OK, this is using for_each_online_cpu but why is this a problem? Have
> > > you checked what the code actually does? Let's say that online_pages is
> > > racing with cpu hotplug. A new CPU appears/disappears from the online
> > > mask while we are iterating it, right? Let's start with cpu offlining
> > > case. We have two choices, either the cpu is still visible and we update
> > > its local node configuration even though it will disappear shortly which
> > > is ok because we are not touching any data that disappears (it's all
> > > per-cpu). Case when the cpu is no longer there is not really
> > > interesting. For the online case we might miss a cpu but that should be
> > > tolerateable because that is not any different from triggering the
> > > online independently of the memory hotplug. So there has to be a hook
> > > from that code path as well. If there is none then this is buggy
> > > irrespective of the locking.
> > > 
> > > Makes sense?
> > 
> > This sounds to me requires lots of audits and testing. Also, someone who is more
> > familiar with CPU hotplug should review this patch.
> 
> Thomas is on the CC list.
> 
> > Personally, I am no fun of
> > operating on an incorrect CPU mask to begin with, things could go wrong really
> > quickly...
> 
> Do you have any specific arguments? Just think of cpu and memory
> hotplugs being independent operations. There is nothing really
> inherently binding them together. If the cpu_online_mask really needs a
> special treatment here then I would like to hear about that. Handwaving 
> doesn't really helps us.

That is why I said it needs CPU hotplug experts to confirm that things including
if CPU masks are tolerate to this kind of "abuse", or in-depth analysis of each 
calls sites that access CPU masks in both online_pages() and offline_pages() as
well as ideally, more testing data in those areas.

However, many kernel commits were merged with the expectations that people are
going to deal with the aftermath, so I am not going to insist.
