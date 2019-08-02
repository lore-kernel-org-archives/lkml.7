Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0FDC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F37320657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfHBHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:30:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41065 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389656AbfHBHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:30:22 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so72860552wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 00:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qpvX7/WeVyRtLNS5W1XR6+ViveiHMM5DFdzi+nH8f/c=;
        b=YxI64iag55vfjsGmLzQtERLKRusLHZJ+r/Os6eiS5SgkNWMa9XDDJH644yDGiW356O
         oAGfwDnP4KSaUtSNN2sgTws7IBgb84YFg0+qW+hI8uaTzmdowjuySqyTewGKsdYVVl1T
         LCKn5xd8jcu/mYtUsvNh+waIK7q+FacqnxKPcp+66OS/k1OSx//VrNlncnhLcLhboBI7
         jA6GWGDfIVJB6EJ4jCqYaT6RFEcWhJbnXbC28YfnJpXPDEQc72ZH4yoPCnkvq62pAE/S
         v1jLe1DLzn6BqAAnm8Vevk7nz9fAyKdVcsqHUL6A5iE/xNT/BAUXtllpIF7yd2hl1lT6
         sH8g==
X-Gm-Message-State: APjAAAW9556jINbeXJdnn0LJkPfx+TGewUpXI1oD2l7PTDmMmiTRtpQW
        86e3A68XA4XLCSyWWl6+3fbzqg==
X-Google-Smtp-Source: APXvYqxmdlPd/oQ5dQRfxfIqrgz1a/a7DfY/skn79VPh1U4+qZY7pWaVE7vccEualPXpFdaLBMOXjw==
X-Received: by 2002:adf:9f0e:: with SMTP id l14mr4855268wrf.23.1564731020432;
        Fri, 02 Aug 2019 00:30:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (ip-89-176-127-93.net.upcbroadband.cz. [89.176.127.93])
        by smtp.gmail.com with ESMTPSA id c78sm102668211wmd.16.2019.08.02.00.30.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:30:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Branden Bonaby <brandonbonaby94@gmail.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org
Subject: Re: [PATCH 0/3] hv: vmbus: add fuzz testing to hv devices
In-Reply-To: <cover.1564527684.git.brandonbonaby94@gmail.com>
References: <cover.1564527684.git.brandonbonaby94@gmail.com>
Date:   Fri, 02 Aug 2019 09:30:18 +0200
Message-ID: <87ftmkgh2t.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Branden Bonaby <brandonbonaby94@gmail.com> writes:

> This patchset introduces a testing framework for Hyper-V drivers.
> This framework allows us to introduce delays in the packet receive
> path on a per-device basis. While the current code only supports 
> introducing arbitrary delays in the host/guest communication path,
> we intend to expand this to support error injection in the future.
>
> Branden Bonaby (3):
>   drivers: hv: vmbus: Introduce latency testing
>   drivers: hv: vmbus: add fuzz test attributes to sysfs
>   tools: hv: add vmbus testing tool
>
>  Documentation/ABI/stable/sysfs-bus-vmbus |  22 ++
>  drivers/hv/connection.c                  |   5 +
>  drivers/hv/ring_buffer.c                 |  10 +
>  drivers/hv/vmbus_drv.c                   |  97 ++++++-

Can we have something like CONFIG_HYPERV_TESTING and put this new 
code under #ifdef?

>  include/linux/hyperv.h                   |  14 +
>  tools/hv/vmbus_testing                   | 326 +++++++++++++++++++++++
>  6 files changed, 473 insertions(+), 1 deletion(-)
>  create mode 100644 tools/hv/vmbus_testing

-- 
Vitaly
