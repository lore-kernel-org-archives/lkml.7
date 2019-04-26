Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD6DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F8B206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qag9KjXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfDZFl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:41:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36642 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfDZFl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:41:57 -0400
Received: by mail-qt1-f196.google.com with SMTP id c35so2873713qtk.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALLpMjxVV7s2gAejGFkSCvqnEKGQlvw6lP7jI9b0o+U=;
        b=qag9KjXWknF7uuEdv6ozbZ5nBt5wL6UuUSEwd4Ebrpeprk9cU/WyJtP9b50s2ET2qc
         cdy1GvZHpltDE4jVPxqSUEXf1crxK4pPF1eFc+25FXrItwxgWw/Xf8Md8cY2q6QclRtm
         Z7eFivTNbWIZSxQndD9/dXAgNNygLVeFpjr1otWRnU/tWBdy4EqLb7iolCPMk06oMkHf
         p5QM0ntv0Pvr5cqpJ9LXS9VVEqMyGiNhnAyO2Dm6rRfBdkXk8hPc7qL8/LU0GZmP189p
         x2c0uf+EoBIQCCCUFrREhHlDRdPKQHTNZMTnQqf4h1JpHW9MJJsBapPJXvcKwThfOHDk
         D8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALLpMjxVV7s2gAejGFkSCvqnEKGQlvw6lP7jI9b0o+U=;
        b=c4XQb1n46OpGtE89OZPg0AKeKNIksUmJDJ+Lf5kvvgCn1+KGI3bmxXkFv5t6ELOcvi
         8/DREHaSX4jw1S/N1DTqtQ9Fq2Dh/QxN5Y7FVZ1R48BSngNKgH6EbHQjEoVGoEWSKoT3
         DZQnScPnl8HZClGy19yG+V3IJPQ71eJKGYesmSXH6eQGqh9L28/Kkpg0zSvax+DSoGwq
         dLSgWcJyMAffqDi6VVOBysQKVfgED5IXIb1ArNt1pMaFyeXU6c87ruw6GqNTT+my7SOg
         nRr3LZNjgYFmIWDVJnxvLHKk0x5d0pL2doDa0jJFn+otyupL+YJCQ1a380mxtOhBorx1
         6WWA==
X-Gm-Message-State: APjAAAWTaRPpszoZOqW/rl3iAmlugHokTzLr8WxNzmppsw2H6odKiW5+
        mGMAIeSjEY4Jua/3P5lRopD0XFAbUXuLh+8nEqA=
X-Google-Smtp-Source: APXvYqz0zBOCLrIQOWkGlOxgE4OeHmcPevliWC9oYZaCci0Os7htRJlFOqptJb5HffeZ+uUveJ6r8bdGJMgBidhJebY=
X-Received: by 2002:a0c:ae04:: with SMTP id y4mr34693540qvc.49.1556257317039;
 Thu, 25 Apr 2019 22:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190424101934.51535-1-duyuyang@gmail.com> <20190424101934.51535-3-duyuyang@gmail.com>
 <20190425140110.GS12232@hirez.programming.kicks-ass.net>
In-Reply-To: <20190425140110.GS12232@hirez.programming.kicks-ass.net>
From:   Yuyang Du <duyuyang@gmail.com>
Date:   Fri, 26 Apr 2019 13:41:45 +0800
Message-ID: <CAHttsra1e4s0RApdLb1=FtQFkB_pYe5YiLJ=7Ne4z3_jU_NmSw@mail.gmail.com>
Subject: Re: [PATCH 02/28] locking/lockdep: Add description and explanation in
 lockdep design doc
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for review.

You mean class can go away? Before Bart's addition, it can go away.
Right? I think maybe the original point of "never go away" in that
context did not intend to talk about a class's real disappearance.

Anyway, the points should be made comprehensive. You want me to resend
the patch or you modify it?

On Thu, 25 Apr 2019 at 22:01, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 06:19:08PM +0800, Yuyang Du wrote:
> > +Unlike a lock instance, a lock-class itself never goes away: when a
> > +lock-class's instance is used for the first time after bootup the class gets
> > +registered, and all (subsequent) instances of that lock-class will be mapped
> > +to the lock-class.
>
> That's not entirely accurate anymore. Bart van Assche recently added
> lockdep_{,un}register_key().
