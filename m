Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54B6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D24920811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ommez+kc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCSXlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:41:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52076 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfCSXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:41:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id n19so18616363wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 16:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rg9mK1kJOMuRsY9leXe20xar5bspdwa24vDi2J1Vf1c=;
        b=Ommez+kcjBwgvEjMbDspXwG4H7XJE4ef2dHHdqNUYscI9IMD7gQeOtKFP2rM3QQQpa
         AlYohY0EWfsyYTT+hGYhY13kIwZij4NRvH/cc+2qNjD/lj3LzQ3FMrN29QdltxOrM511
         Hta16ow/I6OzFfyOa/JWoZI8YnKbrUSXBoGx/dRwm97yNgQJMN7UVCbR92GPHaOI15vm
         uRGOoU6aMocp83Q2prRY/z9qsbktyE3O8HZMx95i9EvHOEe7F9VCoX5yWPyEJx873ouj
         It0LvVH/P7+Hh5JELKBRoj61oJYVMGhJDre2/08r7bH6QJR5SgUshFrrGIlTOfuQs20P
         0ptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rg9mK1kJOMuRsY9leXe20xar5bspdwa24vDi2J1Vf1c=;
        b=neUxbScF7STY6tQ35KCbpy/DhFCE0RjB1JJ0naWq1A7cnYDDk6K7XvvBNqG/Fi7+7K
         UkGG3/sar8pp33T722bNdTxXgf7q0zfL/XGZXkKK9dKVNui+Sad9ea86XvKiZrFHsRKr
         JRc95v37ovKqBwBxDcTcQKVkSa6UdiVFc9X6GqbG0ihWYCVwPv71/TtBbxIOc6muJWT5
         LH/2gmt3GWhrUkqvffuwxOHLAHAXccZYAB5vOysSL0TgaMznnpJO5dwr+FB9I+0KjCHX
         hP4El4b0h2WSsX4VQgcPzRUfQIeJGlXptr3u2eGsCFBZ7CdfOh0LBQCyrVDmoCfGDD/7
         cCvw==
X-Gm-Message-State: APjAAAWkOkU5+H+s/TWwhXCqafy8Mq/t05gU49AZjREIFq/udLMaqGbi
        iMFSYDMMwe85n8lF5kW8WkquDOpJhveMsx1fuS4ZfQ==
X-Google-Smtp-Source: APXvYqx/oOcnJ7uTguAakb4WelxkrdfKhQIu4kgJTAWIfI1Z5Pc4ZnWBEm/GOlY+bYcCHRbS9Aq2XR/XNOZv5cINSEI=
X-Received: by 2002:a7b:cb8e:: with SMTP id m14mr5279503wmi.64.1553038898217;
 Tue, 19 Mar 2019 16:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1553037915-85931-1-git-send-email-fei.yang@intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 19 Mar 2019 16:41:24 -0700
Message-ID: <CALAqxLXaUAfz8n6Cpux7XBhHVHifTQhM_wnz4L3DzrmQ0GoCHg@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_fs: don't free buffer prematurely
To:     fei.yang@intel.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jerry Zhang <zhangjerry@google.com>, andrzej.p@collabora.com,
        Vincent Pelletier <plr.vincent@gmail.com>,
        jingx.shen@intel.com, Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 4:25 PM <fei.yang@intel.com> wrote:
>
> From: Fei Yang <fei.yang@intel.com>
>
> The following kernel panic happens due to the io_data buffer gets deallocated
> before the async io is completed. Add a check for the case where io_data buffer
> should be deallocated by ffs_user_copy_worker.

Yay!  Perfect! I was up late last night chasing this crash, but
couldn't de-thread what the problem was.
So very happy to see this patch!

I'll test it here shortly!

thanks
-john
