Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45251C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A7206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jyyXYbhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfLPSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:33:24 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39216 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbfLPSJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:09:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id 2so6012736pfx.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=uTZ9jD6XcU5csDtmDm0A4lEi/ET7Er5jr9WSb1EMelk=;
        b=jyyXYbhQgJvFoH/gkE8wmpD3skyYKQ7NOFesPHXGsZrxJc9FUF39kXCisPYSVTzGH5
         XfprSHFhYdHkCCIcBitR0qWWWt/V9TEhaHrbqEckar9UuCp+Jsl7qVmxq8BZtEsNxyir
         KSiD+A7sa97Cd257ghc22sKZBvGAGw9UYoEQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=uTZ9jD6XcU5csDtmDm0A4lEi/ET7Er5jr9WSb1EMelk=;
        b=VINT1TMjN8+BcQklHQdxAOqiZ2I1Jy1xietNB0OHcxerQLA6RxIYyKi1YcguRppxWZ
         6f1jr2fvSxIv28ONjxTprCHDuuF+Y2OHJAtXek+pCml18aSxnUfk2EUvYejPuALNKgxI
         lktDohXycE5LBTAt7zumocj7XSsJTodpZOSO43ymOz1qm8T8/2NKzMa5u+dE6wsg+Sjm
         7Mm3UXTqAnioTaBt+q447mYyXUwNx3zim+xTcFjf3uA54fkqnOAwej81VEyJwsEuti+y
         tzRq0d9IPKToz0+YVtwd9VH8QLQJPZmpcEDKPwIU9Mrk067/CdZxkHedrhk3GMR0mOKJ
         GsaQ==
X-Gm-Message-State: APjAAAXVAvobGfNh91tACL/L/8loUBU/a+OvUHyB4cI4lNktddWVbyIe
        xJn91RkP61dgp+heUuOuAIAG+A==
X-Google-Smtp-Source: APXvYqwgYd4Qk+VgNW5yogq7vFaECby6SdTTUamWheo+l1m4itfak+lUZHj4qp1Cai9JxJJVFmcP4w==
X-Received: by 2002:a62:5202:: with SMTP id g2mr17177463pfb.43.1576519780253;
        Mon, 16 Dec 2019 10:09:40 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k23sm23348452pgg.7.2019.12.16.10.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 10:09:39 -0800 (PST)
Message-ID: <5df7c863.1c69fb81.91ce4.37b3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1576474742-23409-3-git-send-email-sanm@codeaurora.org>
References: <1576474742-23409-1-git-send-email-sanm@codeaurora.org> <1576474742-23409-3-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: qcom,dwc3: Add compatible for SC7180
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 10:09:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2019-12-15 21:39:02)
> Add compatible for SC7180 in usb dwc3 bindings.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

