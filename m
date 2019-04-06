Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC2C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2FD213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3Il4whT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfDFTLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:11:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33323 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfDFTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:11:40 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so4889425pgh.0;
        Sat, 06 Apr 2019 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8U7TO11hrin3ZlLHK08vql9UURN0Wwx8gVI+6XXGJVw=;
        b=a3Il4whTRmVFTNqgm3TPEYNspxlqnuZBsL/u8oqLUVhBsVC6Z0JgEXKHStTjGypuLu
         K2vAibsgv6EW5r1wftz3nxFdCZ7Ga9WVobrokvs6y7alVjMlawaUGVqLDJm599c/avHe
         7+RimrlLkS2u2awGlTQM3G6gG6RDaeULPWwMieTD2DwYBHBiKLfsxI3640AYYkrOPHsI
         wGDZ8Sck0p0WoMxxT4CzgQGIhsR0Y49sdEYnOMrWquo+Rw74tG+BdNjBmxjKpHYYQNjg
         xh/eCiqFYJ9EE7iBYUJo0srdQSC2j9TRi0YGL31qm9v7++C64gCHotZYER9o4UD85yCA
         t9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8U7TO11hrin3ZlLHK08vql9UURN0Wwx8gVI+6XXGJVw=;
        b=l818BUJb3CHgrSttab0Icvh6RoDWdjviPPc88vrDn/nTYWxBUEU52NSVYA7B+8rlCt
         YoPk+gul+bExiKPGlY0JndbXKrXvwBc9Rl4T4SyF0dYp3Q4fNotiaXeeAxRFv/zG/rWL
         fp5v2CtPHnLrjj3XWpeilorT+RBfr/DJGsDyc96YOroRSZ10d2rLAa2ocsB6z1lu6ZMN
         Cp9BiG/0MpKdgB30xx+fTxWCFFEFw7H2etPJp/KrgPE65kP2G4m7ua74lZp9dgun/y7d
         n3RjdMV/MgOuqQApJ86J1AhlKA9GZgG6B4kTzfwvd0Rm0uPys/QaBezuZ8RCPjIcucdu
         04Ng==
X-Gm-Message-State: APjAAAUHA9/rnjxlfGrojH0nAP0wT39DZqhOTCJInvJZmXkT2xFHE5/y
        hhHkdceqETjkDSl83uiFbixF8a91RZ5UmfgcOug=
X-Google-Smtp-Source: APXvYqwbzyBZgtVEtttjyJT8JcAYQDiWI9r4LOOgY4gV/MsIrgp1uujHJVCjNd5/Ma7na8zTYqXVbXhC6cFPF//Mq1A=
X-Received: by 2002:a62:2587:: with SMTP id l129mr20318896pfl.151.1554577900133;
 Sat, 06 Apr 2019 12:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190401180505.6621-1-evgreen@chromium.org> <20190405071455.GA30194@raj-desk2.iind.intel.com>
 <CAE=gft7r+0s6M2KZLdcp33xvnxjX2Kqyg-vVk5dVVoC5PUOGqw@mail.gmail.com>
In-Reply-To: <CAE=gft7r+0s6M2KZLdcp33xvnxjX2Kqyg-vVk5dVVoC5PUOGqw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Apr 2019 22:11:29 +0300
Message-ID: <CAHp75VdBwUYu7FudBUUeo5cU4RHDk8hey2y-X09-GaskZXU+=Q@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Report slp_s0 residency range
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 8:52 PM Evan Green <evgreen@chromium.org> wrote:
> On Fri, Apr 5, 2019 at 12:28 AM Rajneesh Bhardwaj
> <rajneesh.bhardwaj@intel.com> wrote:
> > On Mon, Apr 01, 2019 at 11:05:04AM -0700, Evan Green wrote:

> > This register is a 32 bit register untill ICL generation and a recent patch
> > from Rajat fixed the overflow https://patchwork.kernel.org/patch/10816103/
> > already so i am not sure how this will help userspace. I think the userspace
> > can still take care of any overflow concerns based on the information
> > available about this register in EDS so i feel exposing a new debugfs entry
> > just for the sake of knowing range is probably not needed.
>
> So you don't anticipate reusing this driver for other models where the
> factor of 100 might change, or the counter might be a different width?
> We can hardcode the multiply in usermode in order to detect when we've
> exceeded the 4.9 day rollover range, but it seemed brittle, and would
> break if this hardware implementation detail ever changed.

No user space component should ever rely on debugfs interface.

-- 
With Best Regards,
Andy Shevchenko
