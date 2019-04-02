Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79276C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440FF20883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyf2FS0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfDBNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:33:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35036 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfDBNdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:33:37 -0400
Received: by mail-io1-f67.google.com with SMTP id p16so10918440iod.2;
        Tue, 02 Apr 2019 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=struTEFQ7267I3oXVjI73LvA2waAe2Q6bkpiluIhVpc=;
        b=eyf2FS0Mr4lp3vr8rXKSNYJpLTRgGFG+p91kBaiR+l+6uMyD4G9RfVfd0S8r/VHOHi
         bqPwchA2PTjWBHWSRHQJh+5oc6AIxcWQ6IbCP8X31GZvfdJl3OJwAL+G3OVGodsKEDcu
         HsBrLAEK+BQiZh+4Jh7Mkvtndw2PHbDjTp+/9tdPaKDEnbKqkWn/pLbJwGTU6jE8X5bn
         67eCLlHeieVfzx6m3qB2iCvRiGMbOYk74yq4JqxxZVDvKudc7FR3qPotlOsFg+jKmreB
         5spuWeI7EyPy+eI15OMZREIRAiEoLBw+eTB4/qLHoojvkLu393YP+k0Pz9yAD1Tr5nIZ
         9KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=struTEFQ7267I3oXVjI73LvA2waAe2Q6bkpiluIhVpc=;
        b=PsKmXRlBkMKbF0CgfzlUw2QALrmdls2oKjyFsRUEif6FeKPy93ZVMZiSIEK4HvYKUA
         duLA99vQ9FRXUBsoW1pEuuMWgU0Y2N7H9O6afSnULtDeBBlBr6jL22j4C850rNo6JFhh
         CsjNk7CYmIAISwp7j2tmEXvojwTJWBVnGSP8a+qrm2OTIeA2SRrrS6/1Pj4YYUIGHpXV
         A/S8MFTbxovhXHyHbX4XLUQ0X7fNx23RIsCVl9kPFbltgnWtiUuwIkjN9XucdaUoGuQ7
         cBdCC2jHKhyafmFhHSPh0NLBVp5mreL24huqfBVBmaobriGWWmcNeWHFEM0mqeSrrpXY
         sBlw==
X-Gm-Message-State: APjAAAWH9mDEcyaGKbZYlYJ9pFM+dTM7DwZ+ZcGK3HqHHmB6aWCo0PV6
        qur4JhITVr9cytvtJVUicfDJUMbtcQe38eM16cc=
X-Google-Smtp-Source: APXvYqyM8p1ilM9kN0qnihkBOjg60ja8etubPw0JZ3/R7n8uKOIhgVb206gQJ5vhao3UEGqMPYNIfjLLSkdMyT3geyY=
X-Received: by 2002:a6b:660e:: with SMTP id a14mr46345408ioc.136.1554212016842;
 Tue, 02 Apr 2019 06:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190402105006.48f93e53@canb.auug.org.au> <20190402112113.GD22763@bombadil.infradead.org>
In-Reply-To: <20190402112113.GD22763@bombadil.infradead.org>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Apr 2019 21:33:25 +0800
Message-ID: <CAKGbVbt4W8UUST8HZ0tPuHyGv4qx98hMqmkhWmJB5K-TbReg5A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 2, 2019 at 7:21 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 02, 2019 at 10:50:06AM +1100, Stephen Rothwell wrote:
> > +++ b/drivers/gpu/drm/lima/lima_ctx.c
> > @@ -23,7 +23,7 @@ int lima_ctx_create(struct lima_device *dev, struct lima_ctx_mgr *mgr, u32 *id)
> >                       goto err_out0;
> >       }
> >
> > -     err = xa_alloc(&mgr->handles, id, UINT_MAX, ctx, GFP_KERNEL);
> > +     err = xa_alloc(&mgr->handles, id, ctx, XA_LIMIT(*id, UINT_MAX), GFP_KERNEL);
> >       if (err < 0)
> >               goto err_out0;
>
> I agree that this is an exact translation of what the code was doing,
> but I don't think it's what the author intended the code to do.
> They almost certainly meant:
>
>         err = xa_alloc(&mgr->handles, id, ctx, xa_limit_32b, GFP_KERNEL);
>
> I'm basing this on:
>
> +struct drm_lima_ctx_create {
> +       __u32 id;          /* out, context handle */
> +       __u32 _pad;        /* pad, must be zero */
> +};
>
> (and this confusion is exactly why I changed the API ...)

Right, I plan to send out a patch like yours after drm-misc-next merge
5.1 changes, as this is a build fix patch and already applied to somewhere.
I can send out another patch now if merge guys could use the new one
directly.
