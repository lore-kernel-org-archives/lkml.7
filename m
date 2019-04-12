Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A800C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2983B2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 03:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+Dvpf57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLDQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 23:16:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36347 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfDLDQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 23:16:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id z5so4423480pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 20:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=lM6txoMFsmyaW/kqPVIC4369gjsMwMQkUKEVFL/U0uQ=;
        b=C+Dvpf57Q8mTkGzKGmmrv2OUDgeyhW/WvYUZ56jZxQnJLI++eVUXsovH46Q+DxG+d1
         oGlZccBFOF3mh7RI32eHGc7Jend6qtvvGeagv8opQAziaBFttRUAmB1gX/hWzy8eO1NK
         Nd4ZxU9B4WlOWt3oEErb4DsMHWqMfxP+uaBjB49KoIfwyZZ7ol4td6njZYxVZwV0I7YX
         8V9/AElCTfqJeMhSOBrC5jJq/NJgD5aq5NqXuG9NJUj5pq26EglPGodvtBWhXJ5aTNOu
         oF3wEVjg2AUYf4YNRjG1uEP+i/q/BD79T8DEIXJDms4CKDmwFCqR4WXvN+l8x33WT2h/
         lG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=lM6txoMFsmyaW/kqPVIC4369gjsMwMQkUKEVFL/U0uQ=;
        b=sADNty8VO4PXrs3rxaSh5AxOa6NhqFE5ncSGW5s9IuB/njr8z3DMA2LGWRLkNNJKj7
         BLdBwQ2GAdJqjmaUmtxQmzp0bE0fW64ceEvrdV2R59PalNoBVk+6EDbH/aVaZsl3EGZb
         cC1/WP7mfC8cbDHoLvZvMW81dhGFJ3OKT9YNtN3FviOY5rDoQTO09w42KbB8O4j8Lg2s
         Qsfoa0KBPwT4EniwcpY9xfrYqLy8Rww6pp89ldrNN1ypeHpg7nQ54wlaltFsbxZrVeby
         qmoajPOJpxbtbXi7P990+RTiMEA0ztFQRD/necISNuDnigCgiHdKJHA872lceT8PRL1e
         QHGg==
X-Gm-Message-State: APjAAAXXz/O/QHWy4Jo2izmly17/F3RbKTaNLvocO6bRxYii21bv5bX1
        XGQaoQGmM2AfM10U3YlPakY=
X-Google-Smtp-Source: APXvYqwQq2Kn04Pnf1gzrrceIE/nXXxoMYTvvvQgK+Ye6NU5Gbc6WBYN9LXCqgku9GGGk/wXlwGJ0g==
X-Received: by 2002:a63:78a:: with SMTP id 132mr48119015pgh.196.1555038971097;
        Thu, 11 Apr 2019 20:16:11 -0700 (PDT)
Received: from localhost (115-64-237-195.tpgi.com.au. [115.64.237.195])
        by smtp.gmail.com with ESMTPSA id p7sm19601229pgb.58.2019.04.11.20.16.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 20:16:10 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:16:01 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
To:     paulmck@linux.ibm.com
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20190404120704.18479-1-npiggin@gmail.com>
        <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
        <1554393113.wbjxx9ccdx.astroid@bobo.none>
        <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
        <1554800737.v126tflazd.astroid@bobo.none>
        <20190411154239.GA29448@linux.ibm.com>
In-Reply-To: <20190411154239.GA29448@linux.ibm.com>
MIME-Version: 1.0
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
Message-Id: <1555037352.52b4w2o4bf.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney's on April 12, 2019 1:42 am:
> On Tue, Apr 09, 2019 at 07:21:54PM +1000, Nicholas Piggin wrote:
>> Thomas Gleixner's on April 6, 2019 3:54 am:
>> > On Fri, 5 Apr 2019, Nicholas Piggin wrote:
>> >> Thomas Gleixner's on April 5, 2019 12:36 am:
>> >> > On Thu, 4 Apr 2019, Nicholas Piggin wrote:
>> >> >=20
>> >> >> I've been looking at ways to fix suspend breakage with CPU0 as a
>> >> >> nohz CPU. I started looking at various things like allowing CPU0
>> >> >> to take over do_timer again temporarily or allowing nohz full
>> >> >> to be stopped at runtime (that is quite a significant change for
>> >> >> little real benefit). The problem then was having the housekeeping
>> >> >> CPU go offline.
>> >> >>=20
>> >> >> So I decided to try just allowing the freeze to occur on non-zero
>> >> >> CPU. This seems to be a lot simpler to get working, but I guess
>> >> >> some archs won't be able to deal with this? Would it be okay to
>> >> >> make it opt-in per arch?
>> >> >=20
>> >> > It needs to be opt in. x86 will fall on its nose with that.
>> >>=20
>> >> Okay I can add that.
>> >>=20
>> >> > Now the real interesting question is WHY do we need that at all?
>> >>=20
>> >> Why full nohz for CPU0? Basically this is how their job system was
>> >> written and used, testing nohz full was a change that came much later=
=20
>> >> as an optimisation.
>> >>=20
>> >> I don't think there is a fundamental reason an equivalent system
>> >> could not be made that uses a different CPU for housekeeping, but I
>> >> was assured the change would be quite difficult for them.
>> >>=20
>> >> If we can support it, it seems nice if you can take a particular
>> >> configuration and just apply nohz_full to your application processors
>> >> without any other changes.
>> >=20
>> > This wants an explanation in the patches.
>>=20
>> Okay.
>>=20
>> > And patch 4 has in the changelog:
>> >=20
>> >    nohz_full has been successful at significantly reducing jitter for =
a
>> >    large supercomputer customer, but their job control system requires=
 CPU0
>> >    to be for housekeeping.
>> >=20
>> > which just makes me dazed and confused :)
>> >=20
>> > Other than some coherent explanation and making it opt in, I don't thi=
nk
>> > there is a fundamental issue with that.
>>=20
>> I will try to make the changelogs less jibberish then :)
>=20
> Maybe this is all taken care of now, but do the various clocks stay
> synchronized with wall-clock time if all CPUs are in nohz_full mode?
> At one time, at least one CPU needed to keep its scheduler-clock
> interrupt going in order to keep things in sync.

Ah, may not have been clear in the changelog -- the series still=20
requires at least one CPU present at boot time to be a housekeeper=20
that keeps things running. So conceptually this doesn't change=20
anything about runtime behaviour, the main change is the boot-time
handoff from CPU0.

> The ppc timebase register might make it possible to do this without any
> scheduler-clock interrupts, but figured I should check.  ;-)

I dont know all this code too well, but if we really wanted to push=20
things, I think nohz-full could be more aggressive in shutting down=20
the tick and possibly even avoiding a housekeeping CPU completely, but=20
you would have to do that work on user->kernel switch too. Likely the=20
complexity and overhead is not worthwhile.

Other thing is you might be able to avoid the jiffies tick completely
and change jiffies to read from timebase register. Lot of interesting
things we could try.

Thanks,
Nick

=
