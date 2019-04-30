Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D0C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284D92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 05:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQeS2G8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfD3F3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 01:29:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36742 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3F3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 01:29:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so7454536wra.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 22:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gByLVW4J/Gu3P/aWPaRVqL5VGCmvIntSLMMQS5bvR/w=;
        b=kQeS2G8TyW2r1LQJAVwbM6r1oO0BT3kSyYw8aA2eTK9poPfUdZFbFMzz668WyBNt+M
         CSfnuNTrhVLdqFtkNDdbNjsa+oHd32lgKj4BptLYlqKaivRSmidaRr59N5PwxRfyKCf7
         YJgZPSCjLWoJyhEDAVQeWZEGj4M3b35Ss1HgL/WZn7L/TFfOq19LzTUUENkPgI9RrDIm
         m7T8lK3LS0K5vwmtO8iZj+U28Te89zefsXd78eEW5v/Qcn7ZBuDzwcHGLqRi5tRglGyD
         JDX3HBO3ElGVeE3m0JWSmiI6DR+4YxGfbnJxQv4KybHKktec06iQz4gdk8oOWleNNyaq
         eIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gByLVW4J/Gu3P/aWPaRVqL5VGCmvIntSLMMQS5bvR/w=;
        b=cTdcmRMfOb5frm1YR5rfZxIKfeKOXFqwzp+t/MmQg1Jv1oTY0dilhNB0hDVEgD9Sdc
         lhlA7Ysl1ecAoFu9zyghZjIeOfygVtyuiiI1Xvu97EnIyTWDD/aADRgfkv0E5249vC3t
         bDSIsq98OeUwpEbjWaRWzi5tm4C4j3Pi6zFwYQpXhhKbuFNWAc8urHuRp91+LIZ8t4Tv
         1lJ2hOZES/Z4IWOqYIax/JpuO9C/2d/livPAJgPOQRToqykIworAE7IU5hU0M8Ihe1Jf
         svZ7ELl1g9ouvBe7nPulSIfbwlDXec3+KEfRszcISyIviDpETdJhh5mpYroX6Q4fOakY
         UTyA==
X-Gm-Message-State: APjAAAU1w1J4+j57x8NOh4ZnCMybXwZTld1OcW4Ue0n5C8YAwdyZUkGB
        P1m5RIHvXDLAxiXIdxYMtxE=
X-Google-Smtp-Source: APXvYqxCzOAfccd51g7qJ+E+tcZuFi8r8qK6qWwGhtWdR5CP7DtWiUNH49Ovcr4coAFqd27ZkNwJwg==
X-Received: by 2002:a5d:6101:: with SMTP id v1mr42875577wrt.222.1556602190899;
        Mon, 29 Apr 2019 22:29:50 -0700 (PDT)
Received: from localhost ([91.93.129.62])
        by smtp.gmail.com with ESMTPSA id v17sm1138477wmc.30.2019.04.29.22.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 22:29:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Tue, 30 Apr 2019 15:27:51 +0900
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v4] panic: add an option to replay all the printk message
 in buffer
Message-ID: <20190430062751.GA399@tigerII.localdomain>
References: <1556199137-14163-1-git-send-email-feng.tang@intel.com>
 <20190426074934.seje2tn5p6fsuwaq@pathway.suse.cz>
 <20190426135316.GA505@tigerII.localdomain>
 <20190426141426.h7hpvhr3rqp7umbk@pathway.suse.cz>
 <20190426164302.GA26127@tigerII.localdomain>
 <20190426171640.GA7413@tigerII.localdomain>
 <20190429114423.yr7hbmfrfbravgsv@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429114423.yr7hbmfrfbravgsv@pathway.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/29/19 13:44), Petr Mladek wrote:
> On Sat 2019-04-27 02:16:40, Sergey Senozhatsky wrote:
> > On (04/27/19 01:43), Sergey Senozhatsky wrote:
> > [..]
> > > > The console waiter logic is effective but it does not always
> > > > work. The current console owner must be calling the console
> > > > drivers.
> > > >
> > > > >   Hmm, we might have a bit of a problem here, maybe.
> > > >
> > > > Hmm, the printk() might wait forever when NMI stopped
> > > > the current console owner in the console driver code
> > > > or with the logbuf_lock taken.
> > > 
> > > I guess this is why we re-init logbuf lock from panic,
> > > however, we don't do anything with the console_owner.
> 
> > > > The console waiter logic might get solved by clearing
> > > > the console_owner in console_flush_on_panic(). It can't
> > > > be much worse, we already ignore console_lock() there, ...
> > 
> > Hmm, or maybe we are fine... console_waiter logic should work
> > before we send out stop IPI/NMI from panic CPU. When we call
> > flush_on_panic() console_unlock() clears console_owner, so
> > panic_print_sys_info() should not deadlock on console_owner.
> 
> Good point!
> 
> > It's probably only problematic if we kill a console_owner
> > CPU and then try to printk() (from smp_send_stop()) before
> > we do flush_on_panic()->console_unlock().
> 
> Yup. There are called several functions between smp_send_stop()
> and console_flush_on_panic().
> 
> The question is if it is worth a code complication. We could
> never 100% guarantee that printk() would work in panic().
> I more and more understand what Peter Zijlstra means
> by the duct taping.

Agreed.

	-ss
