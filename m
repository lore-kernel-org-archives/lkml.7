Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553F20830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570101983;
	bh=AhZQoGf4zTRrL+qcSHQEtSnkoivcIWq/JAiSadZKrWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lNB8NKFalGXgRB/1AuyWj/N2c8X60xwhmaR4aMiqEs2PX8dPYn6jthGM/Bs9qSAM1
	 XNFvuqWk/FFRZNWBM5MloK2oAWYGCP0yxauv4EhUBZmHLc+Vq7psb019oYKRcZsNYI
	 G7IwapiHdmoirmOfXFrZXMgToM8KNiMVZowBCQec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfJCL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:26:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCL0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:26:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E162F206BB;
        Thu,  3 Oct 2019 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570101981;
        bh=AhZQoGf4zTRrL+qcSHQEtSnkoivcIWq/JAiSadZKrWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F+4psT/Bq+vGjfcihWhKTzx0SjGv+QFdtvvVGXRCweHjdQf2sn8P7fuBz17qDXxt4
         d0O6H/mjoOSZ289JAtWH/PSxRLmNGJKmiUMhKbYu1ze1pq04IrhTrLDTg/e9oFmtBX
         Z/eGrAvlBBGcw8jh3qSMOcpHSIpZoTEKvnwdV4lE=
Date:   Thu, 3 Oct 2019 13:26:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC][PATCH 2/3] usb: roles: Add usb role switch notifier.
Message-ID: <20191003112618.GA2420393@kroah.com>
References: <20191002231617.3670-1-john.stultz@linaro.org>
 <20191002231617.3670-3-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002231617.3670-3-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 11:16:16PM +0000, John Stultz wrote:
> From: Yu Chen <chenyu56@huawei.com>
> 
> This patch adds notifier for drivers want to be informed of the usb role
> switch.

Ick, I hate notifiers, they always come back to cause problems.

What's just wrong with a "real" call to who ever needs to know this?
And who does need to know this anyway?  Like Hans said, if we don't have
a user for it, we should not add it.

thanks,

greg k-h
