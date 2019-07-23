Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E8FC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0A5A21BF6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 01:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKvHGdEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387804AbfGWBgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 21:36:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42695 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfGWBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 21:36:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so26305004wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 18:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqJBKEyiTQLza/dKE/jBWzlzCo+YWJoWOovBmgVapuA=;
        b=dKvHGdEr/VfICzXaqDVkUjCyPqL42LEd2tw44nKHE5oZIX4bG1VTRfscVEjEfCfeX1
         2oaWNpEi9hT6DEUtk9ziN3TUTtO+70wGG6ZNrdnBG6YVMk+NowMsBMct7W41G1klIUCx
         0rkdiMIf+/pEbnUFYjgOOS9DJ8V30/6BPwjWCANgs6yQGLvPRiCqusIxW6yiHZFqLp8L
         u+A0NjAfdI9Lhal9nQlnNY7ouf7PGfVmRy//nk6i9QL3sJ3HH9bfQq4TBCuGU8ODe6RP
         cg0ZR5LUbN4fChPkxs8VdzF9B1Gci/v7ifunvAJAEnjKOhJu7t84cNnhL1ljBfVwAQfl
         WFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqJBKEyiTQLza/dKE/jBWzlzCo+YWJoWOovBmgVapuA=;
        b=nsDLdVUknBoAMNjejST2DUsYrZl9mD01CUG68DiJX9JJIHOLqQlTpA/Td7jvfM3Q5y
         jUUMlr5PS1MiUNCSTzdN86u+uqzicFfp3AH234L0tAppfYlVs5r5JiQd9obvSmwU92mO
         c75JAqoReRt6iZDxwCEmacFE9RtG7yY9+piwmWZcel5fql+VqWBGCI4NN5pnb245UCLw
         pKj3t65SeSdi5euRw63d7flx6Hm88mqAxBtAoVF3vk+fLR6N+w3mNA245ZQxZlv9LPCY
         EBqoIxFA7ydjxG2Dq1SN7ba0x2ydGwFP5rxGlnxLsEw9eqnOhjNGmJ/wtiMZJ1dvyc0p
         gEZw==
X-Gm-Message-State: APjAAAWbm9kZI1tVUya/cYMLjUUfri7WueWkMDs34MZlh/6nnO4DZHCa
        C6mhwbybpcoj5SEAlggciZevCrexSmrSm1/SQFtPZr48l/o=
X-Google-Smtp-Source: APXvYqwDKsuNKOsJeto6cfq6QAtW2vLxbHNgQxCwn3shaAfCYUMZkgnlnRzOcqynsuiPPyN2uiKKAjw7xBYS6HbOyvs=
X-Received: by 2002:adf:f088:: with SMTP id n8mr33442310wro.58.1563845812804;
 Mon, 22 Jul 2019 18:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
In-Reply-To: <b1f9bdf0294b8d87d292de3c7462c8e99551b02d.camel@kernel.crashing.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 23 Jul 2019 09:36:40 +0800
Message-ID: <CACVXFVPbrXaAQe2C+13dNQSSL7f7gZ4QZ=W9vMpmmhJnxQMjew@mail.gmail.com>
Subject: Re: [PATCH v3] nvme-pci: Support shared tags across queues for Apple
 2018 controllers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-nvme <linux-nvme@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Pawlowski <paul@mrarm.io>, Jens Axboe <axboe@fb.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 1:31 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> From 8dcba2ef5b1466b023b88b4eca463b30de78d9eb Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Fri, 19 Jul 2019 15:03:06 +1000
> Subject:
>
> Another issue with the Apple T2 based 2018 controllers seem to be
> that they blow up (and shut the machine down) if there's a tag
> collision between the IO queue and the Admin queue.
>
> My suspicion is that they use our tags for their internal tracking
> and don't mix them with the queue id. They also seem to not like
> when tags go beyond the IO queue depth, ie 128 tags.
>
> This adds a quirk that marks tags 0..31 of the IO queue reserved
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Thanks Damien, reserved tags work and make this a lot simpler !
>
>  drivers/nvme/host/nvme.h |  5 +++++
>  drivers/nvme/host/pci.c  | 19 ++++++++++++++++++-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index ced0e0a7e039..8732da6df555 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -102,6 +102,11 @@ enum nvme_quirks {
>          * Use non-standard 128 bytes SQEs.
>          */
>         NVME_QUIRK_128_BYTES_SQES               = (1 << 11),
> +
> +       /*
> +        * Prevent tag overlap between queues
> +        */
> +       NVME_QUIRK_SHARED_TAGS                  = (1 << 12),
>  };
>
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7088971d4c42..fc74395a028b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2106,6 +2106,14 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>         unsigned long size;
>
>         nr_io_queues = max_io_queues();
> +
> +       /*
> +        * If tags are shared with admin queue (Apple bug), then
> +        * make sure we only use one IO queue.
> +        */
> +       if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
> +               nr_io_queues = 1;
> +
>         result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
>         if (result < 0)
>                 return result;
> @@ -2278,6 +2286,14 @@ static int nvme_dev_add(struct nvme_dev *dev)
>                 dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>                 dev->tagset.driver_data = dev;
>
> +               /*
> +                * Some Apple controllers requires tags to be unique
> +                * across admin and IO queue, so reserve the first 32
> +                * tags of the IO queue.
> +                */
> +               if (dev->ctrl.quirks & NVME_QUIRK_SHARED_TAGS)
> +                       dev->tagset.reserved_tags = NVME_AQ_DEPTH;
> +
>                 ret = blk_mq_alloc_tag_set(&dev->tagset);
>                 if (ret) {
>                         dev_warn(dev->ctrl.device,
> @@ -3057,7 +3073,8 @@ static const struct pci_device_id nvme_id_table[] = {
>         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
>         { PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2005),
>                 .driver_data = NVME_QUIRK_SINGLE_VECTOR |
> -                               NVME_QUIRK_128_BYTES_SQES },
> +                               NVME_QUIRK_128_BYTES_SQES |
> +                               NVME_QUIRK_SHARED_TAGS },
>         { 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, nvme_id_table);

Looks fine for me:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
