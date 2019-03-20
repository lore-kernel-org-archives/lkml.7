Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D130D20857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 03:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="AQFMbMTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfCTDMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 23:12:03 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17814 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726749AbfCTDMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 23:12:02 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 23:12:00 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1553050460; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=iN8zMl/E4OxZmWGYhO/XZfgFwvz8qcsT1z77kx8Kpf+gpb1oJYOQ52QfucyqFuoIDFDh3+/iyF6w3Iwd7e9kOO0+FYCbJem7/HA6QhH1lp4uFuSbzSH4gd3HscDCDaL9pwFqBWleIKwS5cW/E8pRRocIrhXCehNtRn5O9qPOsxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1553050460; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=Bkj9qVX6lovTRA5/LtbQdN5ooBi9eafvXSUBaTln7uc=; 
        b=XDY4EjJ42svw//SeWqLV2B2PFWr7GV4P9untTTfhyJubV14WgE/RCS/km1eb/noF1hilaH34Ehrg4VFlx5raZI4J+TmORWbXYVzzYBzKUSyEtawWQKtFnciywJOZ4YpEQBrFgHupdRppBugYs3kyngVso0C0RkHsAOxbq3sqVlE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1553050460;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=257; bh=Bkj9qVX6lovTRA5/LtbQdN5ooBi9eafvXSUBaTln7uc=;
        b=AQFMbMTtf13LBYBio72MV7DB9IE6bZZdVnylol+9pxlKhwAN66GrJbxN7LSQugrf
        cdbiL4a9Jte5cLnh2ebgxkooe/rt/dNyLKScaNhy5oefdqvz1AbC4l7rcwS2aKxwW2S
        mavGvO9ubFa07wyT9fRCWmBjsX4kIoCIziAh/zn4=
Received: from localhost (120.52.147.47 [120.52.147.47]) by mx.zoho.com.cn
        with SMTPS id 1553050457751417.14378170390694; Wed, 20 Mar 2019 10:54:17 +0800 (CST)
Date:   Wed, 20 Mar 2019 10:54:15 +0800
From:   Fam Zheng <fam@euphon.net>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Amnon Ilan <ailan@redhat.com>, John Ferlan <jferlan@redhat.com>
Subject: Re: [PATCH 4/9] nvme/pci: use the NVME_CTRL_SUSPENDED state
Message-ID: <20190320025415.bli42qmifuu5gxdm@deb>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <20190319144116.400-5-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319144116.400-5-mlevitsk@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03/19 16:41, Maxim Levitsky wrote:
> When enteriing low power state, the nvme

Typo: "entering".

> driver will now inform the core with the NVME_CTRL_SUSPENDED state
> which will allow mdev driver to act on this information

[snip]

Fam

