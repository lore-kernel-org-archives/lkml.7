Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDD9C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0401D215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 02:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/fh+FfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfK1ChW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 21:37:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36021 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfK1ChV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 21:37:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15so26724627lja.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 18:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5REmEVOpMqicZFWt4ii+unqDoEikVdqlvJoPRKCdKbo=;
        b=L/fh+FfYxt1npHHb26t0HZ9oc+ybSMlfF9Vbyp4+lUCnaWKHLBsLPaVTDI6CtUNHnI
         07OJ32QxcISH3XQ+mD0bUn5itsgSNyn9KBAHH8qbshbIHOoZGA5ggU6pCv201AY9h2ez
         4xH8drxFjr7TLlylEIEVPMdho4qZ+2f8U/6DO9iEpAi+HEkKVFv9FQjw/sFhVR5/uSdo
         itp8xCu305vLuX6kn4vx6zcwEgdAScgMne50ZlJbUs8RPBHsfq+lMih86FSvCoj4ELQd
         q7sJZKtR3rE3ozluM8bOsLR1+OglysejpkxzWvTiVp160Er55cowTlRWhrhFuVEqKiY1
         l/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5REmEVOpMqicZFWt4ii+unqDoEikVdqlvJoPRKCdKbo=;
        b=KUu4io/57BoWb7eVWbuim4C1B4V2jYC33NLKdHJaHOqLXgs5aJPJy5XmiAnnmqz1oQ
         /fpHYVvCVEemclSgGUYWzxa7WjS794mP1aF9JwvaYNgQC4o6ESU86prCBCZlKqyrxqHp
         ieBa86fo3mKourKDAncqQVHX/oRjACaIyVrtk2N+ZVFHjvU8FwQwehayhnh2rVVRvchq
         uScW4jM61rscXrVQ+NgHHjKeu/s+C2ujup2seuchEaGYM245m4K8F/cssgvyjVNNxIcz
         o/XxTJMd0veSeezXcTw6tyofXqLEafzy4TKLpZQd6py4lM/O0tUelDM0LoP4LHTlRlWE
         nzng==
X-Gm-Message-State: APjAAAXwjbKGJKZK+u8u8UM0MP4ZyDxtvm8HazKEgI+StUw5Txy7zjAd
        eJ9HHbSOp8YOpdIg1v2gNGzoy4R2MPW0Gx/FriI=
X-Google-Smtp-Source: APXvYqya2Qp6M4J9fgghKq2sCsVrxPF2sfveO3PoJ+Zjj5QngKx+1ACuq2onZ4LY00tt63rnX36CO1bO3kkuHqIK1BA=
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr33530905ljq.20.1574908639457;
 Wed, 27 Nov 2019 18:37:19 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9ty6MLNc4qYKOAO3-eFDpQtm9hGPg9hPQOm4iRg_8MkmNw@mail.gmail.com>
 <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
In-Reply-To: <CAHk-=whdhd69G1AiYTQKSB-RApOVbmzmAzO=+oW+yHO-NXLhkQ@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 28 Nov 2019 12:37:06 +1000
Message-ID: <CAPM=9tz3pFTOO45pGcZv+nGf29He-p03fXHbG4sNoCYxZzXkRQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.5-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 at 11:51, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Nov 27, 2019 at 4:59 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > my sample merge is here:
> > https://cgit.freedesktop.org/~airlied/linux/log/?h=drm-next-5.5-merged
>
> Hmm. I think you missed a couple: you left a duplicate
> intel_update_rawclk() around (it got moved into
> intel_power_domains_init_hw() by commit 2f216a850715 ("drm/i915:
> update rawclk also on resume"), and you left the "select
> REFCOUNT_FULL" that no longer exists.

Oops so I should have more caffeine before I did that merge, thanks
for catching those.
>
> And apparently nobody bothered to tell me about the semantic conflict
> with the media tree due to the changed calling convention of
> cec_notifier_cec_adap_unregister(). Didn't that show up in linux-next?

I can see no mention of it, I've got

Hans saying

"This will only be a problem if a new CEC adapter driver is added to the media
subsystem for v5.5, but I am not aware of any plans for that." when I
landed that
in my tree, but I assume the ao-cec change in the media tree collided with it.

But I hadn't seen any mention of it from -next before you mentioned it now.

Dave.
