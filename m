Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0A8C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C32186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 01:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555722768;
	bh=DAIimE/QAXzynNbNX5bEdlCnR/hW0nw3ObD19MBz0a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2eBmtq9kQz7fIGS1cBcEfH7K2dsHmULg3usMrqEM+FhSS09xl59EY06S56HrJSTs4
	 UVx0A7bk1i0mSPpV9TXdJKacATPbBgfqYKbHy5VBLP5u2TEcf9HPp//l9meVNCSzVB
	 4hEvWQ5bYekL3YxTqU9fKvtTGY5wZwFP8w7g/11Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfDTBMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 21:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfDTBMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 21:12:47 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BEF420859;
        Sat, 20 Apr 2019 01:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555722766;
        bh=DAIimE/QAXzynNbNX5bEdlCnR/hW0nw3ObD19MBz0a4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdz4HLSfp4sFEi8eJcjrkQ9v+fx4WYbGCe0uaqjLpRTPs3gW2t4A2ie/eYvWPhn3x
         HXTJnRjFOTXZdjiziVjgDT/KQoIqbElm363r9uUN1zuhLFnnWyoC6+dXf/fbEMDxVo
         zaEeX9XWnga3xpXzeCOyNPpEGrWxvd62nKQPiKyA=
Date:   Fri, 19 Apr 2019 21:12:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
Message-ID: <20190420011245.GG17719@sasha-vm>
References: <20190418160422.455656724@linuxfoundation.org>
 <20190419193926.GA10320@roeck-us.net>
 <20190419201637.GA5347@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190419201637.GA5347@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:16:37PM -0700, Guenter Roeck wrote:
>On Fri, Apr 19, 2019 at 12:39:26PM -0700, Guenter Roeck wrote:
>> On Thu, Apr 18, 2019 at 07:57:11PM +0200, Greg Kroah-Hartman wrote:
>> > This is the start of the stable review cycle for the 4.9.170 release.
>> > There are 50 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, please
>> > let me know.
>> >
>> > Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
>> > Anything received after that time might be too late.
>> >
>> Build results:
>> 	total: 172 pass: 170 fail: 2
>> Failed builds:
>> 	i386:tools/perf
>> 	x86_64:tools/perf
>
>Caused by "tools include: Adopt linux/bits.h". That isn't really
>a bug fix, and since it is the last commit in the perf directory
>it isn't needed either. Reverting it fixes the problem.

Indeed. I'll remove it from all branches since it doesn't look like a
fix to begin with.

--
Thanks,
Sasha
