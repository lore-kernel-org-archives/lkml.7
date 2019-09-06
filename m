Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A4C00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC380214E0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNQZCDL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbfIFUk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 16:40:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42135 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbfIFUk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 16:40:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so4161599pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:to:from:cc:subject:user-agent:date;
        bh=swYhYhOrQirWfGuJUy4F9KFt5Sj0aaeo1T8GuTEGiz4=;
        b=XNQZCDL1t7yoNNof+dtO6sm/fp+82jF9Dd+D/rQFYDJcBz/L2D1KGp8OUyEU0c8k6x
         zUnkoplE8fEg02iv67iCnBKbzlwLAmDwz94XsxzsIa6ZQJY3xQWrtMdBLejK8GkIowW/
         32OdRNGIdjSw6kW2kVX9y36xYaVXLtm9SM/yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
         :user-agent:date;
        bh=swYhYhOrQirWfGuJUy4F9KFt5Sj0aaeo1T8GuTEGiz4=;
        b=eYkSOGmjYaoWy4kNIgsyTnFqZ9hIDIZTMLtciiXBSgUjewKnJ+IhSUm0GwBgYyasV8
         XU9el36WyMUoLdhlEncfD9bcQotwPvn+gR78IxFKH1E2wJv52/xo1wcI3VjswHOmthFO
         8RFZKLWrxQGPKGgxI0pM3djKTElWVa0uCeGHVabo/R6myc23hwykqBIRPeHf/Rg12hDW
         vL/ouCwUC+sFhIbBR/JzV+Nya0iOcuF5AHlG1XnVh+qonM6IfZS7Nf2OWUdclOKoUxdV
         SveQ5oPg3jgCa6AYoelJwl04ZBK2cg2PoB3n9rdX5fVJeUa+t/5vMyH37OIldDrRIXBI
         qg9g==
X-Gm-Message-State: APjAAAXurS03Tft+3TdQh0ZFChTwUa79xHD5NnGluxYU6KcbaokypJKT
        P1leHfiZmmwqHKCSllfoWoI1wH43SChUpA==
X-Google-Smtp-Source: APXvYqw1lGijoxS5N/LyWFNhxa8KAKbm6+WK8DHVTDzRzO5NwdkiAeKIWg805Ebt+vzKg3H6r2nBUQ==
X-Received: by 2002:a17:90a:b383:: with SMTP id e3mr11866956pjr.85.1567802426141;
        Fri, 06 Sep 2019 13:40:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 2sm13930134pfa.43.2019.09.06.13.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 13:40:25 -0700 (PDT)
Message-ID: <5d72c439.1c69fb81.484c6.fe28@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190906182530.GD11938@tuxbook-pro>
References: <5d694878.1c69fb81.5f13b.ec4f@mx.google.com> <5d696ad2.1c69fb81.977ea.39e5@mx.google.com> <f3584f38-dabc-7e7a-d1cb-84c80ed26215@linaro.org> <20190903173924.GB9754@jackp-linux.qualcomm.com> <5d6edee5.1c69fb81.a3896.1d05@mx.google.com> <20190903233410.GQ26807@tuxbook-pro> <c9481b7d-4805-25c6-f40f-9cbfc40afc93@linaro.org> <20190905175802.GA19599@jackp-linux.qualcomm.com> <5d71edf5.1c69fb81.1f307.fdd6@mx.google.com> <20190906182530.GD11938@tuxbook-pro>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jack Pham <jackp@codeaurora.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        robh@kernel.org, andy.gross@linaro.org, shawn.guo@linaro.org,
        gregkh@linuxfoundation.org, mark.rutland@arm.com, kishon@ti.com,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, khasim.mohammed@linaro.org
Subject: Re: [PATCH v4 3/4] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
User-Agent: alot/0.8.1
Date:   Fri, 06 Sep 2019 13:40:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2019-09-06 11:25:30)
> On Thu 05 Sep 22:26 PDT 2019, Stephen Boyd wrote:
>=20
> >=20
> > Yes this looks like the approach that should be taken. One question
> > though, is this a micro-b connector or a type-c connector on the board?
> > I thought it was a type-c, so then this USB gpio based connection driver
> > isn't an exact fit?
> >=20
>=20
> For this particular case it's a type c connector, but the port
> controller is operated completely passively (and there's no PD or DP
> involved), so the GPIO based approach seems like a good fit.
>=20

OK. Perhaps the binding needs an update then to have another compatible
string indicating type-c connector that's not able to support PD or DP?

