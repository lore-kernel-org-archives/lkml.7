Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F82C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F650214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t/yJsoDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfF2O1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:27:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33723 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfF2O1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:27:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id m4so3895630pgk.0;
        Sat, 29 Jun 2019 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9kX/n0b6f6ujUCXc3PZGJaxc+3qpnnuRsSEZJ/yJNk=;
        b=t/yJsoDSM5sqEsERahyJWoye/Lzjud6YFZ/UY/Bswp7m+DUlR42TA+sKmKNvAQ0M6w
         V7f057KHykhT4FArhd8oZhB42vyXKOc0scQGr9rRx/NLysuqoRRzi0QvlTZ+LAXLhL58
         pjMWVjAMMlzSnBwvUFrDTEhly02bXMp8MglhY2Q2w0nRFPnEAjOv7YOky0Ho4uNbee6f
         3WTkOFB3krsjVwnLp9NiDsreJ9oNE7hzjCYY88Sh6gMBgvNL6a9h6yb3ZNPKGpxDAtzV
         Dtrk5vQEG30cdlNrC6/eNubPFFjTh+rM0q04uNotTm7w5UfPR5exH8BvnB1ELVZjcIe9
         A9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9kX/n0b6f6ujUCXc3PZGJaxc+3qpnnuRsSEZJ/yJNk=;
        b=kctM2k9Us1Wua0vO5IhK3JHOPkrPvxmqYEHVx8DFYCcu/Z5j7GlRLH4jqAj7wD9/Ag
         8t98zKnzj9vYPU6i3PIO8FRZFOdHHf9rNk4crwS3dxQIZBwhhUv9xw/mC338tmY9UbKf
         DFdwIfW4jnipim1QqS3TK6o9dr86HCnwfNVZR/4A9bpHn2QUTvQwWuOn5XylrIKmyuK4
         RUTZVPxOLsdJOeEEVpZD7ZehRI17spvhOFxDf81+a/YHaH1IkU8ZJ1FrM/gjKsjpW3f5
         deteJPMiuqpWiebx9wE8aQAJ8hbGf5e/TbyM6r2krVVcx8bw4t0FCDbGwdKIsQpIQT9H
         VfAA==
X-Gm-Message-State: APjAAAVOFT/4ZvYcxyeKZqd7xaecAmoxLkoDCpuiG1lPsMCBHS+Wi0YI
        Mvz1IRbF6i+2plaOjMpBu4zgkcLOMilo7B5yJlk=
X-Google-Smtp-Source: APXvYqwqtpcT5DPWoj7CDByWP4fzCLM+F2kxHTKzJsIRjvNnpVHeFz3tc8bogTl58nNsnotu7pe/Wj/eloUIPQznNkU=
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr19895079pjb.20.1561818459937;
 Sat, 29 Jun 2019 07:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190613030416.25807-1-ayman.bagabas@gmail.com>
In-Reply-To: <20190613030416.25807-1-ayman.bagabas@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 29 Jun 2019 17:27:29 +0300
Message-ID: <CAHp75Vd2oLkjYjh6k8a3fitAHDvQeu9zm2LpHM7fCXUWN9zaVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] platform/x86: Huawei WMI laptop extras driver
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 6:04 AM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
> Changes from v1:
> * introducing debugfs
> * code reformatting
>
> This patch series introduce new features to the driver and also moves the
> driver from wmi_driver to platform_driver. This move is necessary because the
> driver is no longer only a hotkeys driver and platform_driver offers easier
> future extensibility.
>
> The patch series introduces a WMI BIOS interface that brings on new features
> and enables controlling micmute LED through this interface on supported models.
> It also enables controlling battery charging thresholds and fn-lock state.
> These features are controlled through the HWMI WMI device present in most of
> these laptops.
>
> Currently, micmute LED is controlled through an ACPI method under EC.
> This method ("SPIN", "WPIN") is specific to some models and wouldn't
> work on all Huawei laptops. Controlling this LED through the interface provides
> a better unified method to control the LED on models that implements this
> feature.
>
> The behavior of hotkeys is not the same among all models. Some models
> require fn-lock to do things like `Ctrl-Ins` or `Alt-PrtSc`. Fn-lock inverts the
> behavior of the top row from special keys to F1-F12 keys.
>
> A debugfs interface is also implemented to support unrepresented features and to
> provide debugging feedback from users.

You have sent few series regarding Huawei devices.
And from the patch 1 this is not applicable.
So, I dropped all your patches from patchwork queue and will wait for
new versions in order they are applicable.

>
> Ayman Bagabas (8):
>   platform/x86: huawei-wmi: move to platform driver
>   platform/x86: huawei-wmi: implement WMI management interface
>   platform/x86: huawei-wmi: use quirks and module parameters
>   platform/x86: huawei-wmi: control micmute LED through WMI interface
>   platform/x86: huawei-wmi: add battery charging protection support
>   platform/x86: huawei-wmi: add fn-lock support
>   platform/x86: huawei-wmi: add sysfs interface support
>   platform/x86: huawei-wmi: add debugfs files support
>
>  drivers/platform/x86/huawei-wmi.c | 754 ++++++++++++++++++++++++++----
>  1 file changed, 665 insertions(+), 89 deletions(-)
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
