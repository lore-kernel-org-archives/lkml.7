Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9F1C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D458215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5NhMiwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfJCOeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:34:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46997 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729363AbfJCOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:34:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so1995661lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hvhATlwGfyzse+9lgJuOQKk+XJVPQgsWU7QyuLbTa+Y=;
        b=R5NhMiwTWg9Str5l+j5vYpmLZDbmTPsgZ8TvltgouFfOYaOXhwRZjBuIRZH8KjOaL7
         rQbdWUA1Pt66YY3f2a8LSttvEhDB6cwIjVZS94ykci+fo/geFnvch8LCaW0YvE+7BosL
         0Ulk/Y1buj8QeivGnUH1btbcghmWjdRUIFavFvpKCLf59hxKPHPd73t88sxuBbyx/jyJ
         uf3nJWF7IZE+FBsQYJmGRXXICXNj8IjhTTdyUegdL7Wh/MsRI7AuvzpsPum+xHamQJKM
         j/h/eD3iJvpmFr4aVdXTm/hQwlgOPeeQ47PSo2IZ1vRHcSBV9qZTW4f95BIZ+gu8sdnb
         u26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hvhATlwGfyzse+9lgJuOQKk+XJVPQgsWU7QyuLbTa+Y=;
        b=qVrOj/ghWEOZdckq2giZ1Ggh4Sqpj61lR5AiZkmPhFj4ngAxeanGfHDEyjjOjDu+DC
         jJbjZ5DI67k5vqQ+JGXB+qnSF++ahZJbE9EedSczLTaVWHbjXlS8IE9sdeOVOFaGyOAb
         X7SwcybcqZZJwN98G8FavB4TlFNWQsNwsU0/pLaPgkpUN3JOGAFzdxTzCaGALH05LF5L
         BhCsRdfTejdNONmBd+HDO1ldfXrsKxkSJA3HIPA3tDOKY70ZMi8s8HLOs2wfL1zAsBv2
         C1G6viIyySlkO7dY6xHxKRId8KczBwVWaqVtt5om9qwIS+0E+P/Rnk9KoZC6GPcQbrp/
         AVXQ==
X-Gm-Message-State: APjAAAW25JrY4f+h1I2zQiM0MvhRuCQQO2rAypsonDKfslp/4knlZMGx
        8UA9C9wZR/fysdJxy5fr/EsGuOos70PpvSNwqQ9oAxL5
X-Google-Smtp-Source: APXvYqxzdsOLb8buBtK6RvHEFpfSWOJXyEBRpRiDNtKzXeUnHA0CllgxBBRm5WSuEe//ZJx/EU+gvI5WYGl1L3RQ1m0=
X-Received: by 2002:ac2:46ee:: with SMTP id q14mr5569285lfo.152.1570113282029;
 Thu, 03 Oct 2019 07:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191002153827.23026-1-j.neuschaefer@gmx.net>
In-Reply-To: <20191002153827.23026-1-j.neuschaefer@gmx.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 3 Oct 2019 16:34:30 +0200
Message-ID: <CACRpkdZ0ekYtZ4bZ-A4NZN6HO6XJzwpdZ_HjUL=FoWfG08UBtg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/mcde: Fix reference to DOC comment
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:39 PM Jonathan Neusch=C3=A4fer
<j.neuschaefer@gmx.net> wrote:

> The :doc: reference did not match the DOC comment's name.
>
> Fixes: 5fc537bfd000 ("drm/mcde: Add new driver for ST-Ericsson MCDE")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>

Both patches applied!

Yours,
Linus Walleij
