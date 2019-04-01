Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB8320880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jK3Ul6IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfDAVR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:17:27 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43543 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfDAVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:17:26 -0400
Received: by mail-ot1-f68.google.com with SMTP id u15so9980807otq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NU/dwlFy06P3CY+Snl/xjOq1oiT4xOTpJ/q7qEv6+mc=;
        b=jK3Ul6IVqM+e6MyG4Hha49qd0Ku9PjgOWY9QsuD3DNOyzYDX4dfQe5qfISFuZWeN07
         IxMIbLCjKNOrifeFWQ20PAO89fAb+ABVzBB04Xr/bWAsTelYbrFh312wbmVRpAVbjifc
         IHpe3TYUGV613jc6NDXKmrRIQgQKPCTPsZbr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NU/dwlFy06P3CY+Snl/xjOq1oiT4xOTpJ/q7qEv6+mc=;
        b=VAn+Z4hoI86NwCIZ8mQqBkI684mizcWNtFLVgSTsyUY2rh8LdEk2Enjd/Zjmxrta+4
         Mnv6Cxdas5MUDGRZDCmzPOa1PHMTy0jzY+MZukp1Wz7/miIwtYkKFSujslVUHRKnWopG
         +Z2ROoIyhTIvDgiqCMxMdyvEdK2Yidx/8Jhlrdg/OWJpy5tTbzCLwUfcLuss8IUmh68p
         NiBGEe4uqhSjOzctdk5yFQdCfBWctZY2+IVAFRX93aJ23QtPonof5iuPw540aIh02Swc
         DKZu7quZdUFUB/+cz12UQ1bg4KX3eLpgnMAiwZp4sJCZfJrdV+Swq+MNsy0MEebmfFsy
         0KaQ==
X-Gm-Message-State: APjAAAWWKMxgbCRo0ldF15BjO1kP2xf/pMG7qwSPD/u6T/n5DeNYyhad
        7u34DA9JFl/cGaEcsoNQrMRWGmz9fL0=
X-Google-Smtp-Source: APXvYqxlY4fN/uFf4D92cxQIdh3fS49V21zJTiziIwtuducdRm3nt0HGJ2hRQEzjtNjX9k+5NfMKDw==
X-Received: by 2002:a9d:64c1:: with SMTP id n1mr14718328otl.259.1554153445771;
        Mon, 01 Apr 2019 14:17:25 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id e186sm4610837oia.44.2019.04.01.14.17.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 14:17:25 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id e5so9985884otk.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 14:17:24 -0700 (PDT)
X-Received: by 2002:a9d:645a:: with SMTP id m26mr2202525otl.304.1554153444460;
 Mon, 01 Apr 2019 14:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <1553889813-17677-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAHX4x85jFVYhOpRCKfvhYEqhXFwpKaK3_5gEit1EMaXY3L4Z4g@mail.gmail.com>
 <20190330102230.GB19202@intel.com> <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
In-Reply-To: <e2d8ab93c97acf1254830e6f51edb8f19c8767d6.camel@perches.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 1 Apr 2019 15:17:13 -0600
X-Gmail-Original-Message-ID: <CAHX4x85=Sot62T=DtGPLkyFhudyp=jvxcU_W-oShg8iKTach+Q@mail.gmail.com>
Message-ID: <CAHX4x85=Sot62T=DtGPLkyFhudyp=jvxcU_W-oShg8iKTach+Q@mail.gmail.com>
Subject: Re: [PATCH v3] HID: intel-ish-hid: ISH firmware loader client driver
To:     Joe Perches <joe@perches.com>
Cc:     Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        benjamin.tissoires@redhat.com, jikos@kernel.org,
        jettrink@chromium.org, Gwendal Grignou <gwendal@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to send the last message from my phone, and surprise it wasn't
formatted correctly, so it may have been marked as spam. repeating
myself again...

Ah, I guess I was wrong about logging OOM. I hadn=E2=80=99t hear about the
recommendations against it, but they make sense. Thanks for the
clarifications!

On Sat, Mar 30, 2019 at 10:27 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-03-30 at 15:52 +0530, Rushikesh S Kadam wrote:
> > On Fri, Mar 29, 2019 at 04:30:18PM -0700, Nick Crews wrote:
> > > On Fri, Mar 29, 2019 at 1:03 PM Rushikesh S Kadam
> > > <rushikesh.s.kadam@intel.com> wrote:
> > > > +       ldr_xfer_ipc_frag =3D kzalloc(LOADER_SHIM_IPC_BUF_SIZE, GFP=
_KERNEL);
> > > > +       if (!ldr_xfer_ipc_frag) {
> > > Log error here.
> > The error code is logged in calling function
> > load_fw_from_host(). Is that good enough?
> >
> > I believe the checkpatch script too, would
> > recommend against adding debug print for ENOMEM
> > error.
>
> The generic kernel allocation functions already do
> a dump_stack() on OOM conditions when called without
> __GFP_NOWARN so any additional OOM message isn't
> particularly useful.
>
> > Again, I thought it was against practise to log
> > "out of memory" debug prints in probe()
>
> Or anywhere else given the generic OOM stack dump.
>
> > But will add if you tell me this is the right way.
> >
> > > > +               return -ENOMEM;
> > > > +
> > > > +       loader_ishtp_cl =3D ishtp_cl_allocate(cl_device);
> > > > +       if (!loader_ishtp_cl)
> > >
> > > log error here
>
> The ishtp_cl_allocate function just calls kmalloc then
> initializes the struct so an additional OOM message
> isn't useful here either.
>
>
