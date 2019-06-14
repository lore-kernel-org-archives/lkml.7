Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B88C46477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C3D217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pleZuKHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfFNS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:27:16 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36936 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfFNS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:27:15 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so7893446iok.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZb2REwkbeVZNXHI5fD+3eiWIkNOiT6DsVe5Q+EGgfg=;
        b=pleZuKHPpcSGTua34WVC3ejtokF/dddBNXBFlhnTlorTPZW9amP6aXAw5vwqXsxSYO
         Bjg6XWscFzvXr22osb9EwPAhLuYqRREhw1AiceBqkK/MjhQAguNauLQ4dSuwCNoMR4KX
         0mbEkr9nyLUp1jvlva+zycg8gtJGLdrjNWcPYa8Z+Mz4pPF/3pqnH3q103rFbQE6u/Gn
         hgyYTeWa3DoTPs8Jbm36m/PneEe0xVpoj3ZzHKHBZh5stBRSLlp5t8DP4BvX8zF24Ii1
         j0Pnf3FGW8bF20iMY9JyDxKwwf8JqJ4Pni6kh2hu9kOuGZAyCiJz9OT8VzQoqWe6jvV1
         fbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZb2REwkbeVZNXHI5fD+3eiWIkNOiT6DsVe5Q+EGgfg=;
        b=UiffSfFyvMf8kyyRhk3ixQV/XTjbwGa91t7qAChqVwgudiiKElN/gj3S+RiWkav0Zc
         NQXk6jv0V0VWJ/SNbKTdcN+pbfvNiKMKAvRumoDl8/5Zo/B8hzLqz2dydtbhNJLtLBOI
         +RScSONLYdg0OJesyvveGCfGho1F1aOV8z8jxvV7fSaeWRVEVbyPc8BtxnmOUF5/wpVs
         qm/5r5N5BSfYrx3RfOesi+Uu+3iijUVbLn3QS++qGV5HtC5EpZclP9gGPEHv+dNese3e
         2CE9hVn0KaB+Pn2fr21w/CKfTvF4qnjd2Qg3OESMKBSbRFnUdVDJ8HNfRzNbqGNkcRni
         91kA==
X-Gm-Message-State: APjAAAWrzIyvB15VHQQjJ+2oBrO0icNI4Eh/zHmg7LIX9qRB3JJTrQIk
        Lr6HvFxxi9QxjaTIBQP27fyLoLdmsCrehcMoGW1f9A==
X-Google-Smtp-Source: APXvYqzSjJjFKhhfDcZckLiQ5FFkrM2TpYF1hRv9WSd3h7HTHAOZ7F2c+oKGJXp+eVZEF6KwqOAmCXvnjCIsAK7ORCA=
X-Received: by 2002:a6b:901:: with SMTP id t1mr16642472ioi.42.1560536834818;
 Fri, 14 Jun 2019 11:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190614065438.142867-1-phoenixshen@chromium.org>
In-Reply-To: <20190614065438.142867-1-phoenixshen@chromium.org>
From:   Enrico Granata <egranata@google.com>
Date:   Fri, 14 Jun 2019 11:27:03 -0700
Message-ID: <CAPR809sASD=MrQkJULVBgc_iqiPKE2xr8eUR0d4qymQkLUYRaw@mail.gmail.com>
Subject: Re: [PATCH] Input: cros_ec_keyb: mask out extra flags in event_type
To:     Ting Shen <phoenixshen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 11:54 PM Ting Shen <phoenixshen@chromium.org> wrote:
>
> http://crosreview.com/1341159 added a EC_MKBP_HAS_MORE_EVENTS flag to
> the event_type field, the receiver side should mask out this extra bit when
> processing the event.
>
> Signed-off-by: Ting Shen <phoenixshen@chromium.org>

Reviewed-by: Enrico Granata <egranata@google.com>

>
> ---
>
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index d5600118159835..38cb6d82d8fe67 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -237,7 +237,7 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>         if (queued_during_suspend && !device_may_wakeup(ckdev->dev))
>                 return NOTIFY_OK;
>
> -       switch (ckdev->ec->event_data.event_type) {
> +       switch (ckdev->ec->event_data.event_type & EC_MKBP_EVENT_TYPE_MASK) {
>         case EC_MKBP_EVENT_KEY_MATRIX:
>                 pm_wakeup_event(ckdev->dev, 0);
>
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
