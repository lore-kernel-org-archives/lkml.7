Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E8CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5756208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Nt6xRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbfG3K0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:26:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40312 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfG3K0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:26:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so29601421pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B41dOFAL1OVXzo32k2PddSinndYgRrLzOceWuj2dYcs=;
        b=i7Nt6xRkRfvFCCVipqPhPmUZyVmjuAdk9XvMcLtySbCYdYJr0vMsYhkTiIE9qVDOHK
         SYduOpEPzNTNU5fL7XIet0nzi6Hb0+Y3MRI3ycdjx2r32drhNk7ebQNjBQGTP9L3tAY3
         xKPu4OsR0YLH3RZC2tU5A2nV/QJ67w+i5ahlw1mXgS6rsDAYqvvDJLJJNvBcXv3GIew9
         y79fPpsjqTXZT9WvjGuTCjzDuG1NsHjVuLpPyPCoLsV/cBeumt/X/6hYWs1CZ10UZnb3
         wzAqKqygyn9ZasPXv3I83Lsa1RI3RpJFi48CFo98NxQjSZfnpYYDmXF1k5mbARh5QCQk
         TFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B41dOFAL1OVXzo32k2PddSinndYgRrLzOceWuj2dYcs=;
        b=i0RtoG+PSXbN9Za76E2bDvJPpJJwKHNJ6HzpRr1RQlQzxpCTk1u0Sq3li4FFJ27BJd
         oTjOJI3VbzabmW01LFSgOAE6N1atjkVO+1c4gp5EhccKQdBEYKIw3SuBKVKQl5OzWyR4
         kbrngkHxQppM04YRWWpLmz5Xx7VRw1GTt2X30gUCj48uhlhipIeFNtFDWYf82xhZLcLi
         QsWUaKdKfi0vzi1mRzy8PtZG8VCX7g1XA98NBUxHKo+M5QvTcFxOdIZlpeqVWq7RLWyg
         fwUy7G6p0SwYG3ULNdswIf2uU2iAdTOLjcxDeGxaua/rYitOOhedWQb8OJCjo+MLCPjX
         OW5g==
X-Gm-Message-State: APjAAAUPHhN4GAzF5uv4gkfJhg//pMnMU7ccMyGIb5wBfTIXwC+Kv3yo
        F5RXhpuoHXH1qHqRNbCiHHBVrTeW
X-Google-Smtp-Source: APXvYqxOncBM7FFqx4lditTRj2caSLMJ9IX+bFXJ4D8j7fqT/1w8OoqWf5bcpF3t2GTiYtSsQvUPSQ==
X-Received: by 2002:a63:3281:: with SMTP id y123mr105781516pgy.72.1564482380523;
        Tue, 30 Jul 2019 03:26:20 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id k6sm74255606pfi.12.2019.07.30.03.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 03:26:20 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:56:13 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     sivanich@sgi.com, arnd@arndb.de, ira.weiny@intel.com,
        jhubbard@nvidia.com, jglisse@redhat.com,
        gregkh@linuxfoundation.org, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/1] sgi-gru: Remove *pte_lookup functions
Message-ID: <20190730102613.GB6825@bharath12345-Inspiron-5559>
References: <1564170120-11882-1-git-send-email-linux.bhar@gmail.com>
 <1564170120-11882-2-git-send-email-linux.bhar@gmail.com>
 <20190729064842.GA3853@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729064842.GA3853@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 08:48:42AM +0200, Christoph Hellwig wrote:
> On Sat, Jul 27, 2019 at 01:12:00AM +0530, Bharath Vedartham wrote:
> > +		ret = get_user_pages_fast(vaddr, 1, write, &page);
> 
> I think you want to pass "write ? FOLL_WRITE : 0" here, as
> get_user_pages_fast takes a gup_flags argument, not a boolean
> write flag.

You are right there! I ll send another version correcting this.

Thank you
Bharath
