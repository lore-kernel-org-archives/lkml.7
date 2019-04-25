Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B057C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05980218AD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556182225;
	bh=z8wekSRyNs/HMYnqPzwQaEnp8K0ifKZkHIxJmCUqzuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zZi0q4VKxxkKSsrEJodstMMeA7+BgYRcIPi82w4pI6/dlQ4LbF49eAc5gj+Q9ckkr
	 sKK1sanqMG7YtvEso0yfj4INAGnXRUdVNjaYgS4VXSYkeeTKNwCkvtKMknssxekIUL
	 HfP15LnM3AQK/MSXOK7mmcsBnPJsOmNH93uKG4f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfDYIuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:50:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727600AbfDYIuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:50:23 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A20217FA;
        Thu, 25 Apr 2019 08:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556182222;
        bh=z8wekSRyNs/HMYnqPzwQaEnp8K0ifKZkHIxJmCUqzuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DoWnlvbddd5yko9egFCXPUVIy1Gt3V0MUK8H0AZNBSVFSlwhrTofwDWGn0BIbk+fR
         gXGxOj9caQDf/MvJFw5HSxrrP+nhacdC6SZ1+RZDgSnuiOAPvZqUvMsKRHcq0jf6Dd
         1YEpDLKjCIt5m2PbBabIXOWmzVAPwNa2g9rHlRYI=
Date:   Thu, 25 Apr 2019 10:50:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.2
Message-ID: <20190425085020.GA10136@kroah.com>
References: <20190423121032.3910-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423121032.3910-1-kishon@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 05:40:32PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request of 5.2 merge window below.
> 
> It adds a new PHY ops to _release_ the PHY which can be used by PHY drivers
> for cleaning up any initializations done during phy_get.
> It adds a number of new PHY driver including Amlogic's USB2 PHY and a
> shared USB3 + PCIE PHY, Broadcom's Stingray USB PHY, Hisilicon's USB PHY
> in hi3660, MediaTek's UFS M-PHY, Nvidia's XUSB pad controller in
> Tegra186 and TI's AM654 SERDES.
> 
> For the complete list of changes, see the tag message below.
> 
> There is a change in ufs-qcom.c (SCSI subsystem) which now exposes the
> reset controller to be used by PHY. This is required to disable the
> regulator that powers UFS in order to save power during system suspend
> while following the PHY initialization sequence.
> 
> All of these were present in linux-next for quite a while and shouldn't
> have any conflicts.
> 
> Let me know If I have to make any changes.
> 
> Thanks
> Kishon
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2

Now pulled and pushed out, thansk.

greg k-h
