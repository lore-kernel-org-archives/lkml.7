Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F201C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13150206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 11:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WP5N1PnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfFRLMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 07:12:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39992 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfFRLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 07:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=s94Smz4ILSPLKQb0dWr5lKSmygWRGKrTRCyNYAXgFgA=; b=WP5N1PnZMdsD8QTP4RDxLIBSO
        6ACG2cLMqmZ8i93ufBzWcjluZajAZlGVDZSkq4t+q7EvXygp1fM/3z5zhRlE+To5UyTS6X9hplNEL
        GwtNHUrRVQv2+493ukY/kd0uftJSk3KZ06GZFC/MoF/W0DGeY9pprxyKgewyGEI0CUvzin07NnocB
        Ml6Qi8diPEkjfDzbH7rislKEmYusWHokC7W2s5bH4z5joi1eSEF/u2GXRnyQY0jm+6FfgZZHOYlVw
        AlPSOLhAaLTXBYUkY3hYHEr/2H2pct/Y5dCjg/q8PXr5f4bhogfoEWMsnyfnIsGdWY750mrL6YkfJ
        U15PK0PHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hdC2D-0004gX-8P; Tue, 18 Jun 2019 11:12:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6584C20A3C471; Tue, 18 Jun 2019 13:12:15 +0200 (CEST)
Date:   Tue, 18 Jun 2019 13:12:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190618111215.GO3436@hirez.programming.kicks-ass.net>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607162349.18199-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 06:29:48PM +0206, John Ogness wrote:
> +/**
> + * struct prb_descr - A descriptor representing an entry in the ringbuffer.
> + * @seq: The sequence number of the entry.
> + * @id: The descriptor id.
> + *      The location of the descriptor within the descriptor array can be 
> + *      determined from this value.
> + * @data: The logical position of the data for this entry.
> + *        The location of the beginning of the data within the data array
> + *        can be determined from this value.
> + * @data_next: The logical position of the data next to this entry.
> + *             This is used to determine the length of the data as well as
> + *             identify where the next data begins.
> + * @next: The id of the next (newer) descriptor in the linked list.
> + *        A value of EOL means it is the last descriptor in the list.
> + *

For the entire patch; can you please vertically align those
descriptions? This is unreadable. Also, add some whitespace, to aid with
reading, something like do:

 * struct prb_descr - A descriptor representing an entry in the ringbuffer.
 *
 * @seq:       The sequence number of the entry.
 *
 * @id:        The descriptor id.
 *             The location of the descriptor within the descriptor
 *             array can be determined from this value.
 *
 * @data:      The logical position of the data for this entry.  The
 *             location of the beginning of the data within the data
 *             array can be determined from this value.
 *
 * @data_next: The logical position of the data next to this entry.
 *             This is used to determine the length of the data as well as
 *             identify where the next data begins.
 *
 * @next:      The id of the next (newer) descriptor in the linked list.
 *             A value of EOL means it is the last descriptor in the
 *             list.


