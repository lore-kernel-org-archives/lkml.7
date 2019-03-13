Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCC22171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 02:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvzgQjCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfCMCAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 22:00:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37284 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfCMCAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 22:00:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id s22so238183pfh.4;
        Tue, 12 Mar 2019 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IlXv3iixsOJ/nKCBaS/zZcmA/BlLhM+WSNyl/yMmR8k=;
        b=LvzgQjCiLx8kleBpw01TloukXBMdXgt1RB87xKX7L/nYu1Tq0PTkKg3sdrghedrdBf
         ijb5JPfYoYsdawIhXDVKHXSLmn6IBuMZdwUgEeX1LLyszhKxkGRLiNnEMZ6VOd73gzYa
         rQ+jaw1WV76k1OYPNxAoAUIrHguvik22Xi9DHHuCRFs+Bzl9Cy40vslPDHjjPYDwvJsS
         2oqhCY1/N6BfKGC/IqeHFQwpUCnQK5B3Jp5eeh8HbMMlE59ygR15OtGO5r6dGCQmdH5x
         wDkQWrxeyQuDBGV+TdC//TynuFCDd897Oq8WjON/Dle5g2+zMuML1l8A7HLbOXwzG4sH
         mMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IlXv3iixsOJ/nKCBaS/zZcmA/BlLhM+WSNyl/yMmR8k=;
        b=eaBFcGauKlj69ZRI2PJb14cZQbiuwoRQN5KwNYmu1tc7KKhFYVVIhB3lNGcGiMAEKj
         gygoeGraig8vZ+cn2KoZa2xFsuQ53G5l0UoRmhIFJRUM6Ty6l+EH++8RmU+Za19yWCtt
         Vj2QfXJY67EyTphrQnaqKgPMKupCFukObGbaDML19fSjhVufdQR50CWs7Lpi0bbiRa5k
         QC0rED9XpWxJt1TogI4axqsb/a8LbsdM6vgNb/Tpxv/7CfTADjNDQ0foqpob6DWyguuN
         0rZC/jWDKHX33UbV3stvM6mS4AdB87E9S0zbHzFWiwkMY5lSaC3mFYhfIFzVmYJjY6uO
         Ndmw==
X-Gm-Message-State: APjAAAVWFZBFlien5TnFKCdKE6B68rvm+w7hIajOy54GRJ7SY1ARK1RL
        6ik11KFZXRt6PeZZPFPCa4y8EA1Q
X-Google-Smtp-Source: APXvYqyfoj1i9hgxEn1IpI58W+Ibq4Z/PKRjup6LC4WvjVMjnTyC7UtFXWAZeZw/isM3OGVgRj9UVA==
X-Received: by 2002:a17:902:8b83:: with SMTP id ay3mr4121500plb.1.1552442406482;
        Tue, 12 Mar 2019 19:00:06 -0700 (PDT)
Received: from localhost ([110.70.15.13])
        by smtp.gmail.com with ESMTPSA id c2sm13121601pfd.159.2019.03.12.19.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 19:00:05 -0700 (PDT)
Date:   Wed, 13 Mar 2019 11:00:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <20190313020002.GA783@jagdpanzerIV>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190213025520.GA5803@jagdpanzerIV>
 <874l9721hf.fsf@linutronix.de>
 <20190304052335.GA6648@jagdpanzerIV>
 <87lg1rggcz.fsf@linutronix.de>
 <20190311105411.GA368@jagdpanzerIV>
 <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312123857.juatd6fwtfmqajze@pathway.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/12/19 13:38), Petr Mladek wrote:
> > Hmm. OK. So one of the things with printk is that it's fully sequential.
> > We call console drivers one by one. Slow consoles can affect what appears
> > on the fast consoles; fast console have no impact on slow ones.
> > 
> > 	call_console_drivers()
> > 		for_each_console(c)
> > 			c->write(c, text, text_len);
> > 
> > So a list of (slow_serial serial netcon) console drivers is a camel train;
> > fast netcon is not fast anymore, and slow consoles sometimes are the reason
> > we have dropped messages. And if we drop messages we drop them for all
> > consoles, including fast netcon. Turning that sequential pipline into a
> > bunch of per-console kthreads/irq and letting fast consoles to be fast is
> > not a completely bad thing. Let's think more about this, I'd like to read
> > more opinions.
> 
> Per-console kthread sounds interesting but there is the problem with
> reliability. I mean that kthread need not get scheduled.

Correct, it has to get scheduled. From that point of view IRQ offloading
looks better - either to irq_work (like John suggested) or to serial
drivers' irq handler (poll uart xmit + logbuf).

kthread offloading is not super reliable. That's why I played tricks
with CPU affinity - scheduler sometimes schedule printk_kthread on the
same CPU which spins in console_unlock() loop printing the messages, so
printk_kthread offloading never happens. It was first discovered by Jan
Kara (back in the days of async-printk patch set). I think at some point
Jan's async-printk patch set had two printk kthreads.

We also had some concerns regarding offloading on UP systems.

> Some of these problems might get solved by the per-console loglevel
> patchset.

Yes, some.

> Sigh, any feature might be useful in some situation. But we always
> have to consider the cost and the gain. I wonder how common is
> to actively use two consoles at the same time and what would
> be the motivation.

Facebook fleet for example. The motivation is - to have a fancy fast
console that does things which simple serial consoles cannot do and
a slow serial console, which is sometimes more reliable, as last resort.
Fancy stuff usually means dependencies - net, mm, etc. So when fancy
console stop working, slow serial console still does.

	-ss
