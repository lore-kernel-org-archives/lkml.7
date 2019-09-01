Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E73EC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 509B122CE9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 10:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d07z2m+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfIAKKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 06:10:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43827 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfIAKKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 06:10:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id u72so1576949pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FbYRkytrLTtQK9ubk14T6uIbs27wef8QJ0XNrSDsLls=;
        b=d07z2m+gfRKxKrTe9mE3W6Z0l3qMppW00Vk8DnjU85seUU+OMB4i3nwsqfJkhm+/G9
         kag0ti7L1mUt8pXiepMqiMBjbzDoyZAIKwSdTaSOSOdq2YLS7mu/js0JkTDWT/uIVN+a
         nkdsAa8SF6gK+tEYmXpvPgWL4Eg58ROKiEbTWwrIwS37gB1Q0b+K2D+b02OIgDUsr5da
         iLs9PSOX/RrobXdY/n4uQvHepu0pnVrKgswYeVlgU7w6zJ31SSLLEGwc8uOR5SeAGV6o
         BlFQi4hD8AD8rC0msqLSy2xmkByyAtzdRxudH1AvT9CBXinkXq+u0t2I2cerQYHopUxP
         8AJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FbYRkytrLTtQK9ubk14T6uIbs27wef8QJ0XNrSDsLls=;
        b=PyO3vurwuAmZAPTwlJoTM5uOgUxsrLrKgla43vfJFNbZIz1B30XqB/YKGgyxPJU1f1
         Vr/BWUV+qZsy0EwNBK0qriR7agZRJ9mPsi7DmMbcFtk0HU4IfVVuxJpRVaRqk+GrvuoQ
         8W6hwMDe+E6LGcNPpIGXKbm0HdFi7g75Vbaj/VZUNdVgTl7waSFEUcB7xifgeu8KVuBj
         FEZqEhVKNGUigKMP4p9KL5Z3rYTK7PS1wRmNobFZwdOrEvTGo7lUiHxxEbaEIc28H4cZ
         B7e6uMQ1+xVpYTETQGcD98s9ZSRS6Uowr7Y0El/PT1eE6kPhxmwljNunazVoyFnq2zp3
         98iQ==
X-Gm-Message-State: APjAAAW12E3ceEeYo1eAL95kOE5aR5sjX/E1EHB3yPsfNmR4OS3x4isS
        0x06COpS7+bGyTVSsmtPD/I=
X-Google-Smtp-Source: APXvYqwExmjzGX4OyIVinVc09PibTO4YCBgL/x8E45zVzS9+Af3Yrf4ffhMB3FxSmugpbMh8d/Q1Jw==
X-Received: by 2002:a65:6284:: with SMTP id f4mr21181144pgv.416.1567332640404;
        Sun, 01 Sep 2019 03:10:40 -0700 (PDT)
Received: from mail.google.com ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id f20sm9543491pgg.56.2019.09.01.03.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 03:10:39 -0700 (PDT)
Date:   Sun, 1 Sep 2019 18:10:33 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        yamada.masahiro@socionext.com, LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] genirq: move debugfs option to kernel hacking
Message-ID: <20190901101032.7pysfrpincyrci35@mail.google.com>
References: <20190901035539.2957-1-changbin.du@gmail.com>
 <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1909010814360.3955@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 08:23:02AM +0200, Thomas Gleixner wrote:
> On Sun, 1 Sep 2019, Changbin Du wrote:
> 
> > Just like the other generic debug options, move the irq one to
> > 'Kernel hacking' menu.
> 
> Why?
> 
> Kernel hacking is a inscrutable mess where you can waste a lot of time to
> find what you are looking for.
>
yes, the 'kernel hacking' menu has many items now and are not well structured.
Let me see if it can be improved.

> If I want to debug interrupts then having the option right there where all
> other interrupt related configuration is makes tons of sense.
> 
> I would be less opposed to this when the kernel hacking menu would be
> halfways well structured, but you just chose another random place for that
> option which is worse than what we have now.
> 
We already have an irq debug option CONFIG_DEBUG_SHIRQ here. Maybe we can group
them into a submenu.

> Thanks,
> 
> 	tglx
> 
> 
> 

-- 
Cheers,
Changbin Du
