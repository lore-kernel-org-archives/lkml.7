Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E948CC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B7E206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 04:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564633260;
	bh=rmEeLKMV/HkMS3N47x2yY+MuFTr2JAbTc4wtVR45zsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vwQwl2AfTt8dbr7Wjrj0AWN3eFe9RgtpUKCX4zD8cpqMnHIuHqEWdhZfJ6Go/0t86
	 yi4rakyHQIj93HWSoH3L8W301wLM/bngO3PCvjsggxnjFi8ACNcLSwsqQhxdS4KDU8
	 CLksRT93Z9csjwKS5Vpp6X7gsw3o+UDo4Vgomzpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHAEU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 00:20:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfHAEU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 00:20:58 -0400
Received: from X1 (unknown [76.191.170.112])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B9324379;
        Thu,  1 Aug 2019 04:20:56 +0000 (UTC)
Date:   Wed, 31 Jul 2019 21:20:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] fork: Improve error message for corrupted page tables
Message-Id: <20190731212052.5c262ad084cbd6cf475df005@linux-foundation.org>
In-Reply-To: <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
References: <20190730221820.7738-1-sai.praneeth.prakhya@intel.com>
        <20190731152753.b17d9c4418f4bf6815a27ad8@linux-foundation.org>
        <a05920e5994fb74af480255471a6c3f090f29b27.camel@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 15:36:49 -0700 Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> > > +static const char * const resident_page_types[NR_MM_COUNTERS] = {
> > > +	"MM_FILEPAGES",
> > > +	"MM_ANONPAGES",
> > > +	"MM_SWAPENTS",
> > > +	"MM_SHMEMPAGES",
> > > +};
> > 
> > But please let's not put this in a header file.  We're asking the
> > compiler to put a copy of all of this into every compilation unit which
> > includes the header.  Presumably the compiler is smart enough not to
> > do that, but it's not good practice.
> 
> Thanks for the explanation. Makes sense to me.
> 
> Just wanted to check before sending V2,
> Is it OK if I add this to kernel/fork.c? or do you have something else in
> mind?

I was thinking somewhere like mm/util.c so the array could be used by
other code.  But it seems there is no such code.  Perhaps it's best to
just leave fork.c as it is now.


