Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10FC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00DD22CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566678656;
	bh=z0qC+tvzqoRXrGe3re9RsbVsv0fNXWZru8GpauizMzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=K7+LAWW3PEXuXigTwozdKHGQejKiUdFmpcktgSE7NbcZfAqBwRvrCxKhxZuz+HLP+
	 8DtKX8EJb8M0DjtZ7aotSWET8w+BaJTgee98vwNMRzP1xT1vbp6T+9/SiBP6eusSTW
	 zgSbdrgcSGFBzoLGl1Z5TKVzsExYPSCXY6r0kffE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbfHXUaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 16:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbfHXUaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 16:30:55 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E9120870;
        Sat, 24 Aug 2019 20:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566678654;
        bh=z0qC+tvzqoRXrGe3re9RsbVsv0fNXWZru8GpauizMzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DbsD8UNuwVe9QY7Q3Jn61rlEm21WN35Kf5WUSeImK0lRdFpM1/kMr31+4xY2T5eGZ
         JDczCBU4j4kdtomYxw97r8Eet/37N9ktd+4IfAwKG5zSNNNSRQ+WJdy9fZVha34qj3
         3Yw0xyh4/N9Znf7TYjasf5/ih7b0glw9cXjjthbI=
Date:   Sat, 24 Aug 2019 13:30:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCHv2] lib/test_kasan: add roundtrip tests
Message-Id: <20190824133053.aa5c6393815a5cb55dbdb8a4@linux-foundation.org>
In-Reply-To: <20190823104107.GA55480@lakrids.cambridge.arm.com>
References: <20190819161449.30248-1-mark.rutland@arm.com>
        <20190822164857.460353a8195bfd5ddb3d5f50@linux-foundation.org>
        <20190823104107.GA55480@lakrids.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 11:41:08 +0100 Mark Rutland <mark.rutland@arm.com> wrote:

> >  
> >  /*
> > 
> > which is really kinda wrong.  We should strictly include linux/io.h for
> > things like virt_to_phys().
> > 
> > So I think I'll stick with v1 plus my fixlet:
> > 
> > --- a/lib/test_kasan.c~lib-test_kasan-add-roundtrip-tests-checkpatch-fixes
> > +++ a/lib/test_kasan.c
> > @@ -18,8 +18,8 @@
> >  #include <linux/slab.h>
> >  #include <linux/string.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/io.h>
> >  
> > -#include <asm/io.h>
> >  #include <asm/page.h>
> >  
> >  /*
> > 
> 
> Assuming that you mean *v3* with that fix, that looks good to me!

Yes, that's what we have.
