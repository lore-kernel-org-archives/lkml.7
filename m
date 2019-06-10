Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C061C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E397A2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560181144;
	bh=FUq4suVrLDG1IIUGHRa6j68aD+lmlr5m3QrCVHn3MRk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=AVgieBpgEIBUt/NZyOojGJ/j3srwfnlaZDntITNazT6iF/NAHRFTu/5pTJSrHVUzQ
	 2y8bA8Yumfn/wyjvW84ZB63JSu9HZ6uAd0pZyUP4NLXCSDszMwnZyb5TQ3XqFcl70B
	 sBVjtjonzjfkcLWvxJe73iCBm94y7yxTc6hFFbAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391236AbfFJPjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390073AbfFJPjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:39:02 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4501620862
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 15:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560181142;
        bh=FUq4suVrLDG1IIUGHRa6j68aD+lmlr5m3QrCVHn3MRk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ebj/TmAvxM0eiGfq3QcwS2BkcymUD0stm2bTsz0n8ZOJRWDPyP5QsRds40ChtEZ2C
         4GnECJUzxfGHbm1yTUV6Am58NDs+mdLh34UCBUw+mhOLnFulQUc7uq+GZ8sgN5IQOh
         soytCp1XBOaDXaWt+KSm3yFKcFGhOOL6ITbKtjTY=
Received: by mail-qk1-f171.google.com with SMTP id a27so5770244qkk.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 08:39:02 -0700 (PDT)
X-Gm-Message-State: APjAAAUhtq4+KL/lmqWsWPucwfgZs9PGm9QT1nVxpfRKeHAQ2i6asN+1
        /i158Lg9QmbGM/tNhsVI3QCRKLtk12LRtbeyuw==
X-Google-Smtp-Source: APXvYqxtJEfJeRvwWEg6MNQXNzIIbLv/Gxxvs+vk6RDEbINaMiaAilnhmqNDT1gk37a1acPPEUw5WPTz61G0WylDaBU=
X-Received: by 2002:a05:620a:13d1:: with SMTP id g17mr1603265qkl.121.1560181141516;
 Mon, 10 Jun 2019 08:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190520092306.27633-1-steven.price@arm.com> <20190520092306.27633-3-steven.price@arm.com>
 <CAL_JsqLzefOvopTCuyBsNhJDGbFV3JdVce0x398vMaGy3-+fVw@mail.gmail.com>
 <155846303227.23981.8007374203089408422@skylake-alporthouse-com> <a4cd9ada-aaf1-3bd8-a138-f61308baf70c@arm.com>
In-Reply-To: <a4cd9ada-aaf1-3bd8-a138-f61308baf70c@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 10 Jun 2019 09:38:50 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+KpJHgyx017u78+D0HX03NNJuK=fYVES5J1dEpQroeEQ@mail.gmail.com>
Message-ID: <CAL_Jsq+KpJHgyx017u78+D0HX03NNJuK=fYVES5J1dEpQroeEQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panfrost: Use drm_gem_shmem_map_offset()
To:     Steven Price <steven.price@arm.com>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 6:39 AM Steven Price <steven.price@arm.com> wrote:
>
> On 21/05/2019 19:23, Chris Wilson wrote:
> > Quoting Rob Herring (2019-05-21 16:24:27)
> >> On Mon, May 20, 2019 at 4:23 AM Steven Price <steven.price@arm.com> wrote:
> >>>
> >>
> >> You forgot to update the subject. I can fixup when applying, but I'd
> >> like an ack from Chris on patch 1.
>
> Sorry about that - I'll try to be more careful in the future.
>
> > I still think it is incorrect as the limitation is purely an issue with
> > the shmem backend and not a generic GEM limitation. It matters if you
>
> Do you prefer the previous version of this series[1] with the shmem helper?
>
> [1]
> https://lore.kernel.org/lkml/20190516141447.46839-1-steven.price@arm.com/
>
> Although this isn't a generic GEM limitation it's currently the same
> limitation that applies to the 'dumb' drivers as well as shmem backend,
> so I'd prefer not implementing two identical functions purely because
> this limitation could be removed in the future.

In interest of moving this forward, how about some comments in
drm_gem_map_offset() explaining the limitations and when it is
appropriate to use the function.

Rob
