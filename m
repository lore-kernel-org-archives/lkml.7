Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23175C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E545A214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFtJZARB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfHNUia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:38:30 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44005 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfHNUia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:38:30 -0400
Received: by mail-oi1-f193.google.com with SMTP id y8so5688924oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8/VpPJuBcEAlBq5ppU9bWHqxCKnz3CDU+X2UU9Ge/5A=;
        b=iFtJZARBLqCuehUIIZ6AX53e0HLaQLvnEVXGI7Gaw53CJuIbJqqJ2/Gw91zRiWBiOr
         B+AT8Mwb7GgwRNuev7TOp6GfTfnZPTTilFQpSwTpcyVKzFk4xYK2i0026P902uwkbqRe
         AmebT2nh3FEJohKc7/43Er3nVTZ5QP3OxmuJFOuHgr+cceWB05yqa9nsj0G/KWRzXV8w
         dA5GGKSMGhAOc9EJP8uv33aO9C6SMwAhBje5dmq5hPod5JjNxJNvIcFy9C489z/Lm+gQ
         tJPg8UH9nm9pQnfmpw9ZrJPiaOBKfqLMLDLTmit1mVc3vpLGfCBoP+7SQvVheo7TjyXA
         MV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8/VpPJuBcEAlBq5ppU9bWHqxCKnz3CDU+X2UU9Ge/5A=;
        b=YB8h2ZrE1xKDd0jiDc1Gjlfe6eY19h6DwiOtUckYh0cI4NRPGzOI2FtAkxfoePtxNz
         JYxK/1su/w8/5bDGYjuL3SwNrPH12XhCZLURmGCBxRwe5eY/L4mkkHoKsbINGSA5ISbc
         1waAaMRCog3zLdWNV64UE5NKvqCAtQO5y1Shf9zqVhAL32qrG8n6A7PD7USDphdQcqOA
         J+couJc/XUjtShxBfWZYYh2G9Dk7UtLtqywO8B/y2XsDV7MbcO8StSyhcxxZq+JigL0I
         WHzyfgAIUaLhLRaxprXZyuOp//vsyyWCQ9rZWfHKsWIwcLra0/nZ94e01ZkgXFAd+hwl
         jUbA==
X-Gm-Message-State: APjAAAWHGKLWETkCEHBLZs/qzT/QSJldockn+16ua/d8JmC4jkrQFwnq
        LaGkazZOI5AaenYZ2E5PYprzfCwe29lcTq2miSXbkg==
X-Google-Smtp-Source: APXvYqwgjATWeoTZJWJRcTxRDk/XD8i0qTAP3Z8rOiz73ozATuTBONe2NNqtPexULHsGgvc7iWEkUn9MnzC4V5O61aU=
X-Received: by 2002:a02:b609:: with SMTP id h9mr1322561jam.36.1565815109337;
 Wed, 14 Aug 2019 13:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190812221154.46875-1-yabinc@google.com>
In-Reply-To: <20190812221154.46875-1-yabinc@google.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 14 Aug 2019 14:38:18 -0600
Message-ID: <CANLsYkzxLi36JNsOCaEE-Dsm3f4k6RXkkKrdkdeJDivdeu6axQ@mail.gmail.com>
Subject: Re: [PATCH v2] coresight: tmc-etr: Fix updating buffer in
 not-snapshot mode.
To:     Yabin Cui <yabinc@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Aug 2019 at 16:11, Yabin Cui <yabinc@google.com> wrote:
>
> TMC etr always copies all available data to perf aux buffer, which
> may exceed the available space in perf aux buffer. It isn't suitable
> for not-snapshot mode, because:
> 1) It may overwrite previously written data.
> 2) It may make the perf_event_mmap_page->aux_head report having more
> or less data than the reality.
>
> So change to only copy the latest data fitting the available space in
> perf aux buffer.
>
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>
> v1 -> v2: copy the latest data instead of the earliest data.
>
> ---
>  .../hwtracing/coresight/coresight-tmc-etr.c    | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 17006705287a..676dcb4cf0e2 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1410,9 +1410,10 @@ static void tmc_free_etr_buffer(void *config)
>   * tmc_etr_sync_perf_buffer: Copy the actual trace data from the hardware
>   * buffer to the perf ring buffer.
>   */
> -static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
> +static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf,
> +                                    unsigned long to_copy)
>  {
> -       long bytes, to_copy;
> +       long bytes;
>         long pg_idx, pg_offset, src_offset;
>         unsigned long head = etr_perf->head;
>         char **dst_pages, *src_buf;
> @@ -1422,8 +1423,7 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>         pg_idx = head >> PAGE_SHIFT;
>         pg_offset = head & (PAGE_SIZE - 1);
>         dst_pages = (char **)etr_perf->pages;
> -       src_offset = etr_buf->offset;
> -       to_copy = etr_buf->len;
> +       src_offset = etr_buf->offset + etr_buf->len - to_copy;
>
>         while (to_copy > 0) {
>                 /*
> @@ -1434,6 +1434,8 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>                  *  3) what is available in the destination page.
>                  * in one iteration.
>                  */
> +               if (src_offset >= etr_buf->size)
> +                       src_offset -= etr_buf->size;
>                 bytes = tmc_etr_buf_get_data(etr_buf, src_offset, to_copy,
>                                              &src_buf);
>                 if (WARN_ON_ONCE(bytes <= 0))
> @@ -1454,8 +1456,6 @@ static void tmc_etr_sync_perf_buffer(struct etr_perf_buffer *etr_perf)
>
>                 /* Move source pointers */
>                 src_offset += bytes;
> -               if (src_offset >= etr_buf->size)
> -                       src_offset -= etr_buf->size;
>         }
>  }

Yes, much better now.  I have applied your work.

Thanks,
Mathieu

>
> @@ -1501,7 +1501,11 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>
>         size = etr_buf->len;
> -       tmc_etr_sync_perf_buffer(etr_perf);
> +       if (!etr_perf->snapshot && size > handle->size) {
> +               size = handle->size;
> +               lost = true;
> +       }
> +       tmc_etr_sync_perf_buffer(etr_perf, size);
>
>         /*
>          * In snapshot mode we simply increment the head by the number of byte
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
