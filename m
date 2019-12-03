Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68887206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdzFujST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfLCQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 11:47:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42078 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfLCQri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 11:47:38 -0500
Received: by mail-qt1-f195.google.com with SMTP id j5so4394706qtq.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 08:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kpLW4+KBKC6+++fy2CkOyNZVdF+06Q7ITsR6tw96vos=;
        b=CdzFujSTmuuhIBF3/5QBVwnMq1Ebiw0TNuO1H0GryrK2l/e5ltTktcxhdb6RkWuKH3
         9BXU1wGN+OdXCmwRMLRWLqYZV0mkKmq5ot4Ji4TkUeeIsPb2Pr8/i5F3s2Dub0AALgUu
         d5BIJ++q3ZZJXCgxHONBHfAhaK0+oxD49cJAUctFMAV6ThnxyVsDLRfIjdtRPNBtuOIE
         XgfUCejJD4NjewxHKzIfGugOaisG2af1+iDIZVB8d+V9E6+TY1fWNRIdm1KJ6yggCeAA
         B/Dm2uvZzGE8Du3MkNZrmv72+RkU7xs6P1mrrXhaKqQtQZxj13iW62ezC/fFHMwafepD
         LyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kpLW4+KBKC6+++fy2CkOyNZVdF+06Q7ITsR6tw96vos=;
        b=U0T20uLTa2vPqhaITh+MeTxFKaiM2bEQmLmUGlx9qmkrvM7ndb94knMv34asFV7y5E
         m3gy+y3TIqDKUyAW4/T3JZj7rZxK45/U3mw07BVxfN6TaYuCDg+wErfl0h5VyUrr5UYb
         0mJZ0ki6jAX5kptLI2BKVILjWjEUSzJ3wIZYJUBhSj3eh5olJR1JM42j29NiDyz1XUT9
         VyoWRrkIs/kv9xgPBuzbRy1QNcyiavtRC3i706+Pajc9F579YcT8hIN7dTLsFeUGKRX7
         21WT/XjzoZn7si4cgrdFltZMQwhuUskUZWlQiJyWJPGo6IBKViD2q1ty1wtdjQ3HF8bI
         sdCQ==
X-Gm-Message-State: APjAAAWCMRG3M7oBvXuMS0DTzU1R3UKRUCZHHa5hEu/mTGKINWvwiYEa
        Tn5npOY3nqJGhT5EGHHQiKVrdx59Jd1H60pjGor2XQ==
X-Google-Smtp-Source: APXvYqxYAfVYzcBQqzY8M6/6NJdEMGC/11QBvfJGgQcOPTqmt53UtXeQCKjQYt5E9An2PS+idDwqh4H1BlqSqvSseYo=
X-Received: by 2002:ac8:6651:: with SMTP id j17mr6016484qtp.115.1575391657081;
 Tue, 03 Dec 2019 08:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20191119125805.4266-1-benjamin.gaignard@st.com>
 <f6f32b4d8d8e271953f887c50793f9d64d48e7b3.camel@intel.com> <6ad4ff49-240b-a665-d229-20e177fa6b2f@st.com>
In-Reply-To: <6ad4ff49-240b-a665-d229-20e177fa6b2f@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 3 Dec 2019 17:47:26 +0100
Message-ID: <CA+M3ks4b222JuwrmujLrTwXZJC-aE0mo9B+fNg-9NgH7X8=y3w@mail.gmail.com>
Subject: Re: [PATCH] drm/crtc-helper: drm_connector_get_single_encoder
 prototype is missing
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "Souza, Jose" <jose.souza@intel.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "sean@poorly.run" <sean@poorly.run>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 20 nov. 2019 =C3=A0 00:28, Benjamin GAIGNARD
<benjamin.gaignard@st.com> a =C3=A9crit :
>
>
> On 11/19/19 7:53 PM, Souza, Jose wrote:
> > On Tue, 2019-11-19 at 13:58 +0100, Benjamin Gaignard wrote:
> >> Include drm_crtc_helper_internal.h to provide
> >> drm_connector_get_single_encoder
> >> prototype.
> >>
> >> Fixes: a92462d6bf493 ("drm/connector: Share with non-atomic drivers
> >> the function to get the single encoder")
> > drm_connector_get_single_encoder() is implemented before the use in
> > this file so it is not broken, no need of a fixes tag.
> >
> > Reviewed-by: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
>
> I will remove fixe tag before push it.
>
> Thanks,
>
> Benjamin

Applied on drm-misc-next with out Fixes tag.
Thanks for the review.

Benjamin

>
> >
> >> Cc: Jos=C3=A9 Roberto de Souza <jose.souza@intel.com>
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> >> ---
> >>   drivers/gpu/drm/drm_crtc_helper.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_crtc_helper.c
> >> b/drivers/gpu/drm/drm_crtc_helper.c
> >> index 499b05aaccfc..93a4eec429e8 100644
> >> --- a/drivers/gpu/drm/drm_crtc_helper.c
> >> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> >> @@ -48,6 +48,8 @@
> >>   #include <drm/drm_print.h>
> >>   #include <drm/drm_vblank.h>
> >>
> >> +#include "drm_crtc_helper_internal.h"
> >> +
> >>   /**
> >>    * DOC: overview
> >>    *
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
