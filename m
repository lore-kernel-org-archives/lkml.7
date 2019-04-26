Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F80BC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA03206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MSMGsljH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfDZFu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:50:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38548 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfDZFuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:50:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so1772115ljg.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNpC31CjPVPMt4LyUXBuFChEyLXh60VsFc6V2/expr4=;
        b=MSMGsljHd6soZ9TxJZ9DKZWP547y3KOJw6IxtwJSpBG3++X/2b434dVXnSzj9uhhxw
         beW/L0AEfvqz0mt8VnDkhJxseKqdxG42Z6q9t1XhU/Ijj2t8M67ZN8/dY7APQnTK/blh
         FUbXRx/IZLCCdgv0lFyLsmVzfYEzmCTGcsPqY9iMssE9Pwt2NVqsMoGuHRzuL4CmJLNM
         JpA4gnwFuxnuDFaFF+0Vb07cc/PMp3HGd3uDzd52bXbw0Q535BlOeB0IzrAJ/nmeTJRE
         +hpryQf6NjX2Dnc6VNvwerZYV7N/g11En390+RbKHY/Bd+a7V/l8KQvlf6aURI7nZzkH
         pT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNpC31CjPVPMt4LyUXBuFChEyLXh60VsFc6V2/expr4=;
        b=SS9h+pK/0d+AoqQ4rFtO39oegvrwetinF+nJsmlI4DzHaSRCZNswaNSCL7qtbomlLR
         DkVLhwl/np0RCRQpblCixG0VfZm73RYRJFrzGbuq2PwM9J+ZOkyLYQVegxNxyi2KgnVd
         1vGamAuGovBv6Kd9BXoUSxWZ6y5Qk6D00UUz43vSL0526ieI9I1/PbnPEOwnbBJsQt4O
         WgPBsrhia3rZ6GYpaPVbERRAX3cgqBdcWwunSFARzBrG1v+RGXx/2PMcURp+HgaHaX1q
         iM0li57WvZeT3drr0YadPX5GNBGBhI9THGGjCS8wf0txzPnNii2tvdOH1Nw4eZ7JAH4D
         tPYA==
X-Gm-Message-State: APjAAAW6qqWULzgQCSiJoEZi/T89tFozOZhMoJYqUgVeu0iR2mo2Mezb
        ndgfMe2F3F5AemZ0y7JwnrMhkeSbp1ktVPVwN6YP5Q==
X-Google-Smtp-Source: APXvYqzD2fg8HY9Ym+sEq9Cijb2pl6+57V2fxKRIECJiXoeIcf6Prr49EDXjBQm9e8693Fbeb85Vu0NYfV1nSWoy/T4=
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr21952024lji.127.1556257853715;
 Thu, 25 Apr 2019 22:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com> <20190425101318.GA8469@e107155-lin>
In-Reply-To: <20190425101318.GA8469@e107155-lin>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Fri, 26 Apr 2019 11:20:17 +0530
Message-ID: <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Add DT documentation for SiFive L2 Cache Controller
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        mark.rutland@arm.com, robh+dt@kernel.org,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 3:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> > Add device tree bindings for SiFive FU540 L2 cache controller driver
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > new file mode 100644
> > index 0000000..15132e2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > @@ -0,0 +1,53 @@
> > +SiFive L2 Cache Controller
> > +--------------------------
> > +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > +acts as directory-based coherency manager.
> > +
> > +Required Properties:
> > +--------------------
> > +- compatible: Should be "sifive,fu540-c000-ccache"
> > +
> > +- cache-block-size: Specifies the block size in bytes of the cache
> > +
> > +- cache-level: Should be set to 2 for a level 2 cache
> > +
> > +- cache-sets: Specifies the number of associativity sets of the cache
> > +
> > +- cache-size: Specifies the size in bytes of the cache
> > +
> > +- cache-unified: Specifies the cache is a unified cache
> > +
> > +- interrupt-parent: Must be core interrupt controller
> > +
> > +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> > +
> > +- reg: Physical base address and size of L2 cache controller registers map
> > +
> > +- reg-names: Should be "control"
> > +
>
> It would be good if you mark the properties that are present in DT
> specification and those that are added for sifive,fu540-c000-ccache

I believe there isn't any property which is added explicitly for
sifive,fu540-c000-ccache.

> explicitly. Also I assume you can retain the stardard "cache" compatible
> in addition to above. I am interested to see if the cacheinfo infrastructure
> can be used without any issues.

Yes, I will add the "cache" string to the compatible property.

>
> --
> Regards,
> Sudeep

Thanks for your comments.
- Yash
