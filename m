Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DACCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC472184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 10:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgqzt15e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfCMKG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 06:06:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35995 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfCMKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 06:06:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id r124so1177120pgr.3;
        Wed, 13 Mar 2019 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yg0BUzKVaEL/UleSuUnfvZe6QaEQT7nVAeKS6LgLVPg=;
        b=jgqzt15eX5QcwMnYzcImbjZbuY7lkDNHvi18ZKKb2BALqCFSJcvj2rkJ5WYzEV/Itu
         MFsxLIv58vpocsaHvnMD5WPe86uagLcHDWeS3GQDd8Jhi1ciuLaEQa1N+2nwpw+344UC
         v63knvVvjNYCcLUwhN1zDlhtdjNhjL8ki36M0aXn4/biL1yB4vWK/RKLPc8p6p1CQN0r
         tb+BqcecgjDBYZim3xzbqw6gytBAjQ5JSSw/8xibU7JLt1bohfjT6gcVTqBEXM8uCTko
         kNHIvO5Hb4qQFq7/RWy/2xnelkwy61e/PnUPabSHENTb6ea2bOZh9bpNbG6KRva5rf6K
         4Wsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yg0BUzKVaEL/UleSuUnfvZe6QaEQT7nVAeKS6LgLVPg=;
        b=XvP2ff2Q289VJcnbLdOj0V3lgI1zXrTP5bCh+5MGnc7GErehHe3rEPbhnHFFwvOhRC
         jvO63Bk37tlFBR96l5ISC2k4LV8NIf1KS/KG2i5f2BZLyBqE8VXqIwBgjzwu9k+NIsOj
         jW/wAqXpZRJcBFvHFF3AS8EEy85SGtnRbcmcuPzytSCyvzPSp6buBtmJuEhae6ZmCEAj
         Jcoqkfv4wr6sg6zip1xH27Rx7aNdkZy2RsLcZhtjJqHAwz2WNyp4QpAF8JHxdWtllCWl
         qDYn0IOuRm6LtBJwu0hnAHCn0IhSqRBbAWfYCuVYZLiNd2gdQy69DUhx5wrEyh7vqc9M
         V8PQ==
X-Gm-Message-State: APjAAAXXfD77NGb3Ic4m7yrjZjD7+X1pv4kij1lQPiZXyjFvfiKAaitT
        BpJkJjkMYOUwTukKM+RD/Pw=
X-Google-Smtp-Source: APXvYqyJTyl8SiakE+dqYHaP4/22f7U0UfMPPYAKPMz3nuu9jM11QKQLkKVQ/jXWqoONbC0S2r5HwQ==
X-Received: by 2002:a63:4650:: with SMTP id v16mr11581047pgk.329.1552471617383;
        Wed, 13 Mar 2019 03:06:57 -0700 (PDT)
Received: from localhost ([110.70.15.13])
        by smtp.gmail.com with ESMTPSA id j13sm15626576pfh.32.2019.03.13.03.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 03:06:56 -0700 (PDT)
Date:   Wed, 13 Mar 2019 19:06:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [RFC PATCH v1 00/25] printk: new implementation
Message-ID: <20190313100653.GA23478@jagdpanzerIV>
References: <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
 <874l8815uc.fsf@linutronix.de>
 <20190313021534.GB783@jagdpanzerIV>
 <87d0mv9off.fsf@linutronix.de>
 <20190313084028.f2m4qhxd5sjzzawr@linutronix.de>
 <20190313092759.GA10060@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313092759.GA10060@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/13/19 18:27), Sergey Senozhatsky wrote:
> > Does this mean we keep irq_work part or we bury it and solve it by other
> > means?
>
> That's a very good question. Because if we add console_trylock()
> to printk(), then we can't invoke ->atomic() consoles when console_sem
> is already locked, because one of the registered drivers is currently
> being modified by a 3rd party and printk(), thus, must stay away.
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	    one of the drivers or the list itself.

	-ss
