Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B032C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107D120645
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aVidaIVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfGKQls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:41:48 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33926 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbfGKQls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:41:48 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so14031653iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U26HbtI3jD7UvXKWDY+AWCy2gh8PUZwa9sGU1JIWjXQ=;
        b=aVidaIVveN3OJ/2S+w//Bv7p73J9McnzDaalFESTX16MVbFCzrt6QOiQQRBEOtIbKz
         WneY/yV0yMxn0tfb0iuB84iYzx31K19msCtykgFVvKZUHsAw1sNsO+mGPwshtF92J59G
         iY2azj0chu6DOUjxW8Ps71Y11Bw/YPgwBuNVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U26HbtI3jD7UvXKWDY+AWCy2gh8PUZwa9sGU1JIWjXQ=;
        b=pNusEGNftTm5Udm3l3bHm3LA0tC9/AXdaC8ga2je/Yfay+QDmwFpxNahksDbBSDqtr
         bGA9TNJ2xcCdw9dg2v4gwtxqdrADrIQiGNowA7axE1YmcZEwkFwMRGS7Ija0Tf/w8NF8
         sjT5X15QtsoHG8zlrGtv6Htg6YAbCvNB9Wz1SwCCCDD0tuGEGH9U/qHUzL+z3zA/Svcl
         rL3rMBmGv3i48YoFo4CzIEAAONIlhOFuqLQVPbIukDoEn896gGpgY6DAW7MMaseAO8gw
         KeBlWEjpbPrJNkXCC5fH6yQfgpYCGTCCTpr6/v55Y8QNKQjdW/T+dXLb3Je6nv6uvqwO
         t24w==
X-Gm-Message-State: APjAAAWaE5algGb0+lLNJWilnk+FSei9EtnRjD8jjqW069O1uzT5xrz9
        i4yVepiZa+vmn+qA4eLRG2VNdFbTv2Y=
X-Google-Smtp-Source: APXvYqzukZqR1fB3fLKGPiFHCP6Yl51zRvfh2qo4MvVIHQJtj9NZG1ba/0SfxmuEcXRA+qZEsy4qxg==
X-Received: by 2002:a5d:9749:: with SMTP id c9mr5590183ioo.258.1562863307376;
        Thu, 11 Jul 2019 09:41:47 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id n22sm10767592iob.37.2019.07.11.09.41.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 09:41:45 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id i10so13889010iol.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 09:41:45 -0700 (PDT)
X-Received: by 2002:a02:a703:: with SMTP id k3mr5538997jam.12.1562863305402;
 Thu, 11 Jul 2019 09:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190711162919.23813-1-dianders@chromium.org> <20190711163915.GD25807@ziepe.ca>
In-Reply-To: <20190711163915.GD25807@ziepe.ca>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Jul 2019 09:41:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XuDns7n_tShzEUnzJ3te92kkV8+2=QxtekSGdKV645hw@mail.gmail.com>
Message-ID: <CAD=FV=XuDns7n_tShzEUnzJ3te92kkV8+2=QxtekSGdKV645hw@mail.gmail.com>
Subject: Re: [PATCH] tpm: Fix TPM 1.2 Shutdown sequence to prevent future TPM operations
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "# 4.0+" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Huewe <peterhuewe@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 11, 2019 at 9:39 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Jul 11, 2019 at 09:29:19AM -0700, Douglas Anderson wrote:
> > From: Vadim Sukhomlinov <sukhomlinov@google.com>
> >
> > commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream.
> >
> > TPM 2.0 Shutdown involve sending TPM2_Shutdown to TPM chip and disabling
> > future TPM operations. TPM 1.2 behavior was different, future TPM
> > operations weren't disabled, causing rare issues. This patch ensures
> > that future TPM operations are disabled.
> >
> > Fixes: d1bd4a792d39 ("tpm: Issue a TPM2_Shutdown for TPM2 devices.")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vadim Sukhomlinov <sukhomlinov@google.com>
> > [dianders: resolved merge conflicts with mainline]
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > This is the backport of the patch referenced above to 4.19 as was done
> > in Chrome OS.  See <https://crrev.com/c/1495114> for details.  It
> > presumably applies to some older kernels.  NOTE that the problem
> > itself has existed for a long time, but continuing to backport this
> > exact solution to super old kernels is out of scope for me.  For those
> > truly interested feel free to reference the past discussion [1].
> >
> > Reason for backport: mainline has commit a3fbfae82b4c ("tpm: take TPM
> > chip power gating out of tpm_transmit()") and commit 719b7d81f204
> > ("tpm: introduce tpm_chip_start() and tpm_chip_stop()") and it didn't
> > seem like a good idea to backport 17 patches to avoid the conflict.
>
> Careful with this, you can't backport this to any kernels that don't
> have the sysfs ops locking changes or they will crash in sysfs code.

Ah, got it.  Thanks for catching!  Should we just give up on trying to
get this to stable then, or are the sysfs ops locking patches also
easy to queue up?

-Doug
