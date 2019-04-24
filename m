Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D35C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBC221900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="d0x1GTdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732363AbfDXOr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbfDXOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:47:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id c5so16688921wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEa6rgZnUyAXDzw6k5Wm7RfYfnHAGNjNhYDmbAFVjBc=;
        b=d0x1GTdScmTi/VkiE0XNzsl/xx34iXYLR6LOxCKLsTXf+xKgooxCZ2Xyd8J8W86ncJ
         vKseDrctWz4KkIRGBf0ExMi26sVrdk7SnFZgrv4RRSsaVETnvp43d8M8tp/viyukTj+N
         MRlu6ZmZEZo1ZDzwWkG77AETW1r0ukTgnI8fDtumDz5z3Avf9SIGQPvGwh1Xd5KnGmXd
         jZHtvBnQjh33rlWdCP/1Z9O0+GiDh0yQHhB0gsbhD7Hv8JszATRIDEM7PBfPlxLYzKYn
         oTxCBZpjLoVcaf+9vcdNLLqdFnGjedTg73Fnk3NLEWKm+yYFin02gfFGpNQCabirPemr
         SOxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEa6rgZnUyAXDzw6k5Wm7RfYfnHAGNjNhYDmbAFVjBc=;
        b=WkYWpq0GauhNuMm99hYaT4codn3/OgW19lM1dlHzrQzwvdftufrDa6xIP/yclmUXRT
         ZPcgccSQTd9XS9BAOBHx0Xahx8AbZsJSbG0IsuimSWcNr33ElYSwPcsXk34QJeoRb30a
         fXFna9XL/hkV5f3/VBgtACoPOcoxSvil+oqY8UYFWnV7HzgO5h6DEP9kU/mSkr+nWCYd
         I7vbqZ4mrDXLsaKtQQtss+omc3/9OUBDoMoe0xsc4pt+EnZXGRIC+JKOoCmC0S08rSww
         iXgiZ14UIvObdSModXGhYw8YF8bdXQ2w34+9cjh+QsT0jcQZs1NL075Dc2XSWU3wLP/V
         xLBw==
X-Gm-Message-State: APjAAAVI04Lp8L/LYwB64XuZ/64Vsv7DQiApId4Y840qCP7vszT+7IrN
        rrK1uGr8z8LIf4Moxzmy/e1jhICeZokFDt2/8/aOAQ==
X-Google-Smtp-Source: APXvYqy+tNCx4ErCwE6WOvxEyVsF30tF7ipxrjOJfD3cHRqiIutbxkuJzuyVN13jSPde5CZ0RstcCD6CBu9IyH/PGwk=
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr6821472wrs.309.1556117270817;
 Wed, 24 Apr 2019 07:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141900.8883-1-tmurphy@arista.com> <20190424143246.GA24079@infradead.org>
In-Reply-To: <20190424143246.GA24079@infradead.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Wed, 24 Apr 2019 15:47:39 +0100
Message-ID: <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
To:     Christoph Hellwig <hch@infradead.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>The two conditions can go into one if statement to make this a little
>more clear.
Ah, yeah of course

>And I'd really like to understand the unlikely - amd_iommu_np_cache
>is set based on a hardware capability, so it seems rather odd to mark
>it unlikely.  Dynamic branch prediction really should do the right thing
>here usually.

Here is the commit which added it without any explanation:
https://github.com/torvalds/linux/commit/270cab2426cdc6307725e4f1f46ecf8ab8e69193

should we remove it seen as there's no explanation given ?


On Wed, Apr 24, 2019 at 3:32 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Apr 24, 2019 at 03:18:59PM +0100, Tom Murphy via iommu wrote:
> > check if there is a not-present cache present and flush it if there is.
> >
> > Signed-off-by: Tom Murphy <tmurphy@arista.com>
> > ---
> >  drivers/iommu/amd_iommu.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> > index f7cdd2ab7f11..8ef43224aae0 100644
> > --- a/drivers/iommu/amd_iommu.c
> > +++ b/drivers/iommu/amd_iommu.c
> > @@ -1636,6 +1636,12 @@ static int iommu_map_page(struct protection_domain *dom,
> >               pte[i] = __pte;
> >
> >       update_domain(dom);
> > +     if (!dom->updated) {
> > +             if (unlikely(amd_iommu_np_cache)) {
> > +                     domain_flush_pages(dom, bus_addr, page_size);
> > +                     domain_flush_complete(dom);
> > +             }
> > +     }
>
> The two conditions can go into one if statement to make this a little
> more clear.
>
> And I'd really like to understand the unlikely - amd_iommu_np_cache
> is set based on a hardware capability, so it seems rather odd to mark
> it unlikely.  Dynamic branch prediction really should do the right thing
> here usually.
