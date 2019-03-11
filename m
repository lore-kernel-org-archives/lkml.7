Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D10EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B932075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCKPJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:09:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43138 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfCKPJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:09:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id d16so5388837qtn.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mk/P0F9BJzjK+EX7O/4Dd3MQhNF3Qc4rAv/tot5cI6g=;
        b=inbRcH8zODDv997Qs/QENvVq9xmbzxxMwbJhNAbG2qyT9ojpwZwgUj9XIPXg3YDHDT
         FrsTfcZS5yFH47Th0pNC8jhR2Y6Kb3tp7DeZwIWLwa/uXYwRlYg6xMDB3PuBXDJyCvDJ
         i9qI5TVdOKRaJ9CxTRaqGkklEdtvi0zrN11zUp+fOjRTUngx0zjGgpScmNDj5TVnSf27
         YTKw8+5vFeqMZX1hkHaKbREPyIuwwso2Jd5m8SmUAOdqM6VHdTnOx/qw8hAPhq2e6BQd
         qKmuSN4Bb8a0qoTBGx9fhhWmVmYk9rX13a0UvMJQ4x6nYABS7Gcp0G8IXl0/3KYeUNbl
         NvHw==
X-Gm-Message-State: APjAAAVgPl+upGHt3KpGcugJ2mxsMHLdrV+T9kahN/YC6YcDXedXVmni
        ehgT4uYn5xv7GxGhttDk8sg63aTH7DalOJQNn4F3Vw==
X-Google-Smtp-Source: APXvYqwwRHMnSwcqhOk4R/7F8WGOWUypEs8kh6thpoUU3PlNyygiS388z4mXroHZnVzE8kl+3SHLI4DR9Sz1dVXuBkY=
X-Received: by 2002:a0c:d963:: with SMTP id t32mr25891450qvj.231.1552316942687;
 Mon, 11 Mar 2019 08:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190309044345.7018-1-kjlu@umn.edu>
In-Reply-To: <20190309044345.7018-1-kjlu@umn.edu>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 11 Mar 2019 16:08:51 +0100
Message-ID: <CAO-hwJLwvZvhPPKU7r74xtKsp_P5VBZ2964iQhgBR5zF-ZM7wg@mail.gmail.com>
Subject: Re: [PATCH] hid: logitech: check the return value of create_singlethread_workqueue
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 9, 2019 at 5:43 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> create_singlethread_workqueue may fail and return NULL. The fix
> checks if it is NULL to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 15ed6177a7a3..efbc39b92aa2 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -2156,6 +2156,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp, u8 feature_index)
>
>         /* init the hardware command queue */
>         data->wq = create_singlethread_workqueue("hidpp-ff-sendqueue");
> +       if (!data->wq)
> +               return -ENOMEM;
> +

I agree there is something wrong with the current code, but I think
you are not fixing the issue properly.
The code just above allocates data with kzalloc and stores it in the
hid_device and set up everything. If create_singlethread_workqueue()
fails now, then we are screwed and you need to reverse all of the FF
init.

I think we should move the thread creation above so we are not leaking
memory and not create the FF elements if there is something wrong.

Cheers,
Benjamin

>         atomic_set(&data->workqueue_size, 0);
>
>         /* initialize with zero autocenter to get wheel in usable state */
> --
> 2.17.1
>
