Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B75C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A571C208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3jTJ/Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfGaQGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:06:01 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36741 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaQGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:06:01 -0400
Received: by mail-yb1-f194.google.com with SMTP id d9so18198289ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRRqwkpcI53teRjcOkCo/u4yNvkJ3n0LBJJNlhIbQKs=;
        b=P3jTJ/Wx48996sLijiWGaUjfbi/B/kCcMzSSuKiU019fryrueyi8hgODOU+xLAoy0D
         YQuL9F5OvtJm02BhWy+w5navYIeYstp6V+l18UOO4aB0iuPJVD8hoc1sdrUaaXNrVgzc
         l9FV0Crx/OlP6BgCeJ5WZE++YYZ+QxuE/3OrVPToJn+iWQ5xMOoBtgE3wSwPjhBVDAgI
         NWPOP6y79ZJQMEdsY8hRAhzfQre2pvIbGGOi5olgXBuZT/X/Uou24Ex7ed8K9L/93tyM
         FA8qMaXy7Qlzn4jwO+mKuZwufKiCeFOzc0wbauHUDOyuMz1Wsf4k25gf/Yl2DsG9jutU
         h/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRRqwkpcI53teRjcOkCo/u4yNvkJ3n0LBJJNlhIbQKs=;
        b=AMJWs6zTQZz0qN2RTuavYmHQQ5PaIMSSt3MZpIwraxQLescNHQZL1ctw/VLCq7dhLe
         dGONGzwcTpiZBSRk+AvaJr+M4d1FhejJbRnzLoNmHl7DkkPJFA/cp0Vk9mpDKAdfcUck
         WfrEfFVgFRihK83LjeuYSHqPWbLVYmqFqhWfS95YUUsVTcX8kqnKc6xKO/OrocCorY2S
         HJ4En6yQiNirtUd2W9TnoJol8X8Vqn79LC/zraQBxVXSpnZVkvK9y4dv52FFg66qGZtS
         77v5pjigsbitVAW+RruGDWd5IumEYWtSvUU34b5gM2DUReLPgXUv3kf9ksrQcidBbRLI
         HYKA==
X-Gm-Message-State: APjAAAUvLaADJhezTYZgk2BFJla1CF7/gHKOgOrnQVdqMApXyx1MTx4N
        uLkCrozotW2fX0SzYba0iIKdz6GQ
X-Google-Smtp-Source: APXvYqwSgJQ5LM/4D8Q9ICEq9w+RUIaneviVANiF193fq86NGb9e71wWts9vPLZr+wBhhnwMv00NQQ==
X-Received: by 2002:a25:9c83:: with SMTP id y3mr31006763ybo.455.1564589159661;
        Wed, 31 Jul 2019 09:05:59 -0700 (PDT)
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id t201sm16172758ywc.87.2019.07.31.09.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 09:05:58 -0700 (PDT)
Received: by mail-yw1-f47.google.com with SMTP id z197so25141534ywd.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:05:58 -0700 (PDT)
X-Received: by 2002:a0d:cc48:: with SMTP id o69mr70364492ywd.389.1564589158227;
 Wed, 31 Jul 2019 09:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190731122203.948-1-hslester96@gmail.com>
In-Reply-To: <20190731122203.948-1-hslester96@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 31 Jul 2019 12:05:22 -0400
X-Gmail-Original-Message-ID: <CA+FuTScqD4bMpm6n13ETFVEvSKnk_rRUzspzs9HB6B5Un101Dw@mail.gmail.com>
Message-ID: <CA+FuTScqD4bMpm6n13ETFVEvSKnk_rRUzspzs9HB6B5Un101Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] bnxt_en: Use refcount_t for refcount
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 8:22 AM Chuhong Yuan <hslester96@gmail.com> wrote:
>
> refcount_t is better for reference counters since its
> implementation can prevent overflows.
> So convert atomic_t ref counters to refcount_t.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 8 ++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index fc77caf0a076..eb7ed34639e2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> @@ -49,7 +49,7 @@ static int bnxt_register_dev(struct bnxt_en_dev *edev, int ulp_id,
>                         return -ENOMEM;
>         }
>
> -       atomic_set(&ulp->ref_count, 0);
> +       refcount_set(&ulp->ref_count, 0);

One feature of refcount_t is that it warns on refcount_inc from 0 to
detect possible use-after_free. It appears that that can trigger here?

>         ulp->handle = handle;
>         rcu_assign_pointer(ulp->ulp_ops, ulp_ops);
>
> @@ -246,12 +246,12 @@ static int bnxt_send_msg(struct bnxt_en_dev *edev, int ulp_id,
>
>  static void bnxt_ulp_get(struct bnxt_ulp *ulp)
>  {
> -       atomic_inc(&ulp->ref_count);
> +       refcount_inc(&ulp->ref_count);
>  }
