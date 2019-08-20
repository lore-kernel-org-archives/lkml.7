Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662EFC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD2A20644
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfHTIuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:50:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51133 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbfHTIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:50:00 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzzpz-0007TS-B4; Tue, 20 Aug 2019 10:49:55 +0200
Date:   Tue, 20 Aug 2019 10:49:49 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908201036200.2223@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com> <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com> <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com> <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de> <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com> <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com> <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de> <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com> <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
 <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com> <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de> <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arul,

 A: Because it messes up the order in which people normally read text.
 Q: Why is top-posting such a bad thing?
 A: Top-posting.
 Q: What is the most annoying thing in e-mail?

 A: No.
 Q: Should I include quotations after my reply?

 http://daringfireball.net/2007/07/on_top

On Tue, 20 Aug 2019, Arul Jeniston wrote:

> Agreed. Please find the dmesg output below. We see the problem on
> [1456773.366951].
> Let us know if you find anything suspicious.

The most suspicious thing is:

> [    0.000000] Linux version 4.9.0-8-amd64

       		       	       ^^^^^

IOW, a (dead) kernel, which does not contain the new TSC ADJUST verification
mechanism.

If you send patches against mainline in future, then please always verify
that the problem persists with the mainline kernel.

Can you please boot something more recent - at least 4.19 LTS - on that
machine and let it run for a couple of days to check whether there are 'TSC
ADJUST' related entries in dmesg?

Thanks,

	tglx

