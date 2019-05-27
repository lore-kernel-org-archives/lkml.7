Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD0C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D782147A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558955731;
	bh=abFhqbcVcrasy/wr5aCm8Glq6HOxIRsVdv0H1i3SDnc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=T6OJubls4p2clDjRvTNQKa4ngkWqVlTYrwBI1X69zVZVb1DWIQObKCBODGIaSbAqW
	 AylZHwWzFpOyBQZASxaNGp5DdDdOx2VWKHGh88zHMi0BRIXVbTvUM+1YjOB4gtviKQ
	 7PdtH2Rz4UjcyrDgumD9I6bSNrRFd76dbML7QRiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE0LPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:15:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfE0LP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:15:29 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A7CE20883;
        Mon, 27 May 2019 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558955729;
        bh=abFhqbcVcrasy/wr5aCm8Glq6HOxIRsVdv0H1i3SDnc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=J3NvQTbaYjRiw/RE9MlC9Ug4WIfDfl+Cijv8OZTajxW2gXsYhqFzgHZqUn9KyPpvj
         BQ68zJD2eSfJBxk9VxPE0JWfrqL54pNHnpdVXmCn0dbpkJIVH5L/qlnEjItNyJxu2I
         jM7++WXGlW8Y4YhcFwsCQoB5Vs29zBafdmVaszn0=
Date:   Mon, 27 May 2019 13:15:25 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [5.2-rc1 regression]: nvme vs. hibernation
In-Reply-To: <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905271313520.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm> <20190524154429.GE15192@localhost.localdomain> <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm> <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2019, Jiri Kosina wrote:

> > Looks this has been discussed in the past.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> > 
> > I created a fix for a case but not good enough.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html
> 
> That removes the warning, but I still seem to have ~1:1 chance of reboot 
> (triple fault?) immediately after hibernation image is read from disk. 
> Seems like that has been going all the way down to 4.19, which seems to be 
> rock stable. It's a bit hard to bisect, as I am not really 100% sure 
> whether this is one issue or two intermixed ones, and it doesn't reproduce 
> completely reliably.

So far this seems to be independent issue, related to kASLR, I'll look 
into that separately.

Still, we should either remove the warning or fix the underlying issue.

Thanks,

-- 
Jiri Kosina
SUSE Labs

