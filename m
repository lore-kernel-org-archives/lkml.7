Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B962C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE77920665
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BP0qLMaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfG1WVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:21:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44515 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfG1WVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:21:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so56605455ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mk7OXDT+kyhl11Xs5+A7Dfh2TrPQ+FPHs/EPPvVwBk8=;
        b=BP0qLMaB34B+DIXSaiTJtQjgItAK0otiegqrT+wvlhFi61542p5Lgp/w5DK2PVXTiq
         zzUX/wosUMPaHBNxR8MW0Yltc1ncwU87hI4MvNIs1VqxBMyydoDWrFPG71J+mPnvkwNH
         hmyYomNDCiD3OyOeA8RS4fOymh6JVxqET8zE85wkp5G8E5w1RRkoX3OiquEJqtO5RUlG
         JOOoBllw7fVezK3iSHRXLgefubZKppNpkJkZX+1C6JIbpmZzjL9w4VRG8me7hmB08LZB
         wrsKFBBZUE33o3eGt12v3BlX17qt3jMnutjGQOot9avreFpdFTCn9zkKIdIXzKFqwxZG
         851g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mk7OXDT+kyhl11Xs5+A7Dfh2TrPQ+FPHs/EPPvVwBk8=;
        b=cuHiUtSQEjg3QacbDmKDcY6ketkwZnD1PeRiIxuU+mG7qx2coJ92KIewxYvAk1pent
         bY7yAew0Vq1S9Lqq9FhOLusMHRakGeu1JOhk0I9SIzKQbzYG4ghk1+OwkYtpoT0PFwxM
         0UP1yakjXuPJ3kS0G1868KqdWl020KIyuWy060yDxy6zzGHD87Q8wX1Vsz7+0hCEwoaK
         CqK+A0dhN8SM3Nx4smyBmBBsuMMuLs8Jqema8my9vEaJFcqXHzIAYM6EInz9k0Ch5iYA
         E1t23/q9UXfO0PqqTRMlh6o6OPiFFbQed4Qm1PlIioCTnqsDtbnjMxqrkj1slygqssMS
         BLWw==
X-Gm-Message-State: APjAAAWcgVCyc+ZtX/OadVS+83XGR9XTr0b0CTdBXzCOOsfNQSVat5tm
        LhryH73tuYoOzEVaxx63KsY882M/vPg5QQg7H/b5f87M
X-Google-Smtp-Source: APXvYqzHx3cyR6cCsr+RjAbHnpoqvW/Xr6Gb0Pun7EubId3KLjCF9FYL2Y9Vgu+ACOpHAf0sVmzLyABTl832qjzWmrI=
X-Received: by 2002:a2e:2c14:: with SMTP id s20mr8063325ljs.54.1564352509236;
 Sun, 28 Jul 2019 15:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190706164722.18766-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190706164722.18766-1-gregkh@linuxfoundation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:21:38 +0200
Message-ID: <CACRpkdbo77Mq_GYZ+j+qDiOJRbDqkEXtLwoQx4Jh7FhVUbgYBw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mfd: ab3100: no need to check return value of
 debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 6, 2019 at 6:48 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
