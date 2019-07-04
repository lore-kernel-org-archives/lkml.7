Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC1218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ly2ZB1Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfGDHdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:33:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36512 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfGDHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:33:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so5152770ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nZlyonaYBcIHFs68w4W+bmgmZLAi4DVNEFkxYXC9bg=;
        b=ly2ZB1RacvoXgtBZuxppsAKpbjRSfhQ8AdBwb59ZI7CcTPAY1b3+VAeo9SDLy3CvhX
         NErHZ15uZn6Ui9j+6+th4cMMXPdKCoDyxmdwWuuy5tfhlvQqFRHhSdtzBGediN13vhQg
         ltkRmZPytPiNO1j6j96DMn2FyHsaAg57+T7wMNLrUzRhGGk+MnbAtjEi5HuvEI/lFLdR
         pbrUYpGK0O8kY6JjOxnLdhffIFMFuFnUYi0npgFV5QL5gdABcvOnBBKyK9tW8UKnUTr9
         NchwHX5TsqNKMwWVk9WGT3/5wDsYuqYktsAKmDS1iOpCpm/BQN4/Woo2HrGv6JUS5dgk
         LcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nZlyonaYBcIHFs68w4W+bmgmZLAi4DVNEFkxYXC9bg=;
        b=SvzC1Jwq/hHLlAw0aevE4t946ZP6clinTqGxkvk4Gfmoy7hmNm6QbjSXRyiW+eL74B
         /Lty6no5UQx9B5eL5Exw2T9W6L2LJ4B0JwCfQHPWDwlBOVaEYKKB8Pe2asXwT2JHwL8G
         fHq/EGanV5ZcXuEKeln4jr2k43J5k+wTJ4MTuH+JtM9bvM3Fuu3U7vEHH04Akw0zLWkJ
         eXDwsHI8q/VRNqNBW201Lt/FOF+ZVqc+52ZheEWBT0bRMmgMRAfzy12pebhi7QnNkLVL
         McrBGOZs0iQ/wPkw0HG8lNlYWmwUdmFcl+zHSZUVvWWmWIjirSf+vYXeus8g0JYqjcQ3
         sLUA==
X-Gm-Message-State: APjAAAX1IZhkQmIK1OWP2rcjjJDdYBKdXPUxlbD6Oc+GRGdxMsUg+KBE
        Qn5W4VB5LtAvRf3TFD0cMeZvbLZdbZpmdAVSEI9hgg==
X-Google-Smtp-Source: APXvYqx26V0oB3KzDPNa332FvmrdU9YRFQjWa+Pf4/6aOydVvuHTShaMCf9kZhWzOw++n54b2Y94ETsphqlWJxoLR4E=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr2092620ljg.37.1562225612626;
 Thu, 04 Jul 2019 00:33:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190701141005.24631-1-geert+renesas@glider.be>
In-Reply-To: <20190701141005.24631-1-geert+renesas@glider.be>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:33:21 +0200
Message-ID: <CACRpkdavvUR3G89_5DpXvgfpJ7LsxWiLyjFS0hSXVwAgaRFM-Q@mail.gmail.com>
Subject: Re: [PATCH] Documentation: gpio: Fix reference to gpiod_get_array()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 4:10 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> The function is called gpiod_get_array(), not gpiod_array_get().
>
> Fixes: 77588c14ac868cae ("gpiolib: Pass array info to get/set array functions")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied.

Yours,
Linus Walleij
