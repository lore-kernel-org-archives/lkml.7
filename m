Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D2C3A5A1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3E32086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566215967;
	bh=q77Pbhmhnh6Au20DEcDQ5LO3Vkm4vsi4MxushgYg41E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H0lXy/RtBYS6L5qzC7IKmSpadCgc12qipvFA1gs+aG4snIMJD/5tSkZtihOcUolKv
	 1OeTEhdZzXuvR8rFqPAlzz7w8rDXWxh2rUCbi29LkMPo9hcV5wpM5ra/VkBlyMe8sg
	 cQhJugEoifGidaEjy7CGLIbwqvNciFWtlKb49h6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfHSL70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfHSL7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:59:25 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 671A92085A;
        Mon, 19 Aug 2019 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566215965;
        bh=q77Pbhmhnh6Au20DEcDQ5LO3Vkm4vsi4MxushgYg41E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3vNIVXPUawlMLueohhELWKvuJra7RP2DDGlMa5I/7nWQKz1W+a3ErxDRcogqR7Ko
         rLATceezBol1V7KPynDYF8Pw3vKAQtJAs0+kgEjCfv3iBjWdPm1pWnF/hSFr70tnsl
         rcUrfEo5Abgdwes/jZnkwTTDwb7GZNgnuzDjsNBE=
Date:   Mon, 19 Aug 2019 14:59:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] infiniband: hfi1: fix a memory leak bug
Message-ID: <20190819115921.GE4459@mtr-leonro.mtl.com>
References: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566156571-4335-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 02:29:31PM -0500, Wenwen Wang wrote:
> In fault_opcodes_read(), 'data' is not deallocated if debugfs_file_get()
> fails, leading to a memory leak. To fix this bug, introduce the 'free_data'
> label to free 'data' before returning the error.
>
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/infiniband/hw/hfi1/fault.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Thanks,
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
