Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA82C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F83821841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frAbdH6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfGQXFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:05:07 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41438 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfGQXFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:05:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id v22so18893612qkj.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 16:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6X3lAyZ4nhSUI23jBO0nTgKAeT4lK3jiOA8EMPkRqY=;
        b=frAbdH6dyjD4Yg05XVrC0KB/PkLCDAE0jaS7JrEQXhZI0XJHgay5LoWUcfDQmImjaI
         2Bxd7RlNeQK6wvWWiNurZlY6mF9ZwPj7p8WXoFng1c3QBlUoheYiSFeF/BplGq8z3RxP
         CKmSCRfxE3Zj89Q0Q59EuN88ty4nGk+PhS/FwSmTSgtnFsFdJFphQxwuVizDCVGNzWB3
         yMK0G7yLAoRi4wPT4gw9keQItkfyx5PjZFbuW/fDnzmuxo2dx5YnJWxaD0/pjuP90be0
         vlbXsr5rMdhKcQ+3pGFYKY8LOIrc8d9XIrbB+zGIVwvPNINXm/XSJjLT+ThDCrTxuUQz
         JU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6X3lAyZ4nhSUI23jBO0nTgKAeT4lK3jiOA8EMPkRqY=;
        b=DHtNtBDnN9c6teZ/bFwS4L213hxTCV0+Tex9U2WutF8b8pR2WUXRcr8ijp3AxnFIPr
         CMHxUdbX3eXOGrlgJPSj1oJ2y1wuvBBF28AvHBJF0gZXWXIn63VGSyLUoFbhlV9sYTuv
         5YT0Yp4iU41n2qz1FO6NidXquHgbmVcAtb/xfoC+dfEMXdnus481F2i8cBXq9bdZ4zAg
         kXzTM3Iecno4joL4IaGFumvWr+sWw1TlyhwwRx6vjjNkgk+Pj4VVy8UY/H3vC0SgwV7D
         d4azBoEkkxzV+iFo86MVwGFxVp2eXaGexD5kqaQpNkmaRBKGmbV4aiq3EY+HcB3lJJvE
         RCZA==
X-Gm-Message-State: APjAAAUEYCK/c0y2SqVxg6LVtJEAk4tJjEC6rl0pZ/e2HBcsEg50MusJ
        JMKV3PIBgreyUk8v1CbUeFw=
X-Google-Smtp-Source: APXvYqxaTDZcQ02bBk5pW1vvhkSBEJZHiMiJafycngXLwi1UtewV+jo/YfEISoH2hEMtWjEvgJjJwQ==
X-Received: by 2002:ae9:eb16:: with SMTP id b22mr24660664qkg.160.1563404705766;
        Wed, 17 Jul 2019 16:05:05 -0700 (PDT)
Received: from lclaudio.dyndns.org ([191.177.181.235])
        by smtp.gmail.com with ESMTPSA id j6sm11331933qkf.119.2019.07.17.16.05.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 16:05:04 -0700 (PDT)
From:   "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
X-Google-Original-From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 723F43C154C; Wed, 17 Jul 2019 20:05:01 -0300 (-03)
Date:   Wed, 17 Jul 2019 20:05:01 -0300
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <clark.williams@gmail.com>,
        Julia Cartwright <julia@ni.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [patch 1/1] Kconfig: Introduce CONFIG_PREEMPT_RT
Message-ID: <20190717230501.GA5727@uudg.org>
References: <20190715150402.798499167@linutronix.de>
 <20190715150601.205143057@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715150601.205143057@linutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 05:04:03PM +0200, Thomas Gleixner wrote:
> Add a new entry to the preemption menu which enables the real-time support
> for the kernel. The choice is only enabled when an architecture supports
> it.
> 
> It selects PREEMPT as the RT features depend on it. To achieve that the
> existing PREEMPT choice is renamed to PREEMPT_LL which select PREEMPT as
> well.
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---

Glad to see this important step being taken!

Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

