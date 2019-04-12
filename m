Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA90C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B332184B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 00:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="I0/a8iZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfDLAIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 20:08:14 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52248 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfDLAIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 20:08:13 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so12844979itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C0gl3NUgFQXuG3eu0mpgKkF48V46lmRVT+B0m4qM+es=;
        b=I0/a8iZyEJAc4sPgeuSpnbr1Ns3k3UHMl6WAv5dCgiVO1ryjcxXRmbZdwjdaSdzT8y
         CD+833CoBbEg8198LT8ZEq81PVFv7W+pW3iGp43kSasUq9/AQwUl4Gn6d4tQbdZGeYxU
         r2ocJfMKFYdoMBbAoX86zsdRsQJQjjbV8I1H5XLZFh8ntz+TZnILo5G77IyLQacqaJhL
         fzWSh8GL9c2P4qy4AbTIdvX1bfYzMOCAvsBlMbJWZMQUTZgNYGUH9ZgfccI+dr1lrGov
         nQQUCDc55xv/QIn92Ni6PAl9YnN4JHDj+WMqz2gmlhvbSEPIBFnOSzBNkJcH9Wv3u654
         jjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C0gl3NUgFQXuG3eu0mpgKkF48V46lmRVT+B0m4qM+es=;
        b=NROLfnOi5YDVeSpFldTr1MbqIuqSX5YOnqOqeooR2FXw8CrFByvJNvc18nWegJW9T+
         ON94Qb+wzpUwonwcb0yY9QKl5To2KKApkV+FIEo0dbQnEeLQSKTjZE23GfkpCb5AEZN3
         1iPZqmSSuLmipCNIPqEaB1FHUYg6IAWPlW0FmtdgqJ7w5OMjwADZXGCE0yloE8kfRJ+l
         KuZNWVvTU3lyY+V0ZTeREY7FYkhC7Ttfl+lvLBtOzVKSTJ1687fCGDPvpAKfZNhMIC/B
         /njarxs75Zx/mpbMhXup9oFR0GIbP8+19fJAC/+ycmuU7e6MZP+j/RJODu50KxWpjSN9
         H+rA==
X-Gm-Message-State: APjAAAW4f2nAUncXwRwoemBnqyYCky3EC0dmIQog5IByHziaAeEqZpQR
        DPZwCt1Au34nD8/RkY/CL32v3GHpze0=
X-Google-Smtp-Source: APXvYqyV3gfdu0tWVJVCCP2W9j+aOA//icl4BKPMAsxbDIK05jHZZ4JZ1x5tSenMhakgC5bap85rHg==
X-Received: by 2002:a24:d0d3:: with SMTP id m202mr10686551itg.7.1555027692823;
        Thu, 11 Apr 2019 17:08:12 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id u204sm3378152ita.33.2019.04.11.17.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 17:08:11 -0700 (PDT)
Date:   Thu, 11 Apr 2019 17:08:11 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Paul Walmsley <paul@pwsan.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/6] arch: riscv: add support for building DTB files from
 DT source data
In-Reply-To: <3cf7f2d8-3039-7dd7-e243-77433b1f23a6@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1904111618460.21321@viisi.sifive.com>
References: <20190411084304.5072-2-paul.walmsley@sifive.com> <20190411114616.GA10032@infradead.org> <alpine.DEB.2.21.9999.1904111405470.19990@viisi.sifive.com> <3cf7f2d8-3039-7dd7-e243-77433b1f23a6@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019, Atish Patra wrote:

