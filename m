Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B612C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E24520865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hC0MBIOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfJCOjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:39:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfJCOjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:39:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id l21so3065454lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4BJLNO1nnen45Bue2c6+QWaeFM+NUXNmcN3wO45Wjs4=;
        b=hC0MBIOv99lcqwkgOhJzHbxuJlcR6UF11aD7HCAkB+aMXleaIUPfDtuEhjp6Ud7d+x
         gc6pmY7bL6tUuRbDywxqB2J1WoqqeFNyN3xiImutQAV/zgR4UA2rO340ledNR6F1IFs3
         mm2WmSNfSZovnGWCgHRa3qXWdVCpR3aLeiwiO6por1NWIvZAjlICR0XQpHQ5ALMdJ8VO
         P/IbGz/GiceRUiREKV8kuNinDvh37Z36Rqk4olPswDk8y8QYDiPbFXQfADJH3Lbk2e5e
         gBthUT6vqbA76lABDQcff4RdYexJ2iqxpFCN6h4oTv2KvxCaqZWOrO86moQQ+fO7uOG8
         vJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4BJLNO1nnen45Bue2c6+QWaeFM+NUXNmcN3wO45Wjs4=;
        b=B+NmP4vYmOZ1Tyfk/RtBu0UQPM7SWZXdvegPAG+NBDc/mjICKYF0LeFr4aWByoiGKm
         2STBzrSVe3I3R2D+T5ZmN4lA4sBnSUQum3m+ZOwPaH2KbENu/PuntmRw0Qw4WNA6pwZ2
         N3yx500fAr8fBGAFuld3q85HVQvpFpiIv1RRr0mGD0Zax0ho0d6y0NolgKqJwwRkW7qm
         XSMI4/cjdOKcfJDxxAEWYbsrHn26L0knW/aOwc3ekArvu1lfDbcuIZIqNKNi7ej6w38i
         eI9a1bBKZL9q5221/TazykB5RH4q9Y+SmFsi9sOF4qlOSMmz+rq9FZ+qDVNjVCTXCQfa
         14iQ==
X-Gm-Message-State: APjAAAXYkOVQKdw2iylO+rNoVy/K/drTiQmgdoGTYAXtReNhUGHaA7yk
        WOfZ3x738+kC2p5iTAjjdGimEm/79OsWAspUnsKMOQ==
X-Google-Smtp-Source: APXvYqyoTjg2yu9W/7cu3VsJfhVSAP4iuY3SW2NhSndP3RLZVIIhRQXVpWq1aumTQgFWXKRgi+Y6WuTDVZSWQEpGVBM=
X-Received: by 2002:a2e:5dc3:: with SMTP id v64mr6532816lje.118.1570113590655;
 Thu, 03 Oct 2019 07:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191002153827.23026-1-j.neuschaefer@gmx.net> <CACRpkdZ0ekYtZ4bZ-A4NZN6HO6XJzwpdZ_HjUL=FoWfG08UBtg@mail.gmail.com>
In-Reply-To: <CACRpkdZ0ekYtZ4bZ-A4NZN6HO6XJzwpdZ_HjUL=FoWfG08UBtg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 16:39:39 +0200
Message-ID: <CACRpkdYDuAx6OhFYiXT+79a1NphtfPQfyY=o7jKi0Bas5vr7+g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mcde: Fix reference to DOC comment
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 4:34 PM Linus Walleij <linus.walleij@linaro.org> wro=
te:
> On Wed, Oct 2, 2019 at 5:39 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>
> > The :doc: reference did not match the DOC comment's name.
> >
> > Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
>
> Both patches applied!

...but I can't push the changes:

$ dim push-branch drm-misc-next
dim: 9fa1f9734e40 ("Revert "drm/sun4i: dsi: Change the start delay
calculation""): committer Signed-off-by missing.
dim: ERROR: issues in commits detected, aborting

Not even my commit, apart from that it looks like it does have
the committer Signed-off-by. I'm confused and don't know what
to do... anyone has some hints?

Linus Walleij
