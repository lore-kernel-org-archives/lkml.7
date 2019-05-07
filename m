Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC7BC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F8F20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEGHFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:05:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33655 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfEGHFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:05:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so394379qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 00:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWiAWNDuxMoa7BnWbstcQAwxTlS5yxqis7kCQjsT23I=;
        b=QMOkgytU7WmvIgIRtJclFo/eHyNkZSVBM8N993hxMzydAEcrmjuLM2oVh1PlEvcXSJ
         c0DQ0+CmHVbWQSpf1JBCCPPDWXgSBKXxs8XTpAEsq+z5xWfQaVqoCRyQiqNx+e2uB+eN
         r0FIOjtFMvk3HF4pYzOQSvJYQEiQKUeq9KyHh5fJzk9rP6L83jTwLDfKmqhoxx7oj8cp
         Ih9Xn3YBueJZO044pX1YZGRWFDJMDH0oopyjM7N7gaVmVH/ZiHKoElevHnYNE0CS9IVO
         CZmTVus5OHadmi5RA6iXKLueW2UmyWhskuI+XKvOMpUusNdKN/1U6t/zVGVCpktgnq69
         Z2Bg==
X-Gm-Message-State: APjAAAWDkyaxqx19ZQOvzOxhy80iq0NsicJjVT4DfAhlb3sj0QYeNIqf
        7mWMcechqeb0m7wv51hv5+1PNSS3nQw+8sfipRVNgqAO6P4=
X-Google-Smtp-Source: APXvYqz4HUHY0unSxfyqKVfzthJ4zVbpJ5xgmf3KDTNskB7uJbYHco/MM7pyk5JZEfU+J7rzIPlS71SU9loEQKjgEUw=
X-Received: by 2002:ae9:e418:: with SMTP id q24mr23566715qkc.134.1557212704629;
 Tue, 07 May 2019 00:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
In-Reply-To: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 7 May 2019 09:04:53 +0200
Message-ID: <CAO-hwJKueMUp=4ioCNhgkX2+HWsd9GV4bkKi_+uvzpOV_UED8A@mail.gmail.com>
Subject: Re: [PATCH -next] hid: fix hid-logitech-dj build error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, May 7, 2019 at 3:12 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix build error in hid-logitech-dj by making it depend on
> USB_HID, like several other HID drivers do.
>
> Fixes this build error:
>
> ERROR: "usb_hid_driver" [drivers/hid/hid-logitech-dj.ko] undefined!
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  drivers/hid/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- mmotm-2019-0425-1630.orig/drivers/hid/Kconfig
> +++ mmotm-2019-0425-1630/drivers/hid/Kconfig
> @@ -522,6 +522,7 @@ config HID_LOGITECH
>  config HID_LOGITECH_DJ
>         tristate "Logitech Unifying receivers full support"
>         depends on HIDRAW
> +       depends on USB_HID

this is already scheduled in the HID PR:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=for-linus&id=c08f38e9fd0b5486957ed42438ec8fa9b6ebbf4f

Cheers,
Benjamin

>         depends on HID_LOGITECH
>         select HID_LOGITECH_HIDPP
>         ---help---
>
>
