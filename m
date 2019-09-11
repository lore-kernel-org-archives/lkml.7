Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF58ECDE28
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE73222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568188568;
	bh=vwdg9KLjse6e40fTr8aUorTZdfy5Ppck3ADiYBkf1T4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jgYsjknJ+8u2OO5exPBV3Un/yOkCf8WkiattLIwzIb8caLn/xdspLa5i0/8KCO0S1
	 RMYNFAPL0/UNQk4iOe+bRsdK/hxt40WY7XbFxQNtSp68tcekPyQaNMNbIGj2jl1rUR
	 W1ECUjoRVDt1hfcAtiWzIDk0mw+d5HrRcpeNaw8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfIKH4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfIKH4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:56:07 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A300820872;
        Wed, 11 Sep 2019 07:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568188566;
        bh=vwdg9KLjse6e40fTr8aUorTZdfy5Ppck3ADiYBkf1T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lql4CiyQX+heooybFPSHweBYg47+93NbswFcMHmw9S7BaznL4jbaVGRLpH9+YLRxx
         Y+fc/AIWCX3tOALBJNCE7HGMevBuYz4x0i7pGGvx67iZnKaXXFh8pqi75QvyL9whzx
         blWuoauoUenq8nBmQuFaolKDEU/ODjPok59jw7eI=
Date:   Wed, 11 Sep 2019 03:56:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH AUTOSEL 4.19 126/167] tpm: Fix TPM 1.2 Shutdown sequence
 to prevent future TPM operations
Message-ID: <20190911075603.GH2012@sasha-vm>
References: <20190903162519.7136-1-sashal@kernel.org>
 <20190903162519.7136-126-sashal@kernel.org>
 <CAD=FV=W0YodeoOCiCv9zmv+-gswuU8U_XgrBnesE=wynTbDBiA@mail.gmail.com>
 <20190903165346.hwqlrin77cmzjiti@cantor>
 <20190903194335.GG5281@sasha-vm>
 <f2224c094836a4b8989c1cd6243a0b7ad1261a87.camel@linux.intel.com>
 <20190907220448.GB2012@sasha-vm>
 <20190909162808.ggcnrtvbvor7deqy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190909162808.ggcnrtvbvor7deqy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2019 at 05:28:08PM +0100, Jarkko Sakkinen wrote:
>On Sat, Sep 07, 2019 at 06:04:48PM -0400, Sasha Levin wrote:
>> On Sat, Sep 07, 2019 at 09:55:18PM +0300, Jarkko Sakkinen wrote:
>> > On Tue, 2019-09-03 at 15:43 -0400, Sasha Levin wrote:
>> > > Right. I gave a go at backporting a few patches and this happens to be
>> > > one of them. It will be a while before it goes in a stable tree
>> > > (probably way after after LPC).
>> >
>> > It *semantically* depends on
>> >
>> > db4d8cb9c9f2 ("tpm: use tpm_try_get_ops() in tpm-sysfs.c.")
>> >
>> > I.e. can cause crashes without the above patch. As a code change your
>> > patch is fine but it needs the above patch backported to work in stable
>> > manner.
>> >
>> > So... either I can backport that one (because ultimately I have
>> > responsibility to do that as the maintainer) but if you want to finish
>> > this one that is what you need to backport in addition and then it
>> > should be fine.
>>
>> If you're ok with the backport of this commit, I can just add
>> db4d8cb9c9f2 on top.
>
>Sure, I've already gave my promise to do that :-)

I think that the dependency in question is actually:

	2677ca98ae377 ("tpm: use tpm_try_get_ops() in tpm-sysfs.c.")

Which is tricky to backport. I think I'll drop this patch for now and
wait for your backport instead.

--
Thanks,
Sasha
