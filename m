Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C1DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D1A222D4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bllq8uZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfKDISR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:18:17 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40900 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfKDISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:18:17 -0500
Received: by mail-lf1-f66.google.com with SMTP id f4so11511777lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 00:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=3Fna44DJBr3L3fSk0TA7aVGOJ8OciaIjrKygxibmpbk=;
        b=Bllq8uZQ+wXjp21caCMWm2nncX4I0Av2dxUcTcDkpRNranTo1A59CQOFagVa2S8Zjd
         +eXk/84v7hTGMyop4IhGjrz2/G0hh5TthC58H0QqNoK/U5dhfnkzmRKvQzDCZvAlVXsZ
         K6x6Y+ziNsNhUX1AXbCH82JFC2uLwiir6xB+pCQVUztxRwEDZOQWUJJlLRfxGtSveVMJ
         OZudsZc3s1QZ+bNK/66H9HVRB8CJZko8sgPOAWGf9P1hzj9FfXdKkiJ3m3xbpVpb5U6z
         rzVps1uswrNlY+rZKBKWA15qp5ZXFbwks6sHB2fgRu7u5G6P4WAJMJ6QZ4keOs7OoSt2
         JpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=3Fna44DJBr3L3fSk0TA7aVGOJ8OciaIjrKygxibmpbk=;
        b=G1nnPMNv8xrwjMJjERNkqsLZcWBZ7CwSW6eLVsl6a22EexaNC30IKXQhX6q1xFRseA
         PvZ4hcuGscoMr536IsgXk2lhOaqifCDBGLCmH94xgM3JvtC/rI4YemslCilnkFHk13Nj
         tNkSJaZA18IeDTLEQhjnl67CJSUP/iVI19KTi/gr4wFGx1lNA3+7pk6go1wZRQ8hIhQt
         mOpwfktrFEMYwibNjznFl7X1gqGBPQCbIXyRn+IP0PlP8fEpOMleFLhxjA2nrCbC5hRD
         OxfJnckZUAqzy07ni9tQVo4+s94KtHUtvWv2Rhk6SZOJU4rhwYy42PeiMjIZe88GOGqR
         Lxqw==
X-Gm-Message-State: APjAAAUNxJID+8kBBSRLk/tb0DxYxQdJQBHF96h/0VF6qfLlO8SLE6fY
        QF9sYhWAGyUQoi/EvcpL4L0=
X-Google-Smtp-Source: APXvYqw2SiJP5yRkYlL6bFgDdy2rUvcGVoeof5lrC8G435MxWzQY1L+EDEJyIXFvM9PK5hf/i2i7cA==
X-Received: by 2002:a05:6512:21e:: with SMTP id a30mr15606927lfo.175.1572855493083;
        Mon, 04 Nov 2019 00:18:13 -0800 (PST)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id a26sm8101559lfg.50.2019.11.04.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 00:18:12 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:18:07 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Sandeep Patil <sspatil@google.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Liam Mark <lmark@codeaurora.org>,
        Christoph Hellwig <hch@infradead.org>,
        dri-devel@lists.freedesktop.org, "Andrew F . Davis" <afd@ti.com>,
        Hridya Valsaraju <hridya@google.com>,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: [PATCH v14 0/5] DMA-BUF Heaps (destaging ION)
Message-ID: <20191104101807.79503286@eldfell.localdomain>
In-Reply-To: <20191101214238.78015-1-john.stultz@linaro.org>
References: <20191101214238.78015-1-john.stultz@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MnMKK_kK0nBvDPQ_LbvOkmR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MnMKK_kK0nBvDPQ_LbvOkmR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  1 Nov 2019 21:42:33 +0000
John Stultz <john.stultz@linaro.org> wrote:

