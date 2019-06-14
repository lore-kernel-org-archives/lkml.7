Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5BBC31E4E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066A62177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WPnWyA9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFNSXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:23:44 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36616 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfFNSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:23:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id p15so3595743qtl.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=JgsixOY7DseFYD9NVhuWLlq7gswhsAh5xxa+izOpaUs=;
        b=WPnWyA9duJs6z2zS0gnnr9yCluFRiF9wvX43AUxtxoHAHE1f6Z0gGOh3cIe44zhPeR
         iPlrHPLJUmlRAAVZV9OxdL5/p/dbkWYuhWrwW6plVsIYS1fkTN+0oa8FA1pXi+qw/iEY
         WFzUSnjxJbiyjgrGE8IeXP9n50e2WK+Sm0D50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=JgsixOY7DseFYD9NVhuWLlq7gswhsAh5xxa+izOpaUs=;
        b=laPASwMaPGFJcBQx6+zA3VD1Kq+1JuYofAxsEdAC+tIgQ6exPHtIt7KGERDMOHMLid
         XxdeSpdctOEj9Xbk3oJNQG9Ku48vjprx2i3/KHRAwINorBRMgTTMzzZHaaZ+cYkqO5TU
         XBGF5R3tVJ5/ykgArx2JudDPWT5udPrCc5GswmYFVlHsAGMVqYvMFZPLGSl7QxpFqwNd
         zTeFKdIfyFWcwYXqNfJpAWIoklKfOwQZ3sMEeIVMpzfn/cRUiV2aZUWIEvUGV67Zhxbx
         hPPNKjxKm+V7c3jqZZF3VYqQromMxkG/xE0Iza5LcDJxX2Ycxf4wBfhBq6Cfuqy1ABh/
         w8Aw==
X-Gm-Message-State: APjAAAUPZKqMof/XSr2rHZ7Q5jUWKHH2opqRXR0jBRMRpwW4RxqqGgDh
        +aKiS0YN93oaKgEBir3PhD771dxc55lQKqwNBTV35Q==
X-Google-Smtp-Source: APXvYqzE9Uq5Q9fvJC8Ss1UjPNECoEmT3u8p2KzuQNrXJCQrUgkAXIakzzG+4dvUplkr7sJZRtxsr0LLhkaKEzJOK+8=
X-Received: by 2002:ac8:2f7b:: with SMTP id k56mr70825566qta.376.1560536622857;
 Fri, 14 Jun 2019 11:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190607003735.212291-1-ravisadineni@chromium.org>
In-Reply-To: <20190607003735.212291-1-ravisadineni@chromium.org>
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
Date:   Fri, 14 Jun 2019 11:23:31 -0700
Message-ID: <CAEZbON5oRSnOHQrzPcapd=XrK4_ngAY-7hTzxMOyO+=rWJB1bA@mail.gmail.com>
Subject: Re: [PATCH] power: Do not clear events_check_enabled in pm_wakeup_pending()
To:     len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Todd Broch <tbroch@google.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wanted to check if this o.k.

Thanks,
Ravi

On Thu, Jun 6, 2019 at 5:37 PM Ravi Chandra Sadineni
<ravisadineni@chromium.org> wrote:
>
> events_check_enabled bool is set when wakeup_count sysfs attribute
> is written. User level daemon is expected to write this attribute
> just before suspend.
>
> When this boolean is set, calls to pm_wakeup_event() will result in
> increment of per device and global wakeup count that helps in
> identifying the wake source. global wakeup count is also used by
> pm_wakeup_pending() to identify if there are any pending events that
> should result in an suspend abort.
>
> Currently calls to pm_wakeup_pending() also clears events_check_enabled.
> This can be a problem when there are multiple wake events or when the
> suspend is aborted due to an interrupt on a shared interrupt line.
> For example an Mfd device can create several platform devices which
> might fetch the state on resume in the driver resume method and increment
> the wakeup count if needed. But if events_check_enabled is cleared before
> resume methods get to execute, wakeup count will not be incremented. Thus
> let us not reset the bool here.
>
> Note that events_check_enabled is also cleared in suspend.c/enter_state()
> on every resume at the end.
>
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/base/power/wakeup.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 5b2b6a05a4f3..88aade871589 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -838,7 +838,6 @@ bool pm_wakeup_pending(void)
>
>                 split_counters(&cnt, &inpr);
>                 ret = (cnt != saved_count || inpr > 0);
> -               events_check_enabled = !ret;
>         }
>         raw_spin_unlock_irqrestore(&events_lock, flags);
>
> --
> 2.20.1
>
