Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC103C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9103820854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCSNSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:18:04 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41646 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfCSNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:18:03 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so11776337qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JValrODhL9L1KoNqoer/wGLOwpigQOqn55f7IV3QNRo=;
        b=r9O3Cr1iS2wSleC7aRbkUGbGVulBOXA6CJnHo+SGBlTVadq11+unJQ5bAhTB62thUK
         4vHdBrLZ/oUHyHereknGXJQXWeTVb7FesV63NpWyocYVNTfQ8Y5XbcICskSHMFGbY8gB
         YoFwjCZhwxjgjs4MAjQ62oeDXNOnGAN9hxjqcVA15cr2xel4c0gMMynwCdx8253FJwWP
         O19fqkRmcwO1QoIWuk4A2df0aHxbNN1uK9uqTlhOmMEsC7Ds9r49CIF0pbU67fxPA+Dn
         PyouKd2LVX133p/US/bs0Sn9jM5iImBnMRtdu3lfH5AbJUIDFgtIDYa2KM15OkrkqzUw
         PzHQ==
X-Gm-Message-State: APjAAAUxlrCVnqYxVVwBWLl/FGvxe3k40CKNCZk9oymwI5Q4AhYrLzyT
        1f+UNDYaH5onrv6PTgxOo7yxOaAq0SzrtVwwwSA=
X-Google-Smtp-Source: APXvYqxPu61nlXjGGarQPN4ErRfaeDVgfbh47aaG4gyl6ikCFueu+FzaUsz0GTw5tLL6yxjsQhVJptJpCpM7BhNgaQw=
X-Received: by 2002:a05:620a:153b:: with SMTP id n27mr1694185qkk.343.1553001482905;
 Tue, 19 Mar 2019 06:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com> <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
In-Reply-To: <1552997064-432700-5-git-send-email-dragan.cvetic@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Mar 2019 14:17:45 +0100
Message-ID: <CAK8P3a3uKOVW5HcQD9LLKfoeOkTnhE8M2rHsZuwjNUQv18=J_g@mail.gmail.com>
Subject: Re: [PATCH 04/12] misc: xilinx_sdfec: Add open, close and ioctl
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:05 PM Dragan Cvetic <dragan.cvetic@xilinx.com> wrote:
>
> Add char device interface per DT node present and support
> file operations:
> - open(), which keeps only one open per device at a time,
> - close(), which release the open for this device,
> - ioctl(), which provides infrastructure for a specific driver
> control.

>  drivers/misc/xilinx_sdfec.c      | 79 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/misc/xilinx_sdfec.h |  4 ++
>  2 files changed, 83 insertions(+)
>
> diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
> index a52a5c6..3407de4 100644
> --- a/drivers/misc/xilinx_sdfec.c
> +++ b/drivers/misc/xilinx_sdfec.c
> @@ -81,8 +81,87 @@ struct xsdfec_dev {
>         struct xsdfec_clks clks;
>  };
>
> +static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
> +{
> +       struct xsdfec_dev *xsdfec;
> +
> +       xsdfec = container_of(iptr->i_cdev, struct xsdfec_dev, xsdfec_cdev);
> +       if (!xsdfec)
> +               return -EAGAIN;

The result of container_of() will not be NULL here.
Did you mean to check i_cdev? That probably also won't
be NULL, but that check would be more reasonable.

> +       /* Only one open per device at a time */
> +       if (!atomic_dec_and_test(&xsdfec->open_count)) {
> +               atomic_inc(&xsdfec->open_count);
> +               return -EBUSY;
> +       }

What is that limitation for? Is it worse to open it twice than
to dup() or fork()?

Note that the test is not really atomic either: if three processes
try to open the file at the same time, it gets decremented from
1 to -2, so only the second one sees 0 and increments it back
to -1 afterwards...

> +static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> +                            unsigned long data)
> +{
> +       struct xsdfec_dev *xsdfec = fptr->private_data;
> +       void __user *arg = NULL;
> +       int rval = -EINVAL;
> +       int err = 0;
> +
> +       if (!xsdfec)
> +               return rval;
> +
> +       if (_IOC_TYPE(cmd) != XSDFEC_MAGIC) {
> +               dev_err(xsdfec->dev, "Not a xilinx sdfec ioctl");
> +               return -ENOTTY;
> +       }

remove the error messages here as well.

> +       /* Access check of the argument if present */
> +       if (_IOC_DIR(cmd) & _IOC_READ)
> +               err = !access_ok((void *)arg, _IOC_SIZE(cmd));
> +       else if (_IOC_DIR(cmd) & _IOC_WRITE)
> +               err = !access_ok((void *)arg, _IOC_SIZE(cmd));

This seems odd. Why two separate checks, and why the access_ok()
check when you do a copy_from_user() that contains the same check
later?

If you want to get fancy here, you could just copy the data in the main
ioctl handler based on _IOC_SIZE, and pass around normal kernel
pointers from there.

>  static const struct file_operations xsdfec_fops = {
>         .owner = THIS_MODULE,
> +       .open = xsdfec_dev_open,
> +       .release = xsdfec_dev_release,
> +       .unlocked_ioctl = xsdfec_dev_ioctl,
>  };

This lacks a .compat_ioctl pointer.

       Arnd
