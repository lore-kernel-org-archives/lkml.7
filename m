Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A802ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6259B2168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569945965;
	bh=viFORMoHYlBKltHccmiUPBbIQT2qPwJiFLuYDJ9RYV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M7/TzYOkM9xukeRviKM8zZysPhlkeIf4Als5YwIGywc2L/MV14CqUyRlfYR1uJ+x9
	 HNH1A9qo559Ql6RfIqIbHswVgxFqW3PFNNIAS7FJvw+xBXu2KimZeFaPtZgLQQv6mD
	 KFRWoKl5MwIbXd2+pBxi8PXR/Nosm1Fxz5gBj0ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfJAQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfJAQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:06:03 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F12F2133F;
        Tue,  1 Oct 2019 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569945962;
        bh=viFORMoHYlBKltHccmiUPBbIQT2qPwJiFLuYDJ9RYV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uCi/zPA34gykz3giHeAXKfNiK+GAE+llviRRM/TR33ENpTcX2YcStrK9s8fPEBeeU
         7tdU3nNIJ8lBVZeMfxaCH1rBUhWGIpYzBQzL0HS63v7UMEeo40YPnOgxBAyESxqGJh
         0pbrgcp2h5i2q4wmuVUXGGgxGWql/tTc8ejB+rsg=
Date:   Tue, 1 Oct 2019 12:06:01 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Austin Kim <austindh.kim@gmail.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>, allison@lohutok.net,
        andy@infradead.org, armijn@tjaldur.nl, bp@alien8.de,
        dvhart@infradead.org, hpa@zytor.com, kjlu@umn.edu,
        platform-driver-x86@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.3 169/203] x86/platform/uv: Fix kmalloc() NULL
 check routine
Message-ID: <20191001160601.GX8171@sasha-vm>
References: <20190922184350.30563-1-sashal@kernel.org>
 <20190922184350.30563-169-sashal@kernel.org>
 <20190922202544.GA2719513@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190922202544.GA2719513@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 22, 2019 at 10:25:44PM +0200, Greg KH wrote:
>On Sun, Sep 22, 2019 at 02:43:15PM -0400, Sasha Levin wrote:
>> From: Austin Kim <austindh.kim@gmail.com>
>>
>> [ Upstream commit 864b23f0169d5bff677e8443a7a90dfd6b090afc ]
>>
>> The result of kmalloc() should have been checked ahead of below statement:
>>
>> 	pqp = (struct bau_pq_entry *)vp;
>>
>> Move BUG_ON(!vp) before above statement.
>>
>> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
>> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
>> Cc: Hedi Berriche <hedi.berriche@hpe.com>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Mike Travis <mike.travis@hpe.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Russ Anderson <russ.anderson@hpe.com>
>> Cc: Steve Wahl <steve.wahl@hpe.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: allison@lohutok.net
>> Cc: andy@infradead.org
>> Cc: armijn@tjaldur.nl
>> Cc: bp@alien8.de
>> Cc: dvhart@infradead.org
>> Cc: gregkh@linuxfoundation.org
>> Cc: hpa@zytor.com
>> Cc: kjlu@umn.edu
>> Cc: platform-driver-x86@vger.kernel.org
>> Link: https://lkml.kernel.org/r/20190905232951.GA28779@LGEARND20B15
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  arch/x86/platform/uv/tlb_uv.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
>> index 20c389a91b803..5f0a96bf27a1f 100644
>> --- a/arch/x86/platform/uv/tlb_uv.c
>> +++ b/arch/x86/platform/uv/tlb_uv.c
>> @@ -1804,9 +1804,9 @@ static void pq_init(int node, int pnode)
>>
>>  	plsize = (DEST_Q_SIZE + 1) * sizeof(struct bau_pq_entry);
>>  	vp = kmalloc_node(plsize, GFP_KERNEL, node);
>> -	pqp = (struct bau_pq_entry *)vp;
>> -	BUG_ON(!pqp);
>> +	BUG_ON(!vp);
>>
>> +	pqp = (struct bau_pq_entry *)vp;
>>  	cp = (char *)pqp + 31;
>>  	pqp = (struct bau_pq_entry *)(((unsigned long)cp >> 5) << 5);
>>
>
>How did this even get merged in the first place?  I thought a number of
>us complained about it.
>
>This isn't any change in code, and the original is just fine, the author
>didn't realize how C works :(
>
>Please drop this.

Heh, I've dropped it.

--
Thanks,
Sasha
