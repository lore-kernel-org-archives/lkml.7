Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A52BC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29232086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgnatwRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbfJCSfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:35:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729993AbfJCSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570127713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RTMENbih6iijQ9dlDl/6i1xREO8UhrKYbrBbztUnU2o=;
        b=bgnatwRW7/mo+60RilcyF97tjfrDdWMNAdqDCvDHKU5ZPeqsqkOuRiTo/v7A3QalAR9jZf
        NM2RBed9S0PWO5ykySNkkWMDkmfhOppee757TQzNkR6R+dZQdNzFtUzU18O9N7G1l9Kzqz
        69SF3ooh0iSZBN9vNVoemPSOvUYN1CI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-jVyJ-q_nNJeVFKZoosCI5w-1; Thu, 03 Oct 2019 14:35:11 -0400
Received: by mail-qk1-f200.google.com with SMTP id r17so3601950qkm.16
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 11:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyEBFcoclk0k8j6w3rMJI9yX9wb88qrPD3qqvau6GSE=;
        b=tnK71ucQA7TgLzDi39FVEY7aRFFUws00TqXM2RFcLfDy17dnHFy0oeYT5+z9L3xeph
         aOfHYeGaDifyOedOaXJegG0QNu+J7Rm0PHQMolSUqgmfjBPE2crC9IiTG6IaGPLbUpyY
         7Bd/zSBEiZNPZPNcrkUA5nCMyosfyXxt7brn9Bx/j2yh0DjC14UZfymeIQEcA3JFx1yS
         3/5tRfiz990T4cPmgHoNNcNUTQ+JeTFvLHnVKqiILIWtIFyHaSD591sONqSxQuDe634J
         TRwXczozrlXnoiEch2buYlvCYuuJB0IDefXFJOdoR+uo8Ma1cMSHu7d8ZP45axGYyG/0
         AKzA==
X-Gm-Message-State: APjAAAV4dyW4kHXYNkz5HYQQk9aodvMoxiXzUt5CEuRPlb1iqVi+9RQI
        fMPnAlMfXE9/LMTGQDW7kC0XqJ+kkFfEHRCHTES8tWaNkgyUYh2n9V9AOSImx6kRAUi0GTq4jT1
        K9BD+Qeb8SacRs9GM69x+thEbNcwK8J0vbh4Pd526
X-Received: by 2002:a37:5887:: with SMTP id m129mr5700271qkb.27.1570127710763;
        Thu, 03 Oct 2019 11:35:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzPabDzehR5qiqX01GyYVQ9AZvGW8yw2/ObOo/CM+TKkKRwFdBL9hhoAIlkf7yckrDXv+Uo+KS8XS17NN2bfFY=
X-Received: by 2002:a37:5887:: with SMTP id m129mr5700250qkb.27.1570127710450;
 Thu, 03 Oct 2019 11:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191002215812.GA135681@dtor-ws>
In-Reply-To: <20191002215812.GA135681@dtor-ws>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 3 Oct 2019 14:34:59 -0400
Message-ID: <CAO-hwJ+v1jJJ=APP__84SPrFdR+Te8nAxR6DirD8a9US_Bm4wQ@mail.gmail.com>
Subject: Re: [PATCH] Input: add input_get_poll_interval()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-MC-Unique: jVyJ-q_nNJeVFKZoosCI5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Oct 2, 2019 at 5:58 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Some drivers need to be able to know the current polling interval for
> devices working in polling mode, let's allow them fetching it.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Not sure if you really need my input on this one, but, sure, looks good to =
me:
Acked-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/input/input-poller.c | 9 +++++++++
>  include/linux/input.h        | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/input/input-poller.c b/drivers/input/input-poller.c
> index 1b3d28964bb2..7d6b4e8879f1 100644
> --- a/drivers/input/input-poller.c
> +++ b/drivers/input/input-poller.c
> @@ -123,6 +123,15 @@ void input_set_max_poll_interval(struct input_dev *d=
ev, unsigned int interval)
>  }
>  EXPORT_SYMBOL(input_set_max_poll_interval);
>
> +int input_get_poll_interval(struct input_dev *dev)
> +{
> +       if (!dev->poller)
> +               return -EINVAL;
> +
> +       return dev->poller->poll_interval;
> +}
> +EXPORT_SYMBOL(input_get_poll_interval);
> +
>  /* SYSFS interface */
>
>  static ssize_t input_dev_get_poll_interval(struct device *dev,
> diff --git a/include/linux/input.h b/include/linux/input.h
> index 31da4feaa1d8..a420324b7882 100644
> --- a/include/linux/input.h
> +++ b/include/linux/input.h
> @@ -387,6 +387,7 @@ int input_setup_polling(struct input_dev *dev,
>  void input_set_poll_interval(struct input_dev *dev, unsigned int interva=
l);
>  void input_set_min_poll_interval(struct input_dev *dev, unsigned int int=
erval);
>  void input_set_max_poll_interval(struct input_dev *dev, unsigned int int=
erval);
> +int input_get_poll_interval(struct input_dev *dev);
>
>  int __must_check input_register_handler(struct input_handler *);
>  void input_unregister_handler(struct input_handler *);
> --
> 2.23.0.444.g18eeb5a265-goog
>
>
> --
> Dmitry

