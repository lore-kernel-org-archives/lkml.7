Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7492DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EB2208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfFULFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:05:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33644 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfFULFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:05:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id x2so6490258qtr.0;
        Fri, 21 Jun 2019 04:05:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWrjRbv5sT8Ycn8FrgxcuobL7x+daQ4VNzNCCGx2zM4=;
        b=gDeOrE0giz3FHfLZXaSk9EmPKJQw2RLL+gXvzpCsy9cajxIJEsjB6Xi+WGuFlTkCDM
         qGSam0tW5i+a8PxQ6z77UKxJ+7rlatFUjm8rg/fvzV9AxaJSAopf2k6ohwA94H1lQhgY
         GoK2bKpqxjlIbAKSCmRLYRh/cCo/bQ5JZVlSz45NGW/pRozmv+M5q/b18oEE3NZSwX9H
         OdFMAblZXIA+baMDPTux4pEyEsvAiitdrtSCXk2qJHvpD4Y3FYQ9RSk+9E3DoY6XQOxU
         9tfPyV0u7CzO66sEnSAaa2HU+yqCfZArMUiPSi22C4tFN1c6aZm8dr+Y6KqiFsJt7zWa
         ifEw==
X-Gm-Message-State: APjAAAWiNowFQ1UAPwy6s8ra5NHV+kj26Vb2N81ABIXv89Sg0GgT2XDV
        8IvNEwVIfcTyiqWT/EHvHmUw3dJyZuXA0sJNg2g=
X-Google-Smtp-Source: APXvYqw5uqxdf+phL6riSVug0c30oEd9Ob3YA4KXECDUZ7l4rUQff3J+CqHtXgfdMec/Uqfgyj4gqSkdxcvTzscBjxU=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr38463529qtb.142.1561115135877;
 Fri, 21 Jun 2019 04:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190617131645epcas1p3340c80f9e83af93bcbb4c68128b1ea44@epcas1p3.samsung.com>
 <20190617131624.2382303-1-arnd@arndb.de> <1628618a-7cf6-506e-9d87-c0966a99fbea@samsung.com>
In-Reply-To: <1628618a-7cf6-506e-9d87-c0966a99fbea@samsung.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 21 Jun 2019 13:05:19 +0200
Message-ID: <CAK8P3a3qTCnJn7X1msg03Av71aZmmN8YB=WNs0JfzYoMH+uL-w@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pvr2fb: fix link error for pvr2fb_pci_exit
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 12:58 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
>
> On 6/17/19 3:16 PM, Arnd Bergmann wrote:
> > When the driver is built-in for PCI, we reference the exit function
> > after discarding it:
> >
> > `pvr2fb_pci_exit' referenced in section `.ref.data' of drivers/video/fbdev/pvr2fb.o: defined in discarded section `.exit.text' of drivers/video/fbdev/pvr2fb.o
> >
> > Just remove the __exit annotation as the easiest workaround.
>
> Don't we also need to fix pvr2fb_dc_exit() for CONFIG_SH_DREAMCAST=y case?

I think that's correct, yes. Can you fix that up when applying the patch?

     Arnd
