Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD2CECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC98B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570627673;
	bh=bw+iPGXQ7hJIeZflMW3KHcdNNnd3Dv0YwlLSA0Hz4TM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0sBb2EgfVVYssUznGjUv35X61o4usY+0FSFUltyLq+q0fP83TUIHEK4jQkr+82Xjp
	 T4GuVgikYwhas8T+OLy4hKaWAJ0fOst/OG4dHWAtVPzdvbJ4A5rB80ZRQmPcqnm0c/
	 rukdbm7fbMERLuWYy48W6xVVktnnHeuvU3GBnOf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfJIN1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:27:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731152AbfJIN1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CFDCAC6E;
        Wed,  9 Oct 2019 13:27:47 +0000 (UTC)
Date:   Wed, 9 Oct 2019 15:27:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        sergey.senozhatsky.work@gmail.com, rostedt@goodmis.org,
        peterz@infradead.org, linux-mm@kvack.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>, david@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_isolation: fix a deadlock with printk()
Message-ID: <20191009132746.GA6681@dhcp22.suse.cz>
References: <20191008074357.f33f6pbs4cw5majk@pathway.suse.cz>
 <20191008082752.GB6681@dhcp22.suse.cz>
 <aefe7f75-b0ec-9e99-a77e-87324edb24e0@de.ibm.com>
 <1570550917.5576.303.camel@lca.pw>
 <20191008183525.GQ6681@dhcp22.suse.cz>
 <1570561573.5576.307.camel@lca.pw>
 <20191008191728.GS6681@dhcp22.suse.cz>
 <1570563324.5576.309.camel@lca.pw>
 <20191009114903.aa6j6sa56z2cssom@pathway.suse.cz>
 <1570626402.5937.1.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1570626402.5937.1.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 09:06:42, Qian Cai wrote:
[...]
> https://lore.kernel.org/linux-mm/1570460350.5576.290.camel@lca.pw/
> 
> [  297.425964] -> #1 (&port_lock_key){-.-.}:
> [  297.425967]        __lock_acquire+0x5b3/0xb40
> [  297.425967]        lock_acquire+0x126/0x280
> [  297.425968]        _raw_spin_lock_irqsave+0x3a/0x50
> [  297.425969]        serial8250_console_write+0x3e4/0x450
> [  297.425970]        univ8250_console_write+0x4b/0x60
> [  297.425970]        console_unlock+0x501/0x750
> [  297.425971]        vprintk_emit+0x10d/0x340
> [  297.425972]        vprintk_default+0x1f/0x30
> [  297.425972]        vprintk_func+0x44/0xd4
> [  297.425973]        printk+0x9f/0xc5
> [  297.425974]        register_console+0x39c/0x520
> [  297.425975]        univ8250_console_init+0x23/0x2d
> [  297.425975]        console_init+0x338/0x4cd
> [  297.425976]        start_kernel+0x534/0x724
> [  297.425977]        x86_64_start_reservations+0x24/0x26
> [  297.425977]        x86_64_start_kernel+0xf4/0xfb
> [  297.425978]        secondary_startup_64+0xb6/0xc0
> 
> where the report again show the early boot call trace for the locking
> dependency,
> 
> console_owner --> port_lock_key
> 
> but that dependency clearly not only happen in the early boot.

Can you provide an example of the runtime dependency without any early
boot artifacts? Because this discussion really doens't make much sense
without a clear example of a _real_ lockdep report that is not a false
possitive. All of them so far have been concluded to be false possitive
AFAIU.
-- 
Michal Hocko
SUSE Labs
