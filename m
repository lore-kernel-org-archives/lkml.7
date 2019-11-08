Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F1CC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BBF21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573188375;
	bh=gH4YV/wqrobeQnaVD22aDnltH06bEHnjtZENRGZ48q4=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Bl4wSE4SF0oxpijGlMU0xRLkuqsq7kS5qO5oaJUgp09fvmQDSKX8PnR7ko5WolFiB
	 7uYOtOULpRB+yJnJB7SV6azAB5UPIcIa2btOMVwsXHH5d8G8itlfKWyzl9bUEtDBPc
	 MhVjN+E4e/i+rujhpwjQ6PrtpeOipDnv3OtJ21wI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfKHEqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHEqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:46:14 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC92721848;
        Fri,  8 Nov 2019 04:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573188373;
        bh=gH4YV/wqrobeQnaVD22aDnltH06bEHnjtZENRGZ48q4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=xRn6UE1fCLscoGa0SSMS43OBs/hmPEGgj8EzH0pTY9x2nudK/0/KLYUDldyDZFBiW
         eefoao4dK85ZkzfVnGne6x8pop9UgAK0gyCag4BvbaJ1GqmvgyozJHyhg8t+8IWe7v
         Jqu6973Y1RC3ZxksXaZzEc2ZHihhNBSO+oKuM9iw=
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
To:     =?UTF-8?Q?Ren=c3=a9_van_Dorst?= <opensource@vdorst.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, neil@brown.name,
        DENG Qingfang <dengqf6@mail2.sysu.edu.cn>,
        Chuanhong Guo <gch981213@gmail.com>,
        Weijie Gao <hackpascal@gmail.com>
References: <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com>
From:   Greg Ungerer <gerg@kernel.org>
Message-ID: <b7e61be8-bd72-a4ef-6fb7-1047c7874342@kernel.org>
Date:   Fri, 8 Nov 2019 14:46:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107092053.Horde.i3MVcW9RqZDOQBMADZX9fuc@www.vdorst.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/19 7:20 pm, René van Dorst wrote:
> Quoting gerg@kernel.org:
> 
>> From: Greg Ungerer <gerg@kernel.org>
>>
>> Add a driver to support the NAND flash controller of the MediaTek MT7621
>> System-on-Chip device. (This one is the MIPS based parts from Mediatek).
>>
>> This code is a re-working of the earlier patches for this hardware that
>> have been floating around the internet for years:
>>
>> https://github.com/ReclaimYourPrivacy/cloak/blob/master/target/linux/ramips/patches-3.18/0045-mtd-add-mt7621-nand-support.patch
>>
>> This is a much cleaned up version, put in staging to start with.
>> It does still have some problems, mainly that it still uses a lot of the
>> mtd raw nand legacy support.
>>
>> The driver not only compiles, but it works well on the small range of
>> hardware platforms that it has been used on so far. I have been using
>> for quite a while now, cleaning up as I get time.
>>
>> So... I am looking for comments on the best approach forward with this.
>> At least in staging it can get some more eyeballs going over it.
>>
>> There is a mediatek nand driver already, mtk_nand.c, for their ARM based
>> System-on-Chip devices. That hardware module looks to have some hardware
>> similarities with this one. At this point I don't know if that can be
>> used on the 7621 based devices. (I tried a quick and dirty setup and had
>> no success using it on the 7621).
>>
>> Thoughts?
> 
> +CC DENG Qingfang, Chuanhong Guo, Weijie Gao to the list.
> 
> Hi Greg,
> 
> Thanks for posting this driver.
> 
> But I would like to mention that the openwrt community is currently working on a
> new version which is based a newer version of the MediaTek vendor driver.
> That version is currently targeted for the openwrt 4.19 kernel.
> See full pull request [1] and NAND driver patch [2]
> 
> It would be a shame if duplicate work has been done.

Thanks for pointing that out. I have no particular attachment to the
patch code I sent (I didn't write it). Really just want to see a driver
in mainline.

I am going to spin a v2 of it, lets see how to the 2 drivers stack up
against each other.

Regards
Greg



> [1]: https://github.com/openwrt/openwrt/pull/2385
> [2]: https://github.com/openwrt/openwrt/pull/2385/commits/b2569c0a5943fe8f94ba07c9540ecd14006d729a
> 
> <snip>
> 
> 
