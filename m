Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E494C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1262420684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFOzYHpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbfCFSTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:19:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37086 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfCFSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:19:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so6802378wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KX1v2Gtz/AZRJmP5V/LEY6XIdQRknfHOkMJbmb6XVLo=;
        b=JFOzYHpNhz5IYNT4USkiUQPNxaOF6EBiEiMq4hLrACzrcpWBJlOYs76SdQnEyHBU2M
         bJiN2lRGakqGuoecRzNxXbtsjrt0KG+SnTCEEm3QbL1ar5wrPUN0iURB+tEweXN9CiSh
         fkG+K+ilLC361mifIE3aCVnZEIkLV+uqG0gPhJdQkwvooiZ9wgnldxlUrDjpj2IulT1u
         ksqNnZw/mJO8uYZi6+lRuhPMyi/2MQ3fLHP41Axz0WFzBgXaIzNWriRBZDXcsVFypxCy
         orEdKiNob7/Fsi3FKWNzxeZfKfdv+MnnVOaFl5ON/1Gl9GW1AVuNwSo0/VUSIY9QqZT/
         6iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KX1v2Gtz/AZRJmP5V/LEY6XIdQRknfHOkMJbmb6XVLo=;
        b=gGUuUwJATzLLLF4VMZiabR2rCJl9xkKRxFpKCiTmsAajYKW+hrACY3ut47z1XgNSr6
         8PWb/HTF4PznAhncI4apaQhu4ULn0lRRqu8wJOBjxgdWVDJMPikYwx+uUKHKOSz9GtGf
         uEcM/K96EQ/a5/p3CFVqdB+MyxfJbnYxLvNX0I4/h3bCSCp3p/ALqQFfCAGBroSWDsBK
         j5pGZRbyJP9q74bfCnxTYe7X3Hb2m6KNp6R8cCUTLErDKiUIoF/Ntviwe/LiYaVjGycM
         Uw+JdM9aEyJBpQUtRgiWPRiTLHPmUymgMMMcwg02Vqczy8mMQB/hbVeSHCmADQicL0JT
         Rd7Q==
X-Gm-Message-State: APjAAAXxqA58/6tqOUaOdh+VhnIH286vxfmvH9ErxwjylWzwt1E/PX/n
        wfAcWILQN87GZGomY2HOG5a9eUh0wwDJSy511Ejx3w==
X-Google-Smtp-Source: APXvYqxyG486xa+CI273CndwnSUr7ynWW82EZZFtAkDjtCe35q6LuFDTO5vDmefF0AHdHlAhUV4CDlMItKoi5jgioLY=
X-Received: by 2002:a1c:230e:: with SMTP id j14mr3418621wmj.9.1551896387131;
 Wed, 06 Mar 2019 10:19:47 -0800 (PST)
MIME-Version: 1.0
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org>
 <1551819273-640-6-git-send-email-john.stultz@linaro.org> <CA+M3ks6AUmmYbXscjTRo+Vr-6cV8okafsDn2Tg3tskvzrV_dbA@mail.gmail.com>
 <7deadc25-c8b2-3b58-1867-86f7db3188fa@ti.com>
