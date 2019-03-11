Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC49214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dfus4mt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCKPhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:37:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34614 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfCKPhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:37:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id g16so3990558oib.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0nwzrNUkZdLhL4GU/3no0VIgP0MMMf4JZZpBu04oIkM=;
        b=dfus4mt55MPaTu+8O+JGITBbo/hAy7cBajAyCQ3rVyNtPAOov7e0i5ZHB9hEdPracO
         CmgSLLK8qxK+IDgPco+656DoVH9BWmCyTGeqVQEb+PYVuDPPu1zqt90G/qC2vO4NTnGy
         SWVz5k3AEvTVMNm7JN8VlvgZ7+V65sX55gltafBgJlONegL7ycEzr6LFYKQs1xwSHzY+
         12TaAuixNwXCjWHaOZ0nVE5EOM/uSP1pxD68fn/8MsWaOUfTvGabmb/bI8TR2bepkBJm
         r8jnWq9IT6ONmId53iHbT7jTqqtlLRdh2MgO1o56fCNG1Q0hpN6+fuCJBtVKdcR5XuX3
         0Brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0nwzrNUkZdLhL4GU/3no0VIgP0MMMf4JZZpBu04oIkM=;
        b=A46e1xANFgbhuC7KJXYK6xZJ5szy2VCbloDJF3E+GQYlUaPBEyoiHPbpsNuoMjrxhW
         52SRKfpdf9sOURYDr+sQ1DkZtcze4zLz2F+1PGSCGNyrYfeKppMIChjzmEK/hK+50BRk
         IbBiEy9xK83LodUNI04dlsef3Ht/7zzqnfZC9PzcB2eBf/bzIl8GRKWx35Yt5YusHetQ
         +FiMPkMlUmOXzS+qhBjlbeHqzcg/M0VorpJUo6/sVIxYU0plTYeSk3flNWjmPnXm6oWZ
         hAKzNMuz/7ojBNq22QQNd/OPTuDjFThuuBP+w2PixdRCQHmnMXSLc2gOD9BSmiNA5Pu9
         cYsw==
X-Gm-Message-State: APjAAAWl1tJnaWVNHcxyFoDsGXq9fxlVT9MMah34d8zO8bBC88gcdmA+
        EhmvYufKLZ6vflublRz+Ot8kSObUngcibIbnrtEVYA==
X-Google-Smtp-Source: APXvYqwUzTMumUJkRcDKG6xtSQmWo4U+Bj6Wqtwauep26jP3J3afdhjk6Grvu3NaAT1z/S6zquFp/9jlKhkG4wekzyk=
X-Received: by 2002:aca:c3cb:: with SMTP id t194mr200300oif.70.1552318651813;
 Mon, 11 Mar 2019 08:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com> <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
In-Reply-To: <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 11 Mar 2019 08:37:19 -0700
Message-ID: <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2019 at 5:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Mar 10, 2019 at 4:54 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Unfortunately this particular b0rkage is not constrained to nvmem.
> > I.e. there's nothing specific about nvmem requiring mc-safe memory
> > copy, it's a cpu problem consuming any poison regardless of
> > source-media-type with "rep; movs".
>
> So why is it sold and used for the nvdimm pmem driver?
>
> People told me it was a big deal and machines died.
>
> You can't suddenly change the story just because you want to expose it
> to user space.
>
> You can't have it both ways. Either nvdimms have more likelihood of,
> and problems with, machine checks, or it doesn't.
>
> The end result is the same: if intel believes the kernel needs to
> treat nvdimms specially, then we're sure as hell not exposing those
> snowflakes to user space.
>
> And if intel *doesn't* believe that, then we're removing the mcsafe_* functions.
>
> There's no "oh, it's safe to show to user space, but the kernel is
> magical" middle ground here that makes sense to me.

I don't think anyone is trying to claim both ways... the mcsafe memcpy
is not implemented because NVDIMMs have a higher chance of
encountering poison, it's implemented because the pmem driver affords
an error model that just isn't possible in other kernel poison
consumption paths. Even if this issue didn't exist there would still
be a rep; mov based mcsafe memcpy for the driver to use on the
expectation that userspace would prefer EIO to a reboot for
kernel-space consumed poison.

That said, I agree with the argument that a kernel mcsafe copy is not
sufficient when DAX is there to arrange for the bulk of
memory-mapped-I/O to be issued from userspace.

Another feature the userspace tooling can support for the PMEM as RAM
case is the ability to complete an Address Range Scrub of the range
before it is added to the core-mm. I.e at least ensure that previously
encountered poison is eliminated. The driver can also publish an
attribute to indicate when rep; mov is recoverable, and gate the
hotplug policy on the result. In my opinion a positive indicator of
the cpu's ability to recover rep; mov exceptions is a gap that needs
addressing.
