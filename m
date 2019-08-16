Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0693DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC5521721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VqNOWEK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHPVAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:00:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45591 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfHPVAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:00:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so3498826pgp.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CI/CZT0Ds4R/0RCpWk7/OcD9FklwQWMJXxVrdeA2FT0=;
        b=VqNOWEK5hlqwXwD3sdtXpJRuk5sL/zD8rB0xILprfdWdQBwwEbRKwmOnButLRaYajQ
         CFL1kZMw55YspiVvt93Z1ntrHW89OTGEidFneJC2UiNhDUTHVO8kAGzOxLg0I3G+Q1k6
         4nK/q5xjdG2I3HSMZuo0kcmr8ptvN/HpzZ/TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CI/CZT0Ds4R/0RCpWk7/OcD9FklwQWMJXxVrdeA2FT0=;
        b=riNCi1UDzGfmy0ogfNzGvu5xA4aB6//QmDU4tGcmPLn/6zjCsAXTCv4hKiz61u/aPK
         6XFCnoNRBs/viLDdOuCMskX7rkLNiUGkGlWfh+rp9EtDbZZwv0hsF337XFHIKRBM9ruW
         OFNhDROAEDFS1cBA+2l4TKNM/P883x9fWw2RqKbxZosuBnkr2rTBBkZxwN/g8lvVVyZY
         pg6KLFByir2h57RET6JhFGWEeq4/WhqQCYFchHEKeRot/D2yFNoYBlVzOLOokLRTgVvb
         wLNQYXoYDIx7iWTgwcXezTn/lq3YP8Jgmqp9ceTdZQ9P75R3xbVLDD35FTnyNrFpADQz
         wesg==
X-Gm-Message-State: APjAAAUopRaFV6ORm1afmvIHE3cBb5se9BcfJeYZoFZakR5kKvWNsyTT
        SHqerZm69MUpxEQyBx8g5cEO0g==
X-Google-Smtp-Source: APXvYqz1QWjPOG3z2vk0Rmu7S0byeUM9munQJtqN1hjEeYZwbjMLDvehmItRLtQ2091swf/XOweefQ==
X-Received: by 2002:a17:90a:d3c3:: with SMTP id d3mr9301430pjw.15.1565989215416;
        Fri, 16 Aug 2019 14:00:15 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id d3sm9074576pjz.31.2019.08.16.14.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 14:00:14 -0700 (PDT)
Date:   Fri, 16 Aug 2019 16:59:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190816205957.GG10481@google.com>
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <20190816164912.078b6e01@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816164912.078b6e01@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 04:49:12PM -0400, Steven Rostedt wrote:
> On Fri, 16 Aug 2019 16:44:10 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> 
> > I am also more on the side of using *_ONCE. To me, by principal, I
> > would be willing to convert any concurrent plain access using _ONCE,
> > just so we don't have to worry about it now or in the future and also
> > documents the access.
> > 
> > Perhaps the commit message can be reworded to mention that the _ONCE
> > is an additional clean up for safe access.
> 
> The most I'll take is two separate patches. One is going to be marked
> for stable as it fixes a real bug. The other is more for cosmetic or
> theoretical issues, that I will state clearly "NOT FOR STABLE", such
> that the autosel doesn't take them.

Makes sense to me!

thanks,

 - Joel


