Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403DDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC102084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDCGGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:06:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfDCGGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:06:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A6473082141;
        Wed,  3 Apr 2019 06:06:11 +0000 (UTC)
Received: from xz-x1 (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F2331018A16;
        Wed,  3 Apr 2019 06:06:00 +0000 (UTC)
Date:   Wed, 3 Apr 2019 14:05:58 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.auger@redhat.com, cohuck@redhat.com
Subject: Re: [PATCH v2] vfio/type1: Limit DMA mappings per container
Message-ID: <20190403060558.GL11008@xz-x1>
References: <155422160029.16896.1992475589398080933.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <155422160029.16896.1992475589398080933.stgit@gimli.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 03 Apr 2019 06:06:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 10:15:38AM -0600, Alex Williamson wrote:
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

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
