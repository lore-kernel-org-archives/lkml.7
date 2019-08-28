Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE661C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ACD205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hfh+VP1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfH1PSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:18:12 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:44307 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1PSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:18:09 -0400
Received: by mail-io1-f48.google.com with SMTP id j4so201097iog.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fXLk/4LcGknMhrbu5FAQEDnDPRe9WU+lfaepUFPcE78=;
        b=Hfh+VP1dMxfa5IDIYlJU3/tHSesxEp9B5KRCm17hd1SsoOWEvYmC3jzMmGecdEyM8g
         NPYkbXRNZs40J4OEMYyZVCf4KoiOZ7+b/dxB0rTOgQD+whPNl70/ngALYMpKbO37T29m
         HVrRFq8k4PgRINKNis544HdIyEuna6v1Qj3ENNCDNhqByint3a5W7t4M0niGwqh5eqPM
         o9LXPRe+UZEmxcuaV45fNazSlr8WVJ7MU9dizNk+PzLMabLnxLJkWehNqyHoV3vfk/7f
         A527D8dNq0YXDyaz0j1pG8Jc7ILfSIoPAec+8vDzq6aMHVbtzEWwhPy332exGl+Dh08y
         RYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXLk/4LcGknMhrbu5FAQEDnDPRe9WU+lfaepUFPcE78=;
        b=GENCU8waR7B+22halwaFp/1b978LjEhPx7+IaTXobsaQu6Ca96cPA9TebNRqwfHoxT
         /Hx4BCUwBfbk/ZxzSU/hhiaY/XB2UzV+H29O27GFaQ0lz+zrVjbYZ8I6v0jaSt0nFpXf
         Ff04XH0NyOo+DYc7HoKly8daSNeFaZdHEALVmXVZ1v51y15xg3rrAtAXbg+GfOwtRwWS
         qGkRgKZcv3QDPOyFq0jqNd8RVs39Sqkrfp+oUVDOVIWP94ewe+LKUg7zigjUovBLn0t9
         mDwn0fWKdeMZtDDJyv/L8e1uw0kXVGPTRvo7HdF4Cg3udopzgKq9pjTiFWSdzvrJDRqO
         SfCg==
X-Gm-Message-State: APjAAAWrdsMckjX7RDgr+tOPi8mT+P5OFI1r5Vn0jnF+WUvK0pR9AF4J
        qozbydjQRyqRGXhjpRvks9lLI0HjevrjjmoKtg==
X-Google-Smtp-Source: APXvYqw2KAW46WErJY2AYCpxTvxED2TQsKnfmP1jdF4AyfzZpEAdrw5NxbPIGr9RHCgYTJsxKX9ov5u1k5FWpjXjQ8U=
X-Received: by 2002:a02:8409:: with SMTP id k9mr4929525jah.122.1567005488253;
 Wed, 28 Aug 2019 08:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <2e70a6e2-23a6-dbf2-4911-1e382469c9cb@gmail.com>
 <CAM6Zs0WqdfCv=EGi5qU5w6Dqh2NHQF2y_uF4i57Z9v=NoHHwPA@mail.gmail.com>
 <CAM6Zs0X_TpRPSR9XRikkYxHSA4vZsFr7WH_pEyq6npNjobdRVw@mail.gmail.com>
 <11dc5f68-b253-913a-4219-f6780c8967a0@intel.com> <594c424c-2474-5e2c-9ede-7e7dc68282d5@gmail.com>
 <CAM6Zs0XzBvoNFa5CSAaEEBBJHcxvguZFRqVOVdr5+JDE=PVGVw@mail.gmail.com>
 <alpine.DEB.2.21.1908100811160.7324@nanos.tec.linutronix.de>
 <fbcf3c93-3868-2b0e-b831-43fa68c48d6c@gmail.com> <CAM6Zs0WLQG90EQ+38NE1Nv8bcnbxW8wO4oEfxSuu4dLhfT1YZA@mail.gmail.com>
 <alpine.DEB.2.21.1908121917460.7324@nanos.tec.linutronix.de>
 <CAM6Zs0UoHZyBkY9-RLdO-W+u09RZPbzq-A-K01sHyRkfoEiYTA@mail.gmail.com>
 <alpine.DEB.2.21.1908150924210.2241@nanos.tec.linutronix.de>
 <CAM6Zs0XE8GW-P4Q3YM3KZo-1L+g2wt5QRN+JM3_m1xuwgFDVXQ@mail.gmail.com> <alpine.DEB.2.21.1908212313340.1983@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908212313340.1983@nanos.tec.linutronix.de>
From:   Woody Suwalski <terraluna977@gmail.com>
Date:   Wed, 28 Aug 2019 10:17:56 -0500
Message-ID: <CAM6Zs0VT4hnLu6YAutW8at1-W7DWN990atqdxP2Wv9MwjGG5Dg@mail.gmail.com>
Subject: Re: Kernel 5.3.x, 5.2.2+: VMware player suspend on 64/32 bit guests
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to "bisect" the config changes, and builds working/not
working between
 rc3-rc4-rc5, and come out with the same frustrating result, that
building a "clean" kernel is not producing the same behavoir as
incremental building while bisecting. For some reason even after
getting to the same config step-by-step is not making the kernel work,
similar with actual bisecting.
So for now I simply use my patch to do the timeout.
Thinking of it - should I submit a patch like that to you for
consideration? It may be usefull for other users with the suspend
problems...

Thanks, Woody

On Wed, Aug 21, 2019 at 4:15 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Tue, 20 Aug 2019, Woody Suwalski wrote:
> > On Thu, Aug 15, 2019 at 2:37 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Tue, 13 Aug 2019, Woody Suwalski wrote:
> > > > On Mon, Aug 12, 2019 at 1:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > The ACPI handler is not the culprit. This is either an emulation bug or
> > > > > something really strange. Can you please use a WARN_ON() if the loop is
> > > > > exited via the timeout so we can see in which context this happens?
> > > > >
> > > >
> > > > B. On 5.3-rc4 problem is gone. I guess it is overall good sign.
> > >
> > > Now the interesting question is what changed between 5.3-rc3 and
> > > 5.3-rc4. Could you please try to bisect that?
> > >
> >
> > Apparently I can not, and frustrated'ingly do not understand it.
> > Tried twice, and every time I get it broken to the end of bisection -
> > so the fixed-in-5.3-rc4 theory falls apart. Yet if I build cleanly
> > 5.3-rc4 or -rc5, it works OK.
> > Then on a 32 bit system - I first tried with a scaled-down kernel
> > (just with the drivers needed in the VM). That one is never working,
> > even in rc5. Yet the "full" kernel works OK. So now there is a config
> > issue variation on top of other problem?
>
> Looks like and it would be good to know which knob it is.
>
> Can you send me the two configs please?
>
> > > dpm_suspend_noirq() is called with all CPUs online and interrupts
> > > enabled. In that case an interrupt pending in IRR does not make any sense
> > > at all. Confused.
> > >
> > For now I use a timeout counter patch - and it is showing 100% irq9
> > jammed and needing rescue. And I am even more confused...
>
> You're not alone, if that gives you a bit of comfort :)
>
> Thanks,
>
>         tglx
