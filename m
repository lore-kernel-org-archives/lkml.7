Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242CAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C454E21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 12:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMXPoWHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEIMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 08:37:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32939 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfEIMht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 08:37:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id m32so407316qtf.0;
        Thu, 09 May 2019 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gff3GQLBjvfEeXb3DPqNhomCkoH+ZNgB7C2kigM/kGQ=;
        b=cMXPoWHNwNprH03rOZRpE7hDOwDFRpiRDWA1RQYN/COX3mgDBSvSbMGl8+eayLDIwi
         Wkbu0omPnEtJLSQrcuYr9H44e4PuJ2h+Vb5Fduh7ZzQDpx0s/1CZ9y5qGT5Km/qlQfNQ
         WJXqWu1iWNsjJcGxWLos1H24KMpLxzn7PSnhNOJ1Ot6IS6Gv3PkHLTUysPc0kgUHWc0F
         7pDiMu28+vNjVLsDFhwkefVkaMpPtfiz5Ad3VManfUmtxeplvvLS1EKlws+3thdMuy8m
         eAziH0zvlkdFnyo+tT1CsaJFDcHD3mzE7VlHbodzA81xnCb3RjJwbVSmAKWRrh0uqyWH
         1fuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gff3GQLBjvfEeXb3DPqNhomCkoH+ZNgB7C2kigM/kGQ=;
        b=ZBwfX57KBlKfQptpV90FhuN+wDTM9gh+fVqn1+Hhg9QFLEhSMNH9xgN3R6zXhOMrs3
         kGJmbOHfN3brZeL2wlzKPQDTlnKh9AL0IuIAkVZwhMlVTsJJpISGlCLyD0iy57Kk69c1
         zDOtvwQtQEiVaj6MFtDKLrSCulbBCRX28tyqRKM4JcrZL8xr4Zx+xMP5QNMb167FcTTw
         4sC213r53/4GCDWHAXdBF8GQHgMqP3ysCiGpr/fIDxIUjkN6w5z0RogymKS03AYKn5j/
         bCo1e847n54WGmsvl7PIWWbZ08bTwHkK7u9WZnTiv01VtoR3lBPGpJSzX4UVQj3WXgpN
         QBIw==
X-Gm-Message-State: APjAAAXu9glS8dkCOq6GSOOb0dt5vk9uTfFrtEzbL62xLmEl9EblUypd
        KO6aafP5cMyI4aYjlL7dbR6mtahiesAWYLZlkVA=
X-Google-Smtp-Source: APXvYqxp60Iv1JYDqqaC0FvcdUzXHvUuRZVEJQTWHF2liD0MO9EBDQecfph9+l76xmzznwS7IAZh2YK09FpLP1OSxUs=
X-Received: by 2002:a0c:ee29:: with SMTP id l9mr3225465qvs.151.1557405467891;
 Thu, 09 May 2019 05:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <1548949280-31794-1-git-send-email-xiaoxiang@xiaomi.com>
 <1548949280-31794-3-git-send-email-xiaoxiang@xiaomi.com> <01b88b99-ebc1-a5a3-2ff9-39fe476847be@st.com>
In-Reply-To: <01b88b99-ebc1-a5a3-2ff9-39fe476847be@st.com>
From:   xiang xiao <xiaoxiang781216@gmail.com>
Date:   Thu, 9 May 2019 20:37:36 +0800
Message-ID: <CAH2Cfb8zs7yE-y6NZjRS+e2QTQiJM+DPGfAoKctxY=XYcxAPCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] rpmsg: virtio_rpmsg_bus: allocate rx/tx buffer separately
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc:     Ohad Ben Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        wendy.liang@xilinx.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Content-Type: multipart/mixed; boundary="000000000000af8326058873b743"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000af8326058873b743
Content-Type: text/plain; charset="UTF-8"

On Thu, May 9, 2019 at 8:02 PM Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:
>
> Hello Xiang,
>
> This patch has the opposite effect on my platform as DMA allocation is
> aligned on 4k page.
> For instance i declared:
> - in RX  6 buffers (of 512 bytes)
> - in TX  4 buffers ( of 512 bytes)
>

Yes, dma_init_coherent_memory always allocate memory by 4KB unit, but
this limitation is too waste memory for remoteproc/rpmsg. The attached
patch fix this problem by adding a new device tree option to customize
the unit size.

