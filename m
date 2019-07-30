Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E796AC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEACD205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pm7OTx+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfG3OWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:22:49 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:39079 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725929AbfG3OWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:22:49 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id ED8CF19A2;
        Tue, 30 Jul 2019 10:22:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Jul 2019 10:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=fHTTpR
        5eU19q6OgWJxRIcPsJ3iR77p64plMkqad3uH0=; b=pm7OTx+n/GaE8dZOc5zi5a
        ad6rQFY+y8fPwZqi2QfKRceF0pKBLSzhvSdxAtbkmft7zYKlY74yHff+kigpI3HL
        ld3UX/PA3VB9lrmCXP/LGnNKJik8+95pwgxpHy6UdzIHjbH2ICz/4Tnw5YLJcw8S
        qM/XQdN5JFRb1d9DFd2dImO6svqYSDMbkJI2Zh7brPynrHVx4j0XH9sOhjsyVnZd
        mwuVkGEdyyvehJmunRGFj2OatWwg/aQLccMwinlwFTx8qjxJVMfbCE0eHHle/yog
        L32zh/ZhhgMuLOsXze0IEK6gcZm81sDRUm4XZZBtntyvs7h7NKNnwITRz+77bedw
        ==
X-ME-Sender: <xms:t1JAXXwM3HS4PyKr0NRtCcZALD8EeD3zslS2JF1QxsBpPkOwcz8ieA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujggfsehgtderredtreejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucfkphepledurdeihedrfeegrdef
    feenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslh
    gvthhhihhnghhslhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:t1JAXZUYhtF53dQFeMSl_-UM5eRPDp8_uoFvEoy4dTVFEmOOJd60yg>
    <xmx:t1JAXROxZANG-6bduAieIIUAVIguz5PjEN7URpx2J3w6EeAXbe3Lqg>
    <xmx:t1JAXTBy4y5dd1QQmh592u1hiUTpHXMO52fo35qpQzA8tyAbsTW_pg>
    <xmx:t1JAXVo6zco2qIgDDXNvgQ-O4Ixsl3bFZaWMDnWaOpHA6sNaYBD6rg>
Received: from mail-itl (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA32C380083;
        Tue, 30 Jul 2019 10:22:45 -0400 (EDT)
Date:   Tue, 30 Jul 2019 16:22:33 +0200
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        robin.murphy@arm.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [Xen-devel] [PATCH v4 8/9] xen/gntdev.c: Convert to use
 vm_map_pages()
Message-ID: <20190730142233.GR1250@mail-itl>
References: <20190215024830.GA26477@jordon-HP-15-Notebook-PC>
 <20190728180611.GA20589@mail-itl>
 <CAFqt6zaMDnpB-RuapQAyYAub1t7oSdHH_pTD=f5k-s327ZvqMA@mail.gmail.com>
 <CAFqt6zY+07JBxAVfMqb+X78mXwFOj2VBh0nbR2tGnQOP9RrNkQ@mail.gmail.com>
 <20190729133642.GQ1250@mail-itl>
 <CAFqt6zZN+6r6wYJY+f15JAjj8dY+o30w_+EWH9Vy2kUXCKSBog@mail.gmail.com>
 <bf02becc-9db0-bb78-8efc-9e25cc115237@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6T5LqlUZTKFAO7Wr"
Content-Disposition: inline
In-Reply-To: <bf02becc-9db0-bb78-8efc-9e25cc115237@oracle.com>
User-Agent: Mutt/1.12+29 (a621eaed) (2019-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6T5LqlUZTKFAO7Wr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 10:05:42AM -0400, Boris Ostrovsky wrote:
> On 7/30/19 2:03 AM, Souptick Joarder wrote:
> > On Mon, Jul 29, 2019 at 7:06 PM Marek Marczykowski-G=C3=B3recki
> > <marmarek@invisiblethingslab.com> wrote:
> >> On Mon, Jul 29, 2019 at 02:02:54PM +0530, Souptick Joarder wrote:
> >>> On Mon, Jul 29, 2019 at 1:35 PM Souptick Joarder <jrdr.linux@gmail.co=
m> wrote:
> >>>> On Sun, Jul 28, 2019 at 11:36 PM Marek Marczykowski-G=C3=B3recki
> >>>> <marmarek@invisiblethingslab.com> wrote:
> >>>>> On Fri, Feb 15, 2019 at 08:18:31AM +0530, Souptick Joarder wrote:
> >>>>>> Convert to use vm_map_pages() to map range of kernel
> >>>>>> memory to user vma.
> >>>>>>
> >>>>>> map->count is passed to vm_map_pages() and internal API
> >>>>>> verify map->count against count ( count =3D vma_pages(vma))
> >>>>>> for page array boundary overrun condition.
> >>>>> This commit breaks gntdev driver. If vma->vm_pgoff > 0, vm_map_pages
> >>>>> will:
> >>>>>  - use map->pages starting at vma->vm_pgoff instead of 0
> >>>> The actual code ignores vma->vm_pgoff > 0 scenario and mapped
> >>>> the entire map->pages[i]. Why the entire map->pages[i] needs to be m=
apped
> >>>> if vma->vm_pgoff > 0 (in original code) ?
> >> vma->vm_pgoff is used as index passed to gntdev_find_map_index. It's
> >> basically (ab)using this parameter for "which grant reference to map".
> >>
> >>>> are you referring to set vma->vm_pgoff =3D 0 irrespective of value p=
assed
> >>>> from user space ? If yes, using vm_map_pages_zero() is an alternate
> >>>> option.
> >> Yes, that should work.
> > I prefer to use vm_map_pages_zero() to resolve both the issues. Alterna=
tively
> > the patch can be reverted as you suggested. Let me know you opinion and=
 wait
> > for feedback from others.
> >
> > Boris, would you like to give any feedback ?
>=20
> vm_map_pages_zero() looks good to me. Marek, does it work for you?

Yes, replacing vm_map_pages() with vm_map_pages_zero() fixes the
problem for me.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?

--6T5LqlUZTKFAO7Wr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAl1AUqoACgkQ24/THMrX
1yzE7wf+N9QQUHFQ1i6sZ/XXRhZyzc5rbN03s4QBCSZdeeSjZUJcvNMlunt0kdUG
2Ae1a5mlpnQerTvB3AhzRagzFp2H/mKQF76AconPqpvMiXJtvItwINuoP9TgLNtr
YSv4SDWGnsTVAQftHbzPUISP90Tm4W0mQWekUDQ8/o1/fufNSmU8dp0w4yYSYmJ7
jXDI/vFp323YqSGWsU/KlApuPzXoEEKfFR+7sghCCzZEWRe+LJgOgPQatokQXBBR
lhVCniRlUPeV64r9Ke0Ex0FgHJstrMn/3amyNhFeJKCZQ6d0TkFJdHsi+S6BYk6k
XxTdAiFe4G7DLklUiiiNMLS6tk++FA==
=OGWv
-----END PGP SIGNATURE-----

--6T5LqlUZTKFAO7Wr--
