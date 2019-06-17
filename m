Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA5C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DE20673
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kvgoo1AW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbfFQV7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:59:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34300 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbfFQV7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:59:42 -0400
Received: by mail-ua1-f65.google.com with SMTP id c4so4142692uad.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAhatab0HAVyw+PnT7+3nUVy3uXQEI6O1vd8Cnx2LKk=;
        b=kvgoo1AWJ53ectZxNh7vumo7uHVF3ezzA+dmS6OCiyHy7q38adiyo8Mt48b9s1ecuS
         8vbgSWAHi7F66ZbJb0OnnHkka0SZfIdhx44ptJvkStf7KSPyjOUktnOEWU+P5uVTHP64
         eN+AH0Y198g5GhXwzgWWBTwbfohtVJT/rFQhRmBXLkxVDGhPtni3s7vOLmfSoppPuiMS
         fw+6xL0t8nIg9W/VqAlmea2Xi/QAMj43r70NCnqPKdZOQ+k2pXu+G5fUMaRe8zFdt2fk
         JWWQc2NJ/zMPTaMg9M5+VHQpiaQGfqqosa4YWPSG3qztsQIxZrsszWUCVKNg2vbMMWht
         a6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAhatab0HAVyw+PnT7+3nUVy3uXQEI6O1vd8Cnx2LKk=;
        b=VodJwO5VrpHBWo6CXJrvp8/OUfLW0tEy8et2z4f3EYonLyifIAxXIRIOF+SXb1gxYI
         JET0G+pv8yWAnQgAd3EqIUKLXk6nvVAMJ0Z2FRJ7aGX0ENXMWjm3azjYI6zizhLQtiS+
         E5drBA6ANIXUo7LcZqc7+2M1IAibPGyoGQ8Jc3qYf/NGeoeGQhYnwyrgi2+KDazWr/TT
         muw16Z8HdnmUJw7j/vaGAqKaaxFj8uZIdRZypklhTRCReaLdmKUgmJ1l+8TDqWPTtfq+
         lpjXCPE92T+fWqY6/zJpyfJ2kCVILUPErvYZyKl2AFFcV4mNstVic1LTfXvTPgRhVEZN
         Rfcg==
X-Gm-Message-State: APjAAAXqAOOningNHymZ+SZti3eu8oQ+75WCnPUVY0BfpcwJjzYZ8U12
        wG+fihKIXNxpgBSstjcOUmscZjnFyTdJiZYL8syteg==
X-Google-Smtp-Source: APXvYqx2nWcd1UUVmxVOfqTdpy/EjWGEE63D+8CgDq6wsvkYXGUtTG/eldJ/84K4uXpb1xaJ0VQplOCTsiiUpsYmcEg=
X-Received: by 2002:ab0:234e:: with SMTP id h14mr10788176uao.25.1560808781025;
 Mon, 17 Jun 2019 14:59:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com> <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
 <20190617135636.GC1367@arrakis.emea.arm.com> <CAFKCwrjJ+0ijNKa3ioOP7xa91QmZU0NhkO=tNC-Q_ThC69vTug@mail.gmail.com>
 <20190617171813.GC34565@arrakis.emea.arm.com>
In-Reply-To: <20190617171813.GC34565@arrakis.emea.arm.com>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Mon, 17 Jun 2019 14:59:29 -0700
Message-ID: <CAFKCwrhuQ+x-KprJV=CPCrnQR9Ky9qL=M5q_pa3fGj27oo4mng@mail.gmail.com>
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 10:18 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 17, 2019 at 09:57:36AM -0700, Evgenii Stepanov wrote:
> > On Mon, Jun 17, 2019 at 6:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
> > > > From: Catalin Marinas <catalin.marinas@arm.com>
> > > >
> > > > It is not desirable to relax the ABI to allow tagged user addresses into
> > > > the kernel indiscriminately. This patch introduces a prctl() interface
> > > > for enabling or disabling the tagged ABI with a global sysctl control
> > > > for preventing applications from enabling the relaxed ABI (meant for
> > > > testing user-space prctl() return error checking without reconfiguring
> > > > the kernel). The ABI properties are inherited by threads of the same
> > > > application and fork()'ed children but cleared on execve().
> > > >
> > > > The PR_SET_TAGGED_ADDR_CTRL will be expanded in the future to handle
> > > > MTE-specific settings like imprecise vs precise exceptions.
> > > >
> > > > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > >
> > > A question for the user-space folk: if an application opts in to this
> > > ABI, would you want the sigcontext.fault_address and/or siginfo.si_addr
> > > to contain the tag? We currently clear it early in the arm64 entry.S but
> > > we could find a way to pass it down if needed.
> >
> > For HWASan this would not be useful because we instrument memory
> > accesses with explicit checks anyway. For MTE, on the other hand, it
> > would be very convenient to know the fault address tag without
> > disassembling the code.
>
> I could as this differently: does anything break if, once the user
> opts in to TBI, fault_address and/or si_addr have non-zero top byte?

I think it would be fine.

> Alternatively, we could present the original FAR_EL1 register as a
> separate field as we do with ESR_EL1, independently of whether the user
> opted in to TBI or not.
>
> --
> Catalin
