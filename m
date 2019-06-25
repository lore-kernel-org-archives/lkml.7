Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C63DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE642085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 06:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTuszrkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfFYGpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 02:45:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41725 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFYGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:45:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id y72so8430478pgd.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 23:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CAifnpJEO2ZMcI2CGYepWiuJi+SsX7+yIHhOSV88sqY=;
        b=sTuszrkcp+SlrQ+SCcJ+X7Xy8O/avyX6FScMpy8MoB341G0m8jH3c4Po+dDoRo9KwT
         yhW2ybt9aVuJW/tJyS+wvOaIzLV6BgPisDUGF1adW9y85hL1JWleJx2OMMCjw9URNT4t
         /X5gIHdfIAn/9kEEUZzFKYZXcc4C0YjqgKUpg07PP6uXLXrVVyYrfIvxPZ/ZeaniUqDc
         0vOKm4GqPr0sHcs2vf65dtRqtH7SvQTRTgpDqREP5YO0od01pTt/sbrL6sj4Jfcngb0a
         r7nkl/HiKorDjL7CIZ8Z583Lot39dplPAHoQf1ZfFitWKLVE8oj/0VrXp1OUplL16Lwv
         Qc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CAifnpJEO2ZMcI2CGYepWiuJi+SsX7+yIHhOSV88sqY=;
        b=NONrSW92iBR4eU4dnCC0vIjqoamD6Ul/WQBgfVhqCTcMjHHpW88wzi/7gm2J4nkaVZ
         WumDAofe920pKjZoCnh5ew4Jg09/xZvl6w9Zj25YkdkYmxVQuJq6ay8RoQXrc6AnKRXP
         l/D9vXXbfTQIa9wk+VceN42KCRuEcUNPlxlP3G2QAiQ/Y7eGRVwGz5OYvUE/bzj/Eq8H
         qGu91b7PVWcXpNBvNe0Iwasc64RKfCIQskWofW8yF/czFWLcBusA+/17zATlrR5j0qWp
         4Qc5O9OaBTw57cEOf9Eq35IQfuqomDw0BjSW0GcXDHws3LOkhKkeydmtuRtxrSs3WmV1
         3gqA==
X-Gm-Message-State: APjAAAWSF2yT0weu8dfSM2TXBLp1skV9Yex0VF5K/C37vLXtczIeArbh
        vMeiPmcp1Ln783WLVQr+NG0=
X-Google-Smtp-Source: APXvYqwh1E4uziir/9Y2AHlTpJYc8vgrFWWKVZUDasoTciXkNv1oNoktXcqISbo4pxdreleHfpgtPw==
X-Received: by 2002:a63:490a:: with SMTP id w10mr36637630pga.6.1561445148568;
        Mon, 24 Jun 2019 23:45:48 -0700 (PDT)
Received: from localhost ([175.223.22.38])
        by smtp.gmail.com with ESMTPSA id y12sm12446187pgi.10.2019.06.24.23.45.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 23:45:47 -0700 (PDT)
Date:   Tue, 25 Jun 2019 15:45:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v2 1/2] printk-rb: add a new printk ringbuffer
 implementation
Message-ID: <20190625064543.GA19050@jagdpanzerIV>
References: <20190607162349.18199-1-john.ogness@linutronix.de>
 <20190607162349.18199-2-john.ogness@linutronix.de>
 <20190618045117.GA7419@jagdpanzerIV>
 <87imt2bl0k.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imt2bl0k.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/19 00:12), John Ogness wrote:
> On 2019-06-18, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
> >> +	struct prb_reserved_entry e;
> >> +	char *s;
> >> +
> >> +	s = prb_reserve(&e, &rb, 32);
> >> +	if (s) {
> >> +		sprintf(s, "Hello, world!");
> >> +		prb_commit(&e);
> >> +	}
> >
> > A nit: snprintf().
> >
> > sprintf() is tricky, it may write "slightly more than was
> > anticipated" bytes - all those string_nocheck(" disabled"),
> > error_string("pK-error"), etc.
> 
> Agreed. Documentation should show good examples.

In vprintk_emit(), are we going to always reserve 1024-byte
records, since we don't know the size in advance, e.g.

	printk("%pS %s\n", regs->ip, current->name)
		prb_reserve(&e, &rb, ????);

or are we going to run vscnprintf() on a NULL buffer first,
then reserve the exactly required number of bytes and afterwards
vscnprintf(s) -> prb_commit(&e)?

	-ss
