Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42E0C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1902075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732243AbfDBO6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:58:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfDBO6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:58:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D8063086223;
        Tue,  2 Apr 2019 14:58:43 +0000 (UTC)
Received: from gondolin (dhcp-192-213.str.redhat.com [10.33.192.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A9D060856;
        Tue,  2 Apr 2019 14:58:37 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:58:35 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com
Subject: Re: [PATCH] vfio/type1: Limit DMA mappings per container
Message-ID: <20190402165835.53d4ec9b.cohuck@redhat.com>
In-Reply-To: <155414977872.12780.13728555131525362206.stgit@gimli.home>
References: <155414977872.12780.13728555131525362206.stgit@gimli.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 02 Apr 2019 14:58:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Apr 2019 14:16:52 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Memory backed DMA mappings are accounted against a user's locked
> memory limit, including multiple mappings of the same memory.  This
> accounting bounds the number of such mappings that a user can create.
> However, DMA mappings that are not backed by memory, such as DMA
> mappings of device MMIO via mmaps, do not make use of page pinning
> and therefore do not count against the user's locked memory limit.
> These mappings still consume memory, but the memory is not well
> associated to the process for the purpose of oom killing a task.
> 
> To add bounding on this use case, we introduce a limit to the total
> number of concurrent DMA mappings that a user is allowed to create.
> This limit is exposed as a tunable module option where the default
> value of 64K is expected to be well in excess of any reasonable use
> case (a large virtual machine configuration would typically only make
> use of tens of concurrent mappings).
> 
> This fixes CVE-2019-3882.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
