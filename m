Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F320684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9/FAKn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfCFXtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:49:14 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36192 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:49:13 -0500
Received: by mail-io1-f67.google.com with SMTP id r136so11831388iod.3;
        Wed, 06 Mar 2019 15:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ZJxg0re0sQe/Au75y8ZSXg+6UbrYcDQ07qRUdbYQWs=;
        b=q9/FAKn2N6SBXZKLgsIVsvtBnynSj05oulvGX9a4ZWCJqP+4P6EUxnUpRdpUeYIwTY
         BiOQMebIjg4bTiohF2VH9m6fxLOGQrpov8XdUGNw64bQTIRDVdksvPKigSjK5q+YDQrE
         LJELV5eXSSSvSg79fwI+wWPjh38BpDaffZkl9BOrfeCkTtFIF4Pq7IlIP5o0oJaQBj0f
         7UMU/69D1PRYi9Pp+0jlc/3KCuh/0YLsDsq5o4t54HdJV6vW5q3NToJsme0W4NP0ApXs
         tP0wHl377H+Vc5K1KVUNhn1c48q5L0JC+do/Vu/Hkk090xxGO+miobgUYA/ExKiZAtH1
         TTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ZJxg0re0sQe/Au75y8ZSXg+6UbrYcDQ07qRUdbYQWs=;
        b=Dv2xRY53j9Fe7KtvsacAKZs7QDmjTfYcl5viF0zNhflj3VD1JLvexT03sOtMgefF7u
         7jE4/ZvU6j762AqB4E2NbNWr4Pep54vgC0ReB6qjTYAdIdkMeB5AoMF1CcRPWRLEF8Bx
         nrr5xaTEzUtxjSB4rezNz9Ek/9u9O8oUmGlc/xQsPKZfycWvHwp2eoupHWx28MAIZxTr
         yRpURSAOUvfDPOeIeOSV5NNS9wZhOvQoAKNrn+SN7BXWrCYHAH3gWvJZCDt3hCEwRkbZ
         nN4xohDKUkLS1D4MiM7fCDRWDcU34vUcOst2qY3jOQ1dFqNidczecHpG/K2pExslt1v/
         QVaA==
X-Gm-Message-State: APjAAAUm+jby7gsVk7AjOneW5JlqUu/2jG/QS3YBzkTD6mYERYud7M+u
        WXN+7+y2CA/j3eOw2QkVZaOD+iuU5K31qICIPms=
X-Google-Smtp-Source: APXvYqzTEMW5j0VJ9hw7N6CzbqIujjtpRLTHaUnyhREmr/np/u/5qwoRZ7Q9MPL4Ss/Lh8YbvsOezHJYuviPIK1Leck=
X-Received: by 2002:a6b:e219:: with SMTP id z25mr4592197ioc.116.1551916152354;
 Wed, 06 Mar 2019 15:49:12 -0800 (PST)
