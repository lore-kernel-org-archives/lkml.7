Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9BC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54B9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 18:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekCEzlBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfETSda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 14:33:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42293 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfETSd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 14:33:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id l2so15716728wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=632+c6IqzK2BjCuWL6WJ+2pWVzzX6ijbqjHnP9tGBNo=;
        b=ekCEzlBbb16dcmDM2i7++5oq1yDSWABTDI0lNiL2HxJr1DMsWpttMTWJPfFwSp/tMp
         iG/sqo4wTFuEzMiLKTlYGq+gX6jl6el1X/zfh13X78mLJZMm8qt2QLvi1WKMgchdJ4pe
         UR4FnetITwQvgr4DIc6PZBOC+DRO9325Qsp4YS1V6qqRJhzux8+s1PcjnlRp9YXH+3Ii
         eZEW9n+paE2oHGZfJWhmdguK+aEwIVC0Crm9ZOfyOFW1C2x18GeZFMOL/IqbqVj1Ij8J
         sSukDskZ7qElHkQBKSm9AEsxyZSWLTVWFkm3/QLpB7RkfMWsGQCGPWm6H6J4JPtMQ0xk
         SqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=632+c6IqzK2BjCuWL6WJ+2pWVzzX6ijbqjHnP9tGBNo=;
        b=owR0kJ8NjRfacfz2AKPmDv9qTR5mWPeMZHraFJnsM3tysnI14IwN0h6u9VtqLs7rdl
         0PKgQgHtUE9rylP4u+BWv5JeDUCSIWfJ8qYv3fHRt0tZdEDXvfp7WF9eL909wVrSl5+e
         bah14rr8UbodRjST+ZEgkXEt7kgJaEQf/6xSQBWxQ72sehtj5NZ7bqutIU1rIdKZl1RE
         IyUrXtbRpdKRO7PhszddBikjiAAn7p7H5XsmLH5vpWXpoPblCjkS/114Z5kccswZaBcU
         YUUpwNOWxVSRl6yOK7FtCR+EME7t+06xAM8fFBifxdrlCIZacAmIvzRz7A1XTUNE9eP0
         DHlw==
X-Gm-Message-State: APjAAAUoXuUcVHo4TEXYhEGnJfXP9NIxs310KaJ0C542U909hKC4VeyU
        bYIvZfZE1sXHSy8u29cu1ex4sPp0oEbmtnGBoPMcyA==
X-Google-Smtp-Source: APXvYqwt3G9jviKenTL+rRfOnizevWGrAzRjnqp0RfxuoTG9FygdyFOjs5HHMu222ux92N+pxvaHPqhpF4oC93bBtgI=
X-Received: by 2002:a5d:618b:: with SMTP id j11mr3562517wru.36.1558377208186;
 Mon, 20 May 2019 11:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com> <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
 <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com> <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
 <36620156-d119-b1b2-989e-0c13b783296e@collabora.com> <db5665cf-6274-c254-720c-798fec79d131@collabora.com>
 <02E7334B1630744CBDC55DA8586225837F884D53@ORSMSX103.amr.corp.intel.com>
In-Reply-To: <02E7334B1630744CBDC55DA8586225837F884D53@ORSMSX103.amr.corp.intel.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 20 May 2019 11:33:16 -0700
Message-ID: <CALAqxLWVc6DnRHJ9gQ8orY7f53g4j+x3BWnoJdBv3sXDZVNpVg@mail.gmail.com>
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     "Yang, Fei" <fei.yang@intel.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 9:23 AM Yang, Fei <fei.yang@intel.com> wrote:
>
> >> One question that comes to my mind is this: Does the USB transmission
> >> stall (e.g. endpoint stall) or not? In other words, is adb connection
> >> broken because USB stops transmitting anything, or because the data is
> >> transmitted but its integrity is broken during transmission and that
> >> causes adb/adbd confusion which results in stopping their operation?
> >> Does anything keep happening on FunctionFS when adb connection is
> >> broken?
> >
> >Any discoveries about the problem?
>
> In my debugging, I'm seeing a lot of requests queued up through ffs_epfil=
e_io (returning -EIOCBQUEUED), but
> only a few of them came back through ffs_epfile_async_io_complete -> ffs_=
user_copy_worker.
> I don=E2=80=99t think there is a USB transmission stall though, because i=
f I manually disable io_data->use_sg, everything
> goes back to normal. So it looks more likely to be a buffer handling prob=
lem in the DWC3 driver.

Yea, I also did reconfirm that reverting 772a7a724f6, or setting
gadget->sg_supported to false makes the isssue go away.

And after spending a bunch of time trying to trace through the code
last week, in particular the sg_supported checks, but I'm not seeing
anything that is standing out with the f_fs logic.

I'd start to agree it might be a buffer handling problem in dwc3, but
it feels odd that I'm also seeing this w/ dwc2 hardware as well. Maybe
the  same bug was copied into both drivers?

I'll try to dig a little on that theory today.

thanks
-john
