Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080F2C10F09
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD5C20643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="KGLPKqPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCES1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:27:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36715 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfCES1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:27:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id n22so6338072pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xqn+Yf+5gP/Zaqja+Mz3g2jhch0LiFfd+n+wsWAt/6A=;
        b=KGLPKqPpx9wi4Hrhx6oW22RKrj95iWOfLj1SKFe/bPEgs8Bxtee/rRMVHbFhxJKiFR
         25vweCDQ56eWUv1tYK34TUXim4jCfODDjCzD/dqes4fg0+7iwjn4EOHUwLCj0e9QrsT5
         bPy9Thrq72xihaScYweclCNhdvZpOZBm+Cu4bbD94LRx9i86cyQkA5ZKdPL0MBfLGyrT
         dqHL0szhZmNjq1B0I2awgQjje6desCrJf9TWiV2de0lZu5QUKNhQjTFQFE/kjAB9O2xH
         5dCPg5SA7A6u/Jm4Gtee4TFePmQsEuwEkArF37+qNBUGxV/5sTivu7ILbHlvC2BNulmA
         4NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xqn+Yf+5gP/Zaqja+Mz3g2jhch0LiFfd+n+wsWAt/6A=;
        b=CnRN9w37neOJYQyy74ofnmpEpznigtwbZgJ08fNeNA7Ciam4P8carslQxByWmEKvqW
         myi09ePCh5ZdLQzMQsGUUHLt5jOmcgESsryFzJW+uzXxXvTLyWihEiVzBgx0MqWWN6sj
         95Zy4by5Koht/qZHjagDs1to4/vh1K7sdbfBC5uLs0pX2CKnGZ8Dos2883Sy0DTQnrW1
         qJuz/7aWH0wKW23EBtCOIiATc0so8vrAvciebhaRPw9w9ZA9zsXg7vTBGH8J3itJ30im
         OaA7e3sH/O+MOkaNsHE2jir6PpIedxDLLN+gb322CNDVkjxehK/vcmPL4EzXtJkloG4/
         ljfQ==
X-Gm-Message-State: APjAAAXU0HAIF9att0myjq5yDcvZgUiSFkFpv+fqKPS/gkOZhBnKNOBZ
        jboI5fX2P0FM2q5t4+VcHlhIGA==
X-Google-Smtp-Source: APXvYqzrpQZg1n82nmEhHNyq5fq8ItBMmGNBXZdJ4Z9iuRfUiErmuSbgRGyLwYBJ25NHvS5ZenLLHw==
X-Received: by 2002:a17:902:ea06:: with SMTP id cu6mr2569398plb.187.1551810455001;
        Tue, 05 Mar 2019 10:27:35 -0800 (PST)
Received: from shemminger-XPS-13-9360 ([167.220.56.187])
        by smtp.gmail.com with ESMTPSA id 73sm16653605pga.19.2019.03.05.10.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 10:27:34 -0800 (PST)
Date:   Tue, 5 Mar 2019 10:27:33 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jackm@mellanox.com" <jackm@mellanox.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        vkuznets <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
Subject: Re: [PATCH 0/3] pci-hyperv: fix memory leak and add
 pci_destroy_slot()
Message-ID: <20190305102733.30e25dae@shemminger-XPS-13-9360>
In-Reply-To: <20190304213357.16652-1-decui@microsoft.com>
References: <20190304213357.16652-1-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2019 21:34:47 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> Patch #1 fixes a memory leak caused by incorrectly-maintained hpdev->refs.
> 
> Patch #2 and #3 make sure the "slot" is removed in all the scenarios.
> Without them, in the quick hot-add/hot-remove test, systemd-dev may easily
> crash when trying to access a dangling sys file in /sys/bus/pci/slots/:
> "BUG: unable to handle kernel paging request".
> 
> BTW, Patch #2 was posted on Feb 7, 2019, and this is the v2: the change
> to hv_eject_device_work() in v1 is removed, as the change is only needed
> when we hot-remove the device and remove the pci-hyperv driver at the 
> same time. It looks more work is required to make this scenaro work
> correctly, and since removing the driver is not really a "usual" usage,
> we can address this scenario in the future.
> 
> Please review the patchset.
> 
> Dexuan Cui (3):
>   PCI: hv: Fix a memory leak in hv_eject_device_work()
>   PCI: hv: Add hv_pci_remove_slots() when we unload the driver
>   PCI: hv: Add pci_destroy_slot() in pci_devices_present_work(), if
>     necessary
> 
>  drivers/pci/controller/pci-hyperv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)


Thanks for fixing this.

Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
