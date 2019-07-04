Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B4AC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5B72083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnLAO5N/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfGDQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:12:07 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39143 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGDQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:12:07 -0400
Received: by mail-ot1-f65.google.com with SMTP id r21so1724031otq.6;
        Thu, 04 Jul 2019 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOm/HvLRodK9Gmtg8Pu+nD4Ju+GzARos9DN1PBnngww=;
        b=ZnLAO5N/cjBNnfi05k8nnzcwqeojnDRLbnWpeFhu55YnIK/VkStqmUt2q0KmoNHK7R
         326a9gF9U5YXEUtZK4LlrxAdtTRYmi22miuCjj1vKxSTW7sLqWAvrl8I4GXAUOzbrHCu
         SZsFWfcB89i2UCJgu4VLoD/7iQSwVlmeMihp/gsZVlp8PY8mfVfs5gjRrvab7/3GlOdW
         lovRk3VYcyt/HC3BP/C2sU2NoCCQMNoPuEu4+4MfHJZDDvqDsWAg5/nNn53VgF+A5Ytn
         p2leV/a6bbtjmjsJZVw4ZsaKL0ofI/LQzeLbgqNXCkPzCHb+3O7DiJ2xQ3JvGHDziQ0r
         8rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOm/HvLRodK9Gmtg8Pu+nD4Ju+GzARos9DN1PBnngww=;
        b=o0jdNEpA4njlSSLyMALSs8CfIYngHk0GiAgJmJYKQdvNXvPnxLEZt4LiPmFwgB+yJt
         LN3leYvf6SMKUQL7LGJH23nxC0RmWFnhDbBuknTv1jx1IuklJki676UYfMvgoGxjPubO
         6R/csVpmN/TCrVn9OkMRplEgaxrifbiXoa49CeVJkUzZGsOyi31/lXHNkeeMsvC/Qv57
         MbyPxfpbz7fgTkAJFWKQ+LNoP2Z3KkeV+D+jhunTu6DPzSrmQzYpBMYWQCadwJVkVIy1
         GtjU/0mn3j0h4sfHec2wMk6uifZsFY4ly4hLYT18mydn85zBO1r7X8tbp/xtSQbLMSaR
         cE5Q==
X-Gm-Message-State: APjAAAUMtyYnFat1yNx0uuygz4+DeaVo9MNV780DBpr1gokuRL1X8tu+
        NQZZa6ZPwfwqL+rTA1Hw8YGa/FQiSqt7rNBNr94=
X-Google-Smtp-Source: APXvYqy4bWZa64/P36dEj/NLPY1nKF3u7sWYt5t9/HNW6LIUW4IHgRkpNfgNmSRLikr+xC7CPyWf3pdHpn5BOKIhuiQ=
X-Received: by 2002:a9d:76ce:: with SMTP id p14mr34242454otl.342.1562256726047;
 Thu, 04 Jul 2019 09:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190704133031.28809-1-colin.king@canonical.com>
In-Reply-To: <20190704133031.28809-1-colin.king@canonical.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Thu, 4 Jul 2019 21:41:27 +0530
Message-ID: <CAAs364_ht9ubWrkr3qBYKofmCYUSsQPi-Ahqk4D+hG_JpDXreA@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: remove redundant assignment to variable is_empty
To:     Colin King <colin.king@canonical.com>
Cc:     Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 7:00 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable is_empty is being initialized with a value that is never
> read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/greybus/audio_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index c2a4af4c1d06..9b19ea9d3fa1 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -86,7 +86,7 @@ EXPORT_SYMBOL_GPL(gb_audio_manager_remove);
>  void gb_audio_manager_remove_all(void)
>  {
>         struct gb_audio_manager_module *module, *next;
> -       int is_empty = 1;
> +       int is_empty;
>
>         down_write(&modules_rwsem);
>
> --
> 2.20.1
>
Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
