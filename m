Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE5C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A57217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 05:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eKhdo0U7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfDYFE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:04:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43275 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfDYFE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 01:04:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id a12so5047550wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 22:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b5ZliQNL3dHlGlonyzY7/r/CLr+V6C8KSnOz63CTxII=;
        b=eKhdo0U7s5plIJ+LRJ1d9Lll7ykJncW5GJs5IJWk7tTVQ+OWSKARiKQ8fyi5Hfx+8Q
         BkaKhcBBYU27CcHHoVQADYBovQByoA9mFs9LiJYGjK2Y+avu8mCsXa3FRp4q4E7ZG8r8
         wfcr/ZE7ACuH3eGXkfjjCs2twKKHRiqfD12AGBBwFseMO5wkr07H0k9ZDXA/63yOsC43
         tn8PeR8XmKkCCT/FiF3OAP82qkmI/Pmvll8k4AETGJhiXaPS47cZeZV8XXGuqEGHWiBz
         ZruDcGsRam5K2eUG73F+wSKxxDduqMQD0B5fUEh238PdTnNqwdDMCzVrNB1JNM9BFwC0
         Y/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b5ZliQNL3dHlGlonyzY7/r/CLr+V6C8KSnOz63CTxII=;
        b=Xi+tEDMmElJf1DeT3q371qUoGnxRDAccwVuim7ikRiSU3nVFDVR58pauHzFu0RBNeC
         V0NoNjVIeGdWgfBmRmoelRw3MnXrLHWava//YwcXcBt31NuFfTikm+91Yst56BHa9sk9
         RQmlKkANiCtQ28UWAAlc8OZjh5jDL9HeczokI9YmDmafcbB0odY9umO/Qw+u2r/1SXxP
         nr9AgZt/hm3hOTgr2sd9xfvoP5dnD1xQlu4MzQQKnK4TW6UTn25hSSidiDPgyCJS/ci+
         aVGYtBQpqG0jPPh2kU0RLDpMqKYJTl2/uEpQ//UyWFGWSumpjrvSewp5MxkTMppczIUf
         l/og==
X-Gm-Message-State: APjAAAUiPdtBGRnkwpdhUF3gWdHl6rsKEVn0jHm2ilIrJza1lLRzHSlm
        WCbtmlSjr3wuDBOYQgX58Nk2pmwHzF+ruxxdsjXMUg==
X-Google-Smtp-Source: APXvYqwZHNErCTPnMk7vC6/kS4w/2oRBGMRTilcbpa0G0qAxiWNgZrd1jRBW6f7Vf107yki0xgMwvT1YXtuLZKfJfgw=
X-Received: by 2002:a5d:5108:: with SMTP id s8mr21951551wrt.99.1556168667185;
 Wed, 24 Apr 2019 22:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190415093648.7525-1-anup.patel@wdc.com> <20190415093648.7525-3-anup.patel@wdc.com>
 <20190424062947.GB10400@infradead.org> <CAAhSdy1Xc9AjPKY0RzLL_qsBs6wax23fi2BTVtMhuS0mAoKZmQ@mail.gmail.com>
 <20190424150135.GA19543@infradead.org>
In-Reply-To: <20190424150135.GA19543@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 25 Apr 2019 10:34:16 +0530
Message-ID: <CAAhSdy0xydwViJW8yCPTLrgkNGjwd4J8P-=4b2P4AfGemmyKyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 8:31 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 12:15:45PM +0530, Anup Patel wrote:
> > We need these defines for programming HIDELEG CSR in KVM kernel module
> > so it will be used at multiple places.
> >
> > >
> > > http://git.infradead.org/users/hch/misc.git/commitdiff/1221f5c32345ebe7ea2c1cd6e8a01ad4b422aaba
> >
> > You can certainly use these defines in your nommu commit by using
> > "#ifdef CONFIG_M_MODE" in switch case of do_IRQ().
>
> Or just keep them in the current format even when you move them, as
> that allows everything to work with a single ifdef at their point
> of declaration..

Sure, will do. I will send v4 soon.

Regards,
Anup
