Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72816C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8BF20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 01:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJazjn4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfLCBRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 20:17:25 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39561 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLCBRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 20:17:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so753188pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 17:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gpkHGfMnAbBIyHMTVJxkg4C53iHTuLlw5bP50AIqABQ=;
        b=OJazjn4dJQ2XU6QMdTYDi6Ehk3RROAXULx0PZwJwrEaOSDdgV8+QBKBRvGgeMeagGq
         TIkbnayPo6OF/dIVaHgqcMMPUaHrI4/x3eEStiS1gPp0Q5PCkolFxlAuryJVK+dtJxLh
         VVyf1pHutzWfgdDczDBABWJXcr6nw8xVebRMxvc6wzLFRrhUweoLVxjbMzvo+XH200b0
         MwKRgYXfb3zZiLaE1s8OEOm3BBvQow/HcDe/aduPyTagEA2kuiITxdU+TFxeuwZK09aa
         1uHjdwxlDp5VHHkOpWJ+hC7acOg2rNiwxqXQLJEgoB4PAk2zFelZkWOCKTb4LNAInDj4
         X4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gpkHGfMnAbBIyHMTVJxkg4C53iHTuLlw5bP50AIqABQ=;
        b=UTf6tKK+DFp8nqLT9780bg2I9g/shV2Kj6POUb65CRXzvkls+tE4jQQQFJc8nTBCnK
         meUd3LWg2xlZUS6uRfbpAy5uPmItBkrpPqJsufVliXY/pTW46N9xsAX+zAoWJRBaKuwO
         wJm76M2CNZNNyCMmFb8W7BtpJhy/ZsjYnTxj4WlBgDb8IFYueyQJKGdq39i5J1BHr5RA
         hqNlUIDa5h5CA6mK287zAEPLjM90+UgwwSjmIZsGZRVhAhG700nhUb8IYZ/wRzcGkDLI
         K9NMC9dpM6GwVYJ9INcHipql1TFJAW/n9E+6bPkWGx5p2fIg+4890XGHAPsV3D1qwagc
         BzJQ==
X-Gm-Message-State: APjAAAX2VzsnxceSivmfdq6I20fgkePXno78HUhmT2ZoWDbi4/opewxb
        ExQ3iGHSJVE5MmYgZHyREt4=
X-Google-Smtp-Source: APXvYqw+oWcJw/VMWxq5kNurpKlY83AoJh5RMHYhCrN1w0WetKruGwPmnt8fYYpvNRw67u0Z84DT6g==
X-Received: by 2002:a65:578e:: with SMTP id b14mr2442103pgr.444.1575335844294;
        Mon, 02 Dec 2019 17:17:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id i3sm738898pfd.154.2019.12.02.17.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 17:17:23 -0800 (PST)
Date:   Tue, 3 Dec 2019 10:17:21 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v5 1/3] printk-rb: new printk ringbuffer
 implementation (writer)
Message-ID: <20191203011721.GH93017@google.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
 <20191128015235.12940-2-john.ogness@linutronix.de>
 <20191202154841.qikvuvqt4btudxzg@pathway.suse.cz>
 <20191202155955.meawljmduiciw5t2@pathway.suse.cz>
 <87sgm2fzuh.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgm2fzuh.fsf@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/12/02 17:37), John Ogness wrote:
> On 2019-12-02, Petr Mladek <pmladek@suse.com> wrote:
> >> > +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> >> > +static bool desc_reserve(struct printk_ringbuffer *rb, u32 *id_out)
> >> > +{
> >> > +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> >> > +	struct prb_desc *desc;
> >> > +	u32 id_prev_wrap;
> >> > +	u32 head_id;
> >> > +	u32 id;
> >> > +
> >> > +	head_id = atomic_read(&desc_ring->head_id);
> >> > +
> >> > +	do {
> >> > +		desc = to_desc(desc_ring, head_id);
> >> > +
> >> > +		id = DESC_ID(head_id + 1);
> >> > +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
> >> > +
> >> > +		if (id_prev_wrap == atomic_read(&desc_ring->tail_id)) {
> >> > +			if (!desc_push_tail(rb, id_prev_wrap))
> >> > +				return false;
> >> > +		}
> >> > +	} while (!atomic_try_cmpxchg(&desc_ring->head_id, &head_id, id));
> >> 
> >> Hmm, in theory, ABA problem might cause that we successfully
> >> move desc_ring->head_id when tail has not been pushed yet.
> >> 
> >> As a result we would never call desc_push_tail() until
> >> it overflows again.
> >> 
> >> I am not sure if we need to take care of it. The code is called with
> >> interrupts disabled. IMHO, only NMI could cause ABA problem
> >> in reality. But the game (debugging) is lost anyway when NMI ovewrites
> >> the buffer several times.
> >
> > BTW: If I am counting correctly. The ABA problem would happen when
> > exactly 2^30 (1G) messages is written in the mean time.
> 
> All the ringbuffer code assumes that the use of index numbers handles
> the ABA problem (i.e. there must not be 1 billion printk's within an
> NMI). If we want to support 1 billion+ printk's within an NMI, then
> perhaps the index number should be increased. For 64-bit systems it
> would be no problem to go to 62 bits. For 32-bit systems, I don't know
> how well the 64-bit atomic operations are supported.

ftrace dumps from NMI (DUMP_ALL type ftrace_dump_on_oops on a $BIG
machine)? 1G seems large enough, but who knows.

	-ss
