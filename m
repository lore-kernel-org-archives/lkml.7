Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB45C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93504214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573188218;
	bh=gGcrJLLMEdGJDEnXTg6AGqhRcYT1a9VoEmUmShakP/M=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=wZU21i9Evq61inl7FXkw1DD8KH6BorQ4H2Ozhnt1jSCjvrTjBGNLA/b9uoY6omCqA
	 ryevQx3JdyHimSfSk3S2bQo3cufs4erAMgi8LjUVoGcDhjDxIfouaGYPlJDfFTLVR6
	 wP8pTqQaRQjdMCIad43IhV3NBUJNEEpCzGP1rMQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfKHEnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 23:43:37 -0500
Received: from icp-osb-irony-out3.external.iinet.net.au ([203.59.1.153]:32857
        "EHLO icp-osb-irony-out3.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbfKHEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 23:43:37 -0500
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Nov 2019 23:43:35 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AWAADi78Rd/zXSMGcNWBkBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAREBAQEBAQEBAQEBAYF+gwyBMYQpj2oBAQeBNn+Ca4V6kUM?=
 =?us-ascii?q?JAQEBAQEBAQEBLwgBAYRAAoQyOBMCDgEBAQQBAQEBAQUDAYVYTIVdAQEBAQI?=
 =?us-ascii?q?BIxVBEAsNCAMCAiYCAlcGDQYCAQGDHgGCUgUvsVp1gTIahB8BgRSDNYFCBoE?=
 =?us-ascii?q?OKIFlikd4gQeBESeCNjU+gQSBOSUChHGCXgSWSpc9gi6HF44kBhuOPwOLMpZ?=
 =?us-ascii?q?6k0qBejMaCCgIgydQkHODW4plYgGQdQEB?=
X-IPAS-Result: =?us-ascii?q?A2AWAADi78Rd/zXSMGcNWBkBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?REBAQEBAQEBAQEBAYF+gwyBMYQpj2oBAQeBNn+Ca4V6kUMJAQEBAQEBAQEBL?=
 =?us-ascii?q?wgBAYRAAoQyOBMCDgEBAQQBAQEBAQUDAYVYTIVdAQEBAQIBIxVBEAsNCAMCA?=
 =?us-ascii?q?iYCAlcGDQYCAQGDHgGCUgUvsVp1gTIahB8BgRSDNYFCBoEOKIFlikd4gQeBE?=
 =?us-ascii?q?SeCNjU+gQSBOSUChHGCXgSWSpc9gi6HF44kBhuOPwOLMpZ6k0qBejMaCCgIg?=
 =?us-ascii?q?ydQkHODW4plYgGQdQEB?=
X-IronPort-AV: E=Sophos;i="5.68,280,1569254400"; 
   d="scan'208";a="224499746"
Received: from unknown (HELO [10.44.0.22]) ([103.48.210.53])
  by icp-osb-irony-out3.iinet.net.au with ESMTP; 08 Nov 2019 12:34:16 +0800
Subject: Re: [PATCH] mtd: rawnand: driver for Mediatek MT7621 SoC NAND flash
 controller
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        neil@brown.name, blogic@openwrt.org
References: <20191107073521.11413-1-gerg@kernel.org>
 <20191107084007.GA1203521@kroah.com>
From:   Greg Ungerer <gerg@kernel.org>
Message-ID: <eb68fc5f-0a50-3faf-be61-23af5550ef39@kernel.org>
Date:   Fri, 8 Nov 2019 14:34:15 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107084007.GA1203521@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/11/19 6:40 pm, Greg KH wrote:
> On Thu, Nov 07, 2019 at 05:35:21PM +1000, gerg@kernel.org wrote:
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
> 
> Is that an issue?  Why not just put it in the "real" part of the kernel
> then, if those apis are still in use?

Agreed. If the MTD folks have no problem with it.


>> The driver not only compiles, but it works well on the small range of
>> hardware platforms that it has been used on so far. I have been using
>> for quite a while now, cleaning up as I get time.
>>
>> So... I am looking for comments on the best approach forward with this.
>> At least in staging it can get some more eyeballs going over it.
> 
> staging will just nit-pick it to death for coding style issues, it's not
> going to be get any major api changes/cleanups there usually.  I'd
> recommend just merging this to the "real" part of the kernel now if it's
> working for you.

I'll spin a v2 based on Dan's feedback, and move it into drivers/mtd.

Thanks
Greg

