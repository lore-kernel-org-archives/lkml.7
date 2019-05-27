Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C71C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086B62173C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558949365;
	bh=2MWFhjM4UY8IX250DkFNDH8WwQdNjxGm4HS/F78Ubx0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=JfBxbOl390XZ02MaXxBI2x+CABuCoaD6jU//BTFqEkBkQHNfKdi7FHnkfiyOjhA7v
	 WcylOxZvmIky0rwQwxJDweEAGSwbHDkFXPYeKQpdUZxoUyx8DHPCRrG41WBnaqmgka
	 0pNAH6HlkpbustKE06XaddkCFNbbIi9dZRQ71JBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfE0J3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfE0J3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:29:23 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 439972173B;
        Mon, 27 May 2019 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558949362;
        bh=2MWFhjM4UY8IX250DkFNDH8WwQdNjxGm4HS/F78Ubx0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kYSJaXs2gebpHBrDowtBFSu2CqFIPJRz8884hp2rZsdaV0dQzuDEQ3ZUokch+QkNV
         d6m+UX8/aHP4hphfWvU30waL8xaXpBwE8PHEj4IYh+HpFfDWpFahJugMfpZDIQ6/4x
         8ZQqOosmAml6Innx0KtArS+91hCkNJG/VOWUJJD4=
Date:   Mon, 27 May 2019 11:29:19 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [5.2-rc1 regression]: nvme vs. hibernation
In-Reply-To: <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
Message-ID: <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain> <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm> <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 May 2019, Dongli Zhang wrote:

> Looks this has been discussed in the past.
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> 
> I created a fix for a case but not good enough.
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html

That removes the warning, but I still seem to have ~1:1 chance of reboot 
(triple fault?) immediately after hibernation image is read from disk. 
Seems like that has been going all the way down to 4.19, which seems to be 
rock stable. It's a bit hard to bisect, as I am not really 100% sure 
whether this is one issue or two intermixed ones, and it doesn't reproduce 
completely reliably.

-- 
Jiri Kosina
SUSE Labs

