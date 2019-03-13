Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F166DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC3D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oqs9gMBl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ImopeHRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfCMUXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:23:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46878 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbfCMUXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:23:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F2E9360312; Wed, 13 Mar 2019 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508615;
        bh=2XeLJVW3c4xz6ED8qGo20vKqCnmJdMzGpfyxomXHWRo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=oqs9gMBlyryaNsH/goKRhLOFXgEB1w6YMTro7td4YfDrwKCPmyxG6dMC3rnUzMZO7
         W1qgCJXuhA+rokm73/+qVT3ih4w1VRBYDgLIHiSc4HzBAzAZFVTNm1FS3KtwId7r2e
         xGgrwXSRlhJ+2g7IWi90679pllmm8EL5lJLL8A3Y=
Received: from lmark-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lmark@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1523360208;
        Wed, 13 Mar 2019 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552508613;
        bh=2XeLJVW3c4xz6ED8qGo20vKqCnmJdMzGpfyxomXHWRo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ImopeHRxswu0H0wi+2xZMBoFY4Oxa2YsHpUVFGAFJ5Tz2bgBoEgbBGZ+48NCvXY+u
         Owt9FtnbekDz1sND5R0SS3o9TA1awdoVL3GT8ZhIoQvsezk3mlXroAL++MkCEex8p9
         4XKTKxBXNQrVRpIQg9SoRnYI2QMwZq2DpzFUPJP4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1523360208
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=lmark@codeaurora.org
Date:   Wed, 13 Mar 2019 13:23:32 -0700 (PDT)
From:   Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To:     John Stultz <john.stultz@linaro.org>
cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Andrew F . Davis" <afd@ti.com>, Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH 5/5 v2] kselftests: Add dma-heap test
In-Reply-To: <1551819273-640-6-git-send-email-john.stultz@linaro.org>
Message-ID: <alpine.DEB.2.10.1903131320560.5023@lmark-linux.qualcomm.com>
References: <1551819273-640-1-git-send-email-john.stultz@linaro.org> <1551819273-640-6-git-send-email-john.stultz@linaro.org>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, John Stultz wrote:

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
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 96 ++++++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
> new file mode 100644
> index 0000000..c414ad3
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
> +#LDLIBS += -lrt -lpthread -lm
> +
> +# these are all "safe" tests that don't modify
> +# system time or require escalated privileges
> +TEST_GEN_PROGS = dmabuf-heap
> +
> +
> +include ../lib.mk
> +
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
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
> +	int ret, fd;
> +	char buf[256];
> +
> +	ret = sprintf(buf, "%s/%s", DEVPATH, name);
> +	if (ret < 0) {
> +		printf("sprintf failed!\n");
> +		return ret;
> +	}
> +
> +	fd = open(buf, O_RDWR);
> +	if (fd < 0)
> +		printf("open %s failed!\n", buf);
> +	return fd;
> +}
> +
> +int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags, int *dmabuf_fd)
> +{
> +	struct dma_heap_allocation_data data = {
> +		.len = len,
> +		.flags = flags,
> +	};
> +	int ret;
> +
> +	if (dmabuf_fd == NULL)
> +		return -EINVAL;
> +
> +	ret = ioctl(fd, DMA_HEAP_IOC_ALLOC, &data);
> +	if (ret < 0)
> +		return ret;
> +	*dmabuf_fd = (int)data.fd;
> +	return ret;
> +}
> +
> +#define ONE_MEG (1024*1024)
> +
> +void do_test(char *heap_name)
> +{
> +	int heap_fd = -1, dmabuf_fd = -1;
> +	int ret;
> +
> +	printf("Testing heap: %s\n", heap_name);
> +
> +	heap_fd = dmabuf_heap_open(heap_name);
> +	if (heap_fd < 0)
> +		return;
> +
> +	printf("Allocating 1 MEG\n");
> +	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);

Just be aware that some CMA heaps may already have all their memory 
allocated by the client, so you may see intermittent failures depending on 
when you run the test and failrues may
be more common when run on certain platform.

> +	if (ret)
> +		goto out;
> +
> +	/* DO SOMETHING WITH THE DMABUF HERE? */
> +
> +out:
> +	if (dmabuf_fd >= 0)
> +		close(dmabuf_fd);
> +	if (heap_fd >= 0)
> +		close(heap_fd);
> +}
> +
> +
> +int main(void)
> +{
> +	DIR *d;
> +	struct dirent *dir;
> +
> +	d = opendir(DEVPATH);
> +	if (!d) {
> +		printf("No %s directory?\n", DEVPATH);
> +		return -1;
> +	}
> +
> +	while ((dir = readdir(d)) != NULL)
> +		do_test(dir->d_name);
> +
> +
> +	return 0;
> +}
> -- 
> 2.7.4
> 
> 

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
