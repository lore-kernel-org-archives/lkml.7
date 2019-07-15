Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D3BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27A2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563228750;
	bh=PUoEab0PBi9AGj4YElM+ylbPFSQuofy9Hd/t5Q0c9nY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VWkKXPJHUn4mO+v+OH5KbTEeNXbMzha3YqUTrV7IngOOa+qg9RbOY7+sy+suE1BDy
	 wDXJZriGe+s1yQZAYpOPp4WXWtDlKJONpPWVY7i4eYsayOWJlo4eG5N8i3N+1wHIHE
	 rUuANd722li8K1kIXa3YxGhywAyEmfsGOBzmN84I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfGOWM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbfGOWM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:12:28 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2652145D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563228748;
        bh=PUoEab0PBi9AGj4YElM+ylbPFSQuofy9Hd/t5Q0c9nY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qf8u5c0mYyoKKQZ2I2MhlYWzAHEb5r9v2E3yPTRR3i86MfB0pQR73zOF/6fjgG/Tu
         LPlD9QU4JEqRGNsXwTLAPKWwFz5zCCmnSMgYGHyWK+c5Hfw74uimwuqh/S7eQpQ2hq
         rsGWolEf6zWYHn+RB0gtIa5JgRz3Hv6klHnFN2wg=
Received: by mail-wr1-f53.google.com with SMTP id g17so18721917wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 15:12:27 -0700 (PDT)
X-Gm-Message-State: APjAAAX0a0+W8S9vWUD/H6x0NPEnpJwciSkrEwWHpr1xq8tD4HF1ZrPz
        lESBc852dLOkLGwHqHg2fQGzYfd1ZSVDHJHN1ONYkw==
X-Google-Smtp-Source: APXvYqxCtsgfLm/c7HK7QHWZtA4PiMY03iD7xSOA1kDFDnYFiP35MdU4eWWOggovKbzPsD7pNymMW5kC/yExHrE2F6c=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr29201839wrm.265.1563228746444;
 Mon, 15 Jul 2019 15:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFULd4b=5-=WfF9OPCX+H9VDnsgbN7OBFj-XP=MZ0QqF5WpvQA@mail.gmail.com>
 <8736j7gsza.fsf@linux.intel.com> <alpine.DEB.2.21.1907152033020.1767@nanos.tec.linutronix.de>
 <CAFULd4bcB8tsgZuxZJm_ksp5zyDQXjO=v_Ov622Bmhx=fr7KuA@mail.gmail.com>
 <alpine.DEB.2.21.1907152129350.1767@nanos.tec.linutronix.de> <20190715193836.GF32439@tassilo.jf.intel.com>
In-Reply-To: <20190715193836.GF32439@tassilo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jul 2019 15:12:15 -0700
X-Gmail-Original-Message-ID: <CALCETrVonxn6tDkxZnbetM9W4Uxxm7-M-tv1e7YsieX3U5OBKA@mail.gmail.com>
Message-ID: <CALCETrVonxn6tDkxZnbetM9W4Uxxm7-M-tv1e7YsieX3U5OBKA@mail.gmail.com>
Subject: Re: [RFC PATCH, x86]: Disable CPA cache flush for selfsnoop targets
To:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 12:38 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> >
> > That does not answer the question whether it's worthwhile to do that.
>
> It's likely worthwhile for (Intel integrated) graphics.
>
> There was also a recent issue with 3dxp/dax, which uses ioremap in some
> cases.
>


FWIW, I applied this simpler patch:

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6a9a77a403c9..a933f99b176a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1729,6 +1729,7 @@ static int change_page_attr_set_clr(unsigned
long *addr, int numpages,
         * attributes:
         */
        cache = !!pgprot2cachemode(mask_set);
+       WARN_ON(cache);

        /*
         * On error; flush everything to be sure.

and booted a VM, including loading a module.  The warning did not
fire.  For the most part, we use PAT for things like ioremap_wc(), but
there's no flush, since there's no preexisting mapping at all.

I haven't tested on a real kernel with i915.  Does i915 really hit
this code path?  Does it happen more than once or twice at boot?

The only case I can think of where this would really matter is DAX, if
anyone uses WT for DAX.
