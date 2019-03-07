Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA088C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B3120835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfCGORe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:17:34 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:34677 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:17:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 3164A185C5;
        Thu,  7 Mar 2019 15:17:31 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 6LYXU_Ak-IRA; Thu,  7 Mar 2019 15:17:30 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 28C8F185B8;
        Thu,  7 Mar 2019 15:17:30 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFCA81A06D;
        Thu,  7 Mar 2019 15:17:29 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E453D1A061;
        Thu,  7 Mar 2019 15:17:29 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu,  7 Mar 2019 15:17:29 +0100 (CET)
Received: from XBOX04.axis.com (xbox04.axis.com [10.0.5.18])
        by seth.se.axis.com (Postfix) with ESMTP id D86E92AE6;
        Thu,  7 Mar 2019 15:17:29 +0100 (CET)
Received: from [10.88.41.2] (10.0.5.60) by XBOX04.axis.com (10.0.5.18) with
 Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 7 Mar 2019 15:17:29 +0100
Subject: Re: [PATCH] mm: migrate: add missing flush_dcache_page for non-mapped
 page migrate
From:   Lars Persson <lars.persson@axis.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Lars Persson <larper@axis.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mips@vger.kernel.org>
References: <20190219123212.29838-1-larper@axis.com>
 <65ed6463-b61f-81ff-4fcc-27f4071a28da@suse.cz>
 <ed4dd065-5e1b-dc20-2778-6d0a727914a8@axis.com>
 <2de280a9-e82a-876c-e13b-a2e48d89700a@suse.cz>
 <24af691e-03ab-d79a-ddbd-7057dcf46826@axis.com>
Message-ID: <237ecd2f-477f-2dc7-7849-643e47fe56d5@axis.com>
Date:   Thu, 7 Mar 2019 15:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <24af691e-03ab-d79a-ddbd-7057dcf46826@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: sv
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: XBOX04.axis.com (10.0.5.18) To XBOX04.axis.com (10.0.5.18)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/19 12:57 PM, Lars Persson wrote:
> 
> 
> On 2/26/19 11:07 AM, Vlastimil Babka wrote:
>> On 2/26/19 9:40 AM, Lars Persson wrote:
>>>> What about CC stable and a Fixes tag, would it be applicable here?
>>>>
>>>
>>> Yes this is candidate for stable so let's add:
>>> Cc: <stable@vger.kernel.org>
>>>
>>> I do not find a good candidate for a Fixes tag.
>>
>> How bout a version range where the bug needs to be fixed then?
>>
> 
> The distinction between mapped and non-mapped old page was introduced in 2ebba6b7e1d9 ("mm: unmapped page migration avoid unmap+remap overhead") so at least it applies to stable 4.4+.
> 
> Before that patch there was always a call to remove_migration_ptes() but I cannot conclude if those earlier versions actually will reach the flush_dcache_page call if the old page was unmapped.
> 

Should I submit a V2 patch with CC stable for v4.4+ ?

- Lars
