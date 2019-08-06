Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5ACC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3EE420B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sh0dIWQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfHFKOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:14:23 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58476 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFKOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uHZbFTsY0c3kgdrq0q0UJJfi04d30RhjWxh9oOUKzVE=; b=Sh0dIWQzNVVq8/2vE6O2m7z8Q
        mXehP9I2tAOZd0yOYYy8QHnEBEJ8aGpbUIneAZmoAMHxofw+XGeEr8IW3NdYUcwGtymareWcf6maI
        oLwfkCe2Zoy91ToYT7sHmJ3XoS1yFO7oW8oKlnxVzmNV8OFT9XDyOkNsLwgO0ZNuGFFft/bf8DGT6
        SshBy5qWWkWbUp/nKdRn8Yfq++YBiAevYwpkPWkvBnB9Gx1WlyIiYoEX+mqECwVCk4HSLY7k/yI4Y
        og9oOU7V3OQGLVIfjC8Xpf24oEGRK2c5dmiW1adNd/9wjuyv9obvkEay8fl/VIUmRXnJ697dzQ2Kt
        KU6/e051g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huwTC-0001aQ-SJ; Tue, 06 Aug 2019 10:14:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2988D3067E2;
        Tue,  6 Aug 2019 12:13:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A0D5201BC8AC; Tue,  6 Aug 2019 12:13:27 +0200 (CEST)
Date:   Tue, 6 Aug 2019 12:13:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Zebediah Figura <z.figura12@gmail.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: [PATCH RFC 2/2] futex: Implement mechanism to wait on any of
 several futexes
Message-ID: <20190806101327.GO2332@hirez.programming.kicks-ass.net>
References: <20190730220602.28781-1-krisman@collabora.com>
 <20190730220602.28781-2-krisman@collabora.com>
 <20190731120600.GT31381@hirez.programming.kicks-ass.net>
 <85imra6c81.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85imra6c81.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 02:26:38AM -0400, Gabriel Krisman Bertazi wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> >
> >> +static int futex_wait_multiple(u32 __user *uaddr, unsigned int flags,
> >> +			       u32 count, ktime_t *abs_time)
> >> +{
> >> +	struct futex_wait_block *wb;
> >> +	struct restart_block *restart;
> >> +	int ret;
> >> +
> >> +	if (!count)
> >> +		return -EINVAL;
> >> +
> >> +	wb = kcalloc(count, sizeof(struct futex_wait_block), GFP_KERNEL);
> >> +	if (!wb)
> >> +		return -ENOMEM;
> >> +
> >> +	if (copy_from_user(wb, uaddr,
> >> +			   count * sizeof(struct futex_wait_block))) {
> >> +		ret = -EFAULT;
> >> +		goto out;
> >> +	}
> >
> > I'm thinking we can do away with this giant copy and do it one at a time
> > from the other function, just extend the storage allocated there to
> > store whatever values are still required later.

> I'm not sure I get the suggestion here.  If I understand the code
> correctly, once we do it one at a time, we need to queue_me() each futex
> and then drop the hb lock, before going to the next one. 

So the idea is to reduce to a single allocation; like Thomas also said.
And afaict, we've not yet taken any locks the first time we iterate --
that only does get_futex_key(), the whole __futex_wait_setup() and
queue_me(), comes later, in the second iteration.



