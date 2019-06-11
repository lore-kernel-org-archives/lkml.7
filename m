Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC8EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E582086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OL1jUgfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391110AbfFKQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:55:05 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45074 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387610AbfFKQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 12:55:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id s22so8082719qkj.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76dGMyglhXIsHGduaiPit7Yovd6U12laTtR7hEdIMdc=;
        b=OL1jUgfL0jAs6zZk6ToeEaJbui6K/kJxO24Dras7vvbEwdw10HQlGQJmeKwxqw1RYI
         H9c2vHctd4kgnT/SYNlvHqIDxcgeBRtv5FyFEGu55DRXK+e4igcDbsYor7Jm6iiMTaMg
         szZ7Pvo4vAo2FdCKROGVBCWn3KwakSTNFyCUuVlVe63yMHoJn7sragF2fiIFTr/1MFMJ
         6/NDgbE2IxmbJNY66yce5ivyWvpzKxuhd6Zd8Hwd62wV6gEAKCbODj/FBWS1vyBGDyT2
         EROzl8WZUKYsjGSW65AAQYTt7rhCyvAO7FgJ5Mna4KKultQ9CNdvbXr32NrL6TO8aJ4Z
         ThKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76dGMyglhXIsHGduaiPit7Yovd6U12laTtR7hEdIMdc=;
        b=d8DhqN8HCZD3dBnLpQg+k/4gKmjkApyboH/tYKf6yEgUzPKFLELFwBKUABCM3vhDo0
         b5Cb1GnqCTs4IBTI4bMNoq5R+r4iLr6deBWSb7qD4I2a4pmwMP1I1qzPzi8FPPuQ5E7F
         ZWHxtxMEG+LmN937caegceYUJaF+KmqYTiiWPAXybyvElHs/rkjZ0WeCcQ25XXJcQntM
         5zbZ+se5A0gCj6T78nw7eI7jKOQVtiJJQHgYJKNLNWBz96jMpap72F589L7HzRxUsm9K
         1ph+GhvHF0eRjRRvrhewYXVXZyJQ3ANrjTzpWBMfDrL7wECa8J2ncFpeub8ne/Oa7WXm
         TfCw==
X-Gm-Message-State: APjAAAWO/n+J/xlDskpEhjQwzlK+tROpgFGYf32g0LlUpBlXJmhkaHZT
        AB7VSuhq/pUU6ZKaxhlRXdynKw==
X-Google-Smtp-Source: APXvYqzzOvJxoNk6oZBt7kaaRhFu3Q3TUFRBnhY1YkR+FSaESbk9O/SCseAezdGJ7aYDKNKo/Mz8sQ==
X-Received: by 2002:a37:670d:: with SMTP id b13mr59509027qkc.47.1560272104515;
        Tue, 11 Jun 2019 09:55:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t30sm6527461qkm.39.2019.06.11.09.55.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 09:55:03 -0700 (PDT)
Message-ID: <1560272102.5154.1.camel@lca.pw>
Subject: Re: [PATCH 0/6] iommu/vt-d: Fixes and cleanups for linux-next
From:   Qian Cai <cai@lca.pw>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com,
        sai.praneeth.prakhya@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 11 Jun 2019 12:55:02 -0400
In-Reply-To: <20190609023803.23832-1-baolu.lu@linux.intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-09 at 10:37 +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This series includes several fixes and cleanups after delegating
> DMA domain to generic iommu. Please review and consider them for
> linux-next.
> 
> Best regards,
> Baolu
> 
> Lu Baolu (5):
>   iommu/vt-d: Don't return error when device gets right domain
>   iommu/vt-d: Set domain type for a private domain
>   iommu/vt-d: Don't enable iommu's which have been ignored
>   iommu/vt-d: Fix suspicious RCU usage in probe_acpi_namespace_devices()
>   iommu/vt-d: Consolidate domain_init() to avoid duplication
> 
> Sai Praneeth Prakhya (1):
>   iommu/vt-d: Cleanup after delegating DMA domain to generic iommu
> 
>  drivers/iommu/intel-iommu.c | 210 +++++++++---------------------------
>  1 file changed, 53 insertions(+), 157 deletions(-)
> 

BTW, the linux-next commit "iommu/vt-d: Expose ISA direct mapping region via
iommu_get_resv_regions" [1] also introduced a memory leak below, as it forgets
to ask intel_iommu_put_resv_regions() to call kfree() when
CONFIG_INTEL_IOMMU_FLOPPY_WA=y.

[1] https://lore.kernel.org/patchwork/patch/1078963/

unreferenced object 0xffff88912ef789c8 (size 64):
  comm "swapper/0", pid 1, jiffies 4294946232 (age 5399.530s)
  hex dump (first 32 bytes):
    48 83 f7 2e 91 88 ff ff 30 fa e3 00 82 88 ff ff  H.......0.......
    00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 00  ................
  backtrace:
    [<00000000d267f4be>] kmem_cache_alloc_trace+0x266/0x380
    [<00000000d383d15b>] iommu_alloc_resv_region+0x40/0xb0
    [<00000000db8be31b>] intel_iommu_get_resv_regions+0x25e/0x2d0
    [<0000000021fbc6c3>] iommu_group_create_direct_mappings+0x159/0x3d0
    [<0000000022259268>] iommu_group_add_device+0x17b/0x4f0
    [<0000000028b91093>] iommu_group_get_for_dev+0x153/0x460
    [<00000000577c33b4>] intel_iommu_add_device+0xc4/0x210
    [<00000000587b7492>] iommu_probe_device+0x63/0x80
    [<000000004aa997d1>] add_iommu_group+0xe/0x20
    [<00000000c93a9cd6>] bus_for_each_dev+0xf0/0x150
    [<00000000a2e5f0cb>] bus_set_iommu+0xc6/0x100
    [<00000000dbad5db0>] intel_iommu_init+0x682/0xb0a
    [<00000000226f7444>] pci_iommu_init+0x26/0x62
    [<000000002d8694f5>] do_one_initcall+0xe5/0x3ea
    [<000000004bc60101>] kernel_init_freeable+0x5ad/0x640
    [<0000000091b0bad6>] kernel_init+0x11/0x138