In-Reply-To: <7deadc25-c8b2-3b58-1867-86f7db3188fa@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 Mar 2019 10:19:36 -0800
Message-ID: <CALAqxLU9aq6Qj1qJKQK=a5AbnLc1Hwxvb0nX9JemoW=29gDVoA@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 10:15 AM Andrew F. Davis <afd@ti.com> wrote:
>
> On 3/6/19 10:14 AM, Benjamin Gaignard wrote:
> > Le mar. 5 mars 2019 =C3=A0 21:54, John Stultz <john.stultz@linaro.org> =
a =C3=A9crit :
> >>
> >> Add very trivial allocation test for dma-heaps.
> >>
> >> TODO: Need to actually do some validation on
> >> the returned dma-buf.
> >>
> >> Cc: Laura Abbott <labbott@redhat.com>
> >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> >> Cc: Greg KH <gregkh@linuxfoundation.org>
> >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> >> Cc: Liam Mark <lmark@codeaurora.org>
> >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> >> Cc: Andrew F. Davis <afd@ti.com>
> >> Cc: Chenbo Feng <fengc@google.com>
> >> Cc: Alistair Strachan <astrachan@google.com>
> >> Cc: dri-devel@lists.freedesktop.org
> >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> >> ---
> >> v2: Switched to use reworked dma-heap apis
> >> ---
> >>  tools/testing/selftests/dmabuf-heaps/Makefile      | 11 +++
> >>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 96 +++++++++++++=
+++++++++
> >>  2 files changed, 107 insertions(+)
> >>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
> >>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >>
> >> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/tes=
ting/selftests/dmabuf-heaps/Makefile
> >> new file mode 100644
> >> index 0000000..c414ad3
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> >> @@ -0,0 +1,11 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +CFLAGS +=3D -static -O3 -Wl,-no-as-needed -Wall
> >> +#LDLIBS +=3D -lrt -lpthread -lm
> >> +
> >> +# these are all "safe" tests that don't modify
> >> +# system time or require escalated privileges
> >> +TEST_GEN_PROGS =3D dmabuf-heap
> >> +
> >> +
> >> +include ../lib.mk
> >> +
> >> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tool=
s/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >> new file mode 100644
> >> index 0000000..06837a4
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> >> @@ -0,0 +1,96 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +
> >> +#include <dirent.h>
> >> +#include <errno.h>
> >> +#include <fcntl.h>
> >> +#include <stdio.h>
> >> +#include <string.h>
> >> +#include <unistd.h>
> >> +#include <sys/ioctl.h>
> >> +#include <sys/mman.h>
> >> +#include <sys/types.h>
> >> +
> >> +#include "../../../../include/uapi/linux/dma-heap.h"
> >> +
> >> +#define DEVPATH "/dev/dma_heap"
> >> +
> >> +int dmabuf_heap_open(char *name)
> >> +{
> >> +       int ret, fd;
> >> +       char buf[256];
> >> +
> >> +       ret =3D sprintf(buf, "%s/%s", DEVPATH, name);
> >> +       if (ret < 0) {
> >> +               printf("sprintf failed!\n");
> >> +               return ret;
> >> +       }
> >> +
> >> +       fd =3D open(buf, O_RDWR);
> >> +       if (fd < 0)
> >> +               printf("open %s failed!\n", buf);
> >> +       return fd;
> >> +}
> >> +
> >> +int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dm=
abuf_fd)
> >> +{
> >> +       struct dma_heap_allocation_data data =3D {
> >> +               .len =3D len,
> >> +               .flags =3D flags,
> >> +       };
> >> +       int ret;
> >> +
> >> +       if (dmabuf_fd =3D=3D NULL)
> >> +               return -EINVAL;
> >> +
> >> +       ret =3D ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
> >> +       if (ret < 0)
> >> +               return ret;
> >> +       *dmabuf_fd =3D (int)data.fd;
> >> +       return ret;
> >> +}
> >> +
> >> +#define ONE_MEG (1024*1024)
> >> +
> >> +void do_test(char *heap_name)
> >> +{
> >> +       int heap_fd =3D -1, dmabuf_fd =3D -1;
> >> +       int ret;
> >> +
> >> +       printf("Testing heap: %s\n", heap_name);
> >> +
> >> +       heap_fd =3D dmabuf_heap_open(heap_name);
> >> +       if (heap_fd < 0)
> >> +               return;
> >> +
> >> +       printf("Allocating 1 MEG\n");
> >> +       ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> >> +       if (ret)
> >> +               goto out;
> >> +
> >> +       /* DO SOMETHING WITH THE DMABUF HERE? */
> >
> > You can do a call to mmap and write a pattern in the buffer.
> >
>
> mmap is optional for DMA-BUFs, only attach/map are required. To test
> those we would need a dummy device, so a test kernel module may be
> needed to really exercise this.
>
> I have one I use for ION buffer testing, it consumes a DMA-BUF passed
> from userspace, attach/maps it to a dummy device then return the
> physical address of the first page of the buffer for validation. Might
> be a good test, but dummy devices don't always have the proper dma
> attributes set like a real device does, so it may also fail for some
> otherwise valid buffers.

Cool! Do you mind sharing that? I might try to rework and integrate it
into this patchset?

thanks
-john
