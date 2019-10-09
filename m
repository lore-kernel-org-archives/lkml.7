Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DC9ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709BA21924
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jEaNuP3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbfJINnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:43:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38480 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbfJINnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:43:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so3473959qta.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 06:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbmW8oMNpcfaVBYTBCBL+jTjm9GV5hpZALa8v3HrwBI=;
        b=jEaNuP3rdCVFGZxQzP6IhXiwIvWzYOR2BOnjGW/ZS/MZDjw4lhUkTbFwedoTYx7O8s
         O2oViWttfCcTpn/JPLgmoylmDFj0c3QJtiwW181yaxlV1ZrQCOCiSUe87N4rAIi/2GFS
         hczkgK9kOA5i24jZ5RqZhw4PEsqR2QQTcnb+17TRWPfgHI2x5RA4i6LkQX5Wr2/dzAKO
         WLxa7Azghv0uV36wRLw7JBKD5DWWdWbz/wvm73wvc0M73yHflabvhFxKxxnyQP+jmKPC
         lApfCuu5ddOQyatXSzIyqkDQz/TBf2fjiGSm6mvVzfxgYWg6Y5k7T8TyGT8q5li4Mbyi
         ebYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GbmW8oMNpcfaVBYTBCBL+jTjm9GV5hpZALa8v3HrwBI=;
        b=eZQzYIrq0UGpXPMyoPMx3q7hbfnsFh1/Kz1mmD/w1EZRoonwue8pYu8oaXlRxGGsP4
         h0mG1zbT/Lh62EL76d4BVrXZoEn5Q17AGdvt/f8XChHnC17zGucFzF8T5oXV8kWrdJms
         T40gabYGlhRLLbTcdZGGTtJeK1AiU+FZ3sm0ZF8JoM+TjmLOq92MvR7QAn2Jmeg08Aem
         WjsfGAbdiHLN+2Lc/SrZqdkHv3VhhHZLPzvsOCZyt/bFfvwdnFkkDJ3jD6hPinUf2+xZ
         TEEIIY4ySUju93FJ0oTtjbCK75peU6zjsN6rqHAt7TtSAnhqve8y/jwFP+C3QC/IY9Jv
         ziKA==
X-Gm-Message-State: APjAAAU6BVZWl/Sz6ozrMEm/RtupSxvbd6Fou2gL1PGx4Ucrr6PjWhG2
        gbcqeLrzOOkPtaBrOkppa6FbgA==
X-Google-Smtp-Source: APXvYqwqYbj/zGNpmimC3/YGl2R7OxFdKZ71uQmOs9/bcaIv7w/W7Ed5fVY8a+QSBxB1jax1AN+JWA==
X-Received: by 2002:a0c:c10d:: with SMTP id f13mr3745220qvh.88.1570628595720;
        Wed, 09 Oct 2019 06:43:15 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o14sm1321995qtk.52.2019.10.09.06.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 06:43:15 -0700 (PDT)
Message-ID: <1570628593.5937.3.camel@lca.pw>
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 09 Oct 2019 09:43:13 -0400
In-Reply-To: <20191009132746.GA6681@dhcp22.suse.cz>
References: <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
         <20191008082752.GB6681@dhcp22.suse.cz>
         <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
         <1570550917.5576.303.camel@lca.pw> <20191008183525.GQ6681@dhcp22.suse.cz>
         <1570561573.5576.307.camel@lca.pw> <20191008191728.GS6681@dhcp22.suse.cz>
         <1570563324.5576.309.camel@lca.pw>
         <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
         <1570626402.5937.1.camel@lca.pw> <20191009132746.GA6681@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 15:27 +0200, Michal Hocko wrote:
> On Wed 09-10-19 09:06:42, Qian Cai wrote:
> [...]
> > https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/
> > 
> > [  297.425964] -> #1 (&port_lock_key){-.-.}:
> > [  297.425967]        __lock_acquire+0x5b3/0xb40
> > [  297.425967]        lock_acquire+0x126/0x280
> > [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> > [  297.425969]        serial8250_console_write+0x3e4/0x450
> > [  297.425970]        univ8250_console_write+0x4b/0x60
> > [  297.425970]        console_unlock+0x501/0x750
> > [  297.425971]        vprintk_emit+0x10d/0x340
> > [  297.425972]        vprintk_default+0x1f/0x30
> > [  297.425972]        vprintk_func+0x44/0xd4
> > [  297.425973]        printk+0x9f/0xc5
> > [  297.425974]        register_console+0x39c/0x520
> > [  297.425975]        univ8250_console_init+0x23/0x2d
> > [  297.425975]        console_init+0x338/0x4cd
> > [  297.425976]        start_kernel+0x534/0x724
> > [  297.425977]        x86_64_start_reservations+0x24/0x26
> > [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> > [  297.425978]        secondary_startup_64+0xb6/0xc0
> > 
> > where the report again show the early boot call trace for the locking
> > dependency,
> > 
> > console_owner --> port_lock_key
> > 
> > but that dependency clearly not only happen in the early boot.
> 
> Can you provide an example of the runtime dependency without any early
> boot artifacts? Because this discussion really doens't make much sense
> without a clear example of a _real_ lockdep report that is not a false
> possitive. All of them so far have been concluded to be false possitive
> AFAIU.

An obvious one is in the above link. Just replace the trace in #1 above with
printk() from anywhere, i.e., just ignore the early boot calls there as they are
 not important.

printk()
  console_unlock()
    console_lock_spinning_enable() --> console_owner_lock
  call_console_drivers()
    serial8250_console_write() --> port->lock
