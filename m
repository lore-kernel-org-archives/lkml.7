Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EADCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A6C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 20:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393302AbfJXUDP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:03:15 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33307 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJXUDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 16:03:15 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so21793577oic.0;
        Thu, 24 Oct 2019 13:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=igey018oqO3qwGLtBSWMuY/lWCADIgWzGXzdJ93djzQ=;
        b=ZP6iyDI7xuCIHoPJa4GItuVXkZyGqrtSUiP7+UouPD8wTQhPuAeNAMxcoRVfqHpxgh
         Zzh9K1GvNufatBaVXyCMYthSo/4msYD7KYf7BOML8vPr7h6mz247EpJfFCBv1MDViORC
         K8THOo7aalRVWURUoTqFKZ1vF7iSefQnlD98ZHJmcw/l26xRR8QUZ0WO4DS+1pmYN5QI
         LRPs3JX5B9PNftXTRR68l6mzEdFJ36PEd7s/eO6Fb3+q9hyrQBtxEE23q2xz8H3QzVg2
         uiAN54NUDOKdUzcMbR8EPMwpjcP/hRPoU0LEXxHSuAMBHxbZA5yVAFQSVwSz4wT81e9B
         MLTw==
X-Gm-Message-State: APjAAAV7Y2+UsO5WZoNGVPZazVsaAgC4jFwBXjp0I0kJu/eo3l30EhYP
        wptkk6QD0APDzpGH5KGcRQ7LwhO2VG0=
X-Google-Smtp-Source: APXvYqz16SuuuCtJ6biLPfr/1HjWSlBhlQoOjy7B2BFNBgaMd7fhOAkIkFhNXBLSOCRuEWwCpha+AQ==
X-Received: by 2002:aca:aac6:: with SMTP id t189mr5022022oie.171.1571947392534;
        Thu, 24 Oct 2019 13:03:12 -0700 (PDT)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com. [209.85.167.179])
        by smtp.gmail.com with ESMTPSA id n4sm2583538oic.2.2019.10.24.13.03.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2019 13:03:10 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id s5so6349123oie.10;
        Thu, 24 Oct 2019 13:03:10 -0700 (PDT)
X-Received: by 2002:aca:d88b:: with SMTP id p133mr6042557oig.51.1571947390375;
 Thu, 24 Oct 2019 13:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <VE1PR04MB6687DA0268FAF03D3E77A23B8F6C0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <e02fa027-9c78-3272-d2d7-7ad2b0ed3ab0@rasmusvillemoes.dk> <CADRPPNREUK1SVxO4P5qb2COn+T04dtYgpVEzrveKUt16hBqAtQ@mail.gmail.com>
 <679bf33b-8c05-b77a-0cb2-d79dc5bfbe75@rasmusvillemoes.dk> <CADRPPNSiMUy77Dhxjg03sHDxyZzWf_BP8a5+fCncbynyO_cNGg@mail.gmail.com>
 <VE1PR04MB676825D5709839AEF75ED44C91680@VE1PR04MB6768.eurprd04.prod.outlook.com>
 <43033011-1a2a-dea3-e3c9-75895f997407@rasmusvillemoes.dk> <VE1PR04MB6768D3023802D62AB9FE2F6E916B0@VE1PR04MB6768.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6768D3023802D62AB9FE2F6E916B0@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 24 Oct 2019 15:02:59 -0500
X-Gmail-Original-Message-ID: <CADRPPNRnOH9OgJC7VNYxj5tj87PQzHcvtofqK2xb4Uc7eNCkMg@mail.gmail.com>
Message-ID: <CADRPPNRnOH9OgJC7VNYxj5tj87PQzHcvtofqK2xb4Uc7eNCkMg@mail.gmail.com>
Subject: Re: [PATCH 0/7] towards QE support on ARM
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 9:54 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> On 22/10/2019 18:18, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> > -----Original Message-----
> > From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Sent: 2019年10月22日 18:18
> > To: Qiang Zhao <qiang.zhao@nxp.com>; Leo Li <leoyang.li@nxp.com>
> > Cc: Timur Tabi <timur@kernel.org>; Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org;
> > linux-serial@vger.kernel.org; Jiri Slaby <jslaby@suse.com>;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 0/7] towards QE support on ARM
> >
> > On 22/10/2019 04.24, Qiang Zhao wrote:
> > > On Mon, Oct 22, 2019 at 6:11 AM Leo Li wrote
> >
> > >> Right.  I'm really interested in getting this applied to my tree and
> > >> make it upstream.  Zhao Qiang, can you help to review Rasmus's
> > >> patches and comment?
> > >
> > > As you know, I maintained a similar patchset removing PPC, and someone
> > told me qe_ic should moved into drivers/irqchip/.
> > > I also thought qe_ic is a interrupt control driver, should be moved into dir
> > irqchip.
> >
> > Yes, and I also plan to do that at some point. However, that's orthogonal to
> > making the driver build on ARM, so I don't want to mix the two. Making it
> > usable on ARM is my/our priority currently.
> >
> > I'd appreciate your input on my patches.
>
> Yes, we can put this patchset in first place, ensure it can build and work on ARM, then push another patchset to move qe_ic.

Right.  I would only accept a patch series that can really build and
work on ARM.  At least the current out-of-tree patches can make it
work on ARM.  If we accept partial changes, there is no way to make it
work on the latest kernel on ARM then.

Regards,
Leo
