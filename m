Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4235C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989F6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yR9hA/iN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKN17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:27:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45550 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDKN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:27:58 -0400
Received: by mail-lj1-f196.google.com with SMTP id y6so5497015ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 06:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZITOjpEQVwz8BVuLnukg7mok3jAnlaRfcWnTFu+v0I=;
        b=yR9hA/iNLNwSyfpwWRt/O91v01j2xaaAbOua7rf/+pEVz+vyUtm05VQDjRAqyFLjNS
         0bgQH3H5JZA1lfuwSsjuR1G0vv8iL/F1DjA1sfmjYHoWPL+VF6uTN6C1n5pfYw795934
         RI+JtiEj1jlNB8CbcIy2y95H+59OPHv5GfphHgGDVJwGmOCK/PSX2TGLfZaegBfrA3BJ
         1Wb7C3HqnC3tQizxm/a4BNiMlB2hv9Qjhl31ms7zBOmbKepqFX4yVbPWjDDKDe5aokUF
         A6RSQM+KC5s1Krqy2P6hIWxyxLC8EUJ2qqkahXTMCRSNVdrFqrCmdFfISICVt1jiBNkg
         ywLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZITOjpEQVwz8BVuLnukg7mok3jAnlaRfcWnTFu+v0I=;
        b=fd7Ug8k+54oG1lQ54JfEpvMkl7R6yu2pVHcZfzfJOe/nhw5PMoH+OQRmdWSXsAEYqs
         LwRRH3ks1cXCA0WtEK90y4i/fLQ7dGmUHvLWUyepJJX6DOh6FVvaX5NbDdeQcWnXq4GG
         wqI8b/KnJFukfT7veTERWiJEqXyKnavIGGH0ADg783c2GltFwDqzOoP//hdHFhAqNG0j
         EdbClDNoHhATx5GdmdF/8pBXnDUDwOEc/RYdXRIGtvEXz184vo+bGj9FS720s8+kilYX
         9mJH0UKsJr5ua4A743jPfxw5GGacyDMVXK+CgSFbGa6UCFhKpC6y61ArU4OFw6YDE9xd
         gLIQ==
X-Gm-Message-State: APjAAAU0bEGrW5ZzJhBseFpOfLhPsvUKs8ab5WnPRmo4aCo7pOeoV8c6
        +J0JrkRSqI16Y92EW9H63Djj+j6hhMD3h26zR1jytw==
X-Google-Smtp-Source: APXvYqxBDC7x++TvXu+7fMO9QccxouWcPaVoyUfQO9KEClqqtO9C7/eE2R3v4XLvMB5y9BusQOEAlkuwPCV6z+0mxz0=
X-Received: by 2002:a2e:5d56:: with SMTP id r83mr26742854ljb.74.1554989276869;
 Thu, 11 Apr 2019 06:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <1554748702-2368-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1554748702-2368-1-git-send-email-abel.vesa@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 11 Apr 2019 15:27:44 +0200
Message-ID: <CACRpkdbrAtPAUSO0QMQnqifkHsq55iQnvh1PmYYViUBtz47LQA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: imx8mq: Add suspend/resume ops
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 8:38 PM Abel Vesa <abel.vesa@nxp.com> wrote:

> To support pinctl hog restore after LPSR resume back,
> add the generic suspend/resume in pinctrl-imx along with the
> generic pm ops to be used by platform specific drivers. Then
> make use of the newly added ops in i.MX8MQ platform specific
> driver.
>
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

This v3 version applied with Dong's ACK.

Yours,
Linus Walleij
