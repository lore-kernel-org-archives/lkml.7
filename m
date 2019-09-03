Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81D1C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6E522DCC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567546880;
	bh=VqAnzrjf/HwxuTo5b9fu2nIOvRGN3IVBpWlDHgaD82o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2Wbj8m8KLZm0G1yBNgJdDxVPOQ4WxtToRAvCPA2LZgYtV3H0+GiTJizB5rfONLjkj
	 w3TPo26h5Fu6e68hrAcRPjdp861VGant+uTBuXp+PI+P4k12PvkT6QyaZGHEcoHdj8
	 U9KhIDlBMsIi5LhsG+ljX6USd+05E9i3C4wqpl54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfICVlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfICVlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:41:19 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E796123697
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 21:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567546878;
        bh=VqAnzrjf/HwxuTo5b9fu2nIOvRGN3IVBpWlDHgaD82o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LAbf/z07Pl1PYgNwoGYPR1oPh0yq5P3VlyH4JVOIQYeJN0JLmc1QXmfdlDiAg7sQj
         dlMGly7VCcR4ImsGR2wEST293fgQYIjhlgEpw8lVvHU8AKGIR8/OJXQCNtj6B4sU96
         4qCDRP3X1o2fIJ1Ao+yDDTk2abJ2fTw1yqBys5C0=
Received: by mail-wr1-f47.google.com with SMTP id l16so699962wrv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:41:17 -0700 (PDT)
X-Gm-Message-State: APjAAAU/KZYIkXJ7xEAO6px1JTWBqhY7sNQEhYpKvfv2CP0uIoZ2DHMM
        VFiZo9rU/Mmi26p45edyiy8bpEsyAgMWrb7WaZwpOg==
X-Google-Smtp-Source: APXvYqzXcGyhT7f6XzavKD8KtKDX192fuzOKz0PBM2Wt291z3usBndyfuiJ+RvAT2J7wZHZ6dOtxhDeApHOfWbN1k5E=
X-Received: by 2002:adf:dcc4:: with SMTP id x4mr34060906wrm.221.1567546876229;
 Tue, 03 Sep 2019 14:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-2-thomas_os@shipmail.org> <20190903134627.GA2951@infradead.org>
 <f85e7fa6-54e1-7ac5-ce6c-96349c7af322@shipmail.org> <20190903162204.GB23281@infradead.org>
 <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
In-Reply-To: <558f1224-d157-5848-1752-1430a5b3947e@shipmail.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 3 Sep 2019 14:41:05 -0700
X-Gmail-Original-Message-ID: <CALCETrX4mP51QeoCJU=eebctGuDQ7QdabjGVSgF4G4_8mwg7zA@mail.gmail.com>
Message-ID: <CALCETrX4mP51QeoCJU=eebctGuDQ7QdabjGVSgF4G4_8mwg7zA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] x86/mm: Export force_dma_unencrypted
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        DRI <dri-devel@lists.freedesktop.org>, pv-drivers@vmware.com,
        linux-graphics-maintainer <linux-graphics-maintainer@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 1:46 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 9/3/19 6:22 PM, Christoph Hellwig wrote:
> > On Tue, Sep 03, 2019 at 04:32:45PM +0200, Thomas Hellstr=C3=B6m (VMware=
) wrote:
> >> Is this a layer violation concern, that is, would you be ok with a sim=
ilar
> >> helper for TTM, or is it that you want to force the graphics drivers i=
nto
> >> adhering strictly to the DMA api, even when it from an engineering
> >> perspective makes no sense?
> > >From looking at DRM I strongly believe that making DRM use the DMA
> > mapping properly makes a lot of sense from the engineering perspective,
> > and this series is a good argument for that positions.
>
> What I mean with "from an engineering perspective" is that drivers would
> end up with a non-trivial amount of code supporting purely academic
> cases: Setups where software rendering would be faster than gpu
> accelerated, and setups on platforms where the driver would never run
> anyway because the device would never be supported on that platform...
>
> >   If DRM was using
> > the DMA properl we would not need this series to start with, all the
> > SEV handling is hidden behind the DMA API.  While we had occasional
> > bugs in that support fixing it meant that it covered all drivers
> > properly using that API.
>
> That is not really true. The dma API can't handle faulting of coherent
> pages which is what this series is really all about supporting also with
> SEV active. To handle the case where we move graphics buffers or send
> them to swap space while user-space have them mapped.
>
> To do that and still be fully dma-api compliant we would ideally need,
> for example, an exported dma_pgprot(). (dma_pgprot() by the way is still
> suffering from one of the bugs that you mention above).
>
> Still, I need a way forward and my questions weren't really answered by
> this.
>
>

I read this patch, I read force_dma_encrypted(), I read the changelog
again, and I haven't the faintest clue what TTM could possibly be
doing with force_dma_encrypted().

You're saying that TTM needs to transparently change mappings to
relocate objects in memory between system memory and device memory.
Great, I don't see the problem.  Is the issue that you need to
allocate system memory that is addressable by the GPU and that, if the
GPU has insufficient PA bits, you need unencrypted memory?  If so,
this sounds like an excellent use for the DMA API.   Rather than
kludging directly knowledge of force_dma_encrypted() into the driver,
can't you at least add, if needed, a new helper specifically to
allocate memory that can be addressed by the device?  Like
dma_alloc_coherent()?  Or, if for some reason, dma_alloc_coherent()
doesn't do what you need or your driver isn't ready to use it, then
explain *why* and introduce a new function to solve your problem?

Keep in mind that, depending on just how MKTME ends up being supported
in Linux, it's entirely possible that it will be *backwards* from what
you expect -- high address bits will be needed to ask for
*unencrypted* memory.

--Andy
