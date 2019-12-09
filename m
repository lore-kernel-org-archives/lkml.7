Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DADEC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0C1206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 19:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZYKAyg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfLITx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 14:53:27 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfLITx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 14:53:27 -0500
Received: by mail-ot1-f66.google.com with SMTP id 59so13298806otp.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 11:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnbzGoTl5WhmCbrdoUFbCzn04dh+Cx2Q09zX/BBcpeM=;
        b=kZYKAyg3zh7SfpwrhnpmZt45qa0HvkA5Rt5j9QDeedmJ+DNWXmiXSLpCEBOrf6589C
         F/JfP0Ttm8tTDqEz+D4f2MXDQS0fj+PPn4mREssvR2mpBQWOXzbFQTNWyEz5dE8RH2xq
         2Dv5rkXlth+CUBOS7jjs4hcCZnYdbfwtosMTvjhoZ+yiI+nv5oLv3nE4QKB5taZ3rULD
         hnI3WfixW34/lRc5dD+X7K8tseAwMzRWOmK3Unmg25ZkD+oDI3qGH1OK5VjS/rLNqYL9
         SA/MNAmzf8XY3PTuQ+Ra/SrXaEGmjnXwltP2L0gC5udli0cSR7zQ9585rkRdVC0CIhdM
         3reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnbzGoTl5WhmCbrdoUFbCzn04dh+Cx2Q09zX/BBcpeM=;
        b=al3ZjjGsUksxGPd6x1Pcs5ALHDOnbG0KsCngLNIWoAzZrGc6v38cqyuuv2K5xqx561
         WOHJvOxpG1crwc1OUenSnM4FjhTsIt4VQyfI1lLWgbEF8Jl9tUk5QKSPG4IuF6CwnnY8
         hW5n2WJXfh39h2JJtTRIYzSl6CdiWuRpC5Mo58FgQzcuWT4oCCAdalwI40IJBea4oKmW
         PALarveyleW9Ztr+tqpgJH88RyTV/2E8OLP2uJIyU1xDpc6zuzWc/q2VZei8jNtdcVu8
         8k7iuzIVgNLxW9twUex1gMOwmf4axRjiPaVAuihxB1P9IsvwVF+/OVaMTWLxbrJdROCQ
         bxrA==
X-Gm-Message-State: APjAAAVTgtrOn1Hcem5yHlI2F1O9+pspTAkciJadqPEW3bd7QQxTFyPM
        5HMkddproBqEBoC/7Cw61vv+v0D/uqVl8YiUSX03vA==
X-Google-Smtp-Source: APXvYqy4VB/OSt4mHS6vZdI9+mUErw54dRofHqmMIQfFdqIBE2RR5xMEQIHA9x0Ywj6cmZ37PN3QvsT0YhVg91nQCLQ=
X-Received: by 2002:a05:6830:1cf:: with SMTP id r15mr23899350ota.231.1575921205920;
 Mon, 09 Dec 2019 11:53:25 -0800 (PST)
MIME-Version: 1.0
References: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
In-Reply-To: <20191209193303.1694546-1-gregkh@linuxfoundation.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 9 Dec 2019 11:52:50 -0800
Message-ID: <CAGETcx8s4KCP=ZiYuU6oEpSrzgUyV4JeXpVKxXcWeiNiKgYKKA@mail.gmail.com>
Subject: Re: [PATCH 0/6] device.h: split up into smaller pieces
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> During the 5.4-rc merge Linus complained about the size of device.h and
> how it can be a pain to merge things into at times.  It's also become
> kind of a "kitchen sink" for anything related to drivers / devices /
> busses / classes and is the 10th largest include/linux/*.h file by size.
>
> So let's split it up into smaller pieces, moving things out by logical
> parts where it can be.

Yes please! Took a cursory look at the series (except 1/6) and it
looks okay to me. However, didn't check for copy-pastas or anything
that was left in device.h that could have been moved out. I'll try to
do the latter, later.

-Saravana

> Greg Kroah-Hartman (6):
>   drivers/base: base.h: add proper copyright and header info
>   device.h: move devtmpfs prototypes out of the file
>   device.h: move dev_printk()-like functions to dev_printk.h
>   device.h: move 'struct bus' stuff out to device/bus.h
>   device.h: move 'struct class' stuff out to device/class.h
>   device.h: move 'struct driver' stuff out to device/driver.h
>
>  drivers/base/base.h           |  19 +
>  drivers/base/bus.c            |   1 +
>  drivers/base/class.c          |   1 +
>  drivers/base/driver.c         |   1 +
>  include/linux/dev_printk.h    | 235 ++++++++
>  include/linux/device.h        | 999 +---------------------------------
>  include/linux/device/bus.h    | 288 ++++++++++
>  include/linux/device/class.h  | 266 +++++++++
>  include/linux/device/driver.h | 292 ++++++++++
>  init/main.c                   |   2 +-
>  10 files changed, 1108 insertions(+), 996 deletions(-)
>  create mode 100644 include/linux/dev_printk.h
>  create mode 100644 include/linux/device/bus.h
>  create mode 100644 include/linux/device/class.h
>  create mode 100644 include/linux/device/driver.h
>
> --
> 2.24.0
>
