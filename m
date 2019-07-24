Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25915C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04D621926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563960843;
	bh=3cSIO9EZDi3J13tYyRv3TfjK0zuvMILYluyj3HtRV7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DKr7xYwcQZu7JQoXPT0Quyai33APkTcyz6Zc222ciEjoVROLAOHCtPt15Qd2fO/sW
	 bQ5Pu+KPdqFkugThfOUBHmhBME/YDiQbeuEQa1FlvXl+pQfYtU7Z4BXuJzd1NPiYYD
	 O1FGV3WCZiqq0XWoH/Ps1ruGXKbB1UiyZLzryP40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfGXJeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfGXJeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:34:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAFB421926;
        Wed, 24 Jul 2019 09:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563960840;
        bh=3cSIO9EZDi3J13tYyRv3TfjK0zuvMILYluyj3HtRV7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+lCRxoLNB76QsKlZeG7tXK7idALbdmsQiHPTlBdK8ON/1oNMKvuA6QEXrxEaCROc
         0Gh5shjqnao27yA/FVidF5XwQLpjoCcpG967kMPkZQc3QCo5DmnlhrJYfYZPu+RTHO
         trlrCDn2h8x9MqDb4AqRSE67jRlcFE6u4QVtSqtQ=
Date:   Wed, 24 Jul 2019 11:33:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Zhang Yi Z <yi.z.zhang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 02/12] fpga: dfl: fme: add
 DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.
Message-ID: <20190724093357.GA29532@kroah.com>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
 <1563857495-26692-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563857495-26692-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 12:51:25PM +0800, Wu Hao wrote:
> +/**
> + * dfl_fpga_cdev_config_port - configure a port feature dev
> + * @cdev: parent container device.
> + * @port_id: id of the port feature device.
> + * @release: release port or assign port back.
> + *
> + * This function allows user to release port platform device or assign it back.
> + * e.g. to safely turn one port from PF into VF for PCI device SRIOV support,
> + * release port platform device is one necessary step.
> + */
> +int dfl_fpga_cdev_config_port(struct dfl_fpga_cdev *cdev, int port_id,
> +			      bool release)
> +{
> +	return release ? detach_port_dev(cdev, port_id) :
> +			 attach_port_dev(cdev, port_id);
> +}
> +EXPORT_SYMBOL_GPL(dfl_fpga_cdev_config_port);

That's a horrible api.  Every time you see this call in code, you have
to go and look up what "bool" means here.  There's no reason for it.

Just have 2 different functions, one that attaches a port, and one that
detaches it.  That way when you read the code that calls this function,
you know what it does instantly without having to go look up some api
function somewhere else.

Write code for people to read first.  And you are saving nothing here by
trying to do two different things in the same exact function.

thanks,

greg k-h
