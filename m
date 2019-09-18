Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DEAC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8808620578
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 01:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOFgBadN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfIRBZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 21:25:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35507 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfIRBZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 21:25:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so3268895pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 18:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qTucIh8q1fOUaY+KKBj6aQtvZjzoQVm4j1aVcrELJdg=;
        b=qOFgBadN95TeEZ2PDXgkMFaZWHVt7J+pDCghlwm67uc+HMVkwhEZUk7ljnEeLICS3c
         bMta2W4onT6TXa+2i/KCYf0Ha/+rmpBZIQD6bSj5aZuZLg4Q8wxougqLHYm1s2BS018C
         yA9RPfAOmKAsMXANo4hI3MWc7sGJHH/ueUR3ko8PmniU/BAx/+KDIPGOlXYwJM/vipC7
         lVPeUVtk8I+mD1l3+wGZqKHcHdhzyfpZWzi7LvOMxmGNyOnRtc4JEaTFPlTSkAk2bO0H
         gH5UpL1BjudRLTATUcUaVgZ5ysnNo1cwpSwX9/a0peagmssIRLdb3KdEXxBU+yPqKELF
         mQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qTucIh8q1fOUaY+KKBj6aQtvZjzoQVm4j1aVcrELJdg=;
        b=sKytYddV4y95dP1gNJZzOGT3O0RKhmBDdGk/SycIJW1wI5x+Y/gHTgjWsImx0RCv11
         eL1cnWSReVNRnvxbg7TaXq2HpYpZkM3j6sSgw1rRfeCHt4mtKedgn2RZcaI7YIJYcQKX
         dySLTgXMvAs3vBHJmiUZLR/9Ix1Jjo+Y7coUX/Ozx5xOhIGwLGQgQPxliqS5IBCU8awR
         2tdkdauxUBaFT6GE3YDNh9z/0pabaEFAcrBn5QDKPvafrgO/Kh8K8M4bOvwh9vCWaVhJ
         SBOA8pKly7WnCDADNE0i7eL40wJy9QuVFv/4tlUaCjEXPK9LlKJel+68xgCMpt6GHRVT
         3ogQ==
X-Gm-Message-State: APjAAAWKjjZje5JugUyv90ZZfkn2UTRiLlHnZYPjS/20yaoOyaIlBrbz
        r5IrNeNWpxNxpvQSQw0KCTE=
X-Google-Smtp-Source: APXvYqzg5q+zi7l62CSsBi+FVAyvyazN/rsqBHQwchbTMquy6ZBbE0QNAtXa4cgIoVKUr37UmaMV1Q==
X-Received: by 2002:a62:834c:: with SMTP id h73mr1420640pfe.183.1568769951670;
        Tue, 17 Sep 2019 18:25:51 -0700 (PDT)
Received: from localhost ([175.223.34.14])
        by smtp.gmail.com with ESMTPSA id q2sm5322354pfg.144.2019.09.17.18.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 18:25:50 -0700 (PDT)
Date:   Wed, 18 Sep 2019 10:25:46 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Paul Turner <pjt@google.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Prarit Bhargava <prarit@redhat.com>
Subject: Re: printk meeting at LPC
Message-ID: <20190918012546.GA12090@jagdpanzerIV>
References: <20190807222634.1723-1-john.ogness@linutronix.de>
 <20190904123531.GA2369@hirez.programming.kicks-ass.net>
 <20190905130513.4fru6yvjx73pjx7p@pathway.suse.cz>
 <20190905143118.GP2349@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1909051736410.1902@nanos.tec.linutronix.de>
 <20190905121101.60c78422@oasis.local.home>
 <alpine.DEB.2.21.1909091507540.1791@nanos.tec.linutronix.de>
 <87k1acz5rx.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1acz5rx.fsf@linutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/13/19 15:26), John Ogness wrote:
> 2. A kernel thread will be created for each registered console, each
> responsible for being the sole printers to their respective
> consoles. With this, console printing is _fully_ decoupled from printk()
> callers.

sysrq over serial?

What we currently have is hacky, but, as usual, is a "best effort":

	>> serial driver IRQ

	serial_handle_irq()		[console driver]
	 uart_handle_sysrq_char()
	  handle_sysrq()
	   printk()
	    call_console_drivers()
	     serial_write()		[re-enter console driver]

offloading this to kthread may be unreliable.

	-ss
