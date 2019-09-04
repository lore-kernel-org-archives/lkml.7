Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DAC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D688522CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 12:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QnuouqMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfIDMO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 08:14:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35263 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727900AbfIDMO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 08:14:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so13805378qth.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 05:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bl6KGDbxyH9xibYLFzb2mGM47IhCp8dCBtbeKfHElvA=;
        b=QnuouqMmL8Ruk+R6jgbyEXsFKtEUI5jAhWEUccMzoIFT3hIMpBl5QgvXmfPajbeZgi
         d2iMXBHvzXkhD7THAH6LnGOC8s/EcsqTzcVeAI3UnGtcjpKZGJt9NPTdmm5cTcnuw2XO
         N7Hi3qrBbJdk3+mwG9Milp6EEDXrhwxY1Uvt0wOyxopI4PH9pLEML/64jmM/Ls+0o47e
         ktXGLGHcIC5QGyLUWDJb1dIU4+DiP5SK1Z8QCMsBF1GWBujQzoXO1C5jS6EoUMD6kApL
         qjrI+wfMsyPkw9IUz1frp0Vpe+I20t/JM75jAVRP8cFXMe71o4zxTvut7gNWwNvoMf5a
         NXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bl6KGDbxyH9xibYLFzb2mGM47IhCp8dCBtbeKfHElvA=;
        b=kBteAH4s92NCPNZpdj9eDz8EOtXfXmG5kCIr4zjm1EgnN8xJc2ORaxbF8II4AMikBx
         3j+6kLp8nB2qQPYqMqqGvQV81IjZJeHVO8hij9Zkg4c7Y1OODPWB0w41scRU6ZS7SiKd
         uOt3Imyl3tvLLYqeHUKrDezAsoci+Itybph4ZJe/7G7ALYTUdneA4jv/IEeXFUE3/ZkP
         exgD/kjiHMmUDjdDXE3jWsWnJ59EPWRG+iYOk6mVH5RXfhFUrORwasqSjWSZFcmPCaU2
         HWEBKtcrO75ym/9TLulk7T1IsDq3xC+356EIclmuRA/0QDb++fqE2iXtiK40qXCCbJhq
         W+RA==
X-Gm-Message-State: APjAAAUU/Xn9kH2hxlKo1YXsJB+UbztjSTymIAcJ1o1cCuHNIy0XrGIB
        Lv4OacKcctOkBWobj1PLF5EJrA==
X-Google-Smtp-Source: APXvYqwVMedOXPfbW97QL3Tml18XfuCAjaFmLYqEjgyl13jtOyVoXSys9SE3TEG9CouaQn2bE7sZGw==
X-Received: by 2002:a0c:8ad0:: with SMTP id 16mr14055557qvw.237.1567599265215;
        Wed, 04 Sep 2019 05:14:25 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 29sm7794713qkp.86.2019.09.04.05.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2019 05:14:24 -0700 (PDT)
Message-ID: <1567599263.5576.72.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 04 Sep 2019 08:14:23 -0400
In-Reply-To: <20190904074312.GA25744@jagdpanzerIV>
References: <1567178728.5576.32.camel@lca.pw>
         <229ebc3b-1c7e-474f-36f9-0fa603b889fb@gmail.com>
         <20190903132231.GC18939@dhcp22.suse.cz> <1567525342.5576.60.camel@lca.pw>
         <20190903185305.GA14028@dhcp22.suse.cz> <1567546948.5576.68.camel@lca.pw>
         <20190904061501.GB3838@dhcp22.suse.cz> <20190904064144.GA5487@jagdpanzerIV>
         <20190904065455.GE3838@dhcp22.suse.cz>
         <20190904071911.GB11968@jagdpanzerIV> <20190904074312.GA25744@jagdpanzerIV>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-04 at 16:43 +0900, Sergey Senozhatsky wrote:
> On (09/04/19 16:19), Sergey Senozhatsky wrote:
> > Hmm. I need to look at this more... wake_up_klogd() queues work only once
> > on particular CPU: irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
> > 
> > bool irq_work_queue()
> > {
> > 	/* Only queue if not already pending */
> > 	if (!irq_work_claim(work))
> > 		return false;
> > 
> > 	 __irq_work_queue_local(work);
> > }
> 
> Plus one more check - waitqueue_active(&log_wait). printk() adds
> pending irq_work only if there is a user-space process sleeping on
> log_wait and irq_work is not already scheduled. If the syslog is
> active or there is noone to wakeup then we don't queue irq_work.

Another possibility for this potential livelock is that those printk() from
warn_alloc(), dump_stack() and show_mem() increase the time it needs to process
build_skb() allocation failures significantly under memory pressure. As the
result, ksoftirqd() could be rescheduled during that time via a different CPU
(this is a large x86 NUMA system anyway),

[83605.577256][   C31]  run_ksoftirqd+0x1f/0x40
[83605.577256][   C31]  smpboot_thread_fn+0x255/0x440
[83605.577256][   C31]  kthread+0x1df/0x200
[83605.577256][   C31]  ret_from_fork+0x35/0x40

In addition, those printk() will deal with console drivers or even a networking
console, so it is probably not unusual that it could call irq_exit()-
>__do_softirq() at one point and then this livelock.
