Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B81AC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6036820835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 04:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BKJ/oB49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfD3EVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 00:21:25 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43405 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3EVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 00:21:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id t1so1310860lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 21:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8t58pyvZxW1Md6PX1g2Ns+VeO6t+qdcIVL3s1azo1PA=;
        b=BKJ/oB49fE/XRK+Gh8TN/iWBL1nKOjQ+kW/y7SPwIp8O0ur5ZqCpBg2KebAc8tEjp5
         1DFxABlW/D3hIquSYlN0XsJIdXvdlIlPgHgcctMTv2rltVqQhv/QKVbNOS71B+FNtPaY
         vgqM84YW0qKTBXqO8/e7JbBQKE79/FRH1QoqUdyfzasCIFBUTMPyOXWiZy3Sqj7+MuHf
         2aiSxx3hTZ65PvE0SPp82BcS80Zuq2fglWZ3R83rAlu8w+dVaYN1vleF2cRwvksV6qwS
         kl8PKsVWSFnLTA71uFJQo8Nz66wBTmsC6pg+ZAzjw61P9fyfSlG/mdkVHp9fr8DzjspI
         XXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8t58pyvZxW1Md6PX1g2Ns+VeO6t+qdcIVL3s1azo1PA=;
        b=Ivig0MHIfm3Dtzw89zGCO4HeNTgIkFjdMLm6jesvpi8GH5BBENF5f3ppsiMjPqOyxv
         p65ucNyPtKJ7XOimF6bF8Zi5gYRwUujnguqGgktccdvC467okQJphO8KOHeDk5Ket3Pd
         XKGD+9EbCjsdEbZGsmLsC6HUDhY3TizIDxOhZwrQSrLnJtauuMuF8P3/6BWHiMYgLrvH
         wwzoWwJoN4mnpQFJ3KjiHFbI7zH+G8mZoBixZQ4hRObboyQsiFCoJ3EQ+UM7v8ybq1Uq
         2NsrNz+Qiezw2uFFYj1i66r7Z044wN42BfvfbC/UurcJaVtX+0H+w5Sv91yke71JgEQH
         J0Ag==
X-Gm-Message-State: APjAAAUaGz/BjWUu/k0MHoTW8LiXKr4zd6IJj9otnoVzOg9QMz+SE10J
        ZyysOT9DV82S0nuA46V1KPSfh9pK3EP8zaE7ZzH4iA==
X-Google-Smtp-Source: APXvYqzkQQWeXalbI6bQvrte/IcR7hF54ikPQKnx35AOhJAFG3ySKNN1bIXiA6KbwMDF6/hcnNfUD2MhHS2jZCl9Ysk=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr470763ljj.180.1556598082317;
 Mon, 29 Apr 2019 21:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <1556171696-7741-1-git-send-email-yash.shah@sifive.com>
 <1556171696-7741-2-git-send-email-yash.shah@sifive.com> <20190425101318.GA8469@e107155-lin>
 <CAJ2_jOEBqBnorz9PcQp72Jjju9RX_P8mU=Gq+0xCCcWsBiJksw@mail.gmail.com> <20190426093358.GA28309@e107155-lin>
In-Reply-To: <20190426093358.GA28309@e107155-lin>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 30 Apr 2019 09:50:45 +0530
Message-ID: <CAJ2_jOEoD=Njp+L+H=jG59mA-j9SnwzyNmz7ECogWmbvei_f5Q@mail.gmail.com>
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

On Fri, Apr 26, 2019 at 3:04 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Apr 26, 2019 at 11:20:17AM +0530, Yash Shah wrote:
> > On Thu, Apr 25, 2019 at 3:43 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Apr 25, 2019 at 11:24:55AM +0530, Yash Shah wrote:
> > > > Add device tree bindings for SiFive FU540 L2 cache controller driver
> > > >
> > > > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > > > ---
> > > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 53 ++++++++++++++++++++++
> > > >  1 file changed, 53 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > new file mode 100644
> > > > index 0000000..15132e2
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > > @@ -0,0 +1,53 @@
> > > > +SiFive L2 Cache Controller
> > > > +--------------------------
> > > > +The SiFive Level 2 Cache Controller is used to provide access to fast copies
> > > > +of memory for masters in a Core Complex. The Level 2 Cache Controller also
> > > > +acts as directory-based coherency manager.
> > > > +
> > > > +Required Properties:
> > > > +--------------------
> > > > +- compatible: Should be "sifive,fu540-c000-ccache"
> > > > +
> > > > +- cache-block-size: Specifies the block size in bytes of the cache
> > > > +
> > > > +- cache-level: Should be set to 2 for a level 2 cache
> > > > +
> > > > +- cache-sets: Specifies the number of associativity sets of the cache
> > > > +
> > > > +- cache-size: Specifies the size in bytes of the cache
> > > > +
> > > > +- cache-unified: Specifies the cache is a unified cache
> > > > +
> > > > +- interrupt-parent: Must be core interrupt controller
> > > > +
> > > > +- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
> > > > +
> > > > +- reg: Physical base address and size of L2 cache controller registers map
> > > > +
> > > > +- reg-names: Should be "control"
> > > > +
> > >
> > > It would be good if you mark the properties that are present in DT
> > > specification and those that are added for sifive,fu540-c000-ccache
> >
> > I believe there isn't any property which is added explicitly for
> > sifive,fu540-c000-ccache.
> >
>
> reg and interrupts are generally optional for normal cache and may be
> required for cache controller like this. DT specification[1] covers
> only caches and not cache controllers.

Are you suggesting something like this:

Required Properties:
--------------------
Standard Properties:
- compatible: Should be "sifive,<chip>-ccache"
  Supported compatible strings are:
  "sifive,fu540-c000-ccache" and "sifive,fu740-c000-ccache"

- cache-block-size: Specifies the block size in bytes of the cache

- cache-level: Should be set to 2 for a level 2 cache

- cache-sets: Specifies the number of associativity sets of the cache

- cache-size: Specifies the size in bytes of the cache

- cache-unified: Specifies the cache is a unified cache

Non-Standard Properties:
- interrupt-parent: Must be core interrupt controller

- interrupts: Must contain 3 entries for FU540 (DirError, DataError and
  DataFail signals) or 4 entries for other chips (DirError, DirFail, DataError,
  DataFail signals)

- reg: Physical base address and size of L2 cache controller registers map

- reg-names: Should be "control"

- Yash
>
> --
> Regards,
> Sudeep
>
> [1] https://github.com/devicetree-org/devicetree-specification/releases/download/v0.2/devicetree-specification-v0.2.pdf
