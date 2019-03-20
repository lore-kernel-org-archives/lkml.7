Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD1720830
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uMKkspNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfCTF7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:59:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35330 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfCTF7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:59:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so663869wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohtfMEr6LG9wZDTMQQSLeIGpAAUxMDn0ACoAOodG0Ac=;
        b=uMKkspNhGsp03ZCVBIFQ3+CzA90j9cYgu96q+Prqw2QTkuNEE/JPnMvwWqXT6xR5n8
         ZICe+v7aNjr2pWfxGFD6IO1nz/hA0uth2cxa3hTq2TmY5YLqvQYwkDk1+VQS3gXmbTBt
         ZXNRQ41SpTpLSVGrDCL4WcPI3+8hVabaeB9CfRGZBWlrSXD+jd95BkJ6+B5tnfUmWgNH
         MCCdadppUp/TWVL91FCvmBIl4pSC4D8kmIXGSp+MGyanchMnRwXf0zan850RXFz5/Kon
         4v35HRE/Uo8pgoesnuEUEgPFUppIy+8kCspx36O+BdrVmkW74wSJacq7N9rTQ+qOU2FY
         mrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohtfMEr6LG9wZDTMQQSLeIGpAAUxMDn0ACoAOodG0Ac=;
        b=MvqlW05r1ZtCX2bYcx5GZHg4bDBtQAQ/1cYOfHgB1+XYr0Y64M1/6ItwNVWBvaVBEf
         2IV45EsjUm2ZB7LpI42csPrZ9xVR+mANdMRzTonUjkiTIggBpQ1nZmJF8MhbZul0UeXQ
         HzXOgRWJgY7ONBYFsjQ34Vtq8aNqqpCHhixCIuP6AP7prpbyomPxiYef6v7us2JwC7or
         VhvL+3UQvZQjHtHlWf72z/8EiwHkQ4Ssj+WjW/iBPPl9W7SbOkjfC7aou36U+ubGrn3y
         oYjqVfq8d1fSTLazl9lZYMiUYAyEPk1TdblamblYmB03BnGy8vk3k+mTBoIYLktBzAwY
         /J6A==
X-Gm-Message-State: APjAAAW2o5YKtENNs6dlWOkZ8VegorPkQ9/OnIiu+Fqf4qTjF2Y6Kzmy
        C9XyeySSOpE8Ti6+HhUaTVO79YkoN22AtynturY4hA==
X-Google-Smtp-Source: APXvYqw//oqwPGuEp5l5VqhAK+D9rXysM+kKYX1zQ6AgroZIXJfNkr9LjMB5S2AYgswYcsLTQC5vDoGJIS7u26jDCEc=
X-Received: by 2002:a1c:cb82:: with SMTP id b124mr6301317wmg.11.1553061556914;
 Tue, 19 Mar 2019 22:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com> <CAAHfpN_2rUu+kCCgOV+RdqCU5+XRe_c3KkJk6FNv50FG+5_qwg@mail.gmail.com>
In-Reply-To: <CAAHfpN_2rUu+kCCgOV+RdqCU5+XRe_c3KkJk6FNv50FG+5_qwg@mail.gmail.com>
From:   Josh Gao <jmgao@google.com>
Date:   Tue, 19 Mar 2019 22:59:05 -0700
Message-ID: <CAAHfpN_uVBR5X7e4Bb=OsMVqudB9rVD7rqLhTfix6Pa+-iVwWw@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     fei.yang@intel.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Jerry Zhang <zhangjerry@google.com>, andrzej.p@collabora.com,
        plr.vincent@gmail.com, jingx.shen@intel.com,
        John Stultz <john.stultz@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:56 PM Josh Gao <jmgao@google.com> wrote:
>
> On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
> >
> > From: Fei Yang <fei.yang@intel.com>
> >
> > The following kernel panic happens due to the io_data buffer gets deallocated
> > before the async io is completed. Add a check for the case where io_data buffer
> > should be deallocated by ffs_user_copy_worker.
>
> It looks like this happened because data got renamed to io_data, which made the
> `data = NULL` marked with "Do not kfree the buffer in this function" not do
> what it was hoping. This should probably either delete the assignment above or
> fix the assignment to refer to io_data? (EIOCBQUEUED presumably can't come from
> elsewhere?)

(except ffs_free_buffer doesn't check for null, so probably the former)