> This again? I know!
>=20
> Apologies to all who hoped I'd stop bothering them with this
> patch set, but I ran afoul of the DRM tree rules by not
> getting the userland patches properly reviewed prior to the
> patches landing (I mistakenly was waiting for the patches to
> land upstream before pushing the userland patches). Thus,
> these were correctly reverted from the drm-misc-next tree.

Hi John,

mind, you have to get userland patches reviewed and accepted but *not
pushed*.

You cannot push/merge userland patches before the kernel patches have
properly landed, that bit you got right. But the supposedly confusing
bit is that for kernel patches to land, the userspace patches must be
reviewed and accepted first.

I just wanted to clarify this since you wrote "before pushing the
userland patches" above.


Thanks,
pq

>=20
> My attempts to quickly fix the userland review issue didn't get
> very far, as the revert brought additional eyes to the patchset,
> and further interface changes were requested (comically, which
> is the exact reason I was waiting to push the userland changes
> :)
>=20
> So like groundhog day, here we are again, with v14:
>=20
> This patchset implements per-heap devices which can be opened
> directly and then an ioctl is used to allocate a dmabuf from the
> heap.
>=20
> The interface is similar, but much simpler then IONs, only
> providing an ALLOC ioctl (and a GET_FEATURES interface to help
> with any future changes to the interface).
>=20
> Also, I've provided relatively simple system and cma heaps.
>=20
> I've booted and tested these patches with AOSP on the HiKey960
> using the kernel tree here:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=3Ddev/=
dma-buf-heap
>=20
> And the userspace changes here:
>   https://android-review.googlesource.com/c/device/linaro/hikey/+/909436
>=20
> Compared to ION, this patchset is missing the system-contig,
> carveout and chunk heaps, as I don't have a device that uses
> those, so I'm unable to do much useful validation there.
> Additionally we have no upstream users of chunk or carveout,
> and the system-contig has been deprecated in the common/andoid-*
> kernels, so this should be ok.
>=20
> I've also removed the stats accounting, since any such
> accounting should be implemented by dma-buf core or the heaps
> themselves.
>=20
> New in v14:
> * Reworked ioctl handler to zero fill any difference in
>   structure size, similar to what the DRM core does, as
>   suggested by Dave Airlie
> * Removed now unnecessary reserved bits in allocate_data
> * Added get_features ioctl as suggested by Dave Airlie
> * Removed pr_warn_once messages as requested by Dave
>   Airlie
> * Fix missing argment to WARN() in dma_heap_buffer_destroy()
>   found and fixed by Dan Carpenter <dan.carpenter@oracle.com>
> * Add check in fault hanlder that pgoff isn't larger then
>   pagecount, reported by Dan Carpenter
> * Fix "redundant assignment to variable ret" issue reported
>   by Colin King and fixed by Andrew Davis
> * Fix a missing return value in kselftest
> * Add calls to test the GET_FEATURES ioctl in ksefltest
> * Build fix reported by kernel test robot <lkp@intel.com>
>   and fixed by Xiao Yang <ice_yangxiao@163.com> for kselftest
> * Minor kselftest Makefile cleanups
>=20
> Many thanks again to the folks above who found and submitted
> fixes to small issues while the patches were in -next! I've
> folded them in to the patch set here.
>=20
> The ioctl rework to avoid reserved fields, was mostly duplicated
> from the DRM core, but it does add some complexity to the ioctl
> handler so I'd appreciate extra review.
>=20
> It felt substantial enough that I've removed the previous reviewed
> by and acked-by tags, but please let me know if you'd like me to
> re-add yours back.
>=20
> Apologies again for my flub and the extra noise here!
> I really appreciate everyone's patience with with me.
>=20
> thanks
> -john
>=20
>=20
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Liam Mark <lmark@codeaurora.org>
> Cc: Pratik Patel <pratikp@codeaurora.org>
> Cc: Brian Starkey <Brian.Starkey@arm.com>
> Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> Cc: Andrew F. Davis <afd@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Chenbo Feng <fengc@google.com>
> Cc: Alistair Strachan <astrachan@google.com>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
>=20
> Andrew F. Davis (1):
>   dma-buf: Add dma-buf heaps framework
>=20
> John Stultz (4):
>   dma-buf: heaps: Add heap helpers
>   dma-buf: heaps: Add system heap to dmabuf heaps
>   dma-buf: heaps: Add CMA heap to dmabuf heaps
>   kselftests: Add dma-heap test
>=20
>  MAINTAINERS                                   |  18 +
>  drivers/dma-buf/Kconfig                       |  11 +
>  drivers/dma-buf/Makefile                      |   2 +
>  drivers/dma-buf/dma-heap.c                    | 313 ++++++++++++++++++
>  drivers/dma-buf/heaps/Kconfig                 |  14 +
>  drivers/dma-buf/heaps/Makefile                |   4 +
>  drivers/dma-buf/heaps/cma_heap.c              | 178 ++++++++++
>  drivers/dma-buf/heaps/heap-helpers.c          | 271 +++++++++++++++
>  drivers/dma-buf/heaps/heap-helpers.h          |  55 +++
>  drivers/dma-buf/heaps/system_heap.c           | 124 +++++++
>  include/linux/dma-heap.h                      |  59 ++++
>  include/uapi/linux/dma-heap.h                 |  77 +++++
>  tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 255 ++++++++++++++
>  14 files changed, 1387 insertions(+)
>  create mode 100644 drivers/dma-buf/dma-heap.c
>  create mode 100644 drivers/dma-buf/heaps/Kconfig
>  create mode 100644 drivers/dma-buf/heaps/Makefile
>  create mode 100644 drivers/dma-buf/heaps/cma_heap.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.c
>  create mode 100644 drivers/dma-buf/heaps/heap-helpers.h
>  create mode 100644 drivers/dma-buf/heaps/system_heap.c
>  create mode 100644 include/linux/dma-heap.h
>  create mode 100644 include/uapi/linux/dma-heap.h
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
>=20


