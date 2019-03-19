Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F34CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A10B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfCSNGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:06:03 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40666 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCSNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:06:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id x12so5823131qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 06:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2D4v+FRQq0sJiwzU3+HRtvIEu0V7yJOFkP3Mm7Hr9kk=;
        b=jGHbK3sD+5j3182UcSc1JYltWJvBW+nAD3wuQxIZVSimuw5c5QqZt8L5mndQ5ISUuN
         HJac4iBS8uM7U/RAursO0S646FfD+bl1iFoiCsGzlHOhu71zDP+lq4xfcKUR4FnyOObC
         jITmIktiElgg6/+c2oT6noMmGBPRpJHBr8stlXBHF76N5RR9dyMqgNa3gaVdozcQhdM4
         EGnm6dZnhJwQkvzzjjvIAImuBCDFNnyInPopBdaCOcjnM3aU9fEDDJ9ATEsVbCUeNPsP
         8YF3pi93e6Uvomdfy9eR1Cntxi5EWqnNQakLYov5vQLrWiQeF94oirmIU3m3tOY9gkYl
         YTjA==
X-Gm-Message-State: APjAAAXvtHPullsvGN80wUwGG8/9jzkU9lebAYkX/IIqezyQSxtimndH
        JOe2Kev3Aib5jbkcrboyKDpsCJDSwG1z5ZrV8NsMoq0i
X-Google-Smtp-Source: APXvYqyt5Rp7EYuikLUE0QkscCtdE/yb0JQZg2w3/i8iC/+4XPGeFE6lEDsnuK5jeDxNzgyQkNyXifJ2x/V+CP44F5w=
X-Received: by 2002:a0c:d2fa:: with SMTP id x55mr1781487qvh.161.1553000761904;
 Tue, 19 Mar 2019 06:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com> <1552997064-432700-9-git-send-email-dragan.cvetic@xilinx.com>
In-Reply-To: <1552997064-432700-9-git-send-email-dragan.cvetic@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 19 Mar 2019 14:05:43 +0100
Message-ID: <CAK8P3a0E_eZb1rSb9suv65n8WUnz-cXhk24aGoR8eNKcHVPtFw@mail.gmail.com>
Subject: Re: [PATCH 08/12] misc: xilinx_sdfec: Add ability to get/set config
To:     Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 1:06 PM Dragan Cvetic <dragan.cvetic@xilinx.com> wrote:
> - Add capability to get SD-FEC config data using ioctl
> XSDFEC_GET_CONFIG.
>
> - Add capability to set SD-FEC data order using ioctl
> SDFEC_SET_ORDER. The order of data blocks can change
> from input to output or to be maintained.

Commenting here only on the ABI, not the actual behavior of the driver:

> +static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
> +{
> +       int err;
> +
> +       err = copy_to_user(arg, &xsdfec->config, sizeof(xsdfec->config));
> +       if (err) {
> +               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
> +                       xsdfec->config.fec_id);
> +               err = -EFAULT;
> +       }

Try to avoid printing error messages for things that can be triggered from
user space.

>  static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
>  {
>         struct xsdfec_turbo turbo;
> @@ -670,6 +683,67 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
>         return ret;
>  }
>
> +static int xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
> +{
> +       bool order_invalid;
> +       enum xsdfec_order order = *((enum xsdfec_order *)arg);

Generally speaking, you should never cast between __user pointers
and kernel pointers. It looks like this will actually dereference a
__user pointer, which is a security issue.

Another problem is that the command is defined as

#define XSDFEC_SET_ORDER _IOW(XSDFEC_MAGIC, 8, unsigned long *)

which would indicate an argument of type 'unsigned long __user * __user *',
which is incompatible with 'enum xsdfec_order __user *'. Both enum
and pointer types are variable length and should be avoided in
ioctl commands. Best make this a '__u64 __user *' or '__u32 __user *'.

> + */
> +#define XSDFEC_GET_CONFIG _IOR(XSDFEC_MAGIC, 6, struct xsdfec_config *)
> +/**
>   * DOC: XSDFEC_GET_TURBO
>   * @Parameters
>   *
> @@ -322,4 +335,48 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
>   * ioctl that returns SD-FEC turbo param values
>   */
>  #define XSDFEC_GET_TURBO _IOR(XSDFEC_MAGIC, 7, struct xsdfec_turbo *)

Also wrong type, the function takes a 'struct xsdfec_turbo __user *', not a
'struct xsdfec_turbo __user * __user *',

        Arnd
