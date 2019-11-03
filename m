Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925ECA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0B20848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 16:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="c7cqFcEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbfKCQZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 11:25:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36145 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfKCQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 11:25:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id j22so9684941pgh.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 08:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hrCICX4lUD1hzXvbY2RMWLfwu7sfeKbrgL9ER2BsDkA=;
        b=c7cqFcEhhoOez+81C90RV0pANxFTaEQwP6LSKMhMV+7GWHnC0omhitVB7FZjbKC99N
         rWoRDnNtBUKTBtKao7T5uQ/N1q/GBnAq9ZvT/cghD00ZxQRn0vwvlY7tbW+REL1U3wvw
         pjrOt+yp8T/nyGgjDSqKvrYLCluE49qTZ4kOZlakzGrQjan96bZTpC+PeZTCNUMwl//K
         z88E5n/X9PPr8CIUvnfU2pUkNmXkGU+1bgrqmT4tUc/X+wwT7TpUoWTYfy43jMLiaZEG
         7s7yW/cG8mkBYYlpWu4dBfNIwhH7Xe+ltWHrCsmnPv/0XVC3SJFqOAUB2uNKzhSRd5e2
         yJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hrCICX4lUD1hzXvbY2RMWLfwu7sfeKbrgL9ER2BsDkA=;
        b=MzSNUbPnQR4pwPI30Gv40dqqxwtgrvGd3XznI6SaAGGW6fsZn1oC2k3hVIg2hysUTZ
         vYYeY+/dqxSKgRWCZ04Z2Oqwmrsbo8cIftf4HVb623IgMLD8Fay0PmwrXrSrttF3O6Ui
         DbOZtgVBJJYB9tX2/tJzf2dMYx5WBL9KayzL808DLJRdZJI6ecPFvLy/6EQ+mwSYYNlC
         f3rhstKMFFYFNIXdtWbhmfMvtIq+uecwQhYxsaZTXF33LUfyt0/YiWYE2H6q0Q35gxU7
         xv7yiW/q1ZG02olH62TNrQHLtD+bv6PlstkK8pokWWPg8Knqe4WnxdZhQmxE13vGvIEv
         n5Og==
X-Gm-Message-State: APjAAAUcwPRQTmiNqdxHqPn7+TCuv/jAtBuBd+5+WxGC/OtMOUQUR1ah
        TbcNr1JHR6qSz0irMB9bM5na5w==
X-Google-Smtp-Source: APXvYqzUNyfNLVayZcws7B5PtfTBSruPjD5jamAY/55zIFemNHSpiqAP90vDMb/a4ZMQ0mBvSeft8Q==
X-Received: by 2002:aa7:95ad:: with SMTP id a13mr26470776pfk.216.1572798350048;
        Sun, 03 Nov 2019 08:25:50 -0800 (PST)
Received: from localhost ([66.167.121.235])
        by smtp.gmail.com with ESMTPSA id r185sm13302728pfr.68.2019.11.03.08.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 08:25:49 -0800 (PST)
Date:   Sun, 3 Nov 2019 08:25:45 -0800
From:   Sandeep Patil <sspatil@android.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 5/5] kselftests: Add dma-heap test
Message-ID: <20191103162545.GB116247@google.com>
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-6-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101214238.78015-6-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 09:42:38PM +0000, John Stultz wrote:
> Add very trivial allocation and import test for dma-heaps,
> utilizing the vgem driver as a test importer.
> 
> A good chunk of this code taken from:
>   tools/testing/selftests/android/ion/ionmap_test.c
>   Originally by Laura Abbott <labbott@redhat.com>
> 
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
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Laura Abbott <labbott@redhat.com>
> Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Switched to use reworked dma-heap apis
> v3:
> * Add simple mmap
> * Utilize dma-buf testdev to test importing
> v4:
> * Rework to use vgem
> * Pass in fd_flags to match interface changes
> * Skip . and .. dirs
> v6:
> * Number of style/cleanups suggested by Brian
> v7:
> * Whitespace fixup for checkpatch
> v8:
> * More checkpatch whitespace fixups
> v9:
> * Better handling error returns out to main, suggested
>   by Brian Starkey
> * Switch to using snprintf, suggested by Brian
> v14:
> * Fix a missing return value
> * Add calls to test the GET_FEATURES ioctl
> * Build fix reported by kernel test robot <lkp@intel.com>
>   and fixed by Xiao Yang <ice_yangxiao@163.com>
> * Minor Makefile cleanups
> ---
>  tools/testing/selftests/dmabuf-heaps/Makefile |   6 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 255 ++++++++++++++++++
>  2 files changed, 261 insertions(+)
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/Makefile
>  create mode 100644 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
> new file mode 100644
> index 000000000000..607c2acd2082
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
> +
> +TEST_GEN_PROGS = dmabuf-heap
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> new file mode 100644
> index 000000000000..ec47901ef2e2
> --- /dev/null
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dirent.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +
> +#include <linux/dma-buf.h>
> +#include <drm/drm.h>
> +
> +#include "../../../../include/uapi/linux/dma-heap.h"
> +
> +#define DEVPATH "/dev/dma_heap"
> +
> +static int check_vgem(int fd)
> +{
> +	drm_version_t version = { 0 };
> +	char name[5];
> +	int ret;
> +
> +	version.name_len = 4;
> +	version.name = name;
> +
> +	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
> +	if (ret)
> +		return 0;
> +
> +	return !strcmp(name, "vgem");
> +}
> +
> +static int open_vgem(void)
> +{
> +	int i, fd;
> +	const char *drmstr = "/dev/dri/card";
> +
> +	fd = -1;
> +	for (i = 0; i < 16; i++) {
> +		char name[80];
> +
> +		snprintf(name, 80, "%s%u", drmstr, i);
> +
> +		fd = open(name, O_RDWR);
> +		if (fd < 0)
> +			continue;
> +
> +		if (!check_vgem(fd)) {
> +			close(fd);
> +			fd = -1;
> +			continue;
> +		} else {
> +			break;
> +		}
> +	}
> +	return fd;
> +}
> +
> +static int import_vgem_fd(int vgem_fd, int dma_buf_fd, uint32_t *handle)
> +{
> +	struct drm_prime_handle import_handle = {
> +		.fd = dma_buf_fd,
> +		.flags = 0,
> +		.handle = 0,
> +	 };
> +	int ret;
> +
> +	ret = ioctl(vgem_fd, DRM_IOCTL_PRIME_FD_TO_HANDLE, &import_handle);
> +	if (ret == 0)
> +		*handle = import_handle.handle;
> +	return ret;
> +}
> +
> +static void close_handle(int vgem_fd, uint32_t handle)
> +{
> +	struct drm_gem_close close = {
> +		.handle = handle,
> +	};
> +
> +	ioctl(vgem_fd, DRM_IOCTL_GEM_CLOSE, &close);
> +}
> +
> +static int dmabuf_heap_open(char *name)
> +{
> +	int ret, fd;
> +	char buf[256];
> +
> +	ret = snprintf(buf, 256, "%s/%s", DEVPATH, name);
> +	if (ret < 0) {
> +		printf("snprintf failed!\n");
> +		return ret;
> +	}
> +
> +	fd = open(buf, O_RDWR);
> +	if (fd < 0)
> +		printf("open %s failed!\n", buf);
> +	return fd;
> +}
> +
> +static int dmabuf_heap_get_features(int fd, unsigned long long *features)
> +{
> +	struct dma_heap_get_features_data data = {0};

I'm curious if the test continues to work if you don't zero initialize here?
(See my comment in patch 1/5)


Acked-by: Sandeep Patil <sspatil@android.com>
