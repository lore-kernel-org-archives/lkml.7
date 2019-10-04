Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C72DC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09A21D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570196855;
	bh=wVlonrP/JbwtKS/oWoDn/qqfNjewswSIuSebV205v1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C9V+CK2226naGpsZ1R0XvLNz4QShBy5N30uxbOMKBIbpwR8euf3AvEmmD4GY4WQ3C
	 rtQ6iHILB041lCaBELs8PaCI0nQnlAAX2e+fxzar02+aLAMtqmAAE9r3MvVqdyRXmv
	 RNjQh/RdfGrR77Ft1zwS697ytOE5ri4XcnK60VOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbfJDNre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388438AbfJDNre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:47:34 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744DD20700;
        Fri,  4 Oct 2019 13:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570196853;
        bh=wVlonrP/JbwtKS/oWoDn/qqfNjewswSIuSebV205v1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LeIfYo+wgThfjYSZyRICJlknNQ79leOAX+LOXPxa8Blx1MxYaD+iTZ4n2ghzx6vsO
         nZFQw0lRDh17h5aVdhrllE0ZXXg7+CrBAsyBcLxIECjSVbMQpFxYPzEPpc1ENhR2u8
         JvnU6vntVJXblTljjs6Zk6jdx0gg0WQDZ5uxDHNo=
Date:   Fri, 4 Oct 2019 09:47:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        A Sun <as1033x@comcast.net>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 4.19 090/211] media: mceusb: fix (eliminate) TX IR signal
 length limit
Message-ID: <20191004134732.GG17454@sasha-vm>
References: <20191003154447.010950442@linuxfoundation.org>
 <20191003154507.534538747@linuxfoundation.org>
 <20191004101215.GB24970@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191004101215.GB24970@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 12:12:15PM +0200, Pavel Machek wrote:
>On Thu 2019-10-03 17:52:36, Greg Kroah-Hartman wrote:
>> From: A Sun <as1033x@comcast.net>
>
>> Other changes:
>>
>> The driver's write to USB device architecture change (async to sync I/O)
>> is significant so we bump DRIVER_VERSION to "1.95" (from "1.94").
>
>> ---
>>  drivers/media/rc/mceusb.c | 334 ++++++++++++++++++++++----------------
>>  1 file changed, 196 insertions(+), 138 deletions(-)
>
>This is not a bugfix, this is rewrite that happens to remove a
>limitation, and it is way over the 100 line limit. What is going on
>here? Why is it even considered for stable?

It's on the bigger side, sure, but it's contained inside a driver and
seems to fix an actual issue.

--
Thanks,
Sasha
