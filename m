Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C25C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78B4720715
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="UsxjVTvi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfKUA14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:27:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41843 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKUA14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:27:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so1340285oty.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRno2ndEL0aLy2ekCq8SNn5kziBB2zvsTzrFr0XgIgU=;
        b=UsxjVTviHd1kq3bZY0wQXN4tO71PI7wZsg8+pSSo6kwk8/8EHAMXGv9vdcs9hutQlP
         0leGxb9TacCeXprtwZiY3xsNY6gripp3Qc0tIXxhZ03aDz342HV0mW2x1q45x+bl6UWA
         VWJcMEKRUuHcLh1HZqqGctCaPdfbNFp2oLVjWSy0iWOfjwd4XhDxBMIP/lKIc3a7p/fF
         Y9NVorH1XEf/AfhzqEc8Ntbk1sS/Ox85kDbjLyXyR0BZ8Vo/WfNmRdG5MlXpopfqVJ+x
         dF64g8ETXHgomru5gvKmhahhIoBkVD30oGxPHoUxpVLudN14DWdVmlSpXrAs8wQDJWAL
         J9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRno2ndEL0aLy2ekCq8SNn5kziBB2zvsTzrFr0XgIgU=;
        b=Ze7lj6IKP70GIiZBM8In/FtJwskQuSZZdbIN4AIXpcoIh+9dvd1kCGOBnH2hRDEX+T
         LhlihN/1/S8HegniTiorLhesK+XfTWEPQhktS+DUMSXjC6nuRy8qmRPHLVsorTS6XY/7
         KlSV1U5PSJdZNzr9LCBxSCxuVQRUnEn/DOHspeqVaZkbl0QPs0I9iggENq+sSBsiTGTf
         ffWCMWB7ZjgBdrX5WVELWl09MA2UooOyMHJKkr7TgeRFsOS4UavikOCmqYzpFNpOJvU1
         RKAy68KCDlaYL2gx99eb95WOAWgr0t2404ouoOdy7CqWQmCKCzXHQGn90372efO5syXk
         plDw==
X-Gm-Message-State: APjAAAUwsP92VSVcpvmCg5gZrXtDPJFnyhAhKax6oiHQVG1GRCOEgS8M
        8Ppb9Dgfot+eDxdaXa/DXyDiN3sQ0E8EeC4LudZ0BQ==
X-Google-Smtp-Source: APXvYqydVUCALCV2gDjSgpUPjbBj1Jy2nVlG6eMJ9zJZGgKne8uQD9fRLPiO5DU7wqHm7+NmtFxuyY4SSgF+oSAxO8Y=
X-Received: by 2002:a9d:2d89:: with SMTP id g9mr4139129otb.126.1574296075328;
 Wed, 20 Nov 2019 16:27:55 -0800 (PST)
MIME-Version: 1.0
References: <157428480574.36836.14057238306923901253.stgit@djiang5-desk3.ch.intel.com>
 <157428502934.36836.8119026517510193201.stgit@djiang5-desk3.ch.intel.com>
 <20191120215338.GN2634@zn.tnic> <20191120231923.GA32680@agluck-desk2.amr.corp.intel.com>
 <20191120232645.GO2634@zn.tnic>
In-Reply-To: <20191120232645.GO2634@zn.tnic>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 16:27:43 -0800
Message-ID: <CAPcyv4gngO04iWuKu2_DV4_AXw5yssd6njTNKF=eKk+YJw3AfQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/14] x86/asm: add iosubmit_cmds512() based on
 movdir64b CPU instruction
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Jing Lin <jing.lin@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 3:27 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 20, 2019 at 03:19:23PM -0800, Luck, Tony wrote:
> > That's the underlying functionality of the MOVDIR64B instruction. A
> > posted write so no way to know if it succeeded.
>
> So how do you know whether any of the writes went through?

It's identical to the writel() mmio-write to start a SATA command
transfer. The higher level device driver protocol validates that the
command went through, ultimately with a timeout. There's no return
value for iosubmit_cmds512() for the same reason there's no return
value for the other iowrite primitives.
