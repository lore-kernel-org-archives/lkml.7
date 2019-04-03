Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776ACC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0BA2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbfDCSwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:52:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50370 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:52:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1A40C075D8B;
        Wed,  3 Apr 2019 18:52:21 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 227F64F067;
        Wed,  3 Apr 2019 18:52:21 +0000 (UTC)
Date:   Wed, 3 Apr 2019 12:52:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     aik@ozlabs.ru, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] vfio/pci: use correct format characters
Message-ID: <20190403125220.4d6353ff@x1.home>
In-Reply-To: <20190228194812.30929-1-louis@kragniz.eu>
References: <20190228194812.30929-1-louis@kragniz.eu>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 03 Apr 2019 18:52:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2019 19:48:12 +0000
Louis Taylor <louis@kragniz.eu> wrote:

> When compiling with -Wformat, clang emits the following warnings:
> 
> drivers/vfio/pci/vfio_pci.c:1601:5: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                 ^~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1601:13: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                         ^~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1601:21: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                 ^~~~~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1601:32: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                            ^~~~~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1605:5: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                 ^~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1605:13: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                         ^~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1605:21: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                 ^~~~~~~~~
> 
> drivers/vfio/pci/vfio_pci.c:1605:32: warning: format specifies type
>       'unsigned short' but the argument has type 'unsigned int' [-Wformat]
>                                 vendor, device, subvendor, subdevice,
>                                                            ^~~~~~~~~
> The types of these arguments are unconditionally defined, so this patch
> updates the format character to the correct ones for unsigned ints.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---

Applied to vfio for-linus branch for v5.1 with Nick's R-b.  Thanks!

Alex

>  drivers/vfio/pci/vfio_pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index a25659b5a5d1..3fa20e95a6bb 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1661,11 +1661,11 @@ static void __init vfio_pci_fill_ids(void)
>  		rc = pci_add_dynid(&vfio_pci_driver, vendor, device,
>  				   subvendor, subdevice, class, class_mask, 0);
>  		if (rc)
> -			pr_warn("failed to add dynamic id [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x (%d)\n",
> +			pr_warn("failed to add dynamic id [%04x:%04x[%04x:%04x]] class %#08x/%08x (%d)\n",
>  				vendor, device, subvendor, subdevice,
>  				class, class_mask, rc);
>  		else
> -			pr_info("add [%04hx:%04hx[%04hx:%04hx]] class %#08x/%08x\n",
> +			pr_info("add [%04x:%04x[%04x:%04x]] class %#08x/%08x\n",
>  				vendor, device, subvendor, subdevice,
>  				class, class_mask);
>  	}