> The result is (kernel trace)
> [   41.915896] virtio_rpmsg_bus virtio0: rx buffers: va ebb5f5ca, dma
> 0x0x10042000
> [   41.915922] virtio_rpmsg_bus virtio0: tx buffers: va a7865153, dma
> 0x0x10043000
>
> The TX buffer memory is allocated on next 4k page...
>
> Anyway separate the RX and TX allocation makes sense. This could also
> allow to allocate buffers in 2 different memories.
> For time being, issue is that only one memory area can be attached to
> the virtio device for DMA allocation... and PA/DA translations are missing.
> This means that we probably need (in a first step) a new remoteproc API
> for memory allocation.
> These memories should be declared and mmaped in rproc platform drivers
> (memory region) or in resource table (carveout).
> This is partially done in the API for the platform driver
> (rproc_mem_entry_init) but not available for rproc clients.
>
> Regards
> Arnaud
>
>
> On 1/31/19 4:41 PM, Xiang Xiao wrote:
> > many dma allocator align the returned address with buffer size,
> > so two small allocation could reduce the alignment requirement
> > and save the the memory space wasted by the potential alignment.
> >
> > Signed-off-by: Xiang Xiao <xiaoxiang@xiaomi.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 58 +++++++++++++++++++++++-----------------
> >  1 file changed, 34 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index fb0d2eb..59c4554 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -40,7 +40,8 @@
> >   * @num_sbufs:       total number of buffers for tx
> >   * @buf_size:        size of one rx or tx buffer
> >   * @last_sbuf:       index of last tx buffer used
> > - * @bufs_dma:        dma base addr of the buffers
> > + * @rbufs_dma:       dma base addr of rx buffers
> > + * @sbufs_dma:       dma base addr of tx buffers
> >   * @tx_lock: protects svq, sbufs and sleepers, to allow concurrent senders.
> >   *           sending a message might require waking up a dozing remote
> >   *           processor, which involves sleeping, hence the mutex.
> > @@ -62,7 +63,8 @@ struct virtproc_info {
> >       unsigned int num_sbufs;
> >       unsigned int buf_size;
> >       int last_sbuf;
> > -     dma_addr_t bufs_dma;
> > +     dma_addr_t rbufs_dma;
> > +     dma_addr_t sbufs_dma;
> >       struct mutex tx_lock;
> >       struct idr endpoints;
> >       struct mutex endpoints_lock;
> > @@ -872,9 +874,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >       static const char * const names[] = { "input", "output" };
> >       struct virtqueue *vqs[2];
> >       struct virtproc_info *vrp;
> > -     void *bufs_va;
> >       int err = 0, i;
> > -     size_t total_buf_space;
> >       bool notify;
> >
> >       vrp = kzalloc(sizeof(*vrp), GFP_KERNEL);
> > @@ -909,25 +909,28 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >
> >       vrp->buf_size = MAX_RPMSG_BUF_SIZE;
> >
> > -     total_buf_space = (vrp->num_rbufs + vrp->num_sbufs) * vrp->buf_size;
> > -
> >       /* allocate coherent memory for the buffers */
> > -     bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
> > -                                  total_buf_space, &vrp->bufs_dma,
> > -                                  GFP_KERNEL);
> > -     if (!bufs_va) {
> > +     vrp->rbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> > +                                     vrp->num_rbufs * vrp->buf_size,
> > +                                     &vrp->rbufs_dma, GFP_KERNEL);
> > +     if (!vrp->rbufs) {
> >               err = -ENOMEM;
> >               goto vqs_del;
> >       }
> >
> > -     dev_dbg(&vdev->dev, "buffers: va %p, dma %pad\n",
> > -             bufs_va, &vrp->bufs_dma);
> > +     dev_dbg(&vdev->dev, "rx buffers: va %p, dma 0x%pad\n",
> > +             vrp->rbufs, &vrp->rbufs_dma);
> >
> > -     /* first part of the buffers is dedicated for RX */
> > -     vrp->rbufs = bufs_va;
> > +     vrp->sbufs = dma_alloc_coherent(vdev->dev.parent->parent,
> > +                                     vrp->num_sbufs * vrp->buf_size,
> > +                                     &vrp->sbufs_dma, GFP_KERNEL);
> > +     if (!vrp->sbufs) {
> > +             err = -ENOMEM;
> > +             goto free_rbufs;
> > +     }
> >
> > -     /* and second part is dedicated for TX */
> > -     vrp->sbufs = bufs_va + vrp->num_rbufs * vrp->buf_size;
> > +     dev_dbg(&vdev->dev, "tx buffers: va %p, dma 0x%pad\n",
> > +             vrp->sbufs, &vrp->sbufs_dma);
> >
> >       /* set up the receive buffers */
> >       for (i = 0; i < vrp->num_rbufs; i++) {
> > @@ -954,7 +957,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >               if (!vrp->ns_ept) {
> >                       dev_err(&vdev->dev, "failed to create the ns ept\n");
> >                       err = -ENOMEM;
> > -                     goto free_coherent;
> > +                     goto free_sbufs;
> >               }
> >       }
> >
> > @@ -979,9 +982,14 @@ static int rpmsg_probe(struct virtio_device *vdev)
> >
> >       return 0;
> >
> > -free_coherent:
> > -     dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> > -                       bufs_va, vrp->bufs_dma);
> > +free_sbufs:
> > +     dma_free_coherent(vdev->dev.parent->parent,
> > +                       vrp->num_sbufs * vrp->buf_size,
> > +                       vrp->sbufs, vrp->sbufs_dma);
> > +free_rbufs:
> > +     dma_free_coherent(vdev->dev.parent->parent,
> > +                       vrp->num_rbufs * vrp->buf_size,
> > +                       vrp->rbufs, vrp->rbufs_dma);
> >  vqs_del:
> >       vdev->config->del_vqs(vrp->vdev);
> >  free_vrp:
> > @@ -999,8 +1007,6 @@ static int rpmsg_remove_device(struct device *dev, void *data)
> >  static void rpmsg_remove(struct virtio_device *vdev)
> >  {
> >       struct virtproc_info *vrp = vdev->priv;
> > -     unsigned int num_bufs = vrp->num_rbufs + vrp->num_sbufs;
> > -     size_t total_buf_space = num_bufs * vrp->buf_size;
> >       int ret;
> >
> >       vdev->config->reset(vdev);
> > @@ -1016,8 +1022,12 @@ static void rpmsg_remove(struct virtio_device *vdev)
> >
> >       vdev->config->del_vqs(vrp->vdev);
> >
> > -     dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
> > -                       vrp->rbufs, vrp->bufs_dma);
> > +     dma_free_coherent(vdev->dev.parent->parent,
> > +                       vrp->num_sbufs * vrp->buf_size,
> > +                       vrp->sbufs, vrp->sbufs_dma);
> > +     dma_free_coherent(vdev->dev.parent->parent,
> > +                       vrp->num_rbufs * vrp->buf_size,
> > +                       vrp->rbufs, vrp->rbufs_dma);
> >
> >       kfree(vrp);
> >  }
> >