--Sig_/MnMKK_kK0nBvDPQ_LbvOkmR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAl2/3sAACgkQI1/ltBGq
qqelRBAAp4/ktwV0caLVLYyNYnErMo8XfMZhO/iqxQDI7cott661fCeRAQ99xZ80
zPDRmhkrKd4DnYRXBQvs/IF+Xm0xp+wvGVvaIjTkNRz3RQm7tIRNHljF3fZEYLBY
kEH8mqKOn2d3jvnhSLhLkFZwWBKjt5OE789ns500zeSf3ny/yw+EyNa0guH/t5lg
8QAPzPAwkW5p8KZGYmsB0GZ8VXN1JKIOMTc/mLaCf66dYx3Ml8BYh3GkWeLsSks2
QZ7yvI6wPbGjrTbxjAvAXUIoVbhWloDCRpz95fZWTw5xIMifL5q2DNmw58aSYQdq
X7KH9WWTGXoJJ3/rajq4Nte9mvjmm0rwDb4cm7yygZ6158tj9CvLWy/6FqSJDOzr
d9gTNTcQpflecI/xQneQ1I04wW7nm3u4qYgnejDqmHD9ezLR23nQHECCwMWL+obt
SXb0Ng6EVW5Ci3EUB03YLxQzBep6Du+8a0uFdjFVn/EI+D3NZRMVafYl6U8m8JO8
5/wWGKgvOwJZr8oLUtV84cZ0xjwEeukyRKHQ5eQ/gPoYZBrO9gviFVvpBqXaWHH4
3JhPLpyrgufMUM0CDUBsaRCxfXXOYdmTOfmOM9VD8hdHvJYflPxCT51jyuHXHB1u
DL2Xqm5bc5TIyU2gN96feN3NKTPU2DuHDscwEXVBz0hvMUhxGbg=
=8BeV
-----END PGP SIGNATURE-----

--Sig_/MnMKK_kK0nBvDPQ_LbvOkmR--
