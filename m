Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A2C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC5E208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403762AbfFKIn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 04:43:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39856 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391322AbfFKIn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 04:43:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id i125so7116775qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 01:43:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAM2ZnplmXr9IFFiNeSowp8y01t03eeswE+odNZ6E9s=;
        b=gT3JU24XQHzjYYRIhsPkENxa6mJpCHSNhr0iD9KJVKm7NpR2NlBJSx0lY9Oih/3HhX
         rkWW0+a/IguHO+CbmrRDKyQIddWVXGSBczoQokDjQXEgwXsEWUCcSLkiD2bsBNRm+yfD
         I0074LAistymtWbC1ELtIIyAE1qnS76UlCNOdxA3mLo1Nte21I1wyytWjC3S+1R4dQ4p
         A/QXHM5+IB/edYTxbofhQuK2Vf/p1UmzzqhMaSNXiExVPerN4WjjNP1Q+nf3uBkR+hEJ
         Rztl23EUOkN/TyHjogeuHV5nmOYE8pFn3x+a1OqycMSsSa7QCa9Zn5jiqqwbHkwf7xUv
         LIzQ==
X-Gm-Message-State: APjAAAUj9tltbjCjPsIfiCTRwK9beDxfiDA6bKNIfmPxSCFbQZt1cwj+
        suvN/OxfpURiWbFqpeUznFnvN7Ev8YGHO8nx5b8oXzD8
X-Google-Smtp-Source: APXvYqw1q0laWbp9i/uhwxQEKfuIRYv0WpOBz7X6AGZWrVWGLfI5PYVS4p5HqaMfLACNsj0LWVIWA+5OhadJGL7OKMk=
X-Received: by 2002:a37:ea16:: with SMTP id t22mr59894613qkj.337.1560242606439;
 Tue, 11 Jun 2019 01:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190610185343.27614-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190610185343.27614-1-nsaenzjulienne@suse.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 11 Jun 2019 10:43:15 +0200
Message-ID: <CAO-hwJJzYFQs_Jxc+3zYHzjM9G8zdTfBqdpO27hpKXRBKytvQA@mail.gmail.com>
Subject: Re: [PATCH] HID: input: fix a4tech horizontal wheel custom usage id
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On Mon, Jun 10, 2019 at 8:54 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Some a4tech mice use the 'GenericDesktop.00b8' usage id to inform
> whether the previous wheel report was horizontal or vertical. Before
> c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key") this
> usage id was being mapped to 'Relative.Misc'. After the patch it's
> simply ignored (usage->type == 0 & usage->code == 0). Checking the HID
> Usage Tables it turns out it's a reserved usage_id, so it makes sense to
> map it the way it was. Ultimately this makes hid-a4tech ignore the
> WHEEL/HWHEEL selection event, as it has no usage->type.
>
> The patch reverts the handling of the usage id back to it's previous
> behavior.

Hmm, if A4Tech is using a reserved usage, we shouldn't fix this in
hid-input.c but in hid-a4tech instead.
Because you won't know when someone else in the HID consortium will
remap this usage to some other random axis, and your mouse will be
broken again.

How about you add a .input_mapping callback in hid-a4tech and map this
usage there to your needs? This way you will be sure that such a
situation will not happen again.

Cheers,
Benjamin

>
> Fixes: c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/hid/hid-input.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 63855f275a38..6a956d5a195e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -671,7 +671,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>                 if ((usage->hid & 0xf0) == 0xb0) {      /* SC - Display */
>                         switch (usage->hid & 0xf) {
>                         case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
> -                       default: goto ignore;
> +                       default: goto unknown;
>                         }
>                         break;
>                 }
> --
> 2.21.0
>
