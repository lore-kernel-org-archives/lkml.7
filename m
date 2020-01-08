Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFDAC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756EE20705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJhDdgds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgAHRvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:51:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37966 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbgAHRvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:51:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so3462872wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 09:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aSdZ3aFnA3oyaNn1PxZQVkM/xC6wM/NzLRYNPjDKtGk=;
        b=UJhDdgdsjUO4ywVeJCCVBEmXe8zl1IVqpO8NefBS2jzudGUW4Ae1UiSDzymlFkIjwi
         npZKTirPA9lIsiJKG3hqeOv+ke6PPLyf+Io8IIMEuw69PfOiPlK9UnqHHwGos51O83Xj
         ZEkv0zTlRoT+k3SZtoh6xRRyyA/Jn9S2LetiBTUNeYN6CduaKdEs6zOC81C0sLdtneJL
         7uD2jnziR0kXpdYo6IkvIIJJkELJjM+VSh4aiKMzcukzjGS7adDJtTEflxGBdTdAl548
         asURoyc2sTGOOzwgqlv7EuE0tu9xuIs7jS3XmN/ysLbLU+Spq1yWM+/wxYjuSSv0BPWq
         kuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aSdZ3aFnA3oyaNn1PxZQVkM/xC6wM/NzLRYNPjDKtGk=;
        b=mHEjKNWYC0FNdklkyhtH27HgULOedsxmizDAQ4VnMmbi+VdM/pMBOTAPq7Dz7PTQuo
         fDZGP9Lxrwhz/GJiRxO6H+IbRarPgO8fV7aGWoc5cEDEeT7HgW9d4qF9nZWXnBv9RWzv
         LY77JBJXJzBLqEVI9LfBrbkSiueZb+36EbDepnHNpekZptssbu0r0wxyMX+6OVVkk7JW
         Q1VGoj+HbWtA0C0NpQxk1RIA5k5yrAAfT6svFxo+s5/FNvnY57GrfHvYvpT9ubZIZrVK
         8buq6yREPKtZiDQruPqq0eSNmIc5zIv+IPBjOb2+gxWBZpnhsSfQ3xdP14vPxGYusf5u
         HsuQ==
X-Gm-Message-State: APjAAAUz2glYvzKaB5Do4wrY9gvMGXGdSccMRUcYuuDglTc9EwpjopS2
        0hypAVRSviNFUmTovswr5T8xYVsvkM7jrU1+0m8=
X-Google-Smtp-Source: APXvYqxq2sDXTbxb3S/PFtXkOw3vuLm8LBRlfNKToeO7JJ0ai3l9PSPUe8NacQTzdquRiCfMd9pHXIWsiukQguGIiQ4=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr5231788wmq.65.1578505904939;
 Wed, 08 Jan 2020 09:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20200107192555.20606-1-tli@digitalocean.com> <b5984995-7276-97d3-a604-ddacfb89bd89@amd.com>
 <202001080936.A36005F1@keescook>
In-Reply-To: <202001080936.A36005F1@keescook>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 8 Jan 2020 12:51:33 -0500
Message-ID: <CADnq5_NLS=CuHD39utCTnTVsY_izuTPXFfsew6TpMjovgFoT5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/radeon: have the callers of set_memory_*() check
 the return value
To:     Kees Cook <keescook@chromium.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        kernel-hardening@lists.openwall.com,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tianlin Li <tli@digitalocean.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 12:39 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jan 08, 2020 at 01:56:47PM +0100, Christian K=C3=B6nig wrote:
> > Am 07.01.20 um 20:25 schrieb Tianlin Li:
> > > Right now several architectures allow their set_memory_*() family of
> > > functions to fail, but callers may not be checking the return values.
> > > If set_memory_*() returns with an error, call-site assumptions may be
> > > infact wrong to assume that it would either succeed or not succeed at
> > > all. Ideally, the failure of set_memory_*() should be passed up the
> > > call stack, and callers should examine the failure and deal with it.
> > >
> > > Need to fix the callers and add the __must_check attribute. They also
> > > may not provide any level of atomicity, in the sense that the memory
> > > protections may be left incomplete on failure. This issue likely has =
a
> > > few steps on effects architectures:
> > > 1)Have all callers of set_memory_*() helpers check the return value.
> > > 2)Add __must_check to all set_memory_*() helpers so that new uses do
> > > not ignore the return value.
> > > 3)Add atomicity to the calls so that the memory protections aren't le=
ft
> > > in a partial state.
> > >
> > > This series is part of step 1. Make drm/radeon check the return value=
 of
> > > set_memory_*().
> >
> > I'm a little hesitate merge that. This hardware is >15 years old and no=
body
> > of the developers have any system left to test this change on.
>
> If that's true it should be removed from the tree. We need to be able to
> correctly make these kinds of changes in the kernel.

This driver supports about 15 years of hardware generations.  Newer
cards are still prevalent, but the older stuff is less so.  It still
works and people use it based on feedback I've seen, but the older
stuff has no active development at this point.  This change just
happens to target those older chips.

Alex

>
> > Would it be to much of a problem to just add something like: r =3D
> > set_memory_*(); (void)r; /* Intentionally ignored */.
>
> This seems like a bad idea -- we shouldn't be papering over failures
> like this when there is logic available to deal with it.
>
> > Apart from that certainly a good idea to add __must_check to the functi=
ons.
>
> Agreed!
>
> -Kees
>
> --
> Kees Cook
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
