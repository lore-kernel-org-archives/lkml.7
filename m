Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B996C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86862067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 04:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="AXcW9a5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfGaELH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 00:11:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45517 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGaELH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:11:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so7610129lfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 21:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gtd0BFwAQ/XdE/MYF5pM1JVN5VadgPEIkJktXl2NB3c=;
        b=AXcW9a5p6k4mTN/KFJJzaBWlwVPerhYEZkNW5hJ7YxlD/q/KB7hZO7gkxUYL8IQkOO
         r3XqxCeUf0kKS9rGzOQYlR6fSBsLO5DGvt+FEVsbh7EVAwXTNQsBNksB2E1HaU1JG13H
         AHhH9SU0kzctCh9vLjpQmN+SZyNKzOLACPDuC1zowswoSqbeVF6whshgyhe/Wf4tXFZ+
         YzQ7xIxFOx/dWj425G055DC7E+M79yyDZTunpb9aqkawkqmrYhqRH6+0AXvCwURT4tbS
         lwaSnHzw3iG9M4vTgKSoIY1Y+Tqe2N48E+hEpercLowd/rRqiIyZog3eslXzK1/5TVtV
         Axww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gtd0BFwAQ/XdE/MYF5pM1JVN5VadgPEIkJktXl2NB3c=;
        b=QEtRPfJQdf5vy1sfedxbS508rMXZ0b6JP3GMMy+LyZg2HvsU2zTTqUFnR+d41j3wpB
         bIq32PGKhAV7lqM0AVIcLUts8DMIn2OlCc0BFKD9fiG2FU2yQkR3El7OxAWERobf+2jD
         nek7Q5kIMZzIdjoWlj5MvOfadtca3YggYSloqG1a677XK667iKdPA8zLhFwr3oQ9iGCz
         GCzI0GOQyDOTZpsy/rcq7qv1XHmRQnkl+33WqQIxzaAezID8CTfpq0Uux22fP70+i0S4
         CF9FCmDEpx6MOSDPQ+qYkEo4E46mdIRWTRcQHF+9wce00BRncBh79LgxQuL9QlRkPKAf
         HBjw==
X-Gm-Message-State: APjAAAVSfYwKzcc5blG2noEYvTQqLv770rz9nAk4ugoe4LAO7lofGkub
        k1zD0MuQ1FlE0GSifDCt24YjupbOlyH2CrMIqB+6gA==
X-Google-Smtp-Source: APXvYqy4CPJLowEUr12O30sc9kW+IBVaZHHFJIJOL0e68zsco9UwONFmXC2Qew4LAKHIMQCb5Pva4r2iG/Sp4k2R1yE=
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr35008208lfp.35.1564546265177;
 Tue, 30 Jul 2019 21:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
In-Reply-To: <20190719133135.32418-1-lifei.shirley@bytedance.com>
From:   =?UTF-8?B?5p2O6I+y?= <lifei.shirley@bytedance.com>
Date:   Wed, 31 Jul 2019 12:10:54 +0800
Message-ID: <CA+=e4K6K4BS6vhURemYfEYz4zeEEq5Z7YQ1C=vH97WWNJhJe9Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] virtio-mmio: support multiple interrupt vectors
To:     Sergio Lopez <slp@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        linux-kernel@vger.kernel.org,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergio,

Considering your implementing virtio-mmio v2 in Qemu, please help to give some
suggestions on this patch series. Thanks :)

For web, this link:
https://www.spinics.net/lists/kernel/msg3195667.html may help.

Have a nice day
Fei

On Fri, Jul 19, 2019 at 9:31 PM Fei Li <lifei.shirley@bytedance.com> wrote:
>
> Hi,
>
> This patch series implements multiple interrupt vectors support for
> virtio-mmio device. This is especially useful for multiqueue vhost-net
> device when using firecracker micro-vms as the guest.
>
> Test result:
> With 8 vcpus & 8 net queues set, one vhost-net device with 8 irqs can
> receive 9 times more pps comparing with only one irq:
> - 564830.38 rxpck/s for 8 irqs on
> - 67665.06 rxpck/s for 1 irq on
>
> Please help to review, thanks!
>
> Have a nice day
> Fei
>
>
> Fam Zheng (1):
>   virtio-mmio: Process vrings more proactively
>
> Fei Li (1):
>   virtio-mmio: support multiple interrupt vectors
>
>  drivers/virtio/virtio_mmio.c | 238 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 196 insertions(+), 42 deletions(-)
>
> --
> 2.11.0
>
