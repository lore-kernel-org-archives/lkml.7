Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071AF206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554308428;
	bh=uvDzPPcgD6ibOpn3lvDbvnPTgRR/F2rLiM4f3JPupXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U2ELFlIy3CYo6I92wrdModX2TjdQXtDBYHA1y3vB6oMUselFXvcYrbAcY3XwFu2P/
	 Ez2wNNbXfpBaxQi/xaFUIhCeNzL5uYqD7NDNlpXlGZgkqDiE1Xx/06lJy/eUrtY3GF
	 noUHga/MMvaAC9Q6Snf+YV+MV/zlxIaZPCdQSFRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:20:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D64206C0;
        Wed,  3 Apr 2019 16:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554308425;
        bh=uvDzPPcgD6ibOpn3lvDbvnPTgRR/F2rLiM4f3JPupXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vkohOEoHxQhqkr/o79LcFd0wgxOrtmOa7vnevHt0M1lOSWe6VhTbFwPHLAU9qEyAN
         f+mhego9jIdaUzqz7J3etY/cvRbgpGLAgquFtbyFdHI6cPuLotVVEnKX/rReinHcKm
         VXMcjMpz+l+NB0GWVBmCLPFCkCP5FGUcINw8V4B8=
Date:   Wed, 3 Apr 2019 12:20:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        John Hurley <john.hurley@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        oss-drivers@netronome.com, netdev@vger.kernel.org
Subject: Re: [oss-drivers] [PATCH AUTOSEL 5.0 234/262] nfp: flower: tidy
 tunnel related private data
Message-ID: <20190403162024.GE16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-234-sashal@kernel.org>
 <20190327111549.32911fa7@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190327111549.32911fa7@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 11:15:49AM -0700, Jakub Kicinski wrote:
>On Wed, 27 Mar 2019 14:01:29 -0400, Sasha Levin wrote:
>> From: John Hurley <john.hurley@netronome.com>
>>
>> [ Upstream commit f3b975778c176b01eba10f869a5a64c6b8550c23 ]
>>
>> Recent additions to the flower app private data have grouped the variables
>> of a given feature into a struct and added that struct to the main private
>> data struct.
>>
>> In keeping with this, move all tunnel related private data to their own
>> struct. This has no affect on functionality but improves readability and
>> maintenance of the code.
>>
>> Signed-off-by: John Hurley <john.hurley@netronome.com>
>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: David S. Miller <davem@davemloft.net>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Not a fix.
>
>Is there a way to request patches under drivers/net/ethernet/netronome
>to only be considered if they have an explicit Fixes tag?

Yup, I can add it to my ignore list. Thanks!

--
Thanks,
Sasha
