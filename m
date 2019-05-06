Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E815C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0AE20675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfEFV6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48874 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEFV6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:58:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 451D33087932;
        Mon,  6 May 2019 21:58:47 +0000 (UTC)
Received: from x1.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1868260BEC;
        Mon,  6 May 2019 21:58:46 +0000 (UTC)
Date:   Mon, 6 May 2019 15:58:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Greg Kurz <groug@kaod.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] vfio-pci/nvlink2: Fix potential VMA leak
Message-ID: <20190506155845.70f3b01d@x1.home>
In-Reply-To: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
References: <155568823785.601037.2151744205292679252.stgit@bahia.lan>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 06 May 2019 21:58:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Apr 2019 17:37:17 +0200
Greg Kurz <groug@kaod.org> wrote:

> If vfio_pci_register_dev_region() fails then we should rollback
> previous changes, ie. unmap the ATSD registers.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---

Applied to vfio next branch for v5.2 with Alexey's R-b.  Thanks!

Alex

>  drivers/vfio/pci/vfio_pci_nvlink2.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_nvlink2.c b/drivers/vfio/pci/vfio_pci_nvlink2.c
> index 32f695ffe128..50fe3c4f7feb 100644
> --- a/drivers/vfio/pci/vfio_pci_nvlink2.c
> +++ b/drivers/vfio/pci/vfio_pci_nvlink2.c
> @@ -472,6 +472,8 @@ int vfio_pci_ibm_npu2_init(struct vfio_pci_device *vdev)
>  	return 0;
>  
>  free_exit:
> +	if (data->base)
> +		memunmap(data->base);
>  	kfree(data);
>  
>  	return ret;
> 

