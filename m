Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31452C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41EE2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LW1Nh+cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387593AbfB1Um1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:42:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40454 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731269AbfB1Um1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:42:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id g20so9468431wmh.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 12:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wo/LUz+YAoHMxzB9Y7V0ETnhY6VR9dzHyL71ShD5rSA=;
        b=LW1Nh+cuFRwVhlqTTyUjN+fKMDPV5Ij6APlwPDgTrF99V362MKgmc1EF6k1GwDE3OA
         Gb5ka8IS89BVzhzza5St7D8WNWD58lDqQbqbgNMvqvKMVM/6Gjo96IkYqvQ0+OOhJtDs
         XGAPEWstafAhSKpsLh+nwAbzWzxTT+bEZu0rrrTckhCOitnGu93xnndgUdLdu4l7DT4J
         xI8TfWEt48cAOnmwqzYQn+7bxIj+TWTp3cKpNd6o8qPDBeydYfHLLR9IyKBkyIfC+gXH
         y5KQJGjKWuZIZ+1Cyi5t8B1mRnzDOKtkwVSYii5hOVdQ8A04ArO3ec3ySso3w7UgVGW7
         HCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wo/LUz+YAoHMxzB9Y7V0ETnhY6VR9dzHyL71ShD5rSA=;
        b=TFjxI/p9SabJhaVys2QoB7XpgbajM/mWcDy9jhBrfyRYsdxHnK6zfZZn+LsvQrGkT6
         j+tZOvoEaL6/w4WWyjXTTuDffDvkqjDeHFsdVbbLkXefMAR6pQThASGtqL9johM11RVA
         auTkAacFs8mylE7G+zF3xhRZkOIxhQ0TSIkqfawbppumUyEyYCq31DhVzr1NKgwfPbRn
         yw7yuAXCINKKigYmGRKEMk9OJxUmX9JjnjE8FqrefdGD1euOxlIHebM7kwHIdBKpRctP
         RoZoYPRqFqOjy/SCYpPEYxkuzNSLcHwe148l/Zet1vAGul70Sn1fsysaLabhOr44SMFO
         UgqQ==
X-Gm-Message-State: APjAAAXdYGKUrthDQ+WZUPgds5GEvNL0q/A6cArNdbmzFzB+D4QwsqJS
        8AUDyUh5EKIgavvt7tn2E6CcOUnOCIIIo9RdIMhe
X-Google-Smtp-Source: AHgI3IaS31r8tqzQtG9diGcEoXIbxHGnKO889J/PyXS1u8RFw/damVN2hxhcGZeqDTBkUQZUEMoK3NMQn0kbH2CDOBc=
X-Received: by 2002:a1c:6409:: with SMTP id y9mr1048634wmb.68.1551386545111;
 Thu, 28 Feb 2019 12:42:25 -0800 (PST)
MIME-Version: 1.0
References: <1943648.NMEmlssb0J@aspire.rjw.lan>
In-Reply-To: <1943648.NMEmlssb0J@aspire.rjw.lan>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Thu, 28 Feb 2019 14:42:13 -0600
Message-ID: <CAErSpo6WEgqQ2Loub4QKzCvmh5V6nU8X8sui3WLdJbgVZ0BnJw@mail.gmail.com>
Subject: Re: [PATCH] PCI: PCIe: PME: Fix pcie_pme_remove()
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 5:58 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> It is incorrect to call pcie_pme_suspend() from pcie_pme_remove() for
> two reasons.
>
> First, pcie_pme_suspend() calls synchronize_irq() that will wait for
> the native hotplug interrupt handler as well as for the PME one,
> because they share one IRQ (as per the spec).  That may deadlock if
> hotplug is signaled while pcie_pme_remove() is running and the latter
> calls pci_lock_rescan_remove() before the former.
>
> Second, if pcie_pme_suspend() figures out that wakeup needs to be
> enabled for the port, it will return without disabling the interrupt
> as expected by pcie_pme_remove() which was overlooked by commit
> c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system
> suspend/resume").
>
> To fix that, rework pcie_pme_remove() to disable the PME interrupt,
> clear its status and prevent the PME worker function from re-enabling it
> before calling free_irq() on it which should be sufficient.
>
> Fixes: c7b5a4e6e8fb ("PCI / PM: Fix native PME handling during system suspend/resume")
> Reported-by: Dongdong Liu <liudongdong3@huawei.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I added the deadlock details from Dongdong and applied this to pci/pm
for v5.1, thanks!

Bjorn
