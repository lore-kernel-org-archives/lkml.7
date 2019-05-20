Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8679C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B336720856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vs+n4SXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbfETNpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:45:13 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37983 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbfETNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:45:12 -0400
Received: by mail-oi1-f194.google.com with SMTP id u199so9993671oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kqURiR/ZjyppefNcyX5bQaLFCGWHT5UVZFYxqgSVTZw=;
        b=vs+n4SXrFdjiRJrJJopSLdFRgVKJfYsQwIKMGsBnVGq1DzPvgdlpPQNimjSQ148cSh
         oFKtSVy0eETOEdCQqmbxKrGEABnsH00MqCDdwPHYLVuTz0kSZm5m0lGrliV7T+yHTlPn
         5EwDd4kTAb9VYXF3gEWtwOXsIy4sYXtCXO/3EDri4OVco/8F00vtwuJoufSTYEhLr+Kr
         ytnup/5tobCHle8fyrmxv6LHfB7wx9ZFkMRo5XGGxnHyLfphTh4mglt/VHuHmrdiPk7X
         jPVuhF38AX+aa4R0C/6BrMgr5Jc4kom2Goz+cp5nZO/b7FfSXubcZxczK7ML/4k7j1JF
         OH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kqURiR/ZjyppefNcyX5bQaLFCGWHT5UVZFYxqgSVTZw=;
        b=Ui67/FrbfTehC51kKE9ZxQPe/1XV9hSbUkWIdrR1mQyL4tqn6L45YJJq5muCT3fWFU
         E0TnwK1rjcCJrR1vtjIjN9saYRtK2DufiHBvaNgLABKPHTGQ+Mvw3eTEWpkJ0cX8VoAG
         WsuTPFuHvRGesYDToycJ2Cn+6AOhsZMxYuj35WScw8IdStQwbEyQySJgY+W76jImay7C
         p9+whLmnhn98B4rnl5prBMchNzYRc8Or4MjerdcGoSBqqKXuiLVQ4iWXLWhplsndI2I0
         +AdDJPUZCSxyUxjR1InH3yaNoOZp8cYl9xqWMWe32UgXjqiHRPv9xF1zKOhyiXF1cZRG
         ENmQ==
X-Gm-Message-State: APjAAAWXFMGms/10qxPF4CYQisojERC7weMMu5ufbH1VSH/zvMajNcYv
        RGdZFUbDu+jH0csbxbGujAemijeKiA9K05xfouCGtw==
X-Google-Smtp-Source: APXvYqxGGltCQQkhfd8FsZcR/NEGWHLEa2/5JhNm18lEoFi4cG/57tQCWQc5D/9C2mlMQ6tMhCidUr1+oWZhjww0AM4=
X-Received: by 2002:aca:aa48:: with SMTP id t69mr9852670oie.114.1558359912040;
 Mon, 20 May 2019 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190512053749.7508-1-skunberg.kelsey@gmail.com>
In-Reply-To: <20190512053749.7508-1-skunberg.kelsey@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 20 May 2019 15:45:01 +0200
Message-ID: <CAMpxmJWCD0yOTyEfQhU59BsvnUoGkwWC3cEnS8Dn9W7EupA2Wg@mail.gmail.com>
Subject: Re: [PATCH] tools: gpio: Add include/linux/gpio.h to .gitignore
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

niedz., 12 maj 2019 o 07:38 Kelsey Skunberg
<skunberg.kelsey@gmail.com> napisa=C5=82(a):
>
> File include/linux/gpio.h is generated after building
> tools/testing/selftests
>
> Add gpio.h to .gitignore to help clean up working tree status.
>
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
>  tools/gpio/.gitignore | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/gpio/.gitignore b/tools/gpio/.gitignore
> index 9e9dd4b681b2..a94c0e83b209 100644
> --- a/tools/gpio/.gitignore
> +++ b/tools/gpio/.gitignore
> @@ -1,4 +1,4 @@
>  gpio-event-mon
>  gpio-hammer
>  lsgpio
> -
> +include/linux/gpio.h
> --
> 2.20.1
>

Patch applied, thanks!

Bartosz
