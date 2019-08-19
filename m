Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FFC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB9820651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F7B++fDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHSO1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:27:46 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33732 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfHSO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:27:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so1338945pgn.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=g7SGcsmWT+FULooaq5UQl7DExj4a8uS1tyyXvhheNb8=;
        b=F7B++fDfMJYrpdYGvbFTT3qQ489MSEHBL6T0G9stCqDBOS8VcRefaYC4S/enADXJNp
         2F7T1EO3zH5+xq2vk+ia2joTDoly6PVLwI68tZno7FJxEBgHJER3kEIIiR5lkPiykppq
         seC2Gy5QwSdoWPsA3rGIVtNnVLONWrUaIwFJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=g7SGcsmWT+FULooaq5UQl7DExj4a8uS1tyyXvhheNb8=;
        b=gsO23UNy9IhumNnMP2VaJwou0Fh0jPLdDypkwmLJkJp+SAqC4pGbl7t57BEB0X+WHJ
         nYeueDP3W5JTJgJ2Q9TsYObxRTh5J4RoHnb3UNmOo1dWMxq17IheAOnuIwqc5k5m0nqX
         7hepLNn7fOGQEqF9RNHnH/gzJWSHe9m80xU+VSEYG0Anl6HtjRsL5pGGNeymk5mRsnVC
         ttNhMlT2IQ6XwDID4Pzm9Y2EtwQNHxHx7XMhTe6MVL7imRHHffhQa3isOSWG1xxoYiu4
         Vpuj4h4o6/ajH5mtCnb/NuJxWnvN4v5cfe/ZV21Rq4Op3yBxOS23UAptXP90Gwd9kHtt
         urTA==
X-Gm-Message-State: APjAAAVe+7pkHgrf2yHlRQh7BxJziCu3FC64gkdDEBRzsGeUc4wZM9MJ
        28vXLqJfSBuU0r3X7aNs6Cx07A==
X-Google-Smtp-Source: APXvYqw+w369yIhKY3a4m/3WUecsHdqBhBu/b547AgohkSVK8taH7VQIUqPLOrrbPcsiO761Bn7rJw==
X-Received: by 2002:a17:90a:650c:: with SMTP id i12mr20834840pjj.11.1566224865078;
        Mon, 19 Aug 2019 07:27:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ay7sm13400421pjb.4.2019.08.19.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:27:44 -0700 (PDT)
Message-ID: <5d5ab1e0.1c69fb81.d71db.1ca3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com>
References: <cover.1564091601.git.amit.kucheria@linaro.org> <534b5017c2210ba8d541c206dace204d6617b4c9.1564091601.git.amit.kucheria@linaro.org> <5d577d77.1c69fb81.b6b07.83e6@mx.google.com> <CAHLCerMpWTVquyM3fYQxz-ZhDvnY276hfnZvZOmjV--cgm53UQ@mail.gmail.com>
Subject: Re: [PATCH 04/15] drivers: thermal: tsens: Add debugfs support
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 07:27:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-19 00:58:23)
> On Sat, Aug 17, 2019 at 9:37 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > > +
> > > +static void tsens_debug_init(struct platform_device *pdev)
> > > +{
> > > +       struct tsens_priv *priv =3D platform_get_drvdata(pdev);
> > > +       struct dentry *root, *file;
> > > +
> > > +       root =3D debugfs_lookup("tsens", NULL);
> >
> > Does this get created many times? Why doesn't tsens have a pointer to
> > the root saved away somewhere globally?
> >
>=20
> I guess we could call the statement below to create the root dir and
> save away the pointer. I was trying to avoid #ifdef CONFIG_DEBUG_FS in
> init_common() and instead have all of it in a single function that
> gets called once per instance of the tsens controller.

Or call this code many times and try to create the tsens node if
!tsens_root exists where the variable is some global.

>=20
> > > +       if (!root)
> > > +               priv->debug_root =3D debugfs_create_dir("tsens", NULL=
);
> > > +       else
> > > +               priv->debug_root =3D root;
> > > +
