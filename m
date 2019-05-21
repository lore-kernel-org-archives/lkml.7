Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E5DC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ED52173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfEUKEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 06:04:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfEUKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 06:04:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4BAA828084D
Subject: Re: [REGRESSION] usb: gadget: f_fs: Allow scatter-gather buffers
To:     "Yang, Fei" <fei.yang@intel.com>,
        John Stultz <john.stultz@linaro.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen Yu <chenyu56@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <CALAqxLUMRaNxwTUi9QS7-Cy-Ve4+vteBm8-jW4yzZg_QTJVChA@mail.gmail.com>
 <7caebeb2-ea96-2276-3078-1e53f09ce227@collabora.com>
 <CALAqxLUfJYUtmQDC_aDMxW7KcPUawGoRq-PNUfmzQuNKh97FmQ@mail.gmail.com>
 <CALAqxLVUFfrPVVjR74V3PhhtcCytfp=cUYjo=BcJ14D1fkVXTw@mail.gmail.com>
 <7ec57c29-d1ab-dc4c-755d-a6009b9132b5@collabora.com>
 <CALAqxLUgnTB7aZ4edXCaG8SJsJzfY1_yNEPc6Losssw5Xy9-XA@mail.gmail.com>
 <36620156-d119-b1b2-989e-0c13b783296e@collabora.com>
 <db5665cf-6274-c254-720c-798fec79d131@collabora.com>
 <02E7334B1630744CBDC55DA8586225837F884D53@ORSMSX103.amr.corp.intel.com>
 <CALAqxLWVc6DnRHJ9gQ8orY7f53g4j+x3BWnoJdBv3sXDZVNpVg@mail.gmail.com>
 <02E7334B1630744CBDC55DA8586225837F885FFD@ORSMSX103.amr.corp.intel.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <1672b93a-dfe6-acb2-715e-c4a13af54413@collabora.com>
Date:   Tue, 21 May 2019 12:04:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <02E7334B1630744CBDC55DA8586225837F885FFD@ORSMSX103.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

W dniu 20.05.2019 o 23:52, Yang, Fei pisze:
>>>>> One question that comes to my mind is this: Does the USB

<snip>

> 
> One of the problems appears to be that req->num_mapped_sgs was left uninitialized. I made the following change and got a lot more requests completed.
> However this change is not sufficient to solve the adb issue, the usb requests would eventually get stuck without getting a matching ffs_epfile_async_io_complete.
> 
> @@ -1067,6 +1067,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>                          req->buf = NULL;
>                          req->sg = io_data->sgt.sgl;
>                          req->num_sgs = io_data->sgt.nents;
> +                       req->num_mapped_sgs = req->num_sgs;
>                  } else {
>                          req->buf = data;
>                  }
> @@ -1110,6 +1111,7 @@ static ssize_t ffs_epfile_io(struct file *file, struct ffs_io_data *io_data)
>                          req->buf = NULL;
>                          req->sg = io_data->sgt.sgl;
>                          req->num_sgs = io_data->sgt.nents;
> +                       req->num_mapped_sgs = req->num_sgs;
>                  } else {
>                          req->buf = data;
>                  }
> 

Isn't num_mapped_sgs meant to be set by drivers/usb/gadget/udc/core.c?

And the comment in include/linux/usb/gadget.h says "internal".

One thing that becomes evident now is that adb uses async io.
It seems that interaction of async io and s-g mode should be further
investigated.

Andrzej
