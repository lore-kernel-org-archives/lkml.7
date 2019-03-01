Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153D0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C672920830
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551424923;
	bh=5l1ePDVXl8slynIQWUWeM3TKYW4L+LprTsi2SSp63Rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FnfoJMpvflrTHsm5B3/qh90kGq0MMEpMOyLaCEtx67a28YNQt6yoaIEPyStdSz6Tb
	 hTbil89RK0AvRXUf7XMEbx5QuvfFwj+RO8BLwjAgH+HoE1sQqr/DJihL57/Bk6qN0c
	 s0hDIermHaQIvECGO2hH7gbc4zhv3Pj0ketOEngA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732311AbfCAHWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:22:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbfCAHWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:22:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A71FF20830;
        Fri,  1 Mar 2019 07:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551424921;
        bh=5l1ePDVXl8slynIQWUWeM3TKYW4L+LprTsi2SSp63Rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPlLXt+42BOgPSA0kSBD3Qp+gJgiqMESqSA7OBT9C1yjLHlfE5xX21Fn25DkuLyI9
         04veI1rjuhL4Z9Uo9JZnLFlfWqgKu4nyaiZfiB4GWxT3OAGCckZnAarH4ywvs3SuoD
         3qgIacRFiKWgcbtI9h4t03NOgganJBxz1J3RyBJs=
Date:   Fri, 1 Mar 2019 08:21:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net, jiri@mellanox.com
Subject: Re: [RFC net-next 8/8] net/mlx5: Add subdev driver to bind to subdev
 devices
Message-ID: <20190301072158.GC8975@kroah.com>
References: <1551418672-12822-1-git-send-email-parav@mellanox.com>
 <1551418672-12822-9-git-send-email-parav@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551418672-12822-9-git-send-email-parav@mellanox.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:37:52PM -0600, Parav Pandit wrote:
> Add a subdev driver to probe the subdev devices and create fake
> netdevice for it.

So I'm guessing here is the "meat" of the whole goal here?

You just want multiple netdevices per PCI device?  Why can't you do that
today in your PCI driver?

What problem are you trying to solve that others also are having that
requires all of this?

Adding a new bus type and subsystem is fine, but usually we want more
than just one user of it, as this does not really show how it is
exercised very well.  Ideally 3 users would be there as that is when it
proves itself that it is flexible enough.

Would just using the mfd subsystem work better for you?  That provides
core support for "multi-function" drivers/devices already.  What is
missing from that subsystem that does not work for you here?

thanks,

greg k-h
