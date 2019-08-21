Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330CCC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1817206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 06:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9E4nxzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfHUGeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 02:34:11 -0400
Received: from mail-ua1-f52.google.com ([209.85.222.52]:35433 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfHUGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:34:11 -0400
Received: by mail-ua1-f52.google.com with SMTP id j21so460157uap.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cldCocYqDJhDAW6mUCiaKahQrJ4+bnhSa/eeLTEHE20=;
        b=b9E4nxzDDgDhTa72QcuCf0+Ri0ENZZAcmmRDzScGsGvbITS9f4GrFF553zte4BaIWy
         OE/PKMbCOv0G9cVrDaB6WW02z+M+WSYHQIFOxjb2xBCqPBMZ0BRVJrylWhDMGzJScBsc
         mlpo7sFmpTzA98YeuPn9PENW/5F3rTb2WYE6E8m19fnOQn0NY3DLmEsvt7XB9Oy0hXz8
         ACsStPZ/Yz2cBZEpwsBqbL41GAGwUHWtxhcJpymaZh8ClSeFDiSehXvSLsop2TCNicK4
         7K1XTJCjrkh3JfsDsuOW4locPmvjKygw+v6voagM6ieXmvA2w1iYdwrFNPbWHSZVd++y
         vlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cldCocYqDJhDAW6mUCiaKahQrJ4+bnhSa/eeLTEHE20=;
        b=TOFCQk9sGQZebCS7u35YVzurwiAvZTXXyZi+ubUnXe87AQTnQB5nQKKaep3trP6+zh
         TuD8SO4zuN1JQMnkrie/TGBEtVylLk7h7C3g+M2KovTISkE5XzfkatKfScivRHDMgXp/
         yl7HXe/9EL/032aERqzk4t3dg29IxEF2bTkpMb0duiH+5GaUHdTAFAtF8Uo/dcjWmKs+
         Kqs3rVtfuILNokUx7P0Nd0dsG54pHdKmCJ4py6YaVR/CgtNw7cgjUQmLZpVsj5eo21OK
         QH916QcvT6arjZvtwJXtdpbw9WPbZv2X6vLe1pK+Rn+3GAfMWCaCem25+1UefGEFtSdd
         P/kw==
X-Gm-Message-State: APjAAAVYLSwA/KMivgbP9NHF7hJpT4iWzU3DuQKDHtiAazICvPMB9jP0
        xU9JM2XiGLTRckuhtVoFHLG2r6c5+mFR1dzDMQo=
X-Google-Smtp-Source: APXvYqwV9IXC4VAQSFpeJVeWe8GCDuXR5CxR2jhJJ5ME0hbNNdFy/JCuN0h4tWjJOe7dtaWWt4EHjhL2ip8PbkMN74E=
X-Received: by 2002:ab0:70c8:: with SMTP id r8mr1298852ual.89.1566369250021;
 Tue, 20 Aug 2019 23:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190805140119.7337-1-kraxel@redhat.com> <20190805140119.7337-9-kraxel@redhat.com>
 <20190813151115.GA29955@ulmo> <20190814055827.6hrxj6daovxxnnvw@sirius.home.kraxel.org>
 <20190814093524.GA31345@ulmo> <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
In-Reply-To: <20190814101411.lj3p6zjzbjvnnjf4@sirius.home.kraxel.org>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Wed, 21 Aug 2019 16:33:58 +1000
Message-ID: <CACAvsv5Rar9F=Wf-9HBpndY4QaQZcGCx05j0esvV9pitM=JoGg@mail.gmail.com>
Subject: Re: [Nouveau] [Intel-gfx] [PATCH v6 08/17] drm/ttm: use gem vma_node
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com,
        Ben Skeggs <bskeggs@redhat.com>,
        spice-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 20:14, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Changing the order doesn't look hard.  Patch attached (untested, have no
> > > test hardware).  But maybe I missed some detail ...
> >
> > I came up with something very similar by splitting up nouveau_bo_new()
> > into allocation and initialization steps, so that when necessary the GEM
> > object can be initialized in between. I think that's slightly more
> > flexible and easier to understand than a boolean flag.
>
> Yes, that should work too.
>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Ben Skeggs <bskeggs@redhat.com>

>
> cheers,
>   Gerd
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
