Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD78C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8E8217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387456AbfDQVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:35:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40249 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQVfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:35:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so2751qts.7;
        Wed, 17 Apr 2019 14:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMlvcXl4usKYZNI2g1wqgvxqcTRbJjB8VxhSe1PK0f8=;
        b=WCO34XNTnPWbsMVRJC+RlmJ0qZ6WMBLSFiB3us+Eq12sq5UvqqBUIYNUqwXtVMv9gv
         amlC/juuO5hq1IU62xfMNst7peg/yKtgGMwD+feOTcwfi8N0lBhj4okRMJer2UTNlwz5
         vVFXXZs3FjwPsFCkCMMULrn86/N0YwQwVdetGpQOiWqu48cTbnze0lNQ5bcTT7m0VWTR
         2Im+7LC0NLfQr/HAzHgZw3HG4X+bQ6lmOQrsqurjUgvLlhcxmXuudjgVgewbE7osyOwT
         nlwOv83TQgHEGRdadPDbz+tFEWgPKp6AB2ebnLFHKZv2uwqCqp4PpdSV8zZ5ONK2pnzr
         7hpA==
X-Gm-Message-State: APjAAAXW78LXsROqSTM6S0m3T5PXPiHxZERzcPaUGvPhAop0a+YfNbRX
        7RtPrhVg0b5C9ZcZ7oluncQoiDw6eQmN88HfTye58VVT
X-Google-Smtp-Source: APXvYqw4n0pNvBg5dwif/v6nzj9iK1DQDGNThmnxsABgSKRyz+FMUsd8fB8J2vqPd6Yi8L+OSSI1gWX8NMDjJwWQ7Lk=
X-Received: by 2002:a0c:ba10:: with SMTP id w16mr73956382qvf.115.1555536904406;
 Wed, 17 Apr 2019 14:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190416202013.4034148-1-arnd@arndb.de> <20190416202013.4034148-9-arnd@arndb.de>
 <20190417211934.GW2217@ZenIV.linux.org.uk>
In-Reply-To: <20190417211934.GW2217@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 17 Apr 2019 23:34:48 +0200
Message-ID: <CAK8P3a3A1i90htc5GgFnJNQepbdvF9eDZ05xftzFcSMK7CXs_w@mail.gmail.com>
Subject: Re: [PATCH v3 08/26] compat_ioctl: add compat_ptr_ioctl()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 11:19 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Apr 16, 2019 at 10:19:46PM +0200, Arnd Bergmann wrote:
> > Many drivers have ioctl() handlers that are completely compatible between
> > 32-bit and 64-bit architectures, except for the argument that is passed
> > down from user space and may have to be passed through compat_ptr()
> > in order to become a valid 64-bit pointer.
> >
> > Using ".compat_ptr = compat_ptr_ioctl" in file operations should let
> > us simplify a lot of those drivers to avoid #ifdef checks, and convert
> > additional drivers that don't have proper compat handling yet.
>
> You forgot to mention that it even gets the previous commit to build ;-)
> IOW, that needs to be reordered.

Right. I had reordered the series multiple times and got this part wrong
in the end.

       Arnd
