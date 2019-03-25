Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FB20651
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfCYUtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:49:31 -0400
Received: from smtprelay0212.hostedemail.com ([216.40.44.212]:57634 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729473AbfCYUtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:49:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A79311803901F;
        Mon, 25 Mar 2019 20:49:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smell02_8cc15a2eb6f00
X-Filterd-Recvd-Size: 1600
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 20:49:27 +0000 (UTC)
Message-ID: <4faf234df19c1b54b70cbe82c0dacacc58568b87.camel@perches.com>
Subject: Re: [PATCH] vfio: Use dev_printk() when possible
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 25 Mar 2019 13:49:25 -0700
In-Reply-To: <20190325194220.5873-1-helgaas@kernel.org>
References: <20190325194220.5873-1-helgaas@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 14:42 -0500, Bjorn Helgaas wrote:
> Use dev_printk() when possible to make messages consistent with other
> device-related messages.

trivial note:

> diff --git a/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c b/drivers/vfio/platform/reset/vfio_platform_amdxgbe.c
[]
> @@ -89,7 +89,8 @@ static int vfio_platform_amdxgbe_reset(struct vfio_platform_device *vdev)
>  	} while ((pcs_value & MDIO_CTRL1_RESET) && --count);
>  
>  	if (pcs_value & MDIO_CTRL1_RESET)
> -		pr_warn("%s XGBE PHY reset timeout\n", __func__);
> +		dev_warn(&vdev->device, "%s XGBE PHY reset timeout\n",
> +			 __func__);

Many of these could use a colon after the %s used with __func__
to make the output more consistent with other modules.



