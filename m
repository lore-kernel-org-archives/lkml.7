Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD2C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7AB20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uABdvBSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfCFQOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:14:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42781 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfCFQOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:14:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so11222524oto.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zdCUIyrJr58bJ4p1jt7o4vG/kaR1BVf+OPlXm3EwToI=;
        b=uABdvBSwLMRbqv1aaegNarvvqMw6OBL0tD9PGl1fmkKeD4rMyEFETsxkC3y/tLftAi
         hRd7Ul9mL61Xmqbft38JYUgxsS5hg+TylmmwEUyttUEktkx6ycLgC1ljmixtSHpYur7i
         JMOtJmh+i32S/6lk2TXdpMwsY/RUPYuYgkFUL1XqvPwZHpGxG03AvJRBl/uDGkIiPU5O
         FzotGDbh4DZiCOSH4avxAF0oWLhro4t+rB7P00mqpnNOc2PbS9/pesnOHmxG2tadD2rU
         E7lDOo5DpX6rU1Tx51crYNLZQs/WzpONDwN1yygPdEA1Jgx3/INcEsvByJQpUZz0fLMl
         SVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zdCUIyrJr58bJ4p1jt7o4vG/kaR1BVf+OPlXm3EwToI=;
        b=qTgtYQDytiAdYIplG080B1XisLRQbvEPmrJbEf6cV51V1ELrZ+0xwUIVC6vqJV5Hoh
         WoNdHfuPTfSHHRINS0iTRMXwDD0s4p9r79Xh4Xpv40oToq36a6UEG9vOr2KDQ09XkdXK
         dLnl3K2riNdAtON/k0mXeAkiXuzo02STBLjKQqq+vw9muzpwUm5aBuTk0CIMR1OJu+l1
         S86qf7RpW1YsdJDJcBSFu4/tmK0vxv7rWmaQVvoNR5lcEAH7QpNwK7iTpInLh1eHF39K
         9jY+lsISyqlZYN1QRshY7CZRRctzmzpF3+54oyEAx29crZaiKv8Ys04yLrOiewxrGVQH
         PzDg==
X-Gm-Message-State: APjAAAVZyzeGq8KT5WMs3qT30pZXgvdcmN0AOSXdCB9Qf0V/HCiYjwDe
        7DNK+NLdQwojyFBBpeSdLNcBF7K17KmAYInwCN01rQ==
X-Google-Smtp-Source: APXvYqyo2QU9YvRfIkzE2D3hyVpGYToRP2G0gHVficbS3RtCaFu228P8uCePlFnIddPAPFPYUvhAxOl54QmYPOLwzQs=
X-Received: by 2002:a05:6830:1543:: with SMTP id l3mr5125026otp.84.1551888886437;
 Wed, 06 Mar 2019 08:14:46 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-6-git-send-email-john.stultz@linaro.org>
In-Reply-To: <1551819273-640-6-git-send-email-john.stultz@linaro.org>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Wed, 6 Mar 2019 17:14:35 +0100
Message-ID: <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> a =
=C3=A9crit :
>
> Add very trivial allocation test for dma-heaps.
>
> TODO: Need to actually do some validation on
> the returned dma-buf.
>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Switched to use reworked dma-heap apis
> ---
>  tools/testing/selftests/dmabuf-heaps/Makefile      | 11 +++
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 96 ++++++++++++++++=
++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testin=
g/selftests/dmabuf-heaps/Makefile
> new file mode 100644
> index 0000000..c414ad3
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS +=3D -static -O3 -Wl,-no-as-needed -Wall
> +#LDLIBS +=3D -lrt -lpthread -lm
> +
> +# these are all "safe" tests that don't modify
> +# system time or require escalated privileges
> +TEST_GEN_PROGS =3D dmabuf-heap
> +
> +
> +include ../lib.mk
> +
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> new file mode 100644
> index 0000000..06837a4
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include "../../../../include/uapi/linux/dma-heap.h"
> +
> +#define DEVPATH "/dev/dma_heap"
> +
> +int dmabuf_heap_open(char *name)
> +{
> +       int ret, fd;
> +       char buf[256];
> +
> +       ret =3D sprintf(buf, "%s/%s", DEVPATH, name);
> +       if (ret < 0) {
> +               printf("sprintf failed!\n");
> +               return ret;
> +       }
> +
> +       fd =3D open(buf, O_RDWR);
> +       if (fd < 0)
> +               printf("open %s failed!\n", buf);
> +       return fd;
> +}
> +
> +int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dmabu=
f_fd)
> +{
> +       struct dma_heap_allocation_data data =3D {
> +               .len =3D len,
> +               .flags =3D flags,
> +       };
> +       int ret;
> +
> +       if (dmabuf_fd =3D=3D NULL)
> +               return -EINVAL;
> +
> +       ret =3D ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
> +       if (ret < 0)
> +               return ret;
> +       *dmabuf_fd =3D (int)data.fd;
> +       return ret;
> +}
> +
> +#define ONE_MEG (1024*1024)
> +
> +void do_test(char *heap_name)
> +{
> +       int heap_fd =3D -1, dmabuf_fd =3D -1;
> +       int ret;
> +
> +       printf("Testing heap: %s\n", heap_name);
> +
> +       heap_fd =3D dmabuf_heap_open(heap_name);
> +       if (heap_fd < 0)
> +               return;
> +
> +       printf("Allocating 1 MEG\n");
> +       ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> +       if (ret)
> +               goto out;
> +
> +       /* DO SOMETHING WITH THE DMABUF HERE? */

You can do a call to mmap and write a pattern in the buffer.

Benjamin
> +
> +out:
> +       if (dmabuf_fd >=3D 0)
> +               close(dmabuf_fd);
> +       if (heap_fd >=3D 0)
> +               close(heap_fd);
> +}
> +
> +
> +int main(void)
> +{
> +       DIR *d;
> +       struct dirent *dir;
> +
> +       d =3D opendir(DEVPATH);
> +       if (!d) {
> +               printf("No %s directory?\n", DEVPATH);
> +               return -1;
> +       }
> +
> +       while ((dir =3D readdir(d)) !=3D NULL)
> +               do_test(dir->d_name);
> +
> +
> +       return 0;
> +}
> --
> 2.7.4
>


--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
