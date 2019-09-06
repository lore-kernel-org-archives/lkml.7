Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE52C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DDE7206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+TBVNB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392358AbfIFF0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:26:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42700 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392346AbfIFF0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:26:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so3558911pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 22:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=u7691phoxUxEdEhIJ0JOC7Ng9s9hyHBORKH2Von7rlk=;
        b=Z+TBVNB0VSXglybGnbmX3Xg7oWyQb0Uh3ZQmxpzhBQJojSoaGcCNhwffxCs/S7qP7Z
         X6MODDZ+h1RefxIKPN7IeBWDyWbLVcfMP6VSmijghP6yUKXYFwP6+dkTpAYxLGc2HY0f
         LkN0m2IL7Zss46jGMqiX2iCWNvRVay7S2XySo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=u7691phoxUxEdEhIJ0JOC7Ng9s9hyHBORKH2Von7rlk=;
        b=FhlMlkG7pzLlqU1zUO6NEiN4jACDfcPvZqQNgfwdz5K8if9IKJw2inidk+XiXR59wo
         2NBy2s+iNjqsN91t87eOVziOZM+7L+huP4OL9/tO8QBqOBLeYD+wJlgAiRhPa14Tn3W/
         AyOKMQgbXVdSJq4+1ZEBrr3dUQRRCX+u1MdHTP/pDARwdSl3dyX359RNWENlkqsYVuk1
         cnMba3zfzQV4lIhGHKKFYuDCuYPSWhNtMrxlCntFBTnus+X6Y8mC6gpzkgRzKSk+zKJe
         1OYuJzhlItVHxJDdEHSnP/eBFf4ePjWj7zDp0aRUpfRe2mFMtNoljLvaZfBy3Tv+S2kk
         wy5A==
X-Gm-Message-State: APjAAAV7Gdpr/fxs2WiRxnrAl+SlJ/NChnzLmIn/6C6eujrAt1Ukudzd
        YLbaK0zToh+tfAgX4/nUK2vxRw==
X-Google-Smtp-Source: APXvYqxxS2afeG8bx+7q56JsZOG8CWSYjGmdaA830tTQVpcIVkrfr7pzwoEZ4jywfiS5HQVZln95xw==
X-Received: by 2002:a63:590f:: with SMTP id n15mr6506040pgb.190.1567747574583;
        Thu, 05 Sep 2019 22:26:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s186sm5936916pfb.126.2019.09.05.22.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 22:26:13 -0700 (PDT)
Message-ID: <5d71edf5.1c69fb81.1f307.fdd6@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190905175802.GA19599@jackp-linux.qualcomm.com>
References: <20190223165218.GB572@tuxbook-pro> <5d694878.1c69fb81.5f13b.ec4f@mx.google.com> <20190830164520.GK26807@tuxbook-pro> <5d696ad2.1c69fb81.977ea.39e5@mx.google.com> <f3584f38-dabc-7e7a-d1cb-84c80ed26215@linaro.org> <20190903173924.GB9754@jackp-linux.qualcomm.com> <5d6edee5.1c69fb81.a3896.1d05@mx.google.com> <20190903233410.GQ26807@tuxbook-pro> <c9481b7d-4805-25c6-f40f-9cbfc40afc93@linaro.org> <20190905175802.GA19599@jackp-linux.qualcomm.com>
To:     Jack Pham <jackp@codeaurora.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, robh@kernel.org,
        andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
User-Agent: alot/0.8.1
Date:   Thu, 05 Sep 2019 22:26:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jack Pham (2019-09-05 10:58:02)
> Hi Jorge, Bjorn,
>=20
> On Thu, Sep 05, 2019 at 09:18:57AM +0200, Jorge Ramirez wrote:
> > On 9/4/19 01:34, Bjorn Andersson wrote:
> > > On Tue 03 Sep 14:45 PDT 2019, Stephen Boyd wrote:
> > >> that would need an of_regulator_get() sort of API that can get the
> > >> regulator out of there? Or to make the connector into a struct device
> > >> that can get the regulator out per some generic connector driver and
> > >> then pass it through to the USB controller when it asks for it. Maybe
> > >> try to prototype that out?
> > >>
> > >=20
> > > The examples given in the DT bindings describes the connector as a ch=
ild
> > > of a PMIC, with of_graph somehow tying it to the various inputs. But =
in
> > > these examples vbus is handled by implicitly inside the MFD, where
> > > extcon is informed about the plug event they toggle vbus as well.
> > >=20
> > > In our case we have a extcon-usb-gpio to detect mode, which per Jorge=
's
> > > proposal will trickle down to the PHY and become a regulator calls on
> > > either some external regulator or more typically one of the chargers =
in
> > > the system.
>=20
> Interesting you mention extcon-usb-gpio. I thought extcon at least from
> bindings perspective is pass=C3=83=C2=A9 now. Maybe this is what you need=
 (just
> landed in usb-next):
>=20
> usb: common: add USB GPIO based connection detection driver
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=
=3Dusb-next&id=3D4602f3bff2669012c1147eecfe74c121765f5c56
>=20
> dt-bindings: usb: add binding for USB GPIO based connection detection dri=
ver
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=
=3Dusb-next&id=3Df651c73e71f53f65e9846677d79d8e120452b59f
>=20
> Fortunately this new driver might check the right boxes for you:
> - usb connector binding
> - ID detect GPIO
> - vbus-supply regulator
>=20
> With that, I think you can also keep the connector subnode out of the
> SSPHY node well, and similarly get rid of the vbus toggle handling from
> the PHY driver.
>=20
> The big thing missing now is that this driver replaces extcon
> completely, so we'll need handling in dwc3/dwc3-qcom to retrieve the
> role switch state to know when host mode is entered. I saw this a while
> back but don't think it got picked up:
>=20
> https://patchwork.kernel.org/patch/10909981/
>=20

Yes this looks like the approach that should be taken. One question
though, is this a micro-b connector or a type-c connector on the board?
I thought it was a type-c, so then this USB gpio based connection driver
isn't an exact fit?

