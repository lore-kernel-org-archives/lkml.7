Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3747C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754132085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ahXwc04y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgACMuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:50:17 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18384 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgACMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:50:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f38780000>; Fri, 03 Jan 2020 04:50:00 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 04:50:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 04:50:15 -0800
Received: from [10.19.66.63] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 12:50:13 +0000
Subject: Re: [PATCH V1] nvmem: core: fix memory abort in cleanup path
To:     Thierry Reding <treding@nvidia.com>
CC:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <1577592162-14817-1-git-send-email-bbiswas@nvidia.com>
 <20200102124445.GB1924669@ulmo>
 <7abb79c6-b497-98b3-45ff-44d751f1c781@nvidia.com>
 <20200103071152.GA1933715@ulmo>
From:   Bitan Biswas <bbiswas@nvidia.com>
Message-ID: <e56ff5c6-04b1-3b2b-8ff4-9e416e143dee@nvidia.com>
Date:   Fri, 3 Jan 2020 04:50:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200103071152.GA1933715@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578055800; bh=4/mNdoW5Rf3TahSob4C8kQfsxPpZb4ld27pU9hnmESM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ahXwc04yl0X/aSixwhIURdDlmzrvaqFScTbuZO9t5Bh3QOZRfVRKtWUROu55tPP7I
         dLy/zbPG25sLahfz1PUdwf9xF+84/UCAuAyCXJDS86SCsaiivDiOxkxQr+SofF+Im0
         lr6L6QG7FrWBFrlPZ2+VTR2kzueZy2K5GT+8kPczBemtx0f0OomsVGrywthur5TCRx
         OduBQkO7dKNEGnksy6HqFRPERzzpH0Q/A+qMg7Z0QIx6lr0LYVOx94POWqTp43h+kd
         5vwy3VEx8mpV173bF7lNUP/Y4ROOxV2EslI32PpQSEbQv7gA2M2cUCC5cp8aH6fsh9
         6q/Sz0BeO/kaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

On 1/2/20 11:11 PM, Thierry Reding wrote:
> On Thu, Jan 02, 2020 at 10:51:24AM -0800, Bitan Biswas wrote:
>>
>> Hi Thierry,
>>
>> On 1/2/20 4:44 AM, Thierry Reding wrote:
>>> On Sat, Dec 28, 2019 at 08:02:42PM -0800, Bitan Biswas wrote:
>>>> nvmem_cell_info_to_nvmem_cell implementation has static
>>>> allocation of name. nvmem_add_cells_from_of() call may
>>>> return error and kfree name results in memory abort. Use
>>>> kasprintf() instead of assigning pointer and prevent kfree crash.
>>>>
>>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>>> index 9f1ee9c..0fc66e1 100644
>>>> --- a/drivers/nvmem/core.c
>>>> +++ b/drivers/nvmem/core.c
>>>> @@ -110,7 +110,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
>>>>    	cell->nvmem = nvmem;
>>>>    	cell->offset = info->offset;
>>>>    	cell->bytes = info->bytes;
>>>> -	cell->name = info->name;
>>>> +	cell->name = kasprintf(GFP_KERNEL, "%s", info->name);
>>
>>>
>>> kstrdup() seems more appropriate here.
>> Thanks. I shall update the patch as suggested.
>>
>>>
>>> A slightly more efficient way to do this would be to use a combination
>>> of kstrdup_const() and kfree_const(), which would allow read-only
>>> strings to be replicated by simple assignment rather than duplication.
>>> Note that in that case you'd need to carefully replace all kfree() calls
>>> on cell->name by a kfree_const() to ensure they do the right thing.
>> kfree(cell->name) is also called for allocations in function
>> nvmem_add_cells_from_of() through below call
>> kasprintf(GFP_KERNEL, "%pOFn", child);
>>
>> My understanding is kfree_const may not work for above allocation.
> 
> kfree_const() checks the location that the pointer passed to it points
> to. If it points to the kernel's .rodata section, it returns and only
> calls kfree() otherwise. Similarily, kstrdup_const() returns its
> argument if it points to the .rodata section and duplicates the string
> otherwise. On the other hand, pointers returned by kasprintf() will
> never point to the .rodata section, so kfree_const() will result in
> kfree() getting called.
> 
> That said, the savings here are fairly minimal, so I don't feel very
> strongly about this. Feel free to go with the kstrdup() variant.
Thanks for the explanation. I would test the implementation with the 
_const functions you suggested and send updated patch.

-regards,
  Bitan

