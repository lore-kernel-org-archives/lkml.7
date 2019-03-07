Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A637C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6D220851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIcG9CkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfCGRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:50:09 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42679 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfCGRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:50:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id u7so18103291qtg.9;
        Thu, 07 Mar 2019 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6ghKtnVBoDroLX7UVl1KrnOuRQZ/CsTVRox/BQ4Gn2s=;
        b=RIcG9CkCNIGxCTqh7D0bn1YWNcKwPX23Z7HulZ5RLcnmH0wfDm07x0vuq4lPwO3gct
         ojlRcsUMEO2DppexGnAtfiCdbUXDChWRIg7HjHSM190D/Tf0FLejqPZO18l0P+tiX7Yn
         ekqCsywyNnNxHUFhTRCd2Q3omMTEkQ9+f0TizmxhBzeC5OtTbZFd/CRpPIO9o4xSXN24
         CJ9jNC4nDD0g9CN/o0D6AKrsLkc67Vu5GJPLiLAivmt3GBtkw3HePDuM5GWwYIDB5mo+
         Jf5bSYGXMW9sgzTJJtIogGTShAosFUp/wOTcDvuomN9QQgyTrArq/2wKOTLmYwsDLZ+W
         wLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6ghKtnVBoDroLX7UVl1KrnOuRQZ/CsTVRox/BQ4Gn2s=;
        b=qa8NQz2yqebIvQp9DSPmWKSj7dGNHksBrRKhOA9wFCM3yH6id/lGW7virB3s45kofb
         18s2N7vkSDFebv43UjCjqB5XmAhU40PxxnbDqiaqzuB5f6vV/lh9bDufHPVJMF37GRsf
         nBNRk78dK4nVr6etFOfSIKCfI61dGHaCen8fy1Dtq4ZyckYj6j5/q0F4uhJofJlAFbK6
         yE5nk2idTxmxreDhDqtQ/w/EXFjmMCKbHS0IM4zDW0FeBKnr7y2l4f6EcRGjwxFPP5Go
         Wxln2rOIdNKs21+2hOw8X5o+nxQGHmd1iiKWp/KvGfmtj4RyRO84ZWYl+qn+gC0Bj0xz
         c8vg==
X-Gm-Message-State: APjAAAWLJxbGiR3sVs7sDsDyE/PGNvmS7cexAZ/GuOVh7UKy0PbcCP9u
        rVoC9EdnJNPlX9Au2VQVbaI=
X-Google-Smtp-Source: APXvYqxjs72fqFPBUQVnnQDME1mdoe3rTevSPvjbMhHnaMnIjv2HcTKKIZuQCqoHpWR8Z1z3Hb824A==
X-Received: by 2002:aed:21cb:: with SMTP id m11mr10925392qtc.257.1551981005317;
        Thu, 07 Mar 2019 09:50:05 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f013:3791:2e0d:70cd:9752:703c])
        by smtp.gmail.com with ESMTPSA id b83sm2950377qkg.12.2019.03.07.09.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 09:50:04 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 05225180B7B; Thu,  7 Mar 2019 14:50:01 -0300 (-03)
Date:   Thu, 7 Mar 2019 14:50:01 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        syzbot <syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>, LKML <linux-kernel@vger.kernel.org>,
        linux-sctp@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vlad Yasevich <vyasevich@gmail.com>
Subject: Re: general protection fault in sctp_sched_rr_dequeue
Message-ID: <20190307175001.GA13515@localhost.localdomain>
References: <000000000000cc734405836318dc@google.com>
 <CADvbK_fJ8R0WmQaFcz0sOhL_AXH3AdO2zLeqMD38X22izEAMNg@mail.gmail.com>
 <20190306120310.GA6711@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306120310.GA6711@hmswarspite.think-freely.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 07:03:10AM -0500, Neil Horman wrote:
> On Wed, Mar 06, 2019 at 06:43:48PM +0800, Xin Long wrote:
> > On Wed, Mar 6, 2019 at 9:42 AM syzbot
> > <syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    63bdf4284c38 Merge branch 'linus' of git://git.kernel.org/..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=100347cb200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=872be05707464aaa
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=4c9934f20522c0efd657
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd9b03200000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127de8e7200000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+4c9934f20522c0efd657@syzkaller.appspotmail.com
> > >
> > > kauditd_printk_skb: 2 callbacks suppressed
> > > audit: type=1400 audit(1551833288.424:35): avc:  denied  { map } for
> > > pid=8035 comm="bash" path="/bin/bash" dev="sda1" ino=1457
> > > scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> > > tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
> > > audit: type=1400 audit(1551833294.934:36): avc:  denied  { map } for
> > > pid=8047 comm="syz-executor778" path="/root/syz-executor778173561"
> > > dev="sda1" ino=16484 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023
> > > tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
> > > kasan: CONFIG_KASAN_INLINE enabled
> > > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > > general protection fault: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 1 PID: 8047 Comm: syz-executor778 Not tainted 5.0.0+ #7
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > RIP: 0010:sctp_sched_rr_dequeue+0xd3/0x170 net/sctp/stream_sched_rr.c:141
> > The panic was caused by sched->init() reset stream->rr_next = NULL, even
> > if outq->out_chunk_list is not empty.
> > 
> > We should remove the sched->init() from sctp_stream_init(), since
> > all sched info was moved into sout->ext and sctp_stream_alloc_out()
> > will not afffect it.
> > 
> I think what you're saying is we can just let sctp_outq_init handle the stream
> scheduler initalization, correct?  If so, ACK to that approach
> Neil

+1

  Marcelo
