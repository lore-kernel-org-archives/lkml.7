Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80836C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E2D20721
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfKVKcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:46 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:46477 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfKVKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:43 -0500
Received: from mail-qv1-f41.google.com ([209.85.219.41]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M3loZ-1iXHA21Rlz-000uvV; Fri, 22 Nov 2019 11:32:41 +0100
Received: by mail-qv1-f41.google.com with SMTP id i3so2653964qvv.7;
        Fri, 22 Nov 2019 02:32:41 -0800 (PST)
X-Gm-Message-State: APjAAAX8Qcr5zEsLc+CNVuyN+m7wacOtbzHYx4uXV0JKdjnF9Rdcjym4
        4KQGb5VX/phTNIh5ckYJwlL42K5ZYqOd0kXky08=
X-Google-Smtp-Source: APXvYqx2ZSHe23mYINfOOU60D79xPVDOEFWb0PSxQosYjZVAO0Vxhh+wY96QDTJ+T25991Kim1tOTWU1wRiwYqOJI2I=
X-Received: by 2002:a0c:a9cc:: with SMTP id c12mr6256439qvb.222.1574418760137;
 Fri, 22 Nov 2019 02:32:40 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
In-Reply-To: <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 22 Nov 2019 11:32:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
Message-ID: <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:rNyivOOdNQwk7nYLT6NW3Y7gYZpHVHrBU454HCUNgI9G7YwsRle
 KsWKRyXo3Va9BDfdITrfLu0cs/KHQUDypHzYzqDqtgqThV5vgo3gh4D4RMY9P+nxm1l/U8M
 8p9a96/hXoovps8c4kmiG0FkKv5d06uzHiU2H2LACnqebgoeMXfOgMqnmMZD98IoABAGLDF
 3TGBOmVEEbGyCEvIJzdTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VxGXkeP1g54=:UHFsbRYHY1vWjkKUfwB3ds
 8F1EDS9+uWE/fnd7xdNG2Cj93syunR19vUqZVc/8Wcl4QKq5naH36l1RFRW4Tb31C2YTSMvkd
 KuW3lwoGWT7YX0TPrUQi2GX++2rHrEn4m1DBrzQRju7KRmsusWaaCM1bR92B+eZ9lzIJPVLha
 bba6CO1HYHbcb4/rBIvcp+g7EuecwOzEBZMIamHPs5Ep6WhpP1KPBqPBUDMSq1j5GVaEhGLuS
 RHAgClUZTiASL0CqjxCbiQS0/LXNF2Wg6NOvbOZY733QrD52+7NWe9n/9+sqmtu0g4CROoO3u
 I7NGXXTDrnAVGtC4dPQZxR4leXgFDc7XzWK0lkyTvjpgcuiWN5vVairTAtofvIKXaT4qo98lB
 NL6HViVg2CK0KB51GYZ/Wz4X50sCM28TRmbr6lJ1Emokey42uATEDPNdzVwTvW9KURNKFSB0g
 wRbKpjRXDLr8fPV5EefVpNJdVQ0tuaS1gvF8jn4/l1mvDvzMIVCufJFZ/IhLapRGMrSxit69h
 aeI0ikArY2YS83lQFD6orASSugIOMW+TghIixHcfkNgtrgiJ8sJ53l0fS+xuBp1zY7w6gBykn
 d1Db5fwrcmaafjJmL5UUFrALc3kbbYsbPEACRmkAO5n0lN/jne4bozmN1SkSKw+v0m5gNeMxE
 xpUKOEmvZG+O3aDB2IQNU7DXf2A2t54TsoFKnAUau3qF1ku6e0jSsmqdAiXhon4noeSbmD1qp
 71gbiV68D4yd1WCJcM7kmw72u9k08Ylw4tjVjqO+J9ySbXnjLeD2yJPJ6hLadP6l5mO1N4tQd
 8przuovtC5UF4kj5xT7FAORhYFjF76mUdaC61V2qOE/g6e3XT0/Ma4FW7PM9ca96hg62vlOAj
 5D7JPr5l80NaLf0iWkYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 11:43 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> From: Baolin Wang <baolin.wang@linaro.org>
>
> Now the MMC read/write stack will always wait for previous request is
> completed by mmc_blk_rw_wait(), before sending a new request to hardware,
> or queue a work to complete request, that will bring context switching
> overhead, especially for high I/O per second rates, to affect the IO
> performance.
>
> Thus this patch introduces MMC software queue interface based on the
> hardware command queue engine's interfaces, which is similar with the
> hardware command queue engine's idea, that can remove the context
> switching. Moreover we set the default queue depth as 32 for software
> queue, which allows more requests to be prepared, merged and inserted
> into IO scheduler to improve performance, but we only allow 2 requests
> in flight, that is enough to let the irq handler always trigger the
> next request without a context switch, as well as avoiding a long latency.
>
> From the fio testing data in cover letter, we can see the software
> queue can improve some performance with 4K block size, increasing
> about 16% for random read, increasing about 90% for random write,
> though no obvious improvement for sequential read and write.
>
> Moreover we can expand the software queue interface to support MMC
> packed request or packed command in future.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Overall, this looks like enough of a win that I think we should just
use the current version for the moment, while still working on all the
other improvements.

My biggest concern is the naming of "software queue", which is
a concept that runs against the idea of doing all the heavy lifting,
in particular the queueing in bfq.

Then again, it does not /actually/ do much queuing at all, beyond
preparing a single request so it can fire it off early. Even with the
packed command support added in, there is not really any queuing
beyond what it has to do anyway.

Using the infrastructure that was added for cqe seems like a good
compromise, as this already has a way to hand down multiple
requests to the hardware and is overall more modern than the
existing support.

I still think we should do all the other things I mentioned in my
earlier reply today, but they can be done as add-ons:

- remove all blocking calls from the queue_rq() function:
  partition-change, retune, etc should become non-blocking
  operations that return busy in the queue_rq function.

- get bfq to send down multiple requests all the way into
  the device driver, so we don't have to actually queue them
  here at all to do packed commands

- add packed command support

- submit cmds from hardirq context if this is advantageous,
  and move everything else in the irq handler into irqthread
  context in order to remove all other workqueue and softirq
  processing from the request processing path.

If we can agree on this as the rough plan for the future,
feel free to add my

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
