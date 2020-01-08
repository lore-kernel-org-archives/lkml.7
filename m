Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66289C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380292070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="csH6h22W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgAHD1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:27:30 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36094 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgAHD12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:27:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id 19so2244840otz.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xceLEnO3BCgE8gw6ehmf7oIvMEjYUFeqhS/nKgWDqFI=;
        b=csH6h22WfZnD1xkdgwOCne3Jv32LmlbUzVEaLBevEMe50H5rAy4ECEVfBiovZy8xDu
         b6pHK8e06WX+imuJ6fHw26HY714lCwLnbniIGh5DWXQQ+ipOUvm0uHPExjCoeL58F4te
         MCDUDMy2u+PUNUzChxap4ixBAdfsjM/rm0ovA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xceLEnO3BCgE8gw6ehmf7oIvMEjYUFeqhS/nKgWDqFI=;
        b=BFYUIegXNhHTIj2USu/ZwChztIId7SoLuPePL3m0S4K9HPwoBtjg92elTdooNHcjRw
         TGvTSKuwlMGqU8mGzOHe887Pv9iRYe5flv0H2RZfCF26KhHYrg+uZAyMGuvgK2GBQkB9
         ODhXOseCUZckgowig5fl6Ysy7i7cIqXfoyVgA8xtwnUIqdBd6zj+OY6/M1sQ264g7cRY
         pfjQA+mM04U77FPlFyCTi4PaILNWNAY0XGQqWCWmuAGhO6YZ6WjLVsrWISLYfx5dybm1
         qb/XPZDS5M8+6MjrMH2cp6PXt9+i7okrCkRZHwo1aYgC2eHe/BlfeaXzpY+mcq+dbCqE
         1UyQ==
X-Gm-Message-State: APjAAAXNyW1LWgS4I7ES+PtE/6kZUbFwpQ2fnUiyNxDmzAL5ptjW7+p8
        0kog8RCNBQrNSe/9f8v3EA3MAfeKioFu7w==
X-Google-Smtp-Source: APXvYqztMCEXw0EsdEtMEBoxo4mt9FEs5B86lMJYbCQkli9yV21LrvpJk9yWe3rfAnj1wrcX52GJcQ==
X-Received: by 2002:a9d:6e98:: with SMTP id a24mr2514726otr.109.1578454047860;
        Tue, 07 Jan 2020 19:27:27 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id l1sm669381oic.22.2020.01.07.19.27.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 19:27:27 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id i1so1447164oie.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 19:27:26 -0800 (PST)
X-Received: by 2002:aca:d0b:: with SMTP id 11mr1457408oin.71.1578454046328;
 Tue, 07 Jan 2020 19:27:26 -0800 (PST)
MIME-Version: 1.0
References: <20200107143402.122455-1-acourbot@chromium.org> <3aef91ea-30c1-530f-0c18-ea52b92347f9@linaro.org>
In-Reply-To: <3aef91ea-30c1-530f-0c18-ea52b92347f9@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Wed, 8 Jan 2020 12:27:15 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWY6OEc2EbPW=k8vFU32POamNs0FHJus8fg1u5A2uxrzg@mail.gmail.com>
Message-ID: <CAPBb6MWY6OEc2EbPW=k8vFU32POamNs0FHJus8fg1u5A2uxrzg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: add Venus firmware node on Cheza
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 11:50 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> On 1/7/20 4:34 PM, Alexandre Courbot wrote:
> > Cheza boards require this node to probe, so add it.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 6 ++++++
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi       | 2 +-
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> > index 9a4ff57fc877..35ba65cd9822 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
> > @@ -1279,3 +1279,9 @@ config {
> >               };
> >       };
> >  };
> > +
> > +&venus_codec {
>
> We have similar patch for sc7180 and call it just "venus". Do you think
> we should shorten it here too?

Sure - sent a v2 with that change.