MIME-Version: 1.0
References: <20190306155048.12868-1-nitesh@redhat.com> <20190306155220.12944-1-nitesh@redhat.com>
In-Reply-To: <20190306155220.12944-1-nitesh@redhat.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Mar 2019 15:49:01 -0800
Message-ID: <CAKgT0Ue=kGB4D2oV1WUmWHiYhrXa64KWBP2ZhLgHNgvWyOng5A@mail.gmail.com>
Subject: Re: [RFC][QEMU Patch] KVM: Enable QEMU to free the pages hinted by
 the guest
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:52 AM Nitesh Narayan Lal <nitesh@redhat.com> wrote:
>
> This patch enables QEMU to perform MADVISE_DONTNEED on the pages
> reported by the guest.
>
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  hw/virtio/trace-events                        |  1 +
>  hw/virtio/virtio-balloon.c                    | 90 +++++++++++++++++++
>  include/hw/virtio/virtio-balloon.h            |  2 +-
>  .../standard-headers/linux/virtio_balloon.h   |  1 +
>  4 files changed, 93 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 07bcbe9e85..e3ab66f126 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -46,3 +46,4 @@ virtio_balloon_handle_output(const char *name, uint64_t gpa) "section name: %s g
>  virtio_balloon_get_config(uint32_t num_pages, uint32_t actual) "num_pages: %d actual: %d"
>  virtio_balloon_set_config(uint32_t actual, uint32_t oldactual) "actual: %d oldactual: %d"
>  virtio_balloon_to_target(uint64_t target, uint32_t num_pages) "balloon target: 0x%"PRIx64" num_pages: %d"
> +virtio_balloon_hinting_request(unsigned long pfn, unsigned int num_pages) "Guest page hinting request: %lu num_pages: %d"
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a12677d4d5..7ab1471017 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -33,6 +33,13 @@
>
>  #define BALLOON_PAGE_SIZE  (1 << VIRTIO_BALLOON_PFN_SHIFT)
>
> +struct guest_pages {
> +       unsigned long pfn;
> +       unsigned int order;
> +};
> +
> +void page_hinting_request(uint64_t addr, uint32_t len);
> +
>  static void balloon_page(void *addr, int deflate)
>  {
>      if (!qemu_balloon_is_inhibited()) {
> @@ -207,6 +214,85 @@ static void balloon_stats_set_poll_interval(Object *obj, Visitor *v,
>      balloon_stats_change_timer(s, 0);
>  }
>
> +static void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, Error **errp)
> +{
> +    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
> +                                                 addr, 1);
> +
> +    if (!mrs.mr) {
> +        error_setg(errp, "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
> +        return NULL;
> +    }
> +
> +    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
> +        error_setg(errp, "Memory at address 0x%" HWADDR_PRIx "is not RAM", addr);
> +        memory_region_unref(mrs.mr);
> +        return NULL;
> +    }
> +
> +    *p_mr = mrs.mr;
> +    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
> +}
> +
> +void page_hinting_request(uint64_t addr, uint32_t len)
> +{
> +    Error *local_err = NULL;
> +    MemoryRegion *mr = NULL;
> +    int ret = 0;
> +    struct guest_pages *guest_obj;
> +    int i = 0;
> +    void *hvaddr_to_free;
> +    unsigned long pfn, pfn_end;
> +    uint64_t gpaddr_to_free;
> +    void * temp_addr = gpa2hva(&mr, addr, &local_err);
> +
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return;
> +    }
> +    guest_obj = temp_addr;
> +    while (i < len) {
> +        pfn = guest_obj[i].pfn;
> +       pfn_end = guest_obj[i].pfn + (1 << guest_obj[i].order) - 1;
> +       trace_virtio_balloon_hinting_request(pfn,(1 << guest_obj[i].order));
> +       while (pfn <= pfn_end) {
> +               gpaddr_to_free = pfn << VIRTIO_BALLOON_PFN_SHIFT;
> +               hvaddr_to_free = gpa2hva(&mr, gpaddr_to_free, &local_err);
> +               if (local_err) {
> +                       error_report_err(local_err);
> +                       return;
> +               }
> +               ret = qemu_madvise((void *)hvaddr_to_free, 4096, QEMU_MADV_DONTNEED);

So the structure of this function is going to cause significant
performance issues. Because we are freeing the memory 4K at a time we
are kicking the pages out of using THP and as a result each page fault
will occur on a 4K boundary instead of a THP boundary.

As a result I am seeing the first pass of memhog take around 35s, but
the second pass takes 57s or so because we are no longer faulting in
THP pages and instead having to fault in 4K pages.

We should be trying to madvise the lesser of either PAGE_SIZE <<
guest_obj[i[.order or the size of the memory region minus our offset.

> +               if (ret == -1)
> +                   printf("\n%d:%s Error: Madvise failed with error:%d\n", __LINE__, __func__, ret);
> +               pfn++;
> +       }
> +       i++;
> +    }
> +}
> +
> +static void virtio_balloon_page_hinting(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtQueueElement *elem = NULL;
> +    uint64_t temp_addr;
> +    uint32_t temp_len;
> +    size_t size, t_size = 0;
> +
> +    elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +    if (!elem) {
> +       printf("\npop error\n");
> +       return;
> +    }
> +    size = iov_to_buf(elem->out_sg, elem->out_num, 0, &temp_addr, sizeof(temp_addr));
> +    t_size += size;
> +    size = iov_to_buf(elem->out_sg, elem->out_num, 8, &temp_len, sizeof(temp_len));
> +    t_size += size;
> +    page_hinting_request(temp_addr, temp_len);
> +    virtqueue_push(vq, elem, t_size);
> +    virtio_notify(vdev, vq);
> +    g_free(elem);
> +}
> +
>  static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOBalloon *s = VIRTIO_BALLOON(vdev);
> @@ -376,6 +462,7 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
>      VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
>      f |= dev->host_features;
>      virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
> +    virtio_add_feature(&f, VIRTIO_BALLOON_F_HINTING);
>      return f;
>  }
>
> @@ -445,6 +532,7 @@ static void virtio_balloon_device_realize(DeviceState *dev, Error **errp)
>      s->ivq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->dvq = virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>      s->svq = virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
> +    s->hvq = virtio_add_queue(vdev, 128, virtio_balloon_page_hinting);
>
>      reset_stats(s);
>  }
> @@ -488,6 +576,8 @@ static void virtio_balloon_instance_init(Object *obj)
>
>      object_property_add(obj, "guest-stats", "guest statistics",
>                          balloon_stats_get_all, NULL, NULL, s, NULL);
> +    object_property_add(obj, "guest-page-hinting", "guest page hinting",
> +                        NULL, NULL, NULL, s, NULL);
>
>      object_property_add(obj, "guest-stats-polling-interval", "int",
>                          balloon_stats_get_poll_interval,
> diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
> index e0df3528c8..774498a6ca 100644
> --- a/include/hw/virtio/virtio-balloon.h
> +++ b/include/hw/virtio/virtio-balloon.h
> @@ -32,7 +32,7 @@ typedef struct virtio_balloon_stat_modern {
>
>  typedef struct VirtIOBalloon {
>      VirtIODevice parent_obj;
> -    VirtQueue *ivq, *dvq, *svq;
> +    VirtQueue *ivq, *dvq, *svq, *hvq;
>      uint32_t num_pages;
>      uint32_t actual;
>      uint64_t stats[VIRTIO_BALLOON_S_NR];
> diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> index 4dbb7dc6c0..f50c0d95ea 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -34,6 +34,7 @@
>  #define VIRTIO_BALLOON_F_MUST_TELL_HOST        0 /* Tell before reclaiming pages */
>  #define VIRTIO_BALLOON_F_STATS_VQ      1 /* Memory Stats virtqueue */
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM        2 /* Deflate balloon on OOM */
> +#define VIRTIO_BALLOON_F_HINTING       5 /* Page hinting virtqueue */
>
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> --
> 2.17.2
>
