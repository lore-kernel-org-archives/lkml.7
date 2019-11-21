Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FFAC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E41520898
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKUKCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 05:02:47 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:58335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfKUKCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 05:02:47 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLRI3-1iFn2U2WFn-00IXcv for <linux-kernel@vger.kernel.org>; Thu, 21 Nov
 2019 11:02:45 +0100
Received: by mail-qt1-f181.google.com with SMTP id o3so3014862qtj.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 02:02:45 -0800 (PST)
X-Gm-Message-State: APjAAAUb+RGjT+E3EACrN+KvciGu2zPAS/ytjxOXEk1QhXMs9PvLuuAy
        yGBVTa0EbnVzfjg5f6p2G+b54X/Ek8AhUk44LuY=
X-Google-Smtp-Source: APXvYqzE9t0AKsL1ncZ+umQ6xzlJILzipFxI4dN5a7JRB94aN2AlXoeFAbsRXYBGWls5F1FUF+i6obdblOQRDjk7tOw=
X-Received: by 2002:ac8:75c4:: with SMTP id z4mr7253771qtq.142.1574330564561;
 Thu, 21 Nov 2019 02:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20191108203435.112759-1-arnd@arndb.de> <20191108203435.112759-4-arnd@arndb.de>
 <fdcb510863c801f1f64448e558ee0f8ed20db418.camel@codethink.co.uk>
 <CAK8P3a3BPhX_NRFj66WyRLQUOCV-FGRjmPCgB7gqxMoK8hfywg@mail.gmail.com> <d82ef7b94b9c3adc4fbb4e62c17b81a868fb32d8.camel@codethink.co.uk>
In-Reply-To: <d82ef7b94b9c3adc4fbb4e62c17b81a868fb32d8.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Nov 2019 11:02:27 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
Message-ID: <CAK8P3a1eZwCVMdibuPDzbSF6430yBLuoF+o-VZKX_HBWGePCqA@mail.gmail.com>
Subject: Re: [Y2038] [PATCH 3/8] powerpc: fix vdso32 for ppc64le
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:41XpRS828esakJIKa5bYvZq2wDOJaAcY5zBlfDy8tJbttj/QtDA
 JVjCi/s9I2SKY83OIZqfeAOoglGrlhUFDfX4takhQLnL1jsibmlqTTS4O973pdMweXkjfNw
 IIevDpXhEfMaCbek/5v+Eaeu5wGgzHn6TaEtfOSHWG1SdP4dVxuamHdWwOmY2vgmGb+Phfo
 3zF2xripkLit/u8kiz5gA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/HG6Xz3kEUw=:GoglAnKBBYWkkGpxibP3qe
 sKKbzdGtLIkU8Tr+M9rksz3J4QGJrXk0xtFESAxg3KhnujrbFonmIUePR8Fz06EnSnkOnLJrd
 JLikYAp8SV1omt4O23DrxXV/WopQ0IWWjiIXmO+3ZBcUysr0CdmUPyBHVTpf5Bx6MOjE7h+xG
 V/QvvnuLAxUoIhovOeBV4vH9Hy7KtnMcWmGMu9jQDHt4ksr3mQViNp6rD1jOGsu9CYe400TWz
 7b+LULhZKiS2f2+sUlAnTuUgpIq5K1a68bzPIAVAZYwZHDNnKZVk1zeOt1tikGRpPKWJAevf4
 H2BLTvHo4qHcVX4sv57JN3xaP+QeHNvAtfEVzJLURDrsai7XmIT5RMuW+XUGhPVe9Ft/HKz8N
 ogRB7KO9aTWFg9kRZMyKENO1Gpv67k0V071qMRKN3Y+gUCZV/cJ/hB1hC57B8zV25jLX5w3cH
 PM7t0H2BPnT/BvFs7rJHvDhIbfxs2MW1CXk2Vsg1lHy5f0jwD8y8kt0iu/Ir92imEXGkq189W
 UWuvh3QnwrF/JkGVJcOzt/KB/spFv/4B/E+D7KQ8BD/Zcx3qHeIgMOzdZqDgrzyIXERXnBIGF
 oTiNtFKtbvHIN9Od2u0JmJjT2cz/7cR+PGHjFpetC9C2OK4ifdVg7Wj5/zn/3Lis0LHSgzocj
 kwPe1PSDnEt9xf/ujSmEEsE5ULWhSHrdSiBeC/rX8nOzrQqSolbLa4+uMAvpltfnHGF+mMKQB
 bfwPlzIuuorRXNqsJWA/wBkd2OTDUNoGZW6oL7RFGJrSt94eEblsnuW3aEDwNMPhuyUWSElhW
 NuWchr9N9uGpSNQekETIGUnOW1RI2pgtGmkXDbf/zBjEkKlS1tK3Fl5sopIDejj8Swtr87PId
 wTr6pdypSTIO7PQYcUQQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 10:49 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Wed, 2019-11-20 at 20:35 +0100, Arnd Bergmann wrote:
> > On Wed, Nov 20, 2019 at 8:13 PM Ben Hutchings
> > <ben.hutchings@codethink.co.uk> wrote:
> > > On Fri, 2019-11-08 at 21:34 +0100, Arnd Bergmann wrote:
> > > > On little-endian 32-bit application running on 64-bit kernels,
> > > > the current vdso would read the wrong half of the xtime seconds
> > > > field. Change it to return the lower half like it does on
> > > > big-endian.
> > >
> > > ppc64le doesn't have 32-bit compat so this is only theoretical.
> >
> > That is probably true. I only looked at the kernel, which today still
> > supports compat mode for ppc64le, but I saw the patches to disable
> > it, and I don't think anyone has even attempted building user space
> > for it.
>
> COMPAT is still enabled for some reason, but VDSO32 isn't (since 4.2).

Ok, I had missed that detail. Should I just drop my patch then?

      Arnd
