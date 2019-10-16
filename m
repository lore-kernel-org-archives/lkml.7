Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D575FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70192067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571236277;
	bh=tK6PEB/vdqs3D5dK7xuBVC/lJ+4FHfCBB+s4yE3ld+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mu14/gF7udy4SK/UGakGCnwMXyWF86eD6/bzduq8nhlqeHW5zMfC9IO8JZDBLFzPo
	 zMQJAI1JVgKpheTtojc+4te4EmWeylhNHycOoabJBHJDCkIxMMA2l1OfRn7SVG+rgI
	 IUB3cTrAKOw7gpcZLS5hqWNdwJS+AN6aUkWxVa5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394097AbfJPObP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:31:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbfJPObP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:31:15 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E2E20650;
        Wed, 16 Oct 2019 14:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571236274;
        bh=tK6PEB/vdqs3D5dK7xuBVC/lJ+4FHfCBB+s4yE3ld+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkTD/cTAgZVUpecgbl5rcJGUqwspFVHGHQ85pwloVeiHDEP+ZjGU4NWtpoBNyPXN0
         xLdLRKj53+aT8+MFBw9Ib+vH1bZxV9DoT0DOdUukov23iaba3oOGlRmtL/GH+iMU2i
         cyVp5wcaxcov0DtfVkAkGiRWEP4B0p1voXlWsMF4=
Date:   Wed, 16 Oct 2019 10:31:13 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191016143113.GS31224@sasha-vm>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191016140353.4hrncxa5wkx47oau@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:03:53PM +0200, Pali Rohár wrote:
>On Friday 30 August 2019 09:56:47 Pali Rohár wrote:
>> On Thursday 29 August 2019 19:35:06 Sasha Levin wrote:
>> > With regards to missing specs/docs/whatever - our main concern with this
>> > release was that we want full interoperability, which is why the spec
>> > was made public as-is without modifications from what was used
>> > internally. There's no "secret sauce" that Microsoft is hiding here.
>>
>> Ok, if it was just drop of "current version" of documentation then it
>> makes sense.
>>
>> > How about we give this spec/code time to get soaked and reviewed for a
>> > bit, and if folks still feel (in a month or so?) that there are missing
>> > bits of information related to exfat, I'll be happy to go back and try
>> > to get them out as well.
>
>Hello Sasha!
>
>Now one month passed, so do you have some information when missing parts
>of documentation like TexFAT would be released to public?

Sure, I'll see if I can get an approval to open it up.

Can I assume you will be implementing TexFAT support once the spec is
available?

-- 
Thanks,
Sasha
