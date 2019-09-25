Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C73EC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB31420872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 07:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqGKhf01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442638AbfIYHwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 03:52:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437273AbfIYHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 03:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QLaOtog4CSMwHTDIFjzn/+Kdo/fBdOj+k2FeIrSbTy4=; b=TqGKhf011tJez3WGVTsuibpOq
        fYc8GSKe211UHuZYVzqU96dFjLEjGy8xkq2JG9hHHS+3eAv6na36eHo66aM6DcOyxVM0NmUkWtHJx
        b/aUMWcH+9xNAC3W2CWU957lCcmYYtCFWRXueJSSFm7FS08m9tNr705KTnerAHhESmQtQ+uAgb7CT
        5xc27Za2DGuE8cc7zQHI0zmrvCQnvzop6IQoVWBYm97u8/UP3JQwPa3xnyA27WTLLHi3tXSyhaBuS
        MAMsE6XKW5oe6nveeWPfthtn8SLEKAcE2FsXoteNDk3/IZBtPzW07eQnZW3kR95JK2nmtmBEyzHsj
        ZmY+y6Nqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD25d-0008JK-L4; Wed, 25 Sep 2019 07:51:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9213E305E42;
        Wed, 25 Sep 2019 09:51:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7D526202411BF; Wed, 25 Sep 2019 09:51:55 +0200 (CEST)
Date:   Wed, 25 Sep 2019 09:51:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v2 0/4] task: Making tasks on the runqueue rcu protected
Message-ID: <20190925075155.GB4536@hirez.programming.kicks-ass.net>
References: <87muf7f4bf.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=whej3MMKJBHKWp66djfEP5=kyncX7FoqJacYtmBXB6v9w@mail.gmail.com>
 <8736gu962r.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736gu962r.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 12:38:04PM -0500, Eric W. Biederman wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:

> > Can anybody see anything wrong with the series? Because I'd love to
> > have it for 5.4,
> 
> Peter,
> 
> I am more than happy for these to come through your tree.  However
> if this is one thing to many I will be happy to send Linus a pull
> request myself early next week.

Yeah, sorry for being late, I fell ill after LPC and am only now
getting back to things.

I see nothing wrong with these patches; if they've not been picked up
(and I'm not seeing them in Linus' tree yet) I'll pick them up now and
munge them together with Mathieu's membarrier patches and get them to
Linus in a few days.
