Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340BEC4CEC7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0910120644
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 15:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHVrhAIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfINPni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 11:43:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37669 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfINPnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 11:43:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id i1so29547110edv.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7hV0MZv/AgzA3SV2umv+bCKTqcvOG8PODShBqrdIfPQ=;
        b=HHVrhAInl82Mt5UsRke9ItQ0hbKadb+zGyYFA2p7t//I6afWDUISogJqVeDIgX70rN
         2JoXv5bkW2gTazwZ1tl6AsjMz4JNQmxPdneG27ankkEszRU4ngNGrzqEUqK7Tk5sGjem
         2k/2tf6Dg4eGCmrhx+CppejtiKG7Fi1RJqduFWOBFVLUf1ddwq2BjdOI6PZLY2LP+9My
         pcwqa0fmyhOpE0rpLHtsO0tGxQPDVrhA+UrJBKv/2+KhuZtsRy9y8sjnvSIn1/bENLuG
         HLQNLxPKdGPzuZ0DPN2dS1GESs5GBmzd9YDfBLDRBuc3wquzW7iv+3HRrGfZfp+5RL47
         F0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7hV0MZv/AgzA3SV2umv+bCKTqcvOG8PODShBqrdIfPQ=;
        b=l9aVj6S3nHodlNmmmEehG6I5a4VvyyWIPqG6C17szYMBVUZhp3f2TUcco5kDML1c7S
         S/hYUTxRaifrDCRE2lHQp0S7TAIh3U1zZ+LqDqclMHqg3/BB9xDsybvO/ur0YQAfGHcG
         CoYkc6J2DbJWvEbF7AZTFYOJ/t3OEcnqpF5zlJ7HWEL7UENHrk2Mc/eZDAjqSaYbCtG/
         Ci7rFEY4CCn1wtBY5HspAhSL8XW+b7gHd/mivCAC4aT9eVkcUB1y+Foe+7FJ9Sj9d0qN
         Hnz144oucEoH29Oejb9Qr79YRzojnihKWCDZppAuLK+Yj6u2nkhO1GP1WBRZsmrNxJbC
         wadA==
X-Gm-Message-State: APjAAAWbotdCSXxQ6hJAgtxa7X+3WAX+cn0hB3Nr0Jm3yf+HUlOexjYj
        ybljRhighFGmP2TVAkblOyWwqY4kWCrGFPnJRcc=
X-Google-Smtp-Source: APXvYqznWW+0BxbJIAZP+1jswzi3dJcuHQKsaGdvPEqC2+VRjJW+e/KQnSnQZLZAE+WOXWyylHlrTrrhBE6G1kOrBB0=
X-Received: by 2002:a17:906:2451:: with SMTP id a17mr35125242ejb.164.1568475814084;
 Sat, 14 Sep 2019 08:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060550.62095-1-john.stultz@linaro.org>
 <CGME20190829173938epcas3p1276089cb3d6f9813840d1bb6cac8b1da@epcas3p1.samsung.com>
 <CAF6AEGvborwLmjfC6_vgZ-ZbfvF3HEFFyb_NHSLRoYWF35bw+g@mail.gmail.com>
 <ebdf3ff5-5a9b-718d-2832-f326138a5b2d@samsung.com> <CAF6AEGtkvRpXSoddjmxer2U6LxnV_SAe+jwE2Ct8B8dDpFy2mA@mail.gmail.com>
 <b925e340-4b6a-fbda-3d8d-5c27204d2814@samsung.com> <CALAqxLU5Ov+__b5gxnuMxQP1RLjndXkB4jAiGgmb-OMdaKePug@mail.gmail.com>
 <9d31af23-8a65-d8e8-b73d-b2eb815fcd6f@samsung.com> <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
In-Reply-To: <CALAqxLVP=x9+p9scGyfgFUMN2di+ngOz9-fWW=A1YCM4aN7JRA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sat, 14 Sep 2019 08:43:23 -0700
Message-ID: <CAF6AEGsaE9M_kyRxm5en1vxs=GQLcaaJsdREfR1kdegz8dHFcA@mail.gmail.com>
Subject: Re: [RFC][PATCH] drm: kirin: Fix dsi probe/attach logic
To:     John Stultz <john.stultz@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Matt Redfearn <matt.redfearn@thinci.com>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 7:39 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Wed, Sep 4, 2019 at 3:26 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > On 03.09.2019 18:18, John Stultz wrote:
> > > On Mon, Sep 2, 2019 at 6:22 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > >> On 30.08.2019 19:00, Rob Clark wrote:
> > >>> On Thu, Aug 29, 2019 at 11:52 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
> > >>>> Of course it seems you have different opinion what is the right thing in
> > >>>> this case, so if you convince us that your approach is better one can
> > >>>> revert the patch.
> > >>> I guess my strongest / most immediate opinion is to not break other
> > >>> existing adv75xx bridge users.
> > >>
> > >> It is pity that breakage happened, and next time we should be more
> > >> strict about testing other platforms, before patch acceptance.
> > >>
> > >> But reverting it now will break also platform which depend on it.
> > > I'm really of no opinion of which approach is better here, but I will
> > > say that when a patch breaks previously working boards, that's a
> > > regression and justifying that some other board is now enabled that
> > > would be broken by the revert (of a patch that is not yet upstream)
> > > isn't really a strong argument.
> > >
> > > I'm happy to work with folks to try to fixup the kirin driver if this
> > > patch really is the right approach, but we need someone to do the same
> > > for the db410c, and I don't think its fair to just dump that work onto
> > > folks under the threat of the board breaking.
> >
> >
> > These drivers should be fixed anyway - assumption that
> > drm_bridge/drm_panel will be registered before the bus it is attached to
> > is just incorrect.
> >
> > So instead of reverting, fixing and then re-applying the patch I have
> > gently proposed shorter path. If you prefer long path we can try to go
> > this way.
> >
> > Matt, is the pure revert OK for you or is it possible to prepare some
> > workaround allowing cooperation with both approaches?
>
> Rob/Andrzej: What's the call here?
>
> Should I resubmit the kirin fix for the adv7511 regression here?
> Or do we revert the adv7511 patch? I believe db410c still needs a fix.
>
> I'd just like to keep the HiKey board from breaking, so let me know so
> I can get the fix submitted if needed.
>

Does the kirin fix break things if the adv7511 patch is reverted?  If
not, I'd submit it anyways.

Hopefully by next weekend I'll be finished with my move and unpacked
enough to be able to setup db410c + monitor to start working on fixing
db410c.  So perhaps one option would be to wait a week, and see if I
can come up with something small enough to land as a post-merge-window
fix, with the fallback being to revert and try again next merge
window?

BR,
-R