> On 4/11/19 2:12 PM, Paul Walmsley wrote:
> > On Thu, 11 Apr 2019, Christoph Hellwig wrote:
> > 
> > > On Thu, Apr 11, 2019 at 01:42:59AM -0700, Paul Walmsley wrote:
> > > > Similar to ARM64, add support for building DTB files from DT source
> > > > data for RISC-V boards.
> > > > 
> > > > This patch starts with the infrastructure needed for SiFive boards.
> > > > Boards from other vendors would add support here in a similar form.
> > > 
> > > What do we build it for?  We'd really need something like this:
> > > 
> > > http://git.infradead.org/users/hch/misc.git/commitdiff/d6242aa147baf57e05e2932199c74d8d24b9926e
> > > http://git.infradead.org/users/hch/misc.git/commitdiff/0cd5413c8094ab57b68e0629dacfed695f4c1ef1
> > > 
> > > To actually use the DT files.
> > 
> > Those patches might be useful - I have not reviewed them closely - but
> > they are not necessary.
> > 
> > The FSBL already supplies a DTB to Linux.  I assume the U-boot port works
> > the same way.
> > 
> 
> I am bit confused here. I thought the idea behind putting the the DTS in
> kernel so that Kernel don't need to depend on DT passed from boot loaders.

Some users will want to do that - mostly embedded device integrators and 
kernel developers.  We should definitely support these use-cases.  So the 
basic idea behind Christoph's patch to do that is good (I have not yet 
reviewed the code nor tested it).

In fact, there has been an unofficial patch to do something similar for 
ARM for about a decade now.  But for various reasons, some technical, some 
managerial - it was never merged.  To be clear, I do agree that we should 
merge something like that for RISC-V.

However: the vast majority of users -- even embedded users -- will not use 
a kernel with a bundled DTB.  This is because it irrevocably ties that 
kernel binary to one specific board type.  I hope it is obvious why this 
would be a non-starter for Linux distributions, and, more generally, 
anyone who wants their kernels to be usable on multiple boards.  Those 
distributors would need to ship one kernel binary per board, or bloat 
their kernels with DTBs and come up with some new mechanism to select one.

> Currently, DTB passed from FSBL is modified by OpenSBI/BBL before passing to
> U-Boot or Linux.

This should be avoided whenever possible.  I'd be interested in hearing 
what OpenSBI is doing now to the DTB; perhaps there is a case where it 
makes sense.  But in general, doing this makes development and maintenance 
quite difficult.  Considre that different operating systems that may use 
the same SBI layer may use different DT data formats, or may not even use 
DT at all.  And when the DT data format changes - as is happening now - a 
maintenance hassle is created, since then versions across multiple pieces 
of software may need to be synchronized.  It is also very disconcerting as 
a kernel developer to have multiple pieces of software modifying one's 
DTB.

The DT data is meant to represent hardware fact.  DT is also used to pass 
in some non-hardware-related runtime configuration parameters, via the 
"chosen" node.  But that's about it.  So from that point of view, only the 
first-stage bootloader should be altering the DT data, and only then in 
very minimal ways.

> If Linux kernel can boot from the DTS contained within its source code as is,
> that would be much more helpful.

If you are thinking about embedded system builders, and developers who 
only care about their test kernel being compatible with one board, I agree 
with you for those specific use-cases.  Almost everyone else will pass in 
a separate DTB, specific to the board they are using, from U-Boot or 
Coreboot or GRUB.

> > I haven't switched to U-boot yet for these driver tests, so I 
> > personally have been using the open-source FSBL 
> > (freedom-u540-c000-bootloader) with the following trivial patches 
> > applied:
> > 
> > https://github.com/sifive/freedom-u540-c000-bootloader/tree/dev/paulw/supply-fsbl-dtb-v5.1-rc4
> 
> > The fsbl/ux00_fsbl.dtb file can be symlinked to the kernel DTB output,
> > e.g., ~/linux/arch/riscv/boot/dts/sifive/hifive-unleashed-a00-fu540.dtb.
> 
> This assumes that FSBL has to be rebuilt every time I want to change the DT. I
> was hoping to avoid that.

The FSBL is on its way out.  It is just a short-term workaround until the 
various popular bootloader ports become more stable.  After that happens, 
it's likely that almost no one to use the current SiFive FSBLs.  We plan 
to transition our Freedom-U development environment away from it 
ourselves.

The point of what I wrote to Christoph earlier is simply that everyone is 
already using DTB data that is passed in from an early bootloader, whether 
they realize it or not.  So there is an existence proof that no additional 
patches are needed for the basics to function.  It may not be functioning 
well in some cases, and may need patching; but that is a separate matter.


- Paul
