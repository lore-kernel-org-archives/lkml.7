Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D53ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E004E206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMLKJPZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfJGPf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:35:29 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:35:29 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so8406328pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=9grFCI4XfO/P0ws+W1hJ+qqcKoeFDoYdqOk/sFE2nys=;
        b=aMLKJPZSjvPLIvvPUOcLneGm6UxCTtoLtzu9ffcLbVXvDidM8JuF1e+MVb3sIS65Rq
         U+WAA8O0CjIgP1SVdukQJ1n7LhU5IDHRkmgOsXRbwgbLurkHtpICBk6CDY5zOBvJOuKG
         Uk12yc1LHvoAeGZUh/7hlz1jJKzEGxP+syK4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=9grFCI4XfO/P0ws+W1hJ+qqcKoeFDoYdqOk/sFE2nys=;
        b=ZNgyt15msEAvXtbwdFK07PEBEqsR9kI8Ii91caUbYguUdvtROWKV26Lmfr4SX73N85
         uCG5+GZ9H7ncyuDFmmw70uIdYPk7dv1kWMm3gGJucEejfw6WtS6s0cLLsDH1Gb3gOo2z
         P4cu531rG17QmBUOVVDN4E/AFrfGbVBgVYmTPwW1VjySjZJPpMgPd5v/Qjv3dMCsblxk
         SrSRk2yINpOn3x8gu/MR1RkUWvUOYX7SkXNaFJbZGdPuVWiHeKkepFPnBHV8KiF2saVk
         uC7YpZdTArI85x+qejGef6u2/VyFn/ckdahO0r/WiStFyf6TLbKQ2IugfxS/cjVEIo1c
         mngw==
X-Gm-Message-State: APjAAAU6zoOjZ2ej9Jeylsd7QeM0xevLpTB4EZO207VRkd7I9sCjQJOA
        uJ0JMwYMl/wWxLxaWONRL6sqRw==
X-Google-Smtp-Source: APXvYqxI/+jk3P66gPY4uMBlG8j+Wudd2oTqEZlZdOkg+hiDgW6/L1ArOedrtmf15tLgJKc8pMlAUw==
X-Received: by 2002:a65:6644:: with SMTP id z4mr4897044pgv.208.1570462527521;
        Mon, 07 Oct 2019 08:35:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i1sm15674482pfg.2.2019.10.07.08.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:35:26 -0700 (PDT)
Message-ID: <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com> <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net> <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
User-Agent: alot/0.8.1
Date:   Mon, 07 Oct 2019 08:35:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cheng-yi Chiang (2019-10-07 06:58:41)
>=20
> Hi Guenter,
> Thanks for the quick review.
> I'll update accordingly in v2.

I'd prefer this use the nvmem framework which already handles many of
the requirements discussed here. Implement an nvmem provider and figure
out how to wire that up to the kernel users. Also, please include a user
of the added support, otherwise it is impossible to understand how this
code is used.

