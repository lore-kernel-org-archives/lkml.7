Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD75BC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EEA20679
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8RSZqq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfHSXZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:25:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37451 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfHSXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:25:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so974072wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RI2i+ZmVIneVzAnzEN5HZB0xPiD2U6L93Cbq2/BjWMc=;
        b=B8RSZqq6HMnH/WHrtR2nEisw9Iz4dvSDHQRtWAnkMNAKL2FKAjaehkv/oy3fER8wBu
         sizh9XNs6XIrrWr8V7wm24KAUg3htcBWBfulCRfqq9xHEnE7kpwM943I88zC3GQMf+pD
         jSv0BR4MVKgQO4PqDpAufxcq3d39qCEpGEe7lEVdpwYCY1rp94vrpG74Ck3LPgXcyVWo
         jq1E1BhJ7kye6J51x2g7U/QHgZ9jB8Hbd4qxls9Q6j00+JDD0ofNHgXzCV96GtGl1Wfj
         qIYR7TxuTGDC2IriNr7coqLv5GFdgQtv9eNKije+Ibxs0R1ffrXYdxy4D1OnJqnUQyE0
         GFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RI2i+ZmVIneVzAnzEN5HZB0xPiD2U6L93Cbq2/BjWMc=;
        b=HR7+FOWtFGUXsr5q9pz63sYJznlzasqMEdDh8UpSrgKmykDAIfNwa/G+KNF4Psdytw
         1wN18v/45FPw3ZHJrTO74FdIPZDsGiyUCITxkOyS5wdKMVo2MZq+SpM5w6cjccFGWNnz
         hqZ3zWHgcuNGpaYmMdg+ewo1NFcHAMNxDjgARsQXBpZqdyaRa1KbquGKobIi8dRP4tHr
         +jJebae+jA5BAiz6qY1jw5oDNEILk8oR8YGAim7C1frAyLm3Od/I1wCSRNBNnoPTSE+/
         VQx7TrDynW197AjxfMTQkXwK/TrqYgz0EBjBbR5WpappETBU/Mi1xFNmgbKBlZkzOR5j
         Lf8w==
X-Gm-Message-State: APjAAAVymOIMS3Wdy7xw9vadsLKnm3cP7zpVAP5wHLjU/5sBF/iiEFoH
        eyBB9cOgQF0BRCvvKHdqgx80bDCqOENWkzAL3h0adw==
X-Google-Smtp-Source: APXvYqx3edDM9AlFjypdPYMEunUXS9sBqznDgRPvSCwQ6lY8zlb/2fEuWVBPNLSfZecPHsiNgEz7TCCGJi/jriJlfkg=
X-Received: by 2002:a1c:f910:: with SMTP id x16mr5413369wmh.173.1566257132989;
 Mon, 19 Aug 2019 16:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190814184702.54275-1-john.stultz@linaro.org>
 <20190814194508.GA26866@ravnborg.org> <5D5A045C.5020707@hisilicon.com> <20190819044054.GA8554@ravnborg.org>
In-Reply-To: <20190819044054.GA8554@ravnborg.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 19 Aug 2019 16:25:21 -0700
Message-ID: <CALAqxLUzmScmAHErR6jLxR1ZnaezanhyA8SgB9LLU60x87N4Pg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v3 00/26] drm: Kirin driver cleanups to prep for
 Kirin960 support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     xinliang <z.liuxinliang@hisilicon.com>,
        YiPing Xu <xuyiping@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 9:40 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > > As Maintainers can we please get some feedback from one of you.
> > > Just an "OK to commit" would do it.
> > > But preferably an ack or a review on the individual patches.
> >
> > As I have done a pre-review and talked with the  author before sending out
> > the patches.
> > So, for this serial patches,
> > Acked-by: Xinliang Liu <z.liuxinliang@hisilicon.com>
>
> Thanks!
> We all know how it is to be busy, especially when trying to keep up
> after role changes.
> Unless someone beats me, then I will apply tonight or tomorrow.
>
> > > If the reality is that John is the Maintainer today,
> > > then we should update MAINTAINERS to reflect this.
> >
> > I am assuming you are talking about the kirin[1] drm driver not the hibmc[2]
> > one, right?
> > I really appreciate John's awesome work at kirin drm driver all the way.
> > Honestly, after my work change from mobile to server years ago, I am always
> > waiting for some guy who is stably working at kirin drm driver to take the
> > maintenance work.
> > John, surely is a such guy.  Please add up a patch to update the maintainer
> > as John, if John agree so.  Then John can push the patch set to drm
> > maintainer himself.
> > *Note* that the maintainer patch should break hisilicon drivers into kirin
> > and hibmc two parts, like bellow:
> >
> > DRM DRIVERS FOR HISILICON HIBMC
> > M:  Xinliang Liu <z.liuxinliang@hisilicon.com>
> > ...
> > F:  drivers/gpu/drm/hisilicon/hibmc
> > ...
> >
> > DRM DRIVERS FOR HISILICON KIRIN
> > M:  John Stultz <john.stultz@linaro.org>
> > ...
> > F:  drivers/gpu/drm/hisilicon/kirin
> > ...
> >
> > [1] drivers/gpu/drm/hisilicon/kirin # for kirin mobile display driver
> > [2] drivers/gpu/drm/hisilicon/hibmc # for server VGA driver
>
> Hi John
>
> Up to the challenge?

I guess if necessary, though I don't believe myself to be a great maintainer.

Though I do have the hardware, am regularly are testing on it, and
maintain a tree of patches to keep it working, so I can validate basic
correctness and handle patch wrangling.

> If yes then please consider to apply for commit rights to drm-misc-next.
>
> And read:
> https://drm.pages.freedesktop.org/maintainer-tools/index.html
>
> See this to get an account:
> https://www.freedesktop.org/wiki/AccountRequests/
>
> You will need an ssh account for drm-misc-next as it is not (yet?)
> gitlab enabled.

I'll try to find some time to read through the above and apply.

thanks
-john
