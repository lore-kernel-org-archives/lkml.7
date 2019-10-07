Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29A9ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72A620700
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570463091;
	bh=7AVcHfK0bWVvjbPHEPoXKNBy22PlFsfUrhaMLwuWDd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Robwo/HWGAjbzphPXRcffaOsznfoqUwvbdDrwgeGH1WX/LgVImTAMHOdatDJxJZ51
	 FjhFKy4hyrLCiMc68AOlAHMmVzhNyKk/U2sqIksTZwc6DcJynUh/tf65ADkU87hnhZ
	 c8Wh9NHElxdyIO0v2pkRy+Lj9BHN2ZiYeNU9/wtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbfJGPou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJGPou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:44:50 -0400
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E70020640;
        Mon,  7 Oct 2019 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570463089;
        bh=7AVcHfK0bWVvjbPHEPoXKNBy22PlFsfUrhaMLwuWDd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJsQV7x6ZBiPD5VZEcxKK9/wKGyBDjS3LqOw8dRYjFTV6E10xSlpPPswFT6XLffWr
         IAf2UukUH0CW3fWCT+BmXqqFdB5SYdrXYnDEAder6sy44MLnZMMXPfdXEnvg5iwL8J
         Ndikus1/w88Ex9MyuVIw4tNMX3ti/O40TZuXrdNg=
Date:   Mon, 7 Oct 2019 09:44:48 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tyler Ramer <tyaramer@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191007154448.GA3818@C02WT3WMHTD6>
References: <20191003191354.GA4481@Serenity>
 <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
 <20191006192109.GA9983@keith-busch>
 <CAKcoMVCDk+VDk6PSznTzMfJsjhZMdo6wBKZLzNbjDCkg73-WEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKcoMVCDk+VDk6PSznTzMfJsjhZMdo6wBKZLzNbjDCkg73-WEw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 11:13:12AM -0400, Tyler Ramer wrote:
> > Setting the shutdown to true is
> > usually just to get the queues flushed, but the nvme_kill_queues() that
> > we call accomplishes the same thing.
> 
> The intention of this patch was to clean up another location where
> nvme_dev_disable()
> is called with shutdown == false, but the device is being removed due
> to a failure
> condition, so it should be shutdown.
> 
> Perhaps though, given nvme_kill_queues() provides a subset of the
> functionality of
> nvme_dev_disable() with shutdown == true, we can just use
> nvme_dev_disable() and
> remove nvme_kill_queues()?
> 
> This will make nvme_remove_dead_ctrl() more in line with nvme_remove(),
> nvme_shutdown(), etc.

It's fine to use the shutdown == true in this path as well, but I just wanted
to understand what problem it was fixing. It doesn't sound like your scenario
is going to end up setting CC.SHN, so the only thing the shutdown should
accomplish is flushing pending IO, but we already call kill_queues() right
after the nvme_dev_disable(), so that part should be okay.
