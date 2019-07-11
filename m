Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38BBC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889A720665
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 12:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfH6sWli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfGKMMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 08:12:40 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42953 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbfGKMMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 08:12:39 -0400
Received: by mail-yw1-f65.google.com with SMTP id z63so3155419ywz.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JLpZTDyH6Q/WVfB7D3ohVeoj0U2p4Tl2uxiI/qIEuhc=;
        b=EfH6sWliBwbfu8sqP4opjoREUcenXWr13a17h77Bpj68HtnncvSRktKCJdngvBVDGj
         iQx8/rI+Ht34P/XquSJHbApJUdh/UZEkkZEz6DXXyvlFkxrKzcbRGI11PUWT4qaM5eeY
         RplKIYBYyVnToeLtjPy3d7F1sWPNJA7VDNZTfUw9nlEj/xUpi1Mzv19F2vrUPMFbxpiZ
         1v0pI61zsb31WW2gsjIrMIAhYnAM3rAFhzTNgZnEKm2OShiMCPC/5+n9YVP7gjT/fXCp
         9XvWqs7A+pS5OONot6+lyJ8pIxT6uzZFhhl2voygxFNNN5eSCQm/I10uk6fgYHZtUFc2
         mG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JLpZTDyH6Q/WVfB7D3ohVeoj0U2p4Tl2uxiI/qIEuhc=;
        b=tzOdG6ByzjrjPBo+xywPDgYoSPgZZsp1g0U1f7m/jYakwKr/tLBc8eUcugOmOguLxO
         ZiYyHkSC/0qne4EFrABE4CFLxPzfhAQJu3LafDLmuXlordbgNQeB1mhXxG1Y3aMJgXNH
         Gn4AR1GsN6ZOKSTThr9kYgFN3IEbVKaVJA8dfDr7iYfCstbqfi3CcrJmjUqFVRE0GG7K
         +Uh9qamaPVRttMXGZ1Q/mJcz6UQUWNhXNXfOg9cVlZg2YQftJZUTn+HGPJeJjGdwzt0r
         gMszu3EYzrk7Y0VEggt9zMctn90PCcUIGDU9qHQFHQg31ZjFxU2dgRokvf3NWHue380l
         KXKA==
X-Gm-Message-State: APjAAAUU+yC/egBn+JOAkIBLz+5wLJqU7QaBXPPxR7LRPtwnwMmrU16X
        xtD1H6gG/hrNKG3+haeQHPxt2pvagPK4F1zOhsXMSQ==
X-Google-Smtp-Source: APXvYqzGVBbdyzATQFuVMW3IFDJn0oZE3752K4RBlif7yTSyE6BtlJCKiTmlzKVDg38zAYQuNx/xDs549BoClqzTLhQ=
X-Received: by 2002:aed:3f47:: with SMTP id q7mr1946820qtf.209.1562847159155;
 Thu, 11 Jul 2019 05:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190507091224.17781-1-benjamin.gaignard@st.com> <20190711115059.GA7778@icarus>
In-Reply-To: <20190711115059.GA7778@icarus>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Thu, 11 Jul 2019 14:12:27 +0200
Message-ID: <CA+M3ks42Whd=QVQ-4==n5bRJKEwYpQtRHs=gBGEZ_Hr=_8YU1g@mail.gmail.com>
Subject: Re: [PATCH] IIO: stm32: Remove quadrature related functions from
 trigger driver
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 11 juil. 2019 =C3=A0 13:51, William Breathitt Gray
<vilhelm.gray@gmail.com> a =C3=A9crit :
>
> On Tue, May 07, 2019 at 11:12:24AM +0200, Benjamin Gaignard wrote:
> > Quadrature feature is now hosted on it own framework.
> > Remove quadrature related code from stm32-trigger driver to avoid
> > code duplication and simplify the ABI.
> >
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>
> What is the status of this patch? Are there any objections currently for
> its inclusion?

You were the only one asking for more details about it :-)
If you agree I think that Jonathan can merge it.

Benjamin
>
> William Breathitt Gray
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
