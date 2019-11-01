Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA045CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2B21855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572636563;
	bh=j1KP7pjcUgESkZ4XvE0fMh0jUHiONkGtncQhbYNGfKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=brgC4G1hMbIQHVk5RW/eDn8urfvY0N/gFduc1y4ymHCiilyVeCFl3+PbeLWCA2FyF
	 CxcUeF6ii7zGQ0bgvFB7jCOtqSOMeLGvlqF4GKfjBXCNFRnvncE79opOpYpgRHahoI
	 MurNbqG6r62rWw0b+YhdIsrRDAuJV34sAY2Pnpl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfKAT3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfKAT3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:29:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4546121734;
        Fri,  1 Nov 2019 19:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572636561;
        bh=j1KP7pjcUgESkZ4XvE0fMh0jUHiONkGtncQhbYNGfKg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VQGuM5stE1HnHHX0/rKMjhl2CcL6gPIiR5IegIedqZV9LtP0K3PUPaKqiZ/MKXSZA
         LAFu4aa9tnMPAxIm4eKyd8Joz4koQv0usvrJDZVKT8frTycD5ktAbqySKSTOXBuNti
         3XZvZk51mV0e5RqEJJKImxuJprnp7ZKRpoEvANcA=
Date:   Fri, 1 Nov 2019 12:29:20 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-Id: <20191101122920.798a6d61b2725da8cfe80549@linux-foundation.org>
In-Reply-To: <20191101192405.GA866154@chrisdown.name>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
        <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
        <20191101110901.GB690103@chrisdown.name>
        <20191101144540.GA12808@cmpxchg.org>
        <20191101115950.bb88d49849bfecb1af0a88bf@linux-foundation.org>
        <20191101192405.GA866154@chrisdown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 19:24:05 +0000 Chris Down <chris@chrisdown.name> wrote:

> Andrew Morton writes:
> >> > The only scenario I can construct in my head is that someone has built
> >> > something to watch drop_caches for modification, but we already have the
> >> > kmsg output for that.
> >
> >The scenario is that something opens /proc/sys/vm/drop_caches for
> >reading, gets unexpected EPERM and blows up?
> 
> Right, but...
> 
> >OK.  What if we make reads always return "0"?  That will fix the
> >misleading output and is more backwards-compatible?
> 
> ...I'm not convinced that if an application has no error boundary for that 
> EPERM that it can tolerate a change in behaviour, either. I mean, if it's 
> opening it at all, presumably it intends to do *something* based on the value 
> (regardless of import or lack thereof). It may do nothing, but it's not 
> possible to know whether that's better or worse than blowing up.
> 
> I have mixed feelings on this one. Pragmatically, as someone who programs in 
> userspace, I'd like failures based on changes in infrastructure to be loud, not 
> silent. If I'm doing something which doesn't work, I'd like to know about it. 
> Of course, one can make the argument that as a user of such an application, 
> sometimes you don't have that luxury.
> 
> Either change is an upgrade from the current situation, at least. I prefer 
> towards whatever makes the API the least confusing, which appears to be 
> Johannes' original change, but I'd support a patch which always set it to 
> 0 instead if it was deemed safer.

On the other hand..  As I mentioned earlier, if someone's code is
failing because of the permissions change, they can chmod
/proc/sys/vm/drop_caches at boot time and be happy.  They have no such
workaround if their software misbehaves due to a read always returning
"0".

