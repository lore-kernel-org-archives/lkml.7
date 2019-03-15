Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DADBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE66218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 05:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAvpBYaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbfCOFUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 01:20:23 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41064 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbfCOFUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 01:20:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id k8so6347258oik.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 22:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAGLbKDU7b1+gCsbgNXFOwg0Sk1ObZTtlc2Ab4OPJAI=;
        b=NAvpBYaPJeOFWI8kil9X3geoSONlcvKZwIw8GdYpMeT46UDdlUYAX+Mobdb4p0t2JH
         qQMP9AUi37xYQSqz+5IYaabb/IVf1hki5GuH4e/TyrZ+NQw7YLXXFoNncVSJO22mjGqY
         v1r0PJ1OozkC8zcgl5w2oVp/TfB2nxCeXxptyy6B5qeo9Xghx5pp8R7lfFwT4eg0CFdn
         6m0twyJW1bnW13hKWmJEhqzDvqGueCbmHnSBxQLmK52p3WYRV/Ty+J4zPy+cyKVMsxrU
         gMPWfsPH7kiHbZJVZjPB+4Q/2Zg4dfedr6L1zM8ap88xlOW4QE2nyDCXi6eV6cJluY/q
         YRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAGLbKDU7b1+gCsbgNXFOwg0Sk1ObZTtlc2Ab4OPJAI=;
        b=LPAenxNOwHGyEqIWpJqtcrmD104bqdRtqlxHXQOErw78deeWLZCOtZXFWP1t1s7JRA
         3CWYUVjwsW2BQp0nPlDH6/AstBV6BGvh+WUuBk7xo3PdNks0S52lmQqwFXJ1umOZeeqi
         4TMhUq3gXe/HKMvvV51oF6guuHOWMOaqxZa3goAouFGdqQUBPIclPxnRHK4f9y9Y4LxG
         me4lqyNC7pas9kLPFojLg0dUfwRa6iCd7TUdghUeSnGM6E/UrAqKFyOeVlk067cj687g
         c5/33ejYINh9WQUCKIvhvK2kKu0YvP/Zu9DoLSXNpbo8YGCLO4qaCBZuKRQW368W8O4f
         OPyw==
X-Gm-Message-State: APjAAAXbWX7HekWgS8Iov9Dnt2xDSuxbeUWmhywo2svXXaHCkWb1PGGS
        KOSA1cbkTsAQ9NvZw0S8yufGKJyEeC3/Yb0DGLA=
X-Google-Smtp-Source: APXvYqyxeQ2P+HETPeS8/9Pc8PtBe2xH7EgjmDReisx/8RrZ8+e87yP7X+8Tc4gqPPRVxiYGjvFPmdOGSk0Nv0hyIHo=
X-Received: by 2002:aca:e0c6:: with SMTP id x189mr450295oig.78.1552627222291;
 Thu, 14 Mar 2019 22:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190314064525.15756-1-kjlu@umn.edu>
In-Reply-To: <20190314064525.15756-1-kjlu@umn.edu>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Fri, 15 Mar 2019 10:49:46 +0530
Message-ID: <CAAs364_6MpywkbsFdZrT5TEdrD8+u1eTmg-8_KY0dypy_PgMxQ@mail.gmail.com>
Subject: Re: [PATCH] greybus: audio_manager: fix a missing check of ida_simple_get
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 12:15 PM Kangjie Lu <kjlu@umn.edu> wrote:
>
> ida_simple_get could fail. The fix inserts a check for its
> return value.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/staging/greybus/audio_manager.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/staging/greybus/audio_manager.c b/drivers/staging/greybus/audio_manager.c
> index d44b070d8862..c2a4af4c1d06 100644
> --- a/drivers/staging/greybus/audio_manager.c
> +++ b/drivers/staging/greybus/audio_manager.c
> @@ -45,6 +45,9 @@ int gb_audio_manager_add(struct gb_audio_manager_module_descriptor *desc)
>         int err;
>
>         id = ida_simple_get(&module_id, 0, 0, GFP_KERNEL);
> +       if (id < 0)
> +               return id;
> +
>         err = gb_audio_manager_module_create(&module, manager_kset,
>                                              id, desc);
>         if (err) {

Reviewed-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

--
./va
