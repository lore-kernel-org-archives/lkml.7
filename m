Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8416FC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5658122CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRgRC8FY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfHTJ1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:27:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfHTJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:27:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so2880421pgp.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=08b1I2pYO3gQfaC4lbdcUSEe7xNXjHJ8nbX5cRtSIag=;
        b=WRgRC8FYg/m9Xy+M3doYmcHAc6uneLwmGC179Myah35JMRHfkwZKvPmOhGaBG42Dyw
         rr6yKU595BWwHoUa9/5kJnxIsFctFnnJeqXN5+pphDWD5fB0XiaMZkQ/bYu/XurZM8Mw
         1xV2Ctz+C6CDhwKAnXTZ/Js3adBkt+tpLShgPVqUfRmjuk7a3oeVPYN19qEW0x6ZpUS9
         HZR41G/9ztMlgSVhPcxMlItERG+W8B6dax5Os4qqxD7EswYX45qPVBBplXpMvxjoNUli
         cxKrhZ6cE14xY5J3eJrXi9jFFw1IH/EywXjDmnSpYgwnDJ1+dPvKUG+Gav+IQELPWunl
         U17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=08b1I2pYO3gQfaC4lbdcUSEe7xNXjHJ8nbX5cRtSIag=;
        b=jeOmqMJbTobmIxrlR4bcnRg6zcoU8KU6VP0PzF+QvnhFTWJFhBBE8ukeNBvqAMBLiK
         TIBCUMMIMdLUPxvCii92QSp9k7BHj3Fmzc//TDibpzkG/qrVslIuBhrNUqq5BL/WCUNI
         3UKc/YJ8G/OruOKW2lPw7ym2U82KaUTHkzX/sWBVhciFbFSWMFSVSKL28ycSF0JTtWJO
         RRnZ4ZyWGoPZ2JufaFM17hFEVJCN+0nEdJiINnRGBjT69I8gn/0glIlygYfoaXMlzKtt
         ybcNv6BR8jcboGR7BzkEsbHXcdafbG0MAsU/4EHubGznt12cStg7UgNAhSeKud7wDXCB
         97JQ==
X-Gm-Message-State: APjAAAVdkbBEwAsRpmQ1Hpj13kga3kCl4O+4BKJ2qFp++5WTmjmrglC8
        bgvRn0wBHGVcvn+NfUk5Img=
X-Google-Smtp-Source: APXvYqw1LipjLLhWzuPUUw5dZfEKZJJGel8AMGRyvu3/sq8TqeEBcnnsYtU036sNbBugQtFjJKkr8g==
X-Received: by 2002:a17:90a:3be5:: with SMTP id e92mr25783659pjc.86.1566293256366;
        Tue, 20 Aug 2019 02:27:36 -0700 (PDT)
Received: from localhost ([175.223.16.125])
        by smtp.gmail.com with ESMTPSA id k36sm17163366pgl.42.2019.08.20.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:27:35 -0700 (PDT)
Date:   Tue, 20 Aug 2019 18:27:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: comments style: Re: [RFC PATCH v4 1/9] printk-rb: add a new
 printk ringbuffer implementation
Message-ID: <20190820092731.GA14137@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820085554.deuejmxn4kbqnq7n@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/20/19 10:55), Petr Mladek wrote:
[..]
> > +	 *
> > +	 * Memory barrier involvement:
> > +	 *
> > +	 * If dB reads from gA, then dC reads from fG.
> > +	 * If dB reads from gA, then dD reads from fH.
> > +	 * If dB reads from gA, then dE reads from fE.
> > +	 *
> > +	 * Note that if dB reads from gA, then dC cannot read from fC.
> > +	 * Note that if dB reads from gA, then dD cannot read from fD.
> > +	 *
> > +	 * Relies on:
> > +	 *
> > +	 * RELEASE from fG to gA
> > +	 *    matching
> > +	 * ADDRESS DEP. from dB to dC
> > +	 *
> > +	 * RELEASE from fH to gA
> > +	 *    matching
> > +	 * ADDRESS DEP. from dB to dD
> > +	 *
> > +	 * RELEASE from fE to gA
> > +	 *    matching
> > +	 * ACQUIRE from dB to dE
> > +	 */
> 
> But I am not sure how much this is useful. It would take ages to decrypt
> all these shortcuts (signs) and translate them into something
> human readable. Also it might get outdated easily.
> 
> That said, I haven't found yet if there was a system in all
> the shortcuts. I mean if they can be descrypted easily
> out of head. Also I am not familiar with the notation
> of the dependencies.

Does not appear to be systematic to me, but maybe I'm missing something
obvious. For chains like

		jA->cD->hA to jB

I haven't found anything better than just git grep jA kernel/printk/
so far.

But once you'll grep for label cD, for instance, you'd see
that it's not defined. It's mentioned but not defined

	kernel/printk/ringbuffer.c:      * jA->cD->hA.
	kernel/printk/ringbuffer.c:      * RELEASE from jA->cD->hA to jB

I was thinking about renaming labels. E.g.

	dataring_desc_init()
	{
		/* di1 */
		WRITE_ONCE(desc->begin_lpos, 1);
		/* di2 */
		WRITE_ONCE(desc->next_lpos, 1);
	}

Where di stands for descriptor init.

	dataring_push()
	{
		/* dp1 */
		ret = get_new_lpos(dr, size, &begin_lpos, &next_lpos);
		...
		/* dp2 */
		smp_mb();
		...
	}

Where dp stands for descriptor push. For dataring we can add a 'dr'
prefix, to avoid confusion with desc barriers, which have 'd' prefix.
And so on. Dunno.

	-ss
