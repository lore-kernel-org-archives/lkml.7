Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABF4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429932068F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="M/k0aGFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKTSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:39:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41744 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfKTSfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:35:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id 207so139437pge.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SguOXdXD06UvXlpJTQF3X/gOJzOdybHb3TZxh+LFCwE=;
        b=M/k0aGFFVeGdcEMo7ik+UWlR4SsoP7CucR9U2FHwRbjsoS6Jxqcz+93aeJIKZnBOzz
         Pc2jMYjAyvzMe3GuRy2XS+vsHKuraV6vaRry8HP7s2ycXSVK14bhkWt0MHSY9/CrZrdK
         lqj5Uq3IVc1Ruu12WucILWSR/ZVulbvVir963Af99szrifaRyz40CQxsJreqUZ2NW7tt
         BKXdpeVpeahKlUXC1lcurEuXhuKmhgK4D48SlaAxPptv067Vwgdtd8/EG2o9CrfnSEwT
         NOo3JtRemeRmdsJLTsEbcx7959y1TZcjFUgLWdAojE5jZX7AqeRishMiOyM+3npTA7DT
         iLGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SguOXdXD06UvXlpJTQF3X/gOJzOdybHb3TZxh+LFCwE=;
        b=THCWxjXOVPQF2m5MZsMFv4fGcMmft0UGaI1QYHhkqWjhaOVtCH9FY4N6RfPwBlt7/4
         c9t+pdznHXWtJp8uqAYp6QDLEr+VhBfK7xTRXcvkLMGsn7PT7NxWWqtuhS3cOTTdngq2
         Yq9xTKnOQAnGVJmeAv+ePlPJj99q9cQdXvFfQjlI+r9bH8V/L6Wafrr5OI2WggSHWZDB
         wRO8EAJmd7nXZ8RR667Kr1oeb4/HUSweqcUhfvG/Z6L0OWe9xXsaC6O1AV0wr+YJG/RM
         E6B6IWRdKn7lhQcZWsGTQ8SgUBROR7fyoNwtQSmbNL5uVoHAObe1OcqUnF79mjpmLU7Z
         I34w==
X-Gm-Message-State: APjAAAXpxRQXI3RhGl7WZaUcEDp+Xzj5Bj6BeRAufFSCd2M91wmFldGd
        XR14dwdAxhXwWzfAvHCOf59QVg==
X-Google-Smtp-Source: APXvYqxyYAth7L1wiJL1kecEmScQt3Ogum8pKto+OQyv1LHRbY3avm8XD4YP/3EEZhm/qCZxoniQDg==
X-Received: by 2002:a63:ec4b:: with SMTP id r11mr4749669pgj.147.1574274912209;
        Wed, 20 Nov 2019 10:35:12 -0800 (PST)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id p123sm78577pfg.30.2019.11.20.10.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:35:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:35:03 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Alex Williamson" <alex.williamson@redhat.com>
Cc:     <lantianyu1986@gmail.com>, <cohuck@redhat.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <mchehab+samsung@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <paulmck@linux.ibm.com>,
        "Michael Kelley" <mikelley@microsoft.com>,
        "Tianyu Lan" <Tianyu.Lan@microsoft.com>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-hyperv@vger.kernel.org>, "vkuznets" <vkuznets@redhat.com>
Subject: Re: [PATCH] VFIO/VMBUS: Add VFIO VMBUS driver support
Message-ID: <20191120103503.5f7bd7c4@hermes.lan>
In-Reply-To: <20191119165620.0f42e5ba@x1.home>
References: <20191111084507.9286-1-Tianyu.Lan@microsoft.com>
        <20191119165620.0f42e5ba@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2019 15:56:20 -0800
"Alex Williamson" <alex.williamson@redhat.com> wrote:

> On Mon, 11 Nov 2019 16:45:07 +0800
> lantianyu1986@gmail.com wrote:
> 
> > From: Tianyu Lan <Tianyu.Lan@microsoft.com>
> > 
> > This patch is to add VFIO VMBUS driver support in order to expose
> > VMBUS devices to user space drivers(Reference Hyper-V UIO driver).
> > DPDK now has netvsc PMD driver support and it may get VMBUS resources
> > via VFIO interface with new driver support.
> > 
> > So far, Hyper-V doesn't provide virtual IOMMU support and so this
> > driver needs to be used with VFIO noiommu mode.  
> 
> Let's be clear here, vfio no-iommu mode taints the kernel and was a
> compromise that we can re-use vfio-pci in its entirety, so it had a
> high code reuse value for minimal code and maintenance investment.  It
> was certainly not intended to provoke new drivers that rely on this mode
> of operation.  In fact, no-iommu should be discouraged as it provides
> absolutely no isolation.  I'd therefore ask, why should this be in the
> kernel versus any other unsupportable out of tree driver?  It appears
> almost entirely self contained.  Thanks,
> 
> Alex

The current VMBUS access from userspace is from uio_hv_generic
there is (and will not be) any out of tree driver for this.

The new driver from Tianyu is to make VMBUS behave like PCI.
This simplifies the code for DPDK and other usermode device drivers
because it can use the same API's for VMBus as is done for PCI.

Unfortunately, since Hyper-V does not support virtual IOMMU yet,
the only usage modle is with no-iommu taint.
