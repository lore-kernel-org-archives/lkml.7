Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E311BC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86CC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573456814;
	bh=RHopYpI5I/OMsLLyX7IFXyJRkHB43Q6WGVEyWlb+uok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k0zdQDsV397iq8Xy5u3zUv4k2PyUqMzSBtlnxAfPcKJDN0OP/u5i/eZvqTynL7CI0
	 93ayWVjjkMLG7rul0TeSTRwpANFiWGvqGZihGvu2D8DYcp8h7xSXGsNW0ssHY/MBoh
	 qEz3fFB3GlVjdXdgMaCbDkJsm4kUDWBENoWj1hwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKKHUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:20:10 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40097 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfKKHUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:20:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id f3so12056001wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rolDzRNdmch+TJjOcq+3SrTl4ASUgxQj4KW8In9RS18=;
        b=Olq79RDuRWkPl2xCzG3S1c3OoCBjaeMVgeZEdzN8RnE3oY4ZGi8+6lJ2dcgdGzT0AT
         VueNBI4qcksxr3neqW/7s1MrYT/r6crRBJb4lgWx9F0nffQNnKpfDkoS025pTsTa/3aD
         Pqhyf9zS0VUw9WZnnbS2bKCBUiya0nhIPd4oUpymJlfMARHn6AouTOIQJJ4k2xy9irbl
         SgRSKtJNNcO+3Dr5yGJFzz0bTECki7qIl4IHowSUvm9EBB3rYKsJLqoG4AIoXZe/dbte
         r4NdPd2w7tJhxEvESXA3wM9rHY58RTT5FtB6fmUbJQ4cmrW/z2wfIxavRT0yx5MzdWyj
         m/Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rolDzRNdmch+TJjOcq+3SrTl4ASUgxQj4KW8In9RS18=;
        b=Cl9CZAmBw/U2ZUoDwc50Qdts9eAyMTzwbozqpZPe77YWMYxbZ7IwBbFZhc0kYxzPvW
         TyPnRYtgx8GMioUAPTbC8eEaJ5VlapE+rUYkhv9dvInyD8pfNQ6fPXwRax603xsxXSva
         jhZCiuUHrnTbxWGEcDOgZMtAwE5hBn3vy98Ie5nma58WU1vyRN9IlIpZWxh4oloI9Exi
         HvUnYue4MTWlMRLnNcunHVEDZ6NUud1ITQ+MUr6ThqiqNfbpiTgT+zwGya6viVqKYp+P
         ZkR8ZMYdl4wshgPBM8BVRvbYlfmHW2PcVjO9Tzlf0MOjHKGb+k9k00FvFaLzJu6CjmIb
         0Ucw==
X-Gm-Message-State: APjAAAU3xKkUXUIK/DB/p4JrarHSn9kk5LABQGZjAy56RZyQXFIFWDJe
        m1wHjnJAAHFNofdWfx6SKZk=
X-Google-Smtp-Source: APXvYqzMptahC1XkkfgLb9z4WvaM8xGJKwBm88GFd7IIJaIZf8+qJQMwcsRrVdyOCtH7h3/L/wocNw==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr8334636wme.89.1573456808198;
        Sun, 10 Nov 2019 23:20:08 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id u16sm14843906wrr.65.2019.11.10.23.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2019 23:20:07 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:20:05 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] irq_work: Fix irq_work_claim() ordering
Message-ID: <20191111072005.GA112047@gmail.com>
References: <20191108160858.31665-1-frederic@kernel.org>
 <20191108160858.31665-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108160858.31665-3-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Frederic Weisbecker <frederic@kernel.org> wrote:

> When irq_work_claim() finds IRQ_WORK_PENDING flag already set, we just
> return and don't raise a new IPI. We expect the destination to see
> and handle our latest updades thanks to the pairing atomic_xchg()
> in irq_work_run_list().
> 
> But cmpxchg() doesn't guarantee a full memory barrier upon failure. So
> it's possible that the destination misses our latest updates.
> 
> So use atomic_fetch_or() instead that is unconditionally fully ordered
> and also performs exactly what we want here and simplify the code.

Just curious, how was this bug found - in the wild, or via code review?

Thanks,

	Ingo
