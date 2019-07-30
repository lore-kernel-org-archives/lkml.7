Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC34C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB7D206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KW3f3qzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfG3IDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:03:16 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfG3IDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3nu47du/8iubKjsIzjPixD1xaKj4CUcoohnp51Rw7eo=; b=KW3f3qzODooeqs96VV2Xkhow0
        urjs6/igcasbivaBcvLfZuidGFRP38/htqosHaeLpv2a1cWtnbF3DZJr1lPgylo/qxHjCzT+eXJ19
        nZHIz3T5C0H1MrKJD2X9+3xnlmBooBzdRUiPYSKP8cr6ZC4RqVj1QwQR7wsmF23MCazqKj9WOpDY8
        A5AdgqO4WtvujNn7U/HUneoJQtZPRbS0RPOGEfnwT4ZwO5m0Gz90td5yK08kf2beAuCKoArQraMqs
        NnWjjavGMxAVVAIaf4ylR5Wib+A28PIs8al6uG8ExUM14Glrsh/NHM20M29FohIePceBR0w1pphiG
        DdZta8BOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsN6F-0005GN-Jw; Tue, 30 Jul 2019 08:03:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADB1820AFFE9F; Tue, 30 Jul 2019 10:03:08 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:03:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/mutex: Use mutex flags macro instead of hard
 code value
Message-ID: <20190730080308.GF31381@hirez.programming.kicks-ass.net>
References: <1564397578-28423-1-git-send-email-mojha@codeaurora.org>
 <1564397578-28423-2-git-send-email-mojha@codeaurora.org>
 <20190729110727.GB31398@hirez.programming.kicks-ass.net>
 <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80972a1-8e24-33cb-0088-49ef0e680540@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:23:13PM +0530, Mukesh Ojha wrote:
> 
> On 7/29/2019 4:37 PM, Peter Zijlstra wrote:
> > On Mon, Jul 29, 2019 at 04:22:58PM +0530, Mukesh Ojha wrote:
> > > Let's use the mutex flag macro(which got moved from mutex.c
> > > to linux/mutex.h in the last patch) instead of hard code
> > > value which was used in __mutex_owner().
> > > 
> > > Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
> > > ---
> > >   include/linux/mutex.h | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > > index 79b28be..c3833ba 100644
> > > --- a/include/linux/mutex.h
> > > +++ b/include/linux/mutex.h
> > > @@ -87,7 +87,7 @@ struct mutex {
> > >    */
> > >   static inline struct task_struct *__mutex_owner(struct mutex *lock)
> > >   {
> > > -	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~0x07);
> > > +	return (struct task_struct *)(atomic_long_read(&lock->owner) & ~MUTEX_FLAGS);
> > >   }
> > I would _much_ rather move __mutex_owner() out of line, you're exposing
> > far too much stuff.
> 
> if i understand you correctly, you want me to move __mutex_owner() to
> mutex.c
> __mutex_owner() is used in mutex_is_locked() and mutex_trylock_recursive
> inside linux/mutex.h.
> 
> Shall i move them as well ?

Yes, then you can make __mutex_owner() static.

Thanks!
