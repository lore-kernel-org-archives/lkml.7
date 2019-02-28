Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5991CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4F2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 10:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbfB1K4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 05:56:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34944 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfB1K4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 05:56:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so21427479wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 02:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5X885l+x/iXoxDZHmd26qKVUeYFleR0kw+jBUUsd7HM=;
        b=JpbdezPMjpUYVewudy+WxEiX+qiYzMdFSaCxSDW3AdG4iYdOMXyHidN16BmU1kVs35
         mKeoy+ineoLfFHGeUnYsRbkgh2W4dLM7KAooO8o6i3gKzROKbhircFIdkbg2eeo1r+qj
         hXaRGRdgcGu9CSaCAmgno2zWQG82RdO1HB2E1B6QUHNor2r1yICput9YpslMo2nvgzTO
         GLjbYMpqZXrMttbqQb6m6Fmh96hJbLawiz5X1sfCVzpaUYHCIwn+l91eGptPil6GBx0c
         fGsXsIkYgY0EEyeYHPYZq9nlVKLU+Xegd2oaCR/ljGKfoN/4lXg4OacRNc5+7ZwIjikr
         c4Tw==
X-Gm-Message-State: APjAAAU6gt0bfDsaMUzZ2pUwYxJsPMvjE8sLy8eZ2j1ojVwA1VmVbUnu
        uH5O805mSDJlAp6/xudrlBPvyA==
X-Google-Smtp-Source: APXvYqwBacWFFRHnJ+rOtxAgoHyxQTM9PFhycb6WStlyVsZMG3m2lDOsEjq9/db/7q9/iGHIYuwn/Q==
X-Received: by 2002:adf:8224:: with SMTP id 33mr5979521wrb.264.1551351376972;
        Thu, 28 Feb 2019 02:56:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 93sm55544517wrh.15.2019.02.28.02.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 02:56:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Maya Nakamura <m.maya.nakamura@gmail.com>
Cc:     linux-kernel@vger.kernel.org, haiyangz@microsoft.com,
        marcelo.cerri@canonical.com, linux-hyperv@vger.kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kys@microsoft.com,
        sthemmin@microsoft.com, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com
Subject: Re: [PATCH v4 0/2] PCI: hv: Refactor hv_irq_unmask() to use hv_vpset and cpumask_to_vpset()
In-Reply-To: <cover.1551319643.git.m.maya.nakamura@gmail.com>
References: <cover.1551319643.git.m.maya.nakamura@gmail.com>
Date:   Thu, 28 Feb 2019 11:56:15 +0100
Message-ID: <87d0nckwq8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maya Nakamura <m.maya.nakamura@gmail.com> writes:

> This patchset removes a duplicate definition of VP set (hv_vp_set) and
> uses the common definition (hv_vpset) that is used in other places. It
> changes the order of the members in struct hv_pcibus_device due to
> flexible array in hv_vpset.
>
> It also removes the duplicate implementation of cpumask_to_vpset(), uses
> the shared implementation, and exports hv_max_vp_index, which is
> required by cpumask_to_vpset().
>
> Based on Vitaly's findings, two changes were applied: replace GFP_KERNEL
> with GFP_ATOMIC for alloc_cpumask_var() because hv_irq_unmask() runs
> while a spinlock is held, and add __aligned(8) to struct
> retarget_msi_interrupt because Hyper-V requires that hypercall arguments
> be aligned on an 8 byte boundary.
>
> Vitaly, thank you for finding the issues, and Lorenzo and Michael, thank
> you for your guidance and support!
>

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I, however, agree with Lorenzo that '__aligned(8)' change deserves its
own patch as it fixes an already present issue (which may actually be
masked but still present).

Going forward I'd like to get rid of the newly added cpumask allocation:
while it is very unlikely to fail and it only happens when we reassign
IRQs to some different CPU (thus it's not a hotpath or anything)
failures are still possible. This work can definitely be postponed, I
don't think it should block your patches.

-- 
Vitaly
