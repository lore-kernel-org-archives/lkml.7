Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0289AC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FDE2087F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="bW95RIN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfD0OUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:20:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55307 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0OUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:20:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so7485620wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2019 07:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZKbcpKE+jjnLBwFYXkMrxjdfDETR3PC8ZYm15vMqpw=;
        b=bW95RIN1825L7mXuK9ObhaHyQ4/IZFGjnXDYYIQ4GRq818wpB6A1rZLT9cG1nT4PY8
         GCuN37x11Fp68+DmxG+0WgI5FuCjuqfGflKtE5XTUMuztiIG8Ub6Me6JvLQp9BHkwZcq
         a73Kz9iv4JTcFV239YY5nzYRMXDzQwrrKEHBW6F6yps1biLJUgRwBZrOJIENpEZQ3Wxz
         ieUpHaSxwnQpy+3IZ2oLs+/EVp+/LVG5vAThTD8PejxKY9yeeqYYdWiNMeO5K833HfN2
         1Jw02EfoIxtjGpk7KKhLQ1B1heLQPKME8XKgiFz/Zkh0d/y49s9xdNlh5rWqot4XnP6g
         zxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZKbcpKE+jjnLBwFYXkMrxjdfDETR3PC8ZYm15vMqpw=;
        b=ezxA38NRt8WxS2pgfxk3OqVcyOfPoFqCAB5FEw+iKZB0jJMhjHQaI/SPxWvyFm3q0H
         27KJKxwvu8YtvTbW7UyL8fqjVfUo6O22Dl2WEjIGQgVtLo0Wei38+8Ejlunx+CyvtMj8
         lhbXtFNq/1RgAVh2s3jaeEPwIrhaGwCnNsxdtgyW27nGI00V+z1SkdvdoT6Yak1sQIJu
         m73GfbHO5awqI83p6+wAsnwJow9u3b8yiNGMJmEmyLgN30c5QC1qj9HKUcnzeT9Nej5k
         cIKdPBQ2bBbdCMDOkN3djnJQtYx7ueoyE/zWuEJTtOZKBICEiXJ8hnTTYEMcPGu9MCX+
         AJzQ==
X-Gm-Message-State: APjAAAWv03bJSo6wbbGI+MeWNkJk6WsMI/BQSXNVcxClv3YCdWTTQJJL
        K3yi1rQ0w2+owc5pGyAxvVe3RJtDGBZ1WB9Gfdmv1IMJWoY=
X-Google-Smtp-Source: APXvYqwzW141/RnAEFxzXCAYJxdQ5vvdZVBOEKJsY/gBgWOt2nmEvGhjXJKbo4/pJHqjJw0+u9p92wNTGyoTFMGfxZg=
X-Received: by 2002:a1c:c142:: with SMTP id r63mr12099950wmf.97.1556374846121;
 Sat, 27 Apr 2019 07:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190424165051.13614-1-tmurphy@arista.com> <20190426140429.GG24576@8bytes.org>
In-Reply-To: <20190426140429.GG24576@8bytes.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Sat, 27 Apr 2019 15:20:35 +0100
Message-ID: <CAPL0++6_Hyozhf+eA2LM=t_Vuq8HaDzcczAUm0S4=DAw4jmMpA@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/amd: flush not present cache in iommu_map_page
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <murphyt7@tcd.ie>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The iommu_map_page function is called once per physical page that is
> mapped, so in the worst case for every 4k mapping established. So it is
> not the right place to put this check in.

Ah, you're right, that was careless of me.

> From a quick glance this check belongs into the map_sg() and the
> amd_iommu_map() function, but without the dom->updated check.
>
> Besides, to really support systems with np-cache in a way that doesn't
> destroy all performance, the driver also needs range-flushes for IOTLBs.

I am working on another patch to improve the intel iotlb flushing in
the iommu ops patch which should cover this too.

> Currently it can only flush a 4k page of the full address space of a
> domain. But that doesn't mean we shouldn't fix the missing flushes now.
>
> So please re-send the patch with the check at the two places I pointed
> out above.

will do
