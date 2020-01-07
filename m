Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A11C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8712072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9TuhSxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgAGNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:12:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbgAGNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3roxz6guEJ/YxIFLVeBH//5xGM64ZcJTUKnaWntqOek=; b=Y9TuhSxtHADNgC+2XWQQAGths
        ovny7OuepH+xVuWPmyn4B+ua4SVqEtowwCDWlINRJv0VJ2VP0ymXprj00rnSN8JT5OVwQFETUW6qO
        BbpldV8TlVGvgWQlTA0oLWB51Oa07YC1RCBnL9uGQlvFSWiF60KfIFA8nlsHJ/q83J26Shk4eWW5M
        0UOXVUP4U5BpVHf+OD346c8iMFtjIwtAOK3GoKe5xPnZ9KMLWhnuGzQ8Swi8DF+lkAlzF/wa+ej8n
        0LPFr0wJS9UE0hwrkWNWNlKhqrbYPONIglqfj4iMRRpSFxcfYFIhDo6qHDOawg4JyrXqKDYk4lZFy
        QVjRRrheg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iooeC-0004hQ-Gg; Tue, 07 Jan 2020 13:11:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 817633012C3;
        Tue,  7 Jan 2020 14:10:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19BEE20D3D423; Tue,  7 Jan 2020 14:11:46 +0100 (CET)
Date:   Tue, 7 Jan 2020 14:11:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+bcad772bbc241b4c6147@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64
Message-ID: <20200107131146.GX2827@hirez.programming.kicks-ass.net>
References: <000000000000e728ec057d5c9d90@google.com>
 <a5478450-f975-228f-1ca6-886a45b654a1@I-love.SAKURA.ne.jp>
 <CACT4Y+YqWgZZFXdX2A2jVYEdHfY9ywGMgRRP5W4Uqdu__rA63g@mail.gmail.com>
 <bc53fe0b-2c17-4d4f-1c40-f290997d0521@i-love.sakura.ne.jp>
 <CACT4Y+bEi9ZsJn0Jm2Lwt-1cijQq=wc5MqYh0qf6R6+wpZVD2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bEi9ZsJn0Jm2Lwt-1cijQq=wc5MqYh0qf6R6+wpZVD2Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:02:47PM +0100, Dmitry Vyukov wrote:
> > >> This is not a LSM problem, for the reproducer is calling
> > >> sched_setattr(SCHED_DEADLINE) with very large values.
> > >>
> > >>   sched_setattr(0, {size=0, sched_policy=0x6 /* SCHED_??? */, sched_flags=0, sched_nice=0, sched_priority=0, sched_runtime=2251799813724439, sched_deadline=4611686018427453437, sched_period=0}, 0) = 0
> > >>
> > >> I think that this problem is nothing but an insane sched_setattr() parameter.

Argh, I had a patch for that somewhere. Let me go dig that out.
