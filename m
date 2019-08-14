Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0F9C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1AA206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 23:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565826093;
	bh=1xAGrO3tCA2lHlAJp4Fm0h66zxQfNwCtYkfuqN1U4gY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Nll56hdt7KrHsnkzZD6Ct9nHLFb1+z+BQDRujWYf7cfDy8DEj7eFjK96FFz+j9HU
	 NFagTBgdWwGQ1haJJS2i5d3IRFLKclFs2gWA3NUvdtDgDxmHLPGDbaTPZ+E8J187sH
	 TAMlbNP9XezfUtn4IQT5gHKBeopGGtM3etFlXAT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbfHNXlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 19:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfHNXlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 19:41:32 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365F12171F;
        Wed, 14 Aug 2019 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565826091;
        bh=1xAGrO3tCA2lHlAJp4Fm0h66zxQfNwCtYkfuqN1U4gY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cSFw9E+RsKmm3M7P/t3mGOjpmQdYjqfCy31u66Zd19mh5XnuV23+02WHGSSNmK2Mk
         GsBA07siSIhoYnhU876eS4oKSc6BHs1jG01A81MoWA8HXPJq9GlLLDI2K52hEYrZrH
         FVure5Ye/Nq/uKtOiS0JFI+z/q1Ioai2pCYAaT24=
Received: by mail-qk1-f180.google.com with SMTP id r6so606725qkc.0;
        Wed, 14 Aug 2019 16:41:31 -0700 (PDT)
X-Gm-Message-State: APjAAAWGYFmjZ4yxJm/6Hq6nLxEuzZG6zUMAeg9JMWEJKGTTUwD4gjzX
        vNje3bObb2lOIbq18t3nJeArPwsqfI08QPMGpQ==
X-Google-Smtp-Source: APXvYqw2OeisYG5A7xl9GVLooBLoJrJfk95eHJXxcQk/oUP5wx23kS4geUog+3gewNeNZwbzZ1lkq/RXyBZ9Gj/iOQo=
X-Received: by 2002:a37:a44a:: with SMTP id n71mr1607622qke.393.1565826090406;
 Wed, 14 Aug 2019 16:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190806192654.138605-1-saravanak@google.com> <20190806192654.138605-2-saravanak@google.com>
 <CAL_Jsq+BwHSj1XUNp_eY362XnNoOqVTNHqAkvnbgece8ZQE3Qw@mail.gmail.com> <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
In-Reply-To: <CAGETcx8+EETv6nSu+BEBStKvbmBs+tZZgo1u_Pw8SNu+7Urq1Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Aug 2019 17:41:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdcn5aZdenLs3RSVCOE1PRNK_qYNmQR=fXPV+ZOQ9+PQ@mail.gmail.com>
Message-ID: <CAL_JsqLdcn5aZdenLs3RSVCOE1PRNK_qYNmQR=fXPV+ZOQ9+PQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] of/platform: Disable generic device linking code for PowerPC
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 4:04 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Aug 6, 2019 at 2:27 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Tue, Aug 6, 2019 at 1:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > PowerPC platforms don't use the generic of/platform code to populate the
> > > devices from DT.
> >
> > Yes, they do.
>
> No they don't. My wording could be better, but they don't use
> of_platform_default_populate_init()
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/platform.c#n511

Right, but the rest of the of/platform code is used (guess where it
got moved here from?).

> > > Therefore the generic device linking code is never used
> > > in PowerPC.  Compile it out to avoid warning about unused functions.
> >
> > I'd prefer this get disabled on PPC using 'if (IS_ENABLED(CONFIG_PPC))
> > return' rather than #ifdefs.
>
> I'm just moving the existing ifndef some lines above. I don't want to
> go change existing #ifndef in this patch. Maybe that should be a
> separate patch series that goes and fixes all such code in drivers/of/
> or driver/

So the initcall was originally just supposed to call
of_platform_default_populate(), but it's grown beyond that. That could
make things fragile as it is possible for platforms to call
of_platform_populate() (directly or indirectly) before
of_platform_default_populate_init(). That was supposed to work, but
now I think it's getting more fragile.

Anyways, I guess this patch is fine for now.

Rob
