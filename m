Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B41DC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311802147A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 17:15:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DQ/prbm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbfFRRPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 13:15:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39240 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRRPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 13:15:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so13078551otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xf9JaMcfMTpA+95buSp6V+RKo2piqDxI9Pf5r4xWOgw=;
        b=DQ/prbm6F/jVALB23o1UX7hNkF+klFj23vBoHAQ0naQTfSoTf2YsYc4H+xShOvuJ/I
         wii73VN4+ZQ8Sflop7Vp3eleYkzqlaMuNgBF38D3NACNU4Vk86EV5lPAaA2nA8Kq+tvG
         8lc5ZSXaDohScGj3b3YdhrjE02Cz5WEBLJZDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xf9JaMcfMTpA+95buSp6V+RKo2piqDxI9Pf5r4xWOgw=;
        b=q0QiqwD13xXYMqsqB+NcayrziZpCnJ+R55YflC4D2y4JWviXz74PdLHTRJqVpZY62x
         3QV0AyMSSOaKFngguEen2C4MlE4ph5z9OJ7IjdYQ+oRbn1zrkWo8rk7f8ZcMspImDERs
         jkxZ8AHJ3QRLnXFWxMPby6kV3w8FaO1vuUOmmCU4zEYcy/A4YmT+RywXwxQjzeqF2QAW
         AC+U2elwajCqkJLxfG3EezFVKwcu744N0aR/8BiokajQ3VTLpkB0BGM3GwMPgfSrar0V
         KQq+Ls+aVLpjKWaYmpN/g206aOl2hKyIiN49JAsCQNoul2d6ichNdY37bqPP37ROCAzY
         VDpQ==
X-Gm-Message-State: APjAAAXoD12+vdA+zvsvoEsUQcyPNZ2nmkfoChj1omFo0Sai9j1BKWJD
        qffY9HvbeyGJIF7mINLrb7dEQpG7J9Y=
X-Google-Smtp-Source: APXvYqwN2f6dh538phmdAfSrk3/FPP5hD4sIjmS82mOzwtqryMe7Gly2agY9wALHJnexOySv3Lhxfg==
X-Received: by 2002:a9d:591a:: with SMTP id t26mr1400786oth.170.1560878116121;
        Tue, 18 Jun 2019 10:15:16 -0700 (PDT)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id t30sm5924108otb.50.2019.06.18.10.15.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 10:15:15 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id b7so15950413otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 10:15:15 -0700 (PDT)
X-Received: by 2002:a9d:2c41:: with SMTP id f59mr40634751otb.268.1560878114700;
 Tue, 18 Jun 2019 10:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190618153924.19491-1-colin.king@canonical.com>
In-Reply-To: <20190618153924.19491-1-colin.king@canonical.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 18 Jun 2019 11:15:03 -0600
X-Gmail-Original-Message-ID: <CAHX4x85sETNNS8gdQYQniCM=K35DjMjdHOihJ76pGPrAoB9gyA@mail.gmail.com>
Message-ID: <CAHX4x85sETNNS8gdQYQniCM=K35DjMjdHOihJ76pGPrAoB9gyA@mail.gmail.com>
Subject: Re: [PATCH][next] platform/chrome: wilco_ec: fix null pointer
 dereference on failed kzalloc
To:     Colin King <colin.king@canonical.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Colin, good catch.

Enric, could you squash this into the real commit?

On Tue, Jun 18, 2019 at 9:39 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> If the kzalloc of the entries queue q fails a null pointer dereference
> occurs when accessing q->capacity and q->lock.  Add a kzalloc failure
> check and handle the null return case in the calling function
> event_device_add.
>
> Addresses-Coverity: ("Dereference null return")
> Fixes: 75589e37d1dc ("platform/chrome: wilco_ec: Add circular buffer as event queue")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/platform/chrome/wilco_ec/event.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
> index c975b76e6255..e251a989b152 100644
> --- a/drivers/platform/chrome/wilco_ec/event.c
> +++ b/drivers/platform/chrome/wilco_ec/event.c
> @@ -112,8 +112,11 @@ module_param(queue_size, int, 0644);
>  static struct ec_event_queue *event_queue_new(int capacity)
>  {
>         size_t entries_size = sizeof(struct ec_event *) * capacity;
> -       struct ec_event_queue *q = kzalloc(sizeof(*q) + entries_size,
> -                                          GFP_KERNEL);
> +       struct ec_event_queue *q;
> +
> +       q = kzalloc(sizeof(*q) + entries_size, GFP_KERNEL);
> +       if (!q)
> +               return NULL;
>
>         q->capacity = capacity;
>         spin_lock_init(&q->lock);
> @@ -474,6 +477,11 @@ static int event_device_add(struct acpi_device *adev)
>         /* Initialize the device data. */
>         adev->driver_data = dev_data;
>         dev_data->events = event_queue_new(queue_size);
> +       if (!dev_data->events) {
> +               kfree(dev_data);
> +               error = -ENOMEM;
> +               goto free_minor;
> +       }
>         init_waitqueue_head(&dev_data->wq);
>         dev_data->exist = true;
>         atomic_set(&dev_data->available, 1);

Signed-off-by: Nick Crews <ncrews@chromium.org>

> --
> 2.20.1
>
