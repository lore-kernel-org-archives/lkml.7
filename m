Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56961C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE3520748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oouu+mmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbfKYSJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:09:01 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46164 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbfKYSJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:09:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id t11so13572112eds.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KP6fVh4ZaU6CUB4fuJ2JgxOsEwtpNNCuWcHmOR+TQM=;
        b=Oouu+mmxmI9i+ll9lg5GVHV8Xb5oK+ZTu3+qMDAvnCiQLuG5SjclA1bPFonOsT+xEv
         CuPOLVCp8rHK0EBitUUP7HyBHbiygW28t9pxcd8UroWl+5RRfNUl0ZU0ESkO5pfDyz1s
         l2T86jCUA+jHsvoLznXvXPW8mkNAA9BomLbBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KP6fVh4ZaU6CUB4fuJ2JgxOsEwtpNNCuWcHmOR+TQM=;
        b=YHWlhOT+Crtn2feK6P/QG1qWVzG52A/z/PNYZdfFLdKc9WZ2b+Lqvj/HLniBLrpnYg
         LvuqTeK8Wu0qh6T8CBhaVaQ2RQjUlYG2Ejj4MccwBRUD16uJIhEdpJVNFRv1xeRLLeOg
         wBaVlBJZ80tYxQNrX9nG7uw38/j9l6lxSirz+4XMev/p4GTZi+mcZeOjHsyfMfAsJcZU
         bErj0/LUq/kh9ASNK69nkjcIYDg15UZT+Y68HcwFb9P5NicemjS1E81beDnoa2lVjQ/8
         Wht/nOqq6SYr7rjO9mf1xl3QAL7vzjp+pVIT/2+KGGjYTG9UYbCpgHFjaxH51ZGpxoSK
         WWaQ==
X-Gm-Message-State: APjAAAVHqp88BCFwVAAZzNrIVZle7A8QYrWm502QwjkcOGMH8kB+atr4
        l7vFKHFF9mDUE7JVxXa7Z0ffoj28A8E=
X-Google-Smtp-Source: APXvYqz6bISJ5sr5G7VaDJR2LIJJ8eNCB7WM1J54w1WvNxr4FPr2LPnC3fO3LfSNroAPrPLBmZhGyg==
X-Received: by 2002:a17:906:5e52:: with SMTP id b18mr37891997eju.318.1574705338893;
        Mon, 25 Nov 2019 10:08:58 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id j4sm249905edb.63.2019.11.25.10.08.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 10:08:58 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id l17so326517wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:08:57 -0800 (PST)
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr185973wmj.28.1574705337285;
 Mon, 25 Nov 2019 10:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20191121090620.75569-1-akshu.agrawal@amd.com> <15b0a142-a62f-1783-fe46-f5654b618f33@collabora.com>
In-Reply-To: <15b0a142-a62f-1783-fe46-f5654b618f33@collabora.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Mon, 25 Nov 2019 11:08:46 -0700
X-Gmail-Original-Message-ID: <CAHQZ30ALpF+2N8ZrA3LxNsh4Umf6x8YzEwTKCPst6LDpYU58Nw@mail.gmail.com>
Message-ID: <CAHQZ30ALpF+2N8ZrA3LxNsh4Umf6x8YzEwTKCPst6LDpYU58Nw@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-cros-ec-tunnel: Fix slave device enumeration
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "open list:I2C SUBSYSTEM HOST DRIVERS" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 8:32 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Akshu,
>
> On 21/11/19 10:06, Akshu Agrawal wrote:
> > During adding of the adapter the slave device registration
> > use to fail as the acpi companion field was not populated.
> >
>
> I am wondering if this a fix that needs to picked on stable kernels? Which
> chrome platform are you using?
>
It's a fixup of https://lore.kernel.org/patchwork/patch/1151436/ so
unless that patch has been ported to stable kernels, I wouldn't worry
about it.
