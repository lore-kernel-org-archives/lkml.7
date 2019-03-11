Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F08C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B45B720857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxAmAyXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfCKOti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:49:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45890 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfCKOti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:49:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id v20so2023456qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XlVUh0mgDC1VL44A8Q/ZXFDCTKY5FpX7/4yaSiNoXb0=;
        b=WxAmAyXYZ/sNvBK5zz9o0MsP6OxRXVUYCZT44SOsaBLq5RT2vKazB66C6Gj7R+rwtk
         7GLMXbYMTpa2JQawaibCTq/osgA66oYsSwyYhrawufcBfUpcfd3otu9kBacqVYeGjZ2c
         u6/wH8+iKDjBOFo3SRZypwFM7b8406pyMPuJwbrjtc9y4813+mES63HYTFZ9+UoWvDxC
         Pr8cE1/O6EhirVYUI/nOcQGc+Hx/zffOBPPDOkJDVaaQof+7l2lzTE2xhDLzwnJ7pJYD
         RdZ7KqkiVW+f7q8r5ZPHVahaipp8Xk4BUVWskgYYG4vAkN197qdfGsr9xF6N+iOtiVMO
         eMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XlVUh0mgDC1VL44A8Q/ZXFDCTKY5FpX7/4yaSiNoXb0=;
        b=Vn8DK4sXZaWWWn/qEBN+D4BalXlSS5rBc7H1k0NHce5qLxImtwUE8efZWk0yjGyY1o
         nxFRDkDBqaSQBec7QkbUqF5fB9msKocIIG6op361e3f0OExjXLMN2LdZwWgUC7EWbeiS
         IvXs5hyttuBFUgpQdvtSEeZDptUwjDMeu5lqwb0HsfWG/SRE8wS06SKw/LCZ03rP0EKE
         2IYRuIBNKJMOzpo1tGTYdKlVJXaHGfvKH4jTjWOoisEWQ8yhEy6mLSaq7BNlpRREG6oK
         6VztkbwgonjqrnxNIyHOZV+Tq/2svVoC9FYVBumj17kmHhUwB6UjvNpTCw2p3D4Q1qgn
         /P+w==
X-Gm-Message-State: APjAAAXThD8b+Oj8j0Uje8vM1M4H552gXUlPBhAzskZX9OGPx6o02cZn
        MAhYD+7VAwEcc1B587IGH1mQ4sUgzD34i8eOzX+PAg==
X-Google-Smtp-Source: APXvYqzkPkpMxjJLNll89nhZHwHnUP2vqC11XucBdtSBxAzXIoGXZR1UpmU+nK6YhTl7ChdpsHKyxGiqTeIu8RTJRbQ=
X-Received: by 2002:ac8:25d1:: with SMTP id f17mr24924035qtf.38.1552315777119;
 Mon, 11 Mar 2019 07:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190307155323.2949975-1-arnd@arndb.de> <d69abbf5-faf6-d169-2a0c-f440e17ef011@st.com>
 <CAK8P3a2Y-H9v6dFNUPLOFEVJka8+w+5X9VuQETXn539K90fHQQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2Y-H9v6dFNUPLOFEVJka8+w+5X9VuQETXn539K90fHQQ@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 11 Mar 2019 15:49:25 +0100
Message-ID: <CA+M3ks62fxwnKR0tHyVUPdxnjNh0ysjtN5bs3u+TD4M_LWpwyw@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: fix CONFIG_FB dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 11 mars 2019 =C3=A0 15:24, Arnd Bergmann <arnd@arndb.de> a =C3=A9cr=
it :
>
> On Fri, Mar 8, 2019 at 4:50 PM Yannick FERTRE <yannick.fertre@st.com> wro=
te:
> >
> > Reviewed-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
>
> Thanks,
>
> > Arnd,
> > could you merge the patch?
> > I think that Benjamin could also merge it.
>
> I think this should go through the drm tree, so someone with
> access to that should merge it, not me.

Applied on drm-misc-next,
Thanks,

Benjamin
>
>      Arnd
