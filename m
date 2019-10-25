Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07DCA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E55421D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572016751;
	bh=6U9yIyl+gH518MCteIB4aAjbK70ZMDQ6y82ZAzopgrs=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=daIpE7Er6v1uTWWv0U71B39vgeMrXNcaspotI5mW6iOTiq89VGfx47nA6Q83KO1Az
	 iNteM8tszcjkGcExS7SuNIheAI3KFErR75qdoRFutNcia3lzD3LWDQSNQae4lqQF9T
	 FN4tA/ATUbKxVwld4cy2rOjrydsj9lKhTjCY1tb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440629AbfJYPTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 11:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440617AbfJYPTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 11:19:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3786A21D71;
        Fri, 25 Oct 2019 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572016748;
        bh=6U9yIyl+gH518MCteIB4aAjbK70ZMDQ6y82ZAzopgrs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=J5wxAyrR5HhPiC1WHsgcx5pak2v0VaBJ7yk9l5zn29vkIT9Dq25Q2V7H51eG/bZyy
         DaD9An09zgj3nRl6wFSv3Agi4N1u0tGmuRIa/6yfNFNw34xQOd+CvnuYiEe7HetM+T
         NMvykqXYa7ZzjfdizPAtBqgxtfSA/cJAC1A2VL0Q=
Subject: Re: [PATCHv2 0/3] Update cpupower and make it more accurate
To:     Thomas Renninger <trenn@suse.com>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        Borislav Petkov <bp@suse.de>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>, shuah <shuah@kernel.org>
References: <cover.1570819652.git.Janakarajan.Natarajan@amd.com>
 <ab5d732b-f322-0aeb-3970-99167afc177c@amd.com>
 <14300539.3gDY5kWNTU@skinner.arch.suse.de>
From:   shuah <shuah@kernel.org>
Message-ID: <4a095339-82ab-54c7-4957-63d0338d122f@kernel.org>
Date:   Fri, 25 Oct 2019 09:18:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <14300539.3gDY5kWNTU@skinner.arch.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/19 4:47 AM, Thomas Renninger wrote:
> Hi,
> 
> Removed: Pu Wen <puwen@hygon.com>
> 
> On Tuesday, October 22, 2019 6:39:11 PM CEST Natarajan, Janakarajan wrote:
>> On 10/11/2019 2:37 PM, Natarajan, Janakarajan wrote:
>>
>>> This patchset updates cpupower to make it more accurate by removing
>>> the userspace to kernel transitions and read_msr initiated IPI delays.
> 
> Acked-by: Thomas Renninger <trenn@suse.de>
> 
> Shuan: If you do not object, it would be great if you can schedule these
> to be included into Rafael's pm tree.
> 

I have no objections.

> It's a nice enhancement for these CPUs.
> Doing it even nicer and more generic (per cpu measures) needs further
> restructuring, but should not delay this any further.
> 

Thanks. I was waiting for you to Ack these before I pulled them in.
I will get them in for 5.5-rc1

thanks,
-- Shuah
