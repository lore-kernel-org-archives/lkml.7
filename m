Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55202C47E48
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC96222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbfIZJuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:50:04 -0400
Received: from foss.arm.com ([217.140.110.172]:43972 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfIZJuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:50:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9467A1000;
        Thu, 26 Sep 2019 02:50:03 -0700 (PDT)
Received: from [10.37.8.90] (unknown [10.37.8.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8207A3F67D;
        Thu, 26 Sep 2019 02:50:01 -0700 (PDT)
Subject: Re: [RFC PATCH] xen/gntdev: Stop abusing DT of_dma_configure API
To:     Rob Herring <robh@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20190925215006.12056-1-robh@kernel.org>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <e898c025-32a7-1d2c-3501-c99556f7cdd4@arm.com>
Date:   Thu, 26 Sep 2019 10:49:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925215006.12056-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On 9/25/19 10:50 PM, Rob Herring wrote:
> As the comment says, this isn't a DT based device. of_dma_configure()
> is going to stop allowing a NULL DT node, so this needs to be fixed.

And this can't work on arch not selecting CONFIG_OF and can select 
CONFIG_XEN_GRANT_DMA_ALLOC.

We are lucky enough on x86 because, AFAICT, arch_setup_dma_ops is just a 
nop.

> 
> Not sure exactly what setup besides arch_setup_dma_ops is needed...

We probably want to update dma_mask, coherent_dma_mask and dma_pfn_offset.

Also, while look at of_configure_dma, I noticed that we consider the DMA 
will not be coherent for the grant-table. Oleksandr, do you know why 
they can't be coherent?

Cheers,

-- 
Julien Grall
