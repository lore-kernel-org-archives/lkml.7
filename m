Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4BCC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDFD2177E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558627852;
	bh=Ks4M8oPURw7oETjX9GzeqfgrTJjuIASee+rooCmyklQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZZmRavVVkdQBSR54C1vtsljHdBHjq7XUL80rNmSCjQ/FQHMQg86PnsBln/qH/pFuR
	 tRck6EhGg/oai0fWy/eMlIcIidFVYNwIuDBNOkZcvgW7B0QBw4v1/9F0JC98uo8Fv7
	 +Kuum1x8mmHcDBZZkOUiFMwOo02u8ob+4SLwkYUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfEWQKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 12:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfEWQKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 12:10:51 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18769217D4;
        Thu, 23 May 2019 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558627851;
        bh=Ks4M8oPURw7oETjX9GzeqfgrTJjuIASee+rooCmyklQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=v+yufGtIIbg3T2fQeV07x1528svajwkiok0mjwSi9rnZ/j0HXNl8tqXpxW9PKKyfA
         zkNYrIzT7TY2FzPjp8oKrAqMO9bt0EiPK37CoHOaVjDvPjiIR8J8AKKPOXBqlf91sy
         IwxrykHg2xt+VxzOa03ixHol8tpqOURriI3mdVwM=
Received: by mail-qt1-f181.google.com with SMTP id y42so7381101qtk.6;
        Thu, 23 May 2019 09:10:51 -0700 (PDT)
X-Gm-Message-State: APjAAAXG8jT0tRGzlv8zQRdsH9DKxfSEON5yBj48ZIO43A1Q7BODGC4h
        NkMfq1VyTopM6jK9FToH23hlYdWZ/mCgxD+DQg==
X-Google-Smtp-Source: APXvYqz3aMyKfY9Kh2G7ct/P7xKbPM0jXnjnWBlvrMkzGlir9kfL/nY5Cx7zOLPgiQ799e5fkJxU3rR6cM+8zrt0T5o=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr81538936qta.136.1558627850320;
 Thu, 23 May 2019 09:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190521105151.51ffa942@canb.auug.org.au> <20190523115355.joyeqlmbjkufueyn@flea>
In-Reply-To: <20190523115355.joyeqlmbjkufueyn@flea>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 23 May 2019 11:10:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKN6+f5FXUVs03VSv2AKvqaS0XemKFSYFthaxPoHJVwEg@mail.gmail.com>
Message-ID: <CAL_JsqKN6+f5FXUVs03VSv2AKvqaS0XemKFSYFthaxPoHJVwEg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drm-misc tree with Linus' tree
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 6:54 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, May 21, 2019 at 10:51:51AM +1000, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the drm-misc tree got a conflict in:
> >
> >   Documentation/devicetree/bindings/vendor-prefixes.txt
> >
> > between commit:
> >
> >   8122de54602e ("dt-bindings: Convert vendor prefixes to json-schema")
> >
> > from Linus' tree and commits:
> >
> >   b4a2c0055a4f ("dt-bindings: Add vendor prefix for VXT Ltd")
> >   b1b0d36bdb15 ("dt-bindings: drm/panel: simple: Add binding for TFC S9700RTWV43TR-01B")
> >   fbd8b69ab616 ("dt-bindings: Add vendor prefix for Evervision Electronics")
> >
> > from the drm-misc tree.
> >
> > I fixed it up (I deleted the file and added the patch below) and can
> > carry the fix as necessary. This is now fixed as far as linux-next is
> > concerned, but any non trivial conflicts should be mentioned to your
> > upstream maintainer when your tree is submitted for merging.  You may
> > also want to consider cooperating with the maintainer of the conflicting
> > tree to minimise any particularly complex conflicts.
>
> I just took your patch and pushed a temp branch there:
> https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git/commit/?h=drm-misc-next&id=3832f2cad5307ebcedeead13fbd8d3cf06ba5e90
>
> Rob, Stephen, are you ok with the change? If so, I'll push it.

The 'tfc' line is missing a ':' on the end. Does the file pass
dt_binding_check like that?

Rob
