Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30131C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0DE320679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfDZQwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:52:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:50112 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfDZQwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:52:11 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 50E6D7DF;
        Fri, 26 Apr 2019 16:52:10 +0000 (UTC)
Date:   Fri, 26 Apr 2019 10:52:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/2] Docs: An initial automarkup extension for sphinx
Message-ID: <20190426105209.1e414eae@lwn.net>
In-Reply-To: <87tvelrv8d.fsf@intel.com>
References: <20190425200125.12302-1-corbet@lwn.net>
        <20190425200125.12302-2-corbet@lwn.net>
        <87tvelrv8d.fsf@intel.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Apr 2019 12:06:42 +0300
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> It's more involved, but I think the better place to do this (as well as
> the kernel-doc transformations) would be in the doctree-read event,
> after the rst parsing is done. You can traverse the doctree and find the
> places which weren't special for Sphinx, and replace the plain text
> nodes in-place. I've toyed with this in the past, but alas I didn't have
> (and still don't) have the time to finish the job.

I had thought about this; indeed, there's a comment in the posted patch to
that effect.  The tradeoff comes down to this, I think:

 - The fragility and inelegance of embedding a bit of redundant RST
   parsing into this extension v. that of adding a late parsing stage as a
   transform, trying to enumerate every node type that you might want to
   change, and digging into the C domain code to emulate its reference
   generation.

 - The time required to implement a solution; I'm having a bit of a hard
   time keeping up with docs at the moment as it is.

 - Regexes.  This solution has more of them, but we're not going to get
   away from them regardless.

I am not at all opposed to a more proper solution that might, in the
long term, produce more deterministic results.  I can even try to work in
that direction.  But this is something that can be done now that, IMO,
doesn't in any way close off a better implementation in the future.  If we
agree that we should automatically generate references for occurrences of
"function()", we can change how that is actually done later.

I'll look into this further, but my inclination is to go forward with what
I have now.  It's simple and easy to understand, and doesn't seem to screw
up anywhere in the current body of kernel docs as far as I can tell.

> If you decide to go with regex anyway, I'd at least consider pulling the
> transformations/highlights from kernel-doc the script to the Sphinx
> extension, and use the exact same transformations for stuff in source
> code comments and rst files.

Pulling all RST manipulation out of kerneldoc has a great deal of appeal;
assuming this goes forward that should indeed be high on the todo list.

Thanks,

jon
