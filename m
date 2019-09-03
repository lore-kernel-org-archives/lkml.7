Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B5DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC2222DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iA7t8Ss2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfICH6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:58:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44732 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfICH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:58:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so5233196pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zfuRrUZi1m5bneOLAPdcpwGbeJ+nRXuErqjv4S4SGNc=;
        b=iA7t8Ss201BF7nB3Sti/TkUxlKiWS2YBQTGzkbk/lCBEgWm4FCd9ocZteTqBFru779
         zAb8Ui3QZ5yv/4RTaNrgEKbRgoJRIJQFQTsbKLgf+T7nWOs54lGqf6IbOEA0zn18dzv1
         CwqioP4akrJe3yrG7Dg3SEAKmrwndlSnINHFnap0kvn4pip/SqvuZGtUlv99z07zBwYT
         Cc608/20NA7ExFK7IINlbAc7jmFNEEhtzVukoe2eJJNz4Sz1qMXCdmIArwZh5vzoe9no
         Dgtio93x2mpFrkjYtoG7wYaBnausTn+wfgaiDzukg9E5vWhUSFqRSOBPu+Xnib6VAn7Q
         iNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zfuRrUZi1m5bneOLAPdcpwGbeJ+nRXuErqjv4S4SGNc=;
        b=bItaM83642g970Jks5pF3pE05Lo9mDxrC2NNwjcpS1XnyMdcFZEIlVhgwNDGoVJIjX
         VW/HUpKhUE12sCsHIOVVSZAHq7Hl+5gM2qJcUND4ZBZEqXat8JuPW0K9pKVHTaUmfr5N
         vU6OHViYThD6+ZVnwzUgm9wLEatYUTMw0+oFYeGfo6GDDaX3P20vR02aJt2qj11bHHXz
         Q7FzTrdKPdwCm0BYXgjxg1wdjhCuLp2Tyam/t2qdnhs8gMVB+VKYLyPDHCblERuPjKX9
         RZmRLD630EUDBeZKV/RNegIZGVfATNwlD7li/j4kYzIyxO+7z6ZuGZ1tn7d7wSv93zR6
         2GjQ==
X-Gm-Message-State: APjAAAUzc+w+Vt3CZ96/ZQrii2GDcn/Y1Xzx8Oew5a/opyQy+kDH2s2/
        +X0viWmsk0eZxKb/k7vv7/w=
X-Google-Smtp-Source: APXvYqzQy7t+cJuawHsvufeNhsg1u0/d8uvkCAsibSCOQk6TvMa00KW8LVlhRcjwHH6d0Ipjy0IHSw==
X-Received: by 2002:a63:9245:: with SMTP id s5mr29603267pgn.123.1567497521586;
        Tue, 03 Sep 2019 00:58:41 -0700 (PDT)
Received: from localhost ([175.223.38.155])
        by smtp.gmail.com with ESMTPSA id c127sm3583405pfb.5.2019.09.03.00.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 00:58:40 -0700 (PDT)
Date:   Tue, 3 Sep 2019 16:58:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: numlist API Re: [RFC PATCH v4 1/9] printk-rb: add a new printk
 ringbuffer implementation
Message-ID: <20190903075837.GA30322@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190807222634.1723-2-john.ogness@linutronix.de>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <20190823171802.eo2chwyktibeub7a@pathway.suse.cz>
 <87sgpnmqdo.fsf@linutronix.de>
 <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827130349.6mrnhdlqyqokgsfk@pathway.suse.cz>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/27/19 15:03), Petr Mladek wrote:
[..]
> > IMHO the API is sane. The only bizarre rule is that the numlist must
> > always have at least 1 node. But since the readers are non-consuming,
> > there is no real tragedy here.
> >
> > My goal is not to create some fabulous abstract data structure that
> > everyone should use. But I did try to minimize numlist (and dataring) to
> > only be concerned with clearly defined and minimal responsibilities
> > without imposing unnecessary restrictions on the user.
>
> The API is complicated because of the callbacks. It depends on a logic
> that is implemented externally. It makes it abstract to some extent.
>
> My view is that the API would be much cleaner and easier to review
> when the ID handling is "hardcoded" (helper functions). It could be
> made abstract anytime later when there is another user.

Makes sense.

> There should always be a reason why to make a code more complicated
> than necessary. It seems that the only reason is some theoretical
> future user and its theoretical requirements.

Agreed.

> Symmetry is really important. It is often sign of a good design.
>
> Simple and straightforward code is another important thing at
> this stage. The code is complicated and we need to make sure
> that it works. Any optimizations and generalization might
> be done later when needed.

Agreed.

	-ss