--000000000000af8326058873b743
Content-Type: application/octet-stream; 
	name="0001-dma-coherent-support-the-alignment-smaller-than-PAGE.patch"
Content-Disposition: attachment; 
	filename="0001-dma-coherent-support-the-alignment-smaller-than-PAGE.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jvgmyvwr0>
X-Attachment-Id: f_jvgmyvwr0

RnJvbSA2MjY3MmUxZGY3OWM5ZmZjY2IwNjJmNWFhMGRjYjE4ZTkzOGNlZDBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBYaWFuZyBYaWFvIDx4aWFveGlhbmdAeGlhb21pLmNvbT4KRGF0
ZTogVGh1LCAyMiBKdW4gMjAxNyAxNDozMDo1MCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRtYS1j
b2hlcmVudDogc3VwcG9ydCB0aGUgYWxpZ25tZW50IHNtYWxsZXIgdGhhbiBQQUdFX1NJWkUKCmFu
ZCByZWFkIHRoZSBhbGlnbm1lbnQoZGVmYXVsdCBQQUdFX1NJWkUpIGZyb20gZGV2aWNlIHRyZWUK
CkNoYW5nZS1JZDogSTUxMjEyODg1OWIwYWFjMmUyNWJlMDljYThlMDk2ODE5MDA1N2UxNjAKU2ln
bmVkLW9mZi1ieTogWGlhbmcgWGlhbyA8eGlhb3hpYW5nQHhpYW9taS5jb20+Ci0tLQogLi4uL2Jp
bmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0ICAgfCAgMiArCiBkcml2
ZXJzL2Jhc2UvZG1hLWNvaGVyZW50LmMgICAgICAgICAgICAgICAgICAgICAgICB8IDc0ICsrKysr
KysrKysrKysrLS0tLS0tLS0KIGluY2x1ZGUvbGludXgvZG1hLW1hcHBpbmcuaCAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDYgKy0KIDMgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9ucygrKSwg
MzEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2VydmVkLW1lbW9yeS9yZXNlcnZlZC1tZW1vcnkudHh0
CmluZGV4IDNkYTBlYmRiYThkOS4uMzgzYWRhMDkyMTNiIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXJ2ZWQtbWVtb3J5L3Jlc2VydmVkLW1lbW9yeS50
eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2VydmVkLW1lbW9y
eS9yZXNlcnZlZC1tZW1vcnkudHh0CkBAIC02Myw2ICs2Myw4IEBAIHJldXNhYmxlIChvcHRpb25h
bCkgLSBlbXB0eSBwcm9wZXJ0eQogICAgICAgYWJsZSB0byByZWNsYWltIGl0IGJhY2suIFR5cGlj
YWxseSB0aGF0IG1lYW5zIHRoYXQgdGhlIG9wZXJhdGluZwogICAgICAgc3lzdGVtIGNhbiB1c2Ug
dGhhdCByZWdpb24gdG8gc3RvcmUgdm9sYXRpbGUgb3IgY2FjaGVkIGRhdGEgdGhhdAogICAgICAg
Y2FuIGJlIG90aGVyd2lzZSByZWdlbmVyYXRlZCBvciBtaWdyYXRlZCBlbHNld2hlcmUuCithbGln
bi1zaGlmdCAob3B0aW9uYWwpIC0gdGhlIGFsbG9jYXRpb24gYWxpZ25tZW50ICgxIDw8IGFsaWdu
LXNoaWZ0KQorICAgIC0gVGhlIGRlZmF1bHQgdmFsdWUgaXMgUEFHRV9TSElGVC4KIAogTGludXgg
aW1wbGVtZW50YXRpb24gbm90ZToKIC0gSWYgYSAibGludXgsY21hLWRlZmF1bHQiIHByb3BlcnR5
IGlzIHByZXNlbnQsIHRoZW4gTGludXggd2lsbCB1c2UgdGhlCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Jhc2UvZG1hLWNvaGVyZW50LmMgYi9kcml2ZXJzL2Jhc2UvZG1hLWNvaGVyZW50LmMKaW5kZXgg
NjQwYTdlNjNjNDUzLi5mOTNhZWU4MWE1YWMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYmFzZS9kbWEt
Y29oZXJlbnQuYworKysgYi9kcml2ZXJzL2Jhc2UvZG1hLWNvaGVyZW50LmMKQEAgLTE0LDE4ICsx
NCwxOSBAQCBzdHJ1Y3QgZG1hX2NvaGVyZW50X21lbSB7CiAJdW5zaWduZWQgbG9uZwlwZm5fYmFz
ZTsKIAlpbnQJCXNpemU7CiAJaW50CQlmbGFnczsKKwlpbnQJCWFsaWduX3NoaWZ0OwogCXVuc2ln
bmVkIGxvbmcJKmJpdG1hcDsKIAlzcGlubG9ja190CXNwaW5sb2NrOwogfTsKIAogc3RhdGljIGJv
b2wgZG1hX2luaXRfY29oZXJlbnRfbWVtb3J5KAogCXBoeXNfYWRkcl90IHBoeXNfYWRkciwgZG1h
X2FkZHJfdCBkZXZpY2VfYWRkciwgc2l6ZV90IHNpemUsIGludCBmbGFncywKLQlzdHJ1Y3QgZG1h
X2NvaGVyZW50X21lbSAqKm1lbSkKKwlpbnQgYWxpZ25fc2hpZnQsIHN0cnVjdCBkbWFfY29oZXJl
bnRfbWVtICoqbWVtKQogewogCXN0cnVjdCBkbWFfY29oZXJlbnRfbWVtICpkbWFfbWVtID0gTlVM
TDsKIAl2b2lkIF9faW9tZW0gKm1lbV9iYXNlID0gTlVMTDsKLQlpbnQgcGFnZXMgPSBzaXplID4+
IFBBR0VfU0hJRlQ7Ci0JaW50IGJpdG1hcF9zaXplID0gQklUU19UT19MT05HUyhwYWdlcykgKiBz
aXplb2YobG9uZyk7CisJaW50IG5iaXRzID0gc2l6ZSA+PiBhbGlnbl9zaGlmdDsKKwlpbnQgYml0
bWFwX3NpemUgPSBCSVRTX1RPX0xPTkdTKG5iaXRzKSAqIHNpemVvZihsb25nKTsKIAogCWlmICgo
ZmxhZ3MgJiAoRE1BX01FTU9SWV9NQVAgfCBETUFfTUVNT1JZX0lPKSkgPT0gMCkKIAkJZ290byBv
dXQ7CkBAIC00OSw4ICs1MCw5IEBAIHN0YXRpYyBib29sIGRtYV9pbml0X2NvaGVyZW50X21lbW9y
eSgKIAlkbWFfbWVtLT52aXJ0X2Jhc2UgPSBtZW1fYmFzZTsKIAlkbWFfbWVtLT5kZXZpY2VfYmFz
ZSA9IGRldmljZV9hZGRyOwogCWRtYV9tZW0tPnBmbl9iYXNlID0gUEZOX0RPV04ocGh5c19hZGRy
KTsKLQlkbWFfbWVtLT5zaXplID0gcGFnZXM7CisJZG1hX21lbS0+c2l6ZSA9IG5iaXRzOwogCWRt
YV9tZW0tPmZsYWdzID0gZmxhZ3M7CisJZG1hX21lbS0+YWxpZ25fc2hpZnQgPSBhbGlnbl9zaGlm
dDsKIAlzcGluX2xvY2tfaW5pdCgmZG1hX21lbS0+c3BpbmxvY2spOwogCiAJKm1lbSA9IGRtYV9t
ZW07CkBAIC05OCw3ICsxMDAsNyBAQCBpbnQgZG1hX2RlY2xhcmVfY29oZXJlbnRfbWVtb3J5KHN0
cnVjdCBkZXZpY2UgKmRldiwgcGh5c19hZGRyX3QgcGh5c19hZGRyLAogCXN0cnVjdCBkbWFfY29o
ZXJlbnRfbWVtICptZW07CiAKIAlpZiAoIWRtYV9pbml0X2NvaGVyZW50X21lbW9yeShwaHlzX2Fk
ZHIsIGRldmljZV9hZGRyLCBzaXplLCBmbGFncywKLQkJCQkgICAgICAmbWVtKSkKKwkJCQkgICAg
ICBQQUdFX1NISUZULCAmbWVtKSkKIAkJcmV0dXJuIDA7CiAKIAlpZiAoZG1hX2Fzc2lnbl9jb2hl
cmVudF9tZW1vcnkoZGV2LCBtZW0pID09IDApCkBAIC0xMjUsMjEgKzEyNywyNSBAQCB2b2lkICpk
bWFfbWFya19kZWNsYXJlZF9tZW1vcnlfb2NjdXBpZWQoc3RydWN0IGRldmljZSAqZGV2LAogewog
CXN0cnVjdCBkbWFfY29oZXJlbnRfbWVtICptZW0gPSBkZXYtPmRtYV9tZW07CiAJdW5zaWduZWQg
bG9uZyBmbGFnczsKLQlpbnQgcG9zLCBlcnI7CisJaW50IHBvcywgbmJpdHMsIGVycjsKIAotCXNp
emUgKz0gZGV2aWNlX2FkZHIgJiB+UEFHRV9NQVNLOworCXNpemUgKz0gZGV2aWNlX2FkZHIgJiAo
KDEgPDwgbWVtLT5hbGlnbl9zaGlmdCkgLSAxKTsKIAogCWlmICghbWVtKQogCQlyZXR1cm4gRVJS
X1BUUigtRUlOVkFMKTsKIAogCXNwaW5fbG9ja19pcnFzYXZlKCZtZW0tPnNwaW5sb2NrLCBmbGFn
cyk7Ci0JcG9zID0gKGRldmljZV9hZGRyIC0gbWVtLT5kZXZpY2VfYmFzZSkgPj4gUEFHRV9TSElG
VDsKLQllcnIgPSBiaXRtYXBfYWxsb2NhdGVfcmVnaW9uKG1lbS0+Yml0bWFwLCBwb3MsIGdldF9v
cmRlcihzaXplKSk7CisJcG9zID0gKGRldmljZV9hZGRyIC0gbWVtLT5kZXZpY2VfYmFzZSkgPj4g
bWVtLT5hbGlnbl9zaGlmdDsKKwluYml0cyA9IChzaXplICsgKDEgPDwgbWVtLT5hbGlnbl9zaGlm
dCkgLSAxKSA+PiBtZW0tPmFsaWduX3NoaWZ0OworCWlmIChwb3MgPT0gYml0bWFwX2ZpbmRfbmV4
dF96ZXJvX2FyZWEobWVtLT5iaXRtYXAsIG1lbS0+c2l6ZSwgcG9zLCBuYml0cywgMCkpCisJCWJp
dG1hcF9zZXQobWVtLT5iaXRtYXAsIHBvcywgbmJpdHMpOworCWVsc2UKKwkJZXJyID0gLUVCVVNZ
OwogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm1lbS0+c3BpbmxvY2ssIGZsYWdzKTsKIAogCWlm
IChlcnIgIT0gMCkKIAkJcmV0dXJuIEVSUl9QVFIoZXJyKTsKLQlyZXR1cm4gbWVtLT52aXJ0X2Jh
c2UgKyAocG9zIDw8IFBBR0VfU0hJRlQpOworCXJldHVybiBtZW0tPnZpcnRfYmFzZSArIChwb3Mg
PDwgbWVtLT5hbGlnbl9zaGlmdCk7CiB9CiBFWFBPUlRfU1lNQk9MKGRtYV9tYXJrX2RlY2xhcmVk
X21lbW9yeV9vY2N1cGllZCk7CiAKQEAgLTE2Miw5ICsxNjgsOSBAQCBpbnQgZG1hX2FsbG9jX2Zy
b21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzc2l6ZV90IHNpemUsCiAJCQkJICAgICAg
IGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsIHZvaWQgKipyZXQpCiB7CiAJc3RydWN0IGRtYV9jb2hl
cmVudF9tZW0gKm1lbTsKLQlpbnQgb3JkZXIgPSBnZXRfb3JkZXIoc2l6ZSk7CisJaW50IG5iaXRz
OwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Ci0JaW50IHBhZ2VubzsKKwlpbnQgYml0bm87CiAJaW50
IGRtYV9tZW1vcnlfbWFwOwogCiAJaWYgKCFkZXYpCkBAIC0xNzYsMTggKzE4MiwyMCBAQCBpbnQg
ZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzc2l6ZV90IHNpemUs
CiAJKnJldCA9IE5VTEw7CiAJc3Bpbl9sb2NrX2lycXNhdmUoJm1lbS0+c3BpbmxvY2ssIGZsYWdz
KTsKIAotCWlmICh1bmxpa2VseShzaXplID4gKG1lbS0+c2l6ZSA8PCBQQUdFX1NISUZUKSkpCisJ
aWYgKHVubGlrZWx5KHNpemUgPiAobWVtLT5zaXplIDw8IG1lbS0+YWxpZ25fc2hpZnQpKSkKIAkJ
Z290byBlcnI7CiAKLQlwYWdlbm8gPSBiaXRtYXBfZmluZF9mcmVlX3JlZ2lvbihtZW0tPmJpdG1h
cCwgbWVtLT5zaXplLCBvcmRlcik7Ci0JaWYgKHVubGlrZWx5KHBhZ2VubyA8IDApKQorCW5iaXRz
ID0gKHNpemUgKyAoMSA8PCBtZW0tPmFsaWduX3NoaWZ0KSAtIDEpID4+IG1lbS0+YWxpZ25fc2hp
ZnQ7CisJYml0bm8gPSBiaXRtYXBfZmluZF9uZXh0X3plcm9fYXJlYShtZW0tPmJpdG1hcCwgbWVt
LT5zaXplLCAwLCBuYml0cywgMCk7CisJaWYgKHVubGlrZWx5KGJpdG5vID49IG1lbS0+c2l6ZSkp
CiAJCWdvdG8gZXJyOworCWJpdG1hcF9zZXQobWVtLT5iaXRtYXAsIGJpdG5vLCBuYml0cyk7CiAK
IAkvKgogCSAqIE1lbW9yeSB3YXMgZm91bmQgaW4gdGhlIHBlci1kZXZpY2UgYXJlYS4KIAkgKi8K
LQkqZG1hX2hhbmRsZSA9IG1lbS0+ZGV2aWNlX2Jhc2UgKyAocGFnZW5vIDw8IFBBR0VfU0hJRlQp
OwotCSpyZXQgPSBtZW0tPnZpcnRfYmFzZSArIChwYWdlbm8gPDwgUEFHRV9TSElGVCk7CisJKmRt
YV9oYW5kbGUgPSBtZW0tPmRldmljZV9iYXNlICsgKGJpdG5vIDw8IG1lbS0+YWxpZ25fc2hpZnQp
OworCSpyZXQgPSBtZW0tPnZpcnRfYmFzZSArIChiaXRubyA8PCBtZW0tPmFsaWduX3NoaWZ0KTsK
IAlkbWFfbWVtb3J5X21hcCA9IChtZW0tPmZsYWdzICYgRE1BX01FTU9SWV9NQVApOwogCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJm1lbS0+c3BpbmxvY2ssIGZsYWdzKTsKIAlpZiAoZG1hX21lbW9y
eV9tYXApCkBAIC0yMTEsNyArMjE5LDcgQEAgRVhQT1JUX1NZTUJPTChkbWFfYWxsb2NfZnJvbV9j
b2hlcmVudCk7CiAvKioKICAqIGRtYV9yZWxlYXNlX2Zyb21fY29oZXJlbnQoKSAtIHRyeSB0byBm
cmVlIHRoZSBtZW1vcnkgYWxsb2NhdGVkIGZyb20gcGVyLWRldmljZSBjb2hlcmVudCBtZW1vcnkg
cG9vbAogICogQGRldjoJZGV2aWNlIGZyb20gd2hpY2ggdGhlIG1lbW9yeSB3YXMgYWxsb2NhdGVk
Ci0gKiBAb3JkZXI6CXRoZSBvcmRlciBvZiBwYWdlcyBhbGxvY2F0ZWQKKyAqIEBzaXplOgl0aGUg
c2l6ZSBvZiBhbGxvY2F0ZWQgbWVtb3J5CiAgKiBAdmFkZHI6CXZpcnR1YWwgYWRkcmVzcyBvZiBh
bGxvY2F0ZWQgcGFnZXMKICAqCiAgKiBUaGlzIGNoZWNrcyB3aGV0aGVyIHRoZSBtZW1vcnkgd2Fz
IGFsbG9jYXRlZCBmcm9tIHRoZSBwZXItZGV2aWNlCkBAIC0yMjEsMTcgKzIyOSwxOCBAQCBFWFBP
UlRfU1lNQk9MKGRtYV9hbGxvY19mcm9tX2NvaGVyZW50KTsKICAqIGRtYV9yZWxlYXNlX2NvaGVy
ZW50KCkgc2hvdWxkIHByb2NlZWQgd2l0aCByZWxlYXNpbmcgbWVtb3J5IGZyb20KICAqIGdlbmVy
aWMgcG9vbHMuCiAgKi8KLWludCBkbWFfcmVsZWFzZV9mcm9tX2NvaGVyZW50KHN0cnVjdCBkZXZp
Y2UgKmRldiwgaW50IG9yZGVyLCB2b2lkICp2YWRkcikKK2ludCBkbWFfcmVsZWFzZV9mcm9tX2Nv
aGVyZW50KHN0cnVjdCBkZXZpY2UgKmRldiwgaW50IHNpemUsIHZvaWQgKnZhZGRyKQogewogCXN0
cnVjdCBkbWFfY29oZXJlbnRfbWVtICptZW0gPSBkZXYgPyBkZXYtPmRtYV9tZW0gOiBOVUxMOwog
CiAJaWYgKG1lbSAmJiB2YWRkciA+PSBtZW0tPnZpcnRfYmFzZSAmJiB2YWRkciA8Ci0JCSAgICht
ZW0tPnZpcnRfYmFzZSArIChtZW0tPnNpemUgPDwgUEFHRV9TSElGVCkpKSB7Ci0JCWludCBwYWdl
ID0gKHZhZGRyIC0gbWVtLT52aXJ0X2Jhc2UpID4+IFBBR0VfU0hJRlQ7CisJCSAgIChtZW0tPnZp
cnRfYmFzZSArIChtZW0tPnNpemUgPDwgbWVtLT5hbGlnbl9zaGlmdCkpKSB7CisJCWludCBiaXRu
byA9ICh2YWRkciAtIG1lbS0+dmlydF9iYXNlKSA+PiBtZW0tPmFsaWduX3NoaWZ0OworCQlpbnQg
bmJpdHMgPSAoc2l6ZSArICgxIDw8IG1lbS0+YWxpZ25fc2hpZnQpIC0gMSkgPj4gbWVtLT5hbGln
bl9zaGlmdDsKIAkJdW5zaWduZWQgbG9uZyBmbGFnczsKIAogCQlzcGluX2xvY2tfaXJxc2F2ZSgm
bWVtLT5zcGlubG9jaywgZmxhZ3MpOwotCQliaXRtYXBfcmVsZWFzZV9yZWdpb24obWVtLT5iaXRt
YXAsIHBhZ2UsIG9yZGVyKTsKKwkJYml0bWFwX2NsZWFyKG1lbS0+Yml0bWFwLCBiaXRubywgbmJp
dHMpOwogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtZW0tPnNwaW5sb2NrLCBmbGFncyk7CiAJ
CXJldHVybiAxOwogCX0KQEAgLTI2MCw3ICsyNjksNyBAQCBpbnQgZG1hX21tYXBfZnJvbV9jb2hl
cmVudChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLAogCXN0
cnVjdCBkbWFfY29oZXJlbnRfbWVtICptZW0gPSBkZXYgPyBkZXYtPmRtYV9tZW0gOiBOVUxMOwog
CiAJaWYgKG1lbSAmJiB2YWRkciA+PSBtZW0tPnZpcnRfYmFzZSAmJiB2YWRkciArIHNpemUgPD0K
LQkJICAgKG1lbS0+dmlydF9iYXNlICsgKG1lbS0+c2l6ZSA8PCBQQUdFX1NISUZUKSkpIHsKKwkJ
ICAgKG1lbS0+dmlydF9iYXNlICsgKG1lbS0+c2l6ZSA8PCBtZW0tPmFsaWduX3NoaWZ0KSkpIHsK
IAkJdW5zaWduZWQgbG9uZyBvZmYgPSB2bWEtPnZtX3Bnb2ZmOwogCQlpbnQgc3RhcnQgPSAodmFk
ZHIgLSBtZW0tPnZpcnRfYmFzZSkgPj4gUEFHRV9TSElGVDsKIAkJaW50IHVzZXJfY291bnQgPSB2
bWFfcGFnZXModm1hKTsKQEAgLTI5MCwxMyArMjk5LDIyIEBAIEVYUE9SVF9TWU1CT0woZG1hX21t
YXBfZnJvbV9jb2hlcmVudCk7CiBzdGF0aWMgaW50IHJtZW1fZG1hX2RldmljZV9pbml0KHN0cnVj
dCByZXNlcnZlZF9tZW0gKnJtZW0sIHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlzdHJ1Y3QgZG1h
X2NvaGVyZW50X21lbSAqbWVtID0gcm1lbS0+cHJpdjsKKwljb25zdCBfX2JlMzIgKnByb3A7CisJ
aW50IGFsaWduX3NoaWZ0OworCWludCBsZW47CisKKwlwcm9wID0gb2ZfZ2V0X2ZsYXRfZHRfcHJv
cChybWVtLT5mZHRfbm9kZSwgImFsaWduLXNoaWZ0IiwgJmxlbik7CisJaWYgKHByb3AgJiYgbGVu
ID49IDQpCisJCWFsaWduX3NoaWZ0ID0gb2ZfcmVhZF9udW1iZXIocHJvcCwgbGVuIC8gNCk7CisJ
ZWxzZQorCQlhbGlnbl9zaGlmdCA9IFBBR0VfU0hJRlQ7CiAKIAlpZiAoIW1lbSAmJgogCSAgICAh
ZG1hX2luaXRfY29oZXJlbnRfbWVtb3J5KHJtZW0tPmJhc2UsIHJtZW0tPmJhc2UsIHJtZW0tPnNp
emUsCiAJCQkJICAgICAgRE1BX01FTU9SWV9NQVAgfCBETUFfTUVNT1JZX0VYQ0xVU0lWRSwKLQkJ
CQkgICAgICAmbWVtKSkgewotCQlwcl9lcnIoIlJlc2VydmVkIG1lbW9yeTogZmFpbGVkIHRvIGlu
aXQgRE1BIG1lbW9yeSBwb29sIGF0ICVwYSwgc2l6ZSAlbGQgTWlCXG4iLAotCQkJJnJtZW0tPmJh
c2UsICh1bnNpZ25lZCBsb25nKXJtZW0tPnNpemUgLyBTWl8xTSk7CisJCQkJICAgICAgYWxpZ25f
c2hpZnQsICZtZW0pKSB7CisJCXByX2VycigiUmVzZXJ2ZWQgbWVtb3J5OiBmYWlsZWQgdG8gaW5p
dCBETUEgbWVtb3J5IHBvb2wgYXQgJXBhLCBzaXplICVsZCBLaUJcbiIsCisJCQkmcm1lbS0+YmFz
ZSwgKHVuc2lnbmVkIGxvbmcpcm1lbS0+c2l6ZSAvIFNaXzFLKTsKIAkJcmV0dXJuIC1FTk9ERVY7
CiAJfQogCXJtZW0tPnByaXYgPSBtZW07CkBAIC0zMzAsOCArMzQ4LDggQEAgc3RhdGljIGludCBf
X2luaXQgcm1lbV9kbWFfc2V0dXAoc3RydWN0IHJlc2VydmVkX21lbSAqcm1lbSkKICNlbmRpZgog
CiAJcm1lbS0+b3BzID0gJnJtZW1fZG1hX29wczsKLQlwcl9pbmZvKCJSZXNlcnZlZCBtZW1vcnk6
IGNyZWF0ZWQgRE1BIG1lbW9yeSBwb29sIGF0ICVwYSwgc2l6ZSAlbGQgTWlCXG4iLAotCQkmcm1l
bS0+YmFzZSwgKHVuc2lnbmVkIGxvbmcpcm1lbS0+c2l6ZSAvIFNaXzFNKTsKKwlwcl9pbmZvKCJS
ZXNlcnZlZCBtZW1vcnk6IGNyZWF0ZWQgRE1BIG1lbW9yeSBwb29sIGF0ICVwYSwgc2l6ZSAlbGQg
S2lCXG4iLAorCQkmcm1lbS0+YmFzZSwgKHVuc2lnbmVkIGxvbmcpcm1lbS0+c2l6ZSAvIFNaXzFL
KTsKIAlyZXR1cm4gMDsKIH0KIFJFU0VSVkVETUVNX09GX0RFQ0xBUkUoZG1hLCAic2hhcmVkLWRt
YS1wb29sIiwgcm1lbV9kbWFfc2V0dXApOwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9kbWEt
bWFwcGluZy5oIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCmluZGV4IDA4NTI4YWZkZjU4
Yi4uOGQ5ZmQ3YjAxZGJiIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1tYXBwaW5nLmgK
KysrIGIvaW5jbHVkZS9saW51eC9kbWEtbWFwcGluZy5oCkBAIC0xNTIsMTMgKzE1MiwxMyBAQCBz
dGF0aWMgaW5saW5lIGludCBpc19kZXZpY2VfZG1hX2NhcGFibGUoc3RydWN0IGRldmljZSAqZGV2
KQogICovCiBpbnQgZG1hX2FsbG9jX2Zyb21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBz
c2l6ZV90IHNpemUsCiAJCQkJICAgICAgIGRtYV9hZGRyX3QgKmRtYV9oYW5kbGUsIHZvaWQgKipy
ZXQpOwotaW50IGRtYV9yZWxlYXNlX2Zyb21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBp
bnQgb3JkZXIsIHZvaWQgKnZhZGRyKTsKK2ludCBkbWFfcmVsZWFzZV9mcm9tX2NvaGVyZW50KHN0
cnVjdCBkZXZpY2UgKmRldiwgaW50IHNpemUsIHZvaWQgKnZhZGRyKTsKIAogaW50IGRtYV9tbWFw
X2Zyb21fY29oZXJlbnQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3Qg
KnZtYSwKIAkJCSAgICB2b2lkICpjcHVfYWRkciwgc2l6ZV90IHNpemUsIGludCAqcmV0KTsKICNl
bHNlCiAjZGVmaW5lIGRtYV9hbGxvY19mcm9tX2NvaGVyZW50KGRldiwgc2l6ZSwgaGFuZGxlLCBy
ZXQpICgwKQotI2RlZmluZSBkbWFfcmVsZWFzZV9mcm9tX2NvaGVyZW50KGRldiwgb3JkZXIsIHZh
ZGRyKSAoMCkKKyNkZWZpbmUgZG1hX3JlbGVhc2VfZnJvbV9jb2hlcmVudChkZXYsIHNpemUsIHZh
ZGRyKSAoMCkKICNkZWZpbmUgZG1hX21tYXBfZnJvbV9jb2hlcmVudChkZXYsIHZtYSwgdmFkZHIs
IG9yZGVyLCByZXQpICgwKQogI2VuZGlmIC8qIENPTkZJR19IQVZFX0dFTkVSSUNfRE1BX0NPSEVS
RU5UICovCiAKQEAgLTQ3OCw3ICs0NzgsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgZG1hX2ZyZWVf
YXR0cnMoc3RydWN0IGRldmljZSAqZGV2LCBzaXplX3Qgc2l6ZSwKIAlCVUdfT04oIW9wcyk7CiAJ
V0FSTl9PTihpcnFzX2Rpc2FibGVkKCkpOwogCi0JaWYgKGRtYV9yZWxlYXNlX2Zyb21fY29oZXJl
bnQoZGV2LCBnZXRfb3JkZXIoc2l6ZSksIGNwdV9hZGRyKSkKKwlpZiAoZG1hX3JlbGVhc2VfZnJv
bV9jb2hlcmVudChkZXYsIHNpemUsIGNwdV9hZGRyKSkKIAkJcmV0dXJuOwogCiAJaWYgKCFvcHMt
PmZyZWUgfHwgIWNwdV9hZGRyKQotLSAKMi4xNi4yCgo=
--000000000000af8326058873b743--
