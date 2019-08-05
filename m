Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C7BC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD32206A2
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 11:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SmFf48nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfHELVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 07:21:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40199 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfHELVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 07:21:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id m8so45373254lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 04:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8hNDwGs8bcTkf5jcX5OpjV6TDJ03VTJoMgNpkl3MEU=;
        b=SmFf48nlUMtHnH/4MDqfmGZa9SsDFGG08uJ9cUu61xnoEmCdTkl4hZ2mab1PS3iWTd
         0emsWS81L1qTrLPk336eb/6aZPADuZ/G8JKgWKNLY3CXqRzfJUs0sFnxi2ulkYMqn9c+
         Lr7CPwjWDiEOO1IGxcJHf3Dtot1TE1jfnSk0uMZ+uggCsWjm7NfxsM012T0w/RGOh62l
         w3ILbSxbdh758KsMkaXY6cr8vOrhrqupbvTuMBxYHKUEYGu62aL+thTBWGlS8AAjZsrm
         PGqqxSNPF4LTN+7X74PUXAB6ZwG4PgD9TQ6r8+ksMb0tumAAe0S/gJTzLjZJjwzTkKSs
         Kwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8hNDwGs8bcTkf5jcX5OpjV6TDJ03VTJoMgNpkl3MEU=;
        b=q7JKHTxiNGMaLbG2clM1JUWx26+ni5z/CHXKVXxNaIXyNHyUoyiTyyyZiYJX7SXUqY
         OU+k6LUxLlctVThZETV0ea0BXaeY6RQkGPP1ecg5T1Wz2Qc6vBpI62dXjwulijdgBDg+
         0XU8ZS1oYWcT+tUcOWQWyWnON01scNjHOr8HLCq/EHCJ54VZ3JjorwVzCv3ocO8hU+/d
         otaXmcO0QM5NpZPI2VMTAS3nNrhTIBcJ6N7EbCj7XkPxFsRCZvB+YMMtMK3izK7N6ncv
         YVHRkhVsVh7dx9AJFFuTA7E9mlHzcwRBDuBrBOxmywQmDRoEmS1PrQegRG4+yfiXyxID
         RpBw==
X-Gm-Message-State: APjAAAW9dGfQc0c+lO6DDJVRgGJ9Mm7d2ZjhNHm5r6bq5hfRFKALSMCm
        GFywaao1vjfOaVtnzXknswlmlQcLwquDNcHJ1X9nzQ==
X-Google-Smtp-Source: APXvYqzc/dxywuCfBMgBTR5GgO9I26r0ATaAILxLk3ZjLZrmxVOqZjYWKXaz3vtYEUWieKdVt+79lFCdSQo5MvANVl0=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr13898023ljo.69.1565004082120;
 Mon, 05 Aug 2019 04:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <1564465410-9165-1-git-send-email-hayashi.kunihiko@socionext.com> <1564465410-9165-5-git-send-email-hayashi.kunihiko@socionext.com>
In-Reply-To: <1564465410-9165-5-git-send-email-hayashi.kunihiko@socionext.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 5 Aug 2019 13:21:10 +0200
Message-ID: <CACRpkdasSJAq6KdsMPMwo77VG-5TzDMmKPPNXXrmEZj4jzurvw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: uniphier: Add Pro5 PCIe pin-mux settings
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 7:43 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:

> Pro5 PCIe interface uses the following pins:
>     XPERST, XPEWAKE, XPECLKRQ
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Patch applied with Masahiro's ACK.

Yours,
Linus Walleij
