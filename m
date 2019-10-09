Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E260C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34535206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 01:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e584x4yH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbfJIB6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 21:58:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35771 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJIB6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 21:58:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so554884pfw.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 18:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=N4NGesu7+LudHzth0OydBmbsxdfqhnx8W8LYisp+NrQ=;
        b=e584x4yHx18hiFqvlc698JaAJA95f63sgzOILU9VL7hd8XxZsETHI1Hgg5kMcFNlTB
         rX3XXUZmzjiIM+R+nW4VPyPXUaqLD53pZRQvV8pQry6JiifTX4fXgC7qCaveTDEf7TYP
         22RWf715Z5yz7lH5RjQMmCBm2c9aua5ju4IVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=N4NGesu7+LudHzth0OydBmbsxdfqhnx8W8LYisp+NrQ=;
        b=HGkEgjeJX10e8EgY3/Dkn/RAnLoPrv80lhjfE1Np3zmgo7c690cd+0/yG/oWbxKVoY
         wFuqLmoqwOTlrDvQ2pE5YHXCVDWZnQ+nTTvSwsMQ0s9siWyGb1GNzbwtISUNK+LUogaa
         a87C6lGCGa7d6G53n1qHrgVN623azQim0gbuOxETEa3l3GLkVUMSabx1gnz/G1HfD6bl
         gO49uwBUQ0ABgk9SdFTEnQrhudN34osARf8JgUhD7Gtnh8E9qnHRYawFXOwePjMybPyY
         UatC5xVOKEA1RKi9ITsWvk7jb8Pj9R2t4p/nrt6h9pKBE5xgP/fmtOdltCG3Y7HEoACb
         0JQg==
X-Gm-Message-State: APjAAAWnEcjCiaXUjydiQxkZEQmfprVaZUhVa/707ZOrEWNK0Ym7Hr3t
        ASd3I+mO/JR7w/Fzo1pdJDi4tA==
X-Google-Smtp-Source: APXvYqwQUXs/txuT157faSRndetKLyxoEajKjIqDLEVK13dzHpkQoILsZ9lcR3OuVfBhpTOSfejTsA==
X-Received: by 2002:a63:5d1e:: with SMTP id r30mr1732669pgb.68.1570586325138;
        Tue, 08 Oct 2019 18:58:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id z12sm366340pfj.41.2019.10.08.18.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 18:58:44 -0700 (PDT)
Message-ID: <5d9d3ed4.1c69fb81.5a936.2b18@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191008235504.GN63675@minitux>
References: <20191008234505.222991-1-swboyd@chromium.org> <20191008235504.GN63675@minitux>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2 0/2] Avoid regmap debugfs collisions in qcom llcc driver
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 18:58:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-10-08 16:55:04)
> On Tue 08 Oct 16:45 PDT 2019, Stephen Boyd wrote:
> >     @@ drivers/soc/qcom/llcc-slice.c
> >      =20
> >       static struct llcc_drv_data *drv_data =3D (void *) -EPROBE_DEFER;
> >      =20
> >     --static const struct regmap_config llcc_regmap_config =3D {
> >     +-static struct regmap_config llcc_regmap_config =3D {
> >      -        .reg_bits =3D 32,
> >      -        .reg_stride =3D 4,
> >      -        .val_bits =3D 32,
> >     @@ drivers/soc/qcom/llcc-slice.c: static struct regmap *qcom_llcc_i=
nit_mmio(struct
> >       {
> >               struct resource *res;
> >               void __iomem *base;
> >     -+        static struct regmap_config llcc_regmap_config =3D {
> >     ++        struct regmap_config llcc_regmap_config =3D {
>=20
> Now that this isn't static I like the end result better. Not sure about
> the need for splitting it in two patches, but if Evan is happy I'll take
> it.
>=20

Well I split it into bug fix and micro-optimization so backport choices
can be made. But yeah, I hope Evan is happy enough to provide a
reviewed-by tag!

