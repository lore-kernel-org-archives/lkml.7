Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84469C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B5820B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMFT1mz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfFRQVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:21:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39106 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729295AbfFRQVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:21:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so12763376otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVqtzTiQQEyqRJyBqq1yEvv/K5mI8W319j/HRb3fZxA=;
        b=bMFT1mz/lb0FbMl9LU00/EM07FtKDXzKHmYPfpRdTb4ZjbCeF9OlsJNf65wsf2eJ6L
         SYvxs3elwvsJ/qOhzbgiXVtH0K+OKp6DISi2rQF6uB6EiOKvPlLtrJ1HWLwLMcw6rKeW
         RBYq2ybNxyONeMd2GZ+MBn8C1ys7jRExNHOcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVqtzTiQQEyqRJyBqq1yEvv/K5mI8W319j/HRb3fZxA=;
        b=BuoTbuPVav3cqP65EBO2wNu4kfdh+w/siXu2l7IkVBG308hWowF2BXyv3MBLnpXk0V
         M6Dqi+oIMCnWJokeXHNGiubHmk8JEYwaHYF9k71uGgZpg6PO13l0QIm3Jxnva+xpJXeM
         Rulvf9x9bMCIC6fCSeYqOomcuo6TyoHW8IYEApeNZXnjVaqSk5aL3hpHXW83+lPXKH93
         dSFpemq2Xwv/nnWc+tGvKgG1lnFmNgUEoTMPf+u0J6U1QcJqn1VkXSS3zjzXAo2yBc6J
         8A4cwxp4LyEK5KRzWeYehNtfQpjIMDa/L3K93utODy8hhkbbcZlG5s2pwued51w+jnev
         eL6A==
X-Gm-Message-State: APjAAAVHricp56bUi5f/o/6CSS7c40EnDBe+x0yBBm0CjSgS9JvCF5IX
        a2ibA7Iz/0HM3I1n07WFvg8T7l5IlKc=
X-Google-Smtp-Source: APXvYqyiuKGIxwmx24IO2fOKvRmZSugZVnvqyr5IztSP/l1MtF0mDlpVHOlUrYy7bTbuZI9JE8RvBw==
X-Received: by 2002:a9d:5911:: with SMTP id t17mr16271388oth.159.1560874861381;
        Tue, 18 Jun 2019 09:21:01 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id m26sm5485335otl.69.2019.06.18.09.21.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:21:00 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id x21so15630359otq.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:21:00 -0700 (PDT)
X-Received: by 2002:a05:6830:12d6:: with SMTP id a22mr13698863otq.236.1560874859804;
 Tue, 18 Jun 2019 09:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190614214302.26043-1-enric.balletbo@collabora.com> <20190614214302.26043-3-enric.balletbo@collabora.com>
In-Reply-To: <20190614214302.26043-3-enric.balletbo@collabora.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 18 Jun 2019 10:20:48 -0600
X-Gmail-Original-Message-ID: <CAHX4x86UjFP2PqBLmvp_0UuVxG5V4owG6v+GnQGJw8m56Leyyg@mail.gmail.com>
Message-ID: <CAHX4x86UjFP2PqBLmvp_0UuVxG5V4owG6v+GnQGJw8m56Leyyg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: cros_ec_lpc_mec: Fix kernel-doc
 comment first line
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Enric, looks great.

On Fri, Jun 14, 2019 at 3:43 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> kernel-doc comments have a prescribed format. To be _particularly_ correct
> we should also capitalise the brief description and terminate it with a
> period.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v5:
> - Introduced this patch just to do some kernel-doc clean up.
>
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_lpc_mec.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
> index d8890bafb55d..9035b17e8c86 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
> @@ -17,12 +17,10 @@
>  static struct mutex io_mutex;
>  static u16 mec_emi_base, mec_emi_end;
>
> -/*
> - * cros_ec_lpc_mec_emi_write_address
> - *
> - * Initialize EMI read / write at a given address.
> +/**
> + * cros_ec_lpc_mec_emi_write_address() - Initialize EMI at a given address.
>   *
> - * @addr:        Starting read / write address
> + * @addr: Starting read / write address
>   * @access_type: Type of access, typically 32-bit auto-increment
>   */
>  static void cros_ec_lpc_mec_emi_write_address(u16 addr,
> @@ -61,15 +59,15 @@ int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
>         return 0;
>  }
>
> -/*
> - * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
> +/**
> + * cros_ec_lpc_io_bytes_mec() - Read / write bytes to MEC EMI port.
>   *
>   * @io_type: MEC_IO_READ or MEC_IO_WRITE, depending on request
>   * @offset:  Base read / write address
>   * @length:  Number of bytes to read / write
>   * @buf:     Destination / source buffer
>   *
> - * @return 8-bit checksum of all bytes read / written
> + * Return: 8-bit checksum of all bytes read / written
>   */
>  u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
>                             unsigned int offset, unsigned int length,

Reviewed-by: Nick Crews <ncrews@chromium.org>

> --
> 2.20.1
>
