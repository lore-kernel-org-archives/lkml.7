Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD00CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CFD21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 21:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PRPobR6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfJ2Vej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 17:34:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33186 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfJ2Vei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 17:34:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id c184so43347pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lWZTdL/Ycl8L0zHYWfiupMxq7Qm95AxSDKo9H9BjXP8=;
        b=PRPobR6gff4iW7vcCqcliQQ2oTk2SnbL8tep2tCUVzkcxNRl9kIhbYrI0UZMRt2ZBD
         s8zqYEHq7hULtExyjugBuG1AAI8jmk+j58vggEJbxAHdb9xFOSFXXWxF8djA4CEu9LLa
         fFzfhyeUIWTDJ1d+OPsqcjOknJBVkNA9BlKUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lWZTdL/Ycl8L0zHYWfiupMxq7Qm95AxSDKo9H9BjXP8=;
        b=pdotVOPTYtUUgayGRM7QINMVVLmHlKRWggyc83fsBBIlV9uOWVPA/aYjSh9gLB6hSm
         50nBwc1QmUKR07eKPvdXNklVbDG2XwQqveBnZP8VOzJMj0IGiY08ewjivdcsOidPukr9
         poMB2MzeX/g5/Vv6yxqwrgn1OsbWQeOQ9tpWClFkCZJSAnFU99A+AnVwilgD/v8SmRpo
         u85avBUB9OV1ZLEssfVkaWqtueW31zw4qGR3dTaIe5HhJyYJH61pw4Mj8XISd2ziDf5N
         gK4oNSWi7ERfA6Z0mxG0rUz8UHFmbsFpdS+InNqUCBXG/sT+vi4Fc/s30saPY76XHoQO
         xGpA==
X-Gm-Message-State: APjAAAXVdPgJTEr1T1/CjBLwTAx+fRa1lNKAQKNlu6zPG2ZCR83sO3cL
        /TLKQwuISTE1pk0V0eN6kEAbJQ==
X-Google-Smtp-Source: APXvYqx3aH3CH+BULx4DuU0U+ZlkEU3+HCKNDcRvDP7umOsBNHrdd7xxt2fFHmJl0bdYYD6n/7hL1g==
X-Received: by 2002:a63:ff65:: with SMTP id s37mr16005991pgk.331.1572384878116;
        Tue, 29 Oct 2019 14:34:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm176825pgn.44.2019.10.29.14.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:34:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Semmle Security Reports <security-reports@semmle.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] dma-mapping: Add vmap checks to dma_map_single()
Date:   Tue, 29 Oct 2019 14:34:21 -0700
Message-Id: <20191029213423.28949-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4: use dev_WARN_ONCE() and improve report string (gregkh, robin)
v3: https://lore.kernel.org/lkml/20191010222829.21940-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/201910041420.F6E55D29A@keescook
v1: https://lore.kernel.org/lkml/201910021341.7819A660@keescook

Duplicating patch 1 commit log:

As we've seen from USB and other areas[1], we need to always do runtime
checks for DMA operating on memory regions that might be remapped. This
adds vmap checks (similar to those already in USB but missing in other
places) into dma_map_single() so all callers benefit from the checking.

[1] https://git.kernel.org/linus/3840c5b78803b2b6cc1ff820100a74a092c40cbb

-Kees

Kees Cook (2):
  dma-mapping: Add vmap checks to dma_map_single()
  usb: core: Remove redundant vmap checks

 drivers/usb/core/hcd.c      | 8 +-------
 include/linux/dma-mapping.h | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1

