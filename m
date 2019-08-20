Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F38C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06EFB22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tk706P5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfHTMes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:34:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45411 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTMer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:34:47 -0400
Received: by mail-io1-f67.google.com with SMTP id t3so11712311ioj.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81olWJ9roiVSRuHP2fqvrmXHfWo10yGJXv+JCQOXliI=;
        b=tk706P5Cou1MizyP1h8CWgCVukuNWhrsgRlX0ez8rnsdPTlZeS+LWQjbIf4IZ9R7pw
         khkHuB5ee96OE/2TZTeos0PboZfPIdzIZZ3P8hJcgYZqyaYw0RSmSzAepK9PQnGRH3yf
         Yj2ZFceVn9+9lALgBcm78yWYXp3pCttCggWKNgkGFPSGd+T3Pn4zW5x2O4zM4DS+CCYh
         5h8eRc4cfFChHe5MI1E12elLQarGr+cyJ6fZQESWX2sfTzVMaFbgHiJMIfIy0VQ0zQgA
         QGPgqONhiJAm8d7q/4UcfFGCYwn+TqnToGeAREr+XiA3bfxuyjLXnfEK5fdKnI9eHtEm
         Fe0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81olWJ9roiVSRuHP2fqvrmXHfWo10yGJXv+JCQOXliI=;
        b=OCvjZSeONPzAjLMXSAOyFla0m3ayoYwDPnG/tNrjqMuzRt6VR6sSTC25z1gWTHL8V3
         oqOKZUa7RharCnb4OU9kz7oEGCXzOKcnUQzM7RY6fciQ1hUZhmZYWBpx8ZeAyCtgatwg
         8NxBqJ1emJT++uMEJgZhkxkVNuS+NPmyDJ1SVLsVFU+VX0ImIUB7TRj/g8DVIpQm70vx
         4Ms6apLmudx+jbFHRRx8Tz+iKH4p4Utvb6gwJniTVbdbJgt0W0EjM/GU92HULcmuLhWM
         +NccNDXYx8lYUtBxYscNvV3EmJvIKxQmgOWnrQACDsBt5aTcXUmqvDva/XVkWZ4wJ7Om
         RPhw==
X-Gm-Message-State: APjAAAVAEMXiKnfi76Y6gB3pMm5re6n4PAWVXwSZovsmdQu5MB17NrQO
        MhFCVbZam+D0vA4wfN72VYVYpIj/E/xdxT2foQ==
X-Google-Smtp-Source: APXvYqymgqWgtRE50NKeUfX7dlt3oD9HgBzMDEMgz+c6OfWLeSqJvmquagFYteTP3RpjM1VPiLEa5SK+XhFB8ewj+sc=
X-Received: by 2002:a02:952d:: with SMTP id y42mr3469605jah.66.1566304486595;
 Tue, 20 Aug 2019 05:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com> <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
 <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com> <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
 <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
 <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com> <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Date:   Tue, 20 Aug 2019 07:34:35 -0500
Message-ID: <CAM6Zs0XE8GW-P4Q3YM3KZo-1L+g2wt5QRN+JM3_m1xuwgFDVXQ@mail.gmail.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 2:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Woody,
>
> On Tue, 13 Aug 2019, Woody Suwalski wrote:
> > On Mon, Aug 12, 2019 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > The ACPI handler is not the culprit. This is either an emulation bug or
> > > something really strange. Can you please use a WARN_ON() if the loop is
> > > exited via the timeout so we can see in which context this happens?
> > >
> >
> > B. On 5.3-rc4 problem is gone. I guess it is overall good sign.
>
> Now the interesting question is what changed between 5.3-rc3 and
> 5.3-rc4. Could you please try to bisect that?
>

Apparently I can not, and frustrated'ingly do not understand it.
Tried twice, and every time I get it broken to the end of bisection -
so the fixed-in-5.3-rc4 theory falls apart. Yet if I build cleanly
5.3-rc4 or -rc5, it works OK.
Then on a 32 bit system - I first tried with a scaled-down kernel
(just with the drivers needed in the VM). That one is never working,
even in rc5. Yet the "full" kernel works OK. So now there is a config
issue variation on top of other problem?

>
> dpm_suspend_noirq() is called with all CPUs online and interrupts
> enabled. In that case an interrupt pending in IRR does not make any sense
> at all. Confused.
>
For now I use a timeout counter patch - and it is showing 100% irq9
jammed and needing rescue. And I am even more confused...

Thanks, Woody
