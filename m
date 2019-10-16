Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99044FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72405205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZLm0NJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfJPLnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:43:50 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34537 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfJPLnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:43:49 -0400
Received: by mail-io1-f43.google.com with SMTP id q1so53441780ion.1;
        Wed, 16 Oct 2019 04:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jJXwx8s5PeYIoSlC+P3xZXzWppbK8BXaw3+mWypgBzs=;
        b=pZLm0NJ/8t65/7jmJMDMxEMW0oN4uRJqGRHDnEiswfoguFzw7d3GgqhfOd1Cm8T6I+
         4imPwGn3M9iqyw78dT7/3fAAwql+/vY/NM1m7Me58yqKqVuRN/bb7ZeLUcFi3nt1ldUe
         DGO2GhRNP7ifg2/+qVSdDiDU/Envn97SBG2dREDG0n8hn3ERroRZjRRc3a6VjkZmel2U
         Us1WyCfEiqoTdYN9orUobsAPZ699aqqsHRxiH+rbFYjbZSTyaSuF98+vgfO1zu9krrBO
         MLOQMZ8Un5vpB2wFnp79uUIyw1Ffqlvp2VrVyOWsezlOi187MPxKEkHfmuOLNdeu3ha9
         8hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jJXwx8s5PeYIoSlC+P3xZXzWppbK8BXaw3+mWypgBzs=;
        b=UOGCzGxkzq7dWGw8/uIDOXrkiGaXupCCjDofUo7nX/4L3v2JYlFmo4/bAVwyXqeuoa
         C+iG9KiDNc8UQ4Om0QNnw8eApsmAGFXFhjOnCsd41ehZaXiYkOD0qtUIokGf5ESRNo2G
         11yxTQlaGKG+7l6c75b9sNgXY5Um2TssDcL0qSaZ4toPuvvDYX0otGdlRZApRzlYLvMg
         AZ05s+FtRhsu1B0+UP/ZFNMOZ5MFjeMgb95pWc2Ic3+FxaSi5j+GPrObR9BVs+KXDesh
         uGuiE6RqvobnaPn9M2XTOc83QdTpboDc5T9WnA5B383fyhr+Ll00fzBvbIRuXmLKQQhU
         5L9A==
X-Gm-Message-State: APjAAAXvvaO0EkIgs65anDFjzQ82euT/tCtXVgb9zEVqQM3HpGZNHT6A
        nUPtjhBrKij+oMG9eJOZgYadO3Wf/M5wxe+0kg4=
X-Google-Smtp-Source: APXvYqySgL7/QGeQFsTtEb6NDaA9MbZmAOYFF5TD+NUX2VWsmTpcVfREpI4FJRBTbApUjb5bbadeKbJcGfmZnnUdFPw=
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr5059443iol.2.1571226228398;
 Wed, 16 Oct 2019 04:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <7933ce8f-ca1b-6ed8-14b9-59679130dc47@web.de> <CA+Ln22GpcMF5e8wjwoRH0wExyoGfta4n3YuaOBNDE+rfqhSZjg@mail.gmail.com>
 <39a142ae-e0a1-0683-d68c-128b388f480e@web.de>
In-Reply-To: <39a142ae-e0a1-0683-d68c-128b388f480e@web.de>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Wed, 16 Oct 2019 20:43:37 +0900
Message-ID: <CA+Ln22FCH-q-joG6i=K2u=3vZTwwytkk0Q48oKekGkVb+VtL3Q@mail.gmail.com>
Subject: Re: clk: samsung: Checking a kmemdup() call in _samsung_clk_register_pll()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019=E5=B9=B410=E6=9C=8816=E6=97=A5(=E6=B0=B4) 2:55 Markus Elfring <Markus.=
Elfring@web.de>:
>
> > That said, there is no need to print any warnings or error messages on
> > allocation failure, so technically they could be removed.
>
> Do you find information sufficient from the Linux allocation failure repo=
rt?

A backtrace should be enough for this kind of a failure that shouldn't
normally happen and if happens, then the rest of the system must be in
a state already about to fail anyway.

Best regards,
Tomasz
