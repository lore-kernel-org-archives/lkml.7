Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376F1C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056272085B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 15:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSDapUHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfHJP3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 11:29:43 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35166 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHJP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 11:29:43 -0400
Received: by mail-ua1-f65.google.com with SMTP id j21so38845861uap.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FWl1+zjthFoyh2naJXJ1bywVHCRQ3np6Mp6kyob26j4=;
        b=uSDapUHzC7R1rO8j8PQ/RxA/agjxJWnmSnh4Iv9Knn9Hr4nRpolt6EZEBofjLME6LV
         JW/2qOx6sRAuacqULDbrQ6K5k6p8UiPbisXTWyr4tXCfteY9A392asz79fBM6z/ZIv8W
         wCKRoc1gxmK/yaH1KJvV3PoEW4N7seouizFTBm1bSHDdKkQL8gVT2zI4rZCnM3m760TN
         c8NF0uIQ/MB+6RjfU27+/UoNedWt1QXGq8XFrQgBr9qtJdXOhw7Z4k0c3KMFWOyhgSjn
         N0/K7V2bL501rKEtM2h4LqniIaWCl+idObOGllGMKZycYvR/TaW+WuFPPOFnSDz3/ume
         YJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FWl1+zjthFoyh2naJXJ1bywVHCRQ3np6Mp6kyob26j4=;
        b=JIVqxhtQxfClVJYNceqtjUzqBi96dEuLAF7YPwyKsaouF6csdpHk0ukddSYMspQ31I
         oAYlFTk1Z2tWzgjaw69Bl5eDTyQ0Tytj9L+UvaCUU/dx+jracPUMUXRs4YCczKnhUZ+B
         Q95Mmz2bTEDVqTopOnvHUbVt9MLJk9q5uRPCtsq7i0UBI4IfkgV9EW6NwingDO1vX38g
         4nFnvBLMfDIrYnqzxcBVWNQT8edLvS1rl9mLzgCDBgHO/nQ488Sjz2BiO0mLsWrsqhbN
         wTN0RJXHuNuty7jqrw06w7+dFIBXb7pfYJSxlppJyCuCHzhYOhi1/jfsXrgl9hr4C9KV
         fm+g==
X-Gm-Message-State: APjAAAV2DyMw7UEVW2QQQDKk8PvlKXQfF/7G6PWXbjS5rZZ0mW6rHy8w
        tf/xNCozBRAghsLio/vIJw+hHCYsbe0tolv9L7AGlKKS
X-Google-Smtp-Source: APXvYqz+gJgZ0P30gosQ4Ow0sdG1fiJtnT+dJTt3imJZGcWRvsvhXZvCmuA4tXEddHDthVTX7cKsFn6RcNufKFswa+s=
X-Received: by 2002:a9f:230c:: with SMTP id 12mr15762093uae.85.1565450982367;
 Sat, 10 Aug 2019 08:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190810123808.13845-1-oded.gabbay@gmail.com> <20190810125344.GE15251@kroah.com>
In-Reply-To: <20190810125344.GE15251@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sat, 10 Aug 2019 18:29:16 +0300
Message-ID: <CAFCwf10SV0w-HQHuONSmdcDYFjmCJN3PLzc89MQMO4j37Qum=w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: print to kernel log when reset is finished
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 3:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Aug 10, 2019 at 03:38:08PM +0300, Oded Gabbay wrote:
> > Now that we don't print the queue testing messages, we need to print when
> > the reset is finished so whoever looks at the kernel log will know the
> > reset process was finished successfully and the driver is not stuck.
> >
> > Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
> > ---
> >  drivers/misc/habanalabs/device.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
> > index 9a5926888b99..1fac808c2546 100644
> > --- a/drivers/misc/habanalabs/device.c
> > +++ b/drivers/misc/habanalabs/device.c
> > @@ -907,6 +907,8 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
> >       else
> >               hdev->soft_reset_cnt++;
> >
> > +     dev_info(hdev->dev, "Successfully finished resetting the device\n");
>
> Really?  For doing things "properly" there is no need to spam the kernel
> log.  Only spit stuff out if an error happens.
>
> thanks,
>
> greg k-h

I beg to differ for two reasons:
1. Reset happens very rarely, if at all. So this message (that get
printed after reset is done) will definitely not spam the kernel log.
2. When a reset starts we print an appropriate error message. I think
it is expected by the user that we will also print if and when the
reset has finished successfully. I really believe that lack of this
printing might be deceiving for users.

Thanks,
Oded
