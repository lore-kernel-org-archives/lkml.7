Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79111C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231C222CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 16:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="kB3cMATD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfH1Q1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:27:40 -0400
Received: from ns3.fnarfbargle.com ([103.4.19.87]:42556 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfH1Q1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:27:37 -0400
Received: from [10.8.0.1] (helo=srv.home ident=heh12100)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1i30mc-000414-Eo; Thu, 29 Aug 2019 00:26:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=Q6pQA2hBI5LX+VRBBaU8DvqsCNBqlofTcGdZN0ScIEs=;
        b=kB3cMATDwH03UOlLtYDNWrVGmDabraS9P1sO7EIjlbdPIxkfOR4Lgsn2/GBI/z80XNLjM+xwiZNIxz6S+9zd8bxQ4cp7goYvOMjZHPrQ411tcJYn6pG770qyAuyhVHdAgpw8kHjk6MF73UOhFTU9cpFdbNZ9+I4CT76ItngB7sg=;
Subject: Re: Thunderbolt DP oddity on v5.2.9 on iMac 12,2
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, michael.jamet@intel.com,
        YehezkelShB@gmail.com
References: <472bee84-d62b-bfcb-eb83-db881165756b@fnarfbargle.com>
 <20190828073302.GO3177@lahna.fi.intel.com>
 <7c9474d2-d948-4d1d-6f7b-94335b8b1f15@fnarfbargle.com>
 <20190828102342.GT3177@lahna.fi.intel.com>
 <e3a8fa91-2cfd-76a4-641c-610c32122833@fnarfbargle.com>
 <20190828131943.GZ3177@lahna.fi.intel.com>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <be32b369-b013-cca8-5475-9b56acaa3e18@fnarfbargle.com>
Date:   Thu, 29 Aug 2019 00:27:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828131943.GZ3177@lahna.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 28/8/19 21:19, Mika Westerberg wrote:
> On Wed, Aug 28, 2019 at 06:43:35PM +0800, Brad Campbell wrote:
>> On 28/8/19 6:23 pm, Mika Westerberg wrote:
>>
>>> On Wed, Aug 28, 2019 at 05:12:00PM +0800, Brad Campbell wrote:
>>>
>>> Apart from the warning in the log (which is not fatal, I'll look into
>>> it) to me the second path setup looks fine.
>>>
>>> Can you do one more experiment? Boot the system up without anything
>>> connected and then plug both monitors. Does it work?
>>>
>> Aside from head ordering issues in X it works just fine.
>> I've attached the dmesg. Boot with nothing plugged in, then plug in 0-1 and
>> 0-3 in that order.
> OK, thanks for checking. So when Linux is in complete control both DP
> tunnels get created properly. I suspect there is something different
> what the firmware does compared to other Macs I've been using and that
> causes the driver to fail to discover all the paths. I will take a look
> at this but I'm away tomorrow and friday so it goes to next week.

It wouldn't surprise me if the firmware was doing something funky. It 
was one of the first Thunderbolt equipped models and the support docs 
explicitly say only one Thunderbolt display in Windows and two in later 
versions of OSX. It almost needs a quirk to say "firmware does something 
we don't like, reset the controller and re-discover from scratch".

Anyway, I'm not in any hurry. It doesn't get rebooted often and it's not 
in any way preventing me using the machine. In fact, upgrading the third 
head from an old 24" 1920x1200 to the second Thunderbolt display has 
been invaluable.

> BTW, have you tried to chain the two monitors?

Not yet, but it was something I've been considering. I'll give it a go 
tomorrow. Due to cable length vs display dimensions it'll require me 
cleaning my desk, and that takes some forward planning.

-- 

An expert is a person who has found out by his own painful
experience all the mistakes that one can make in a very
narrow field. - Niels Bohr

