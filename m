Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BAC31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2A0208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="wR2gqiUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfFNJ5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:57:03 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:51383 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfFNJ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:57:03 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 45c340f9
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jun 2019 09:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AVVulO5koPp3MqRQSN8F3CCnp/s=; b=wR2gqi
        UgxWZzvdzxM/wzWSowXMj0P8TYUMZ5sYfR5EbRwu2zsP9WTSYT/cOP3vrVESjNWH
        gCWAXlroxQmh7LMWzTdXjjAmaTQX4HORdx/BA355BgSEMm+jiWnqYwTlcO7QG/y4
        B/Sv+SObsWpCRZs2TzG0qdY21J1vgwaQG8eMW8nc2aK6Q4HqtZEolcNqCl7iJEyD
        Gttv+oXQ2nHrVUWlEWRY/jDC6P6iKrY4cldpeSRhvUK1GuFQFGU36So4mioA8sb9
        ts2l6a1xNKHKweXrXRgxzgMoN5dYSuTKPdPFxAELqGUbANo7jKjO/73dfl8JbhuZ
        Q4DUPPqY4bS5dLiw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 685c5a28 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jun 2019 09:24:31 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id z23so2032465ote.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 02:57:00 -0700 (PDT)
X-Gm-Message-State: APjAAAVfr3OBVjgt+leYsxaKi/ny/iaKGMBB17uKOCthmVZYzbhVWVyz
        8CqvjnELfzELv9rZ85p9qNOSuhJQRO5PkiAmBPE=
X-Google-Smtp-Source: APXvYqziiVufozTh8voh37sX5EeI7ajB/60Sy6FHSHfaDRrMz5lPRZy5exv3ObKTSI/WydmVQ4SQVWoEDDTFiz580Ps=
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr28823037otn.243.1560506219375;
 Fri, 14 Jun 2019 02:56:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9qBDtO1vJrA2Ch3SQigsu435wR7Q3vTm_3R=u=BE49S-Q@mail.gmail.com>
 <alpine.DEB.2.21.1906112257120.2214@nanos.tec.linutronix.de>
 <20190612090257.GF3436@hirez.programming.kicks-ass.net> <CAHmME9obwzZ5x=p3twDfNYux+kg0h4QAGe0ePAkZ2KqvguBK3g@mail.gmail.com>
 <CAK8P3a15NTV=njOjz-ccYL8=_q_MdEru0A+jeE=f7ufUTOOTgw@mail.gmail.com>
 <CAHmME9pOWk_ZteUZc_PT19rMn1kfYcXtmLcyAy5sncdV1tNuiQ@mail.gmail.com>
 <CAK8P3a3DpRvk1Mw_MKs8wAbRJbMUQoY2UTgK1CF8UOiBQg=btw@mail.gmail.com>
 <CAHmME9pVeYBkUX058EA-W4ZkEch=enPsiPioWnkVLK03djuQ9A@mail.gmail.com>
 <alpine.DEB.2.21.1906131822300.1791@nanos.tec.linutronix.de>
 <CAHmME9q1ihF617=Gjw9k9BK7OC9Ghnzfnfi6LfvJ8DG+vrQOqA@mail.gmail.com>
 <alpine.DEB.2.21.1906132136280.1791@nanos.tec.linutronix.de>
 <CAHmME9qa-8J0-x8zmcBrSg_iyPNS02h5CFvhFfXpNth60OQsBg@mail.gmail.com> <alpine.DEB.2.21.1906141131570.1722@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906141131570.1722@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 14 Jun 2019 11:56:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9r7EX6g-r=qB=jRCPhKKTDXVt4PMsm0xF0o26qwdP8=4A@mail.gmail.com>
Message-ID: <CAHmME9r7EX6g-r=qB=jRCPhKKTDXVt4PMsm0xF0o26qwdP8=4A@mail.gmail.com>
Subject: Re: infinite loop in read_hpet from ktime_get_boot_fast_ns
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        Waiman Long <longman@redhat.com>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jun 14, 2019 at 11:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> jiffies64 uses a seqcount on 32bit as well.

Right, but not 64-bit, which is some sort of improvement I suppose.

> Hrm, I'm not a great fan of these shortcuts which cut corners based on
> 'somewhat rarely, so it should not matter'. Should not matter always
> strikes back at some point. :)

What's the actual rare event you have in mind? That on 32-bits, only
half of the value is updated while resuming from sleep? But isn't
there already a race in that case? Namely, either the boot offset is
never queried until the system has fully resumed (safe), or there's
actually some overlap, where the boot offset is queried on resumption
before it's updated. In the former case, a race isn't possible because
of other locking. In the latter case, there's already a race
contingent on the same instructions executing that's way worse. So I
wonder if this is in the category of "hasn't ever mattered" rather
than "should not matter".

> So what you are looking for is jiffies based on boot time?

Right. Just sent a patch.

Jason
