Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69452C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4127E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 02:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfI3Cc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:32:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3175 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfI3Cc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 22:32:26 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68D437E31D355E6E3DF1;
        Mon, 30 Sep 2019 10:32:23 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Sep 2019
 10:32:19 +0800
Subject: Re: [RFC PATCH] scripts: Fix coccicheck failed
To:     Julia Lawall <julia.lawall@lip6.fr>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
CC:     Gilles Muller <Gilles.Muller@lip6.fr>, <nicolas.palix@imag.fr>,
        <michal.lkml@markovi.net>, <maennich@google.com>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <cocci@systeme.lip6.fr>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
Date:   Mon, 30 Sep 2019 10:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909291810300.3346@hadrien>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/9/30 0:32, Julia Lawall wrote:
> 
> 
> On Sun, 29 Sep 2019, Yuehaibing wrote:
> 
>> On 2019/9/28 20:43, Julia Lawall wrote:
>>>
>>>
>>> On Sat, 28 Sep 2019, YueHaibing wrote:
>>>
>>>> Run make coccicheck, I got this:
>>>>
>>>> spatch -D patch --no-show-diff --very-quiet --cocci-file
>>>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
>>>>  -I ./arch/x86/include -I ./arch/x86/include/generated
>>>>  -I ./include -I ./arch/x86/include/uapi
>>>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
>>>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
>>>>  --jobs 192 --chunksize 1
>>>>
>>>> virtual rule patch not supported
>>>> coccicheck failed
>>>>
>>>> It seems add_namespace.cocci cannot be called in coccicheck.
>>>
>>> Could you explain the issue better?  Does the current state cause make
>>> coccicheck to fail?  Or is it just silently not being called?
>>
>> Yes, it cause make coccicheck failed like this:
>>
>> ...
>> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
>> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
>> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
>> coccicheck failed
>> make[1]: *** [coccicheck] Error 255
>> make: *** [sub-make] Error 2
> 
> Could you set the verbose options to see what the problem is?  Maybe the
> problem would be solved by putting virtual report at the top of the rule.
> But it might still fail because nothing can happen without a value for the
> virtual metavariable ns.

diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
index c832bb6445a8..99e93a6c2e24 100644
--- a/scripts/coccinelle/misc/add_namespace.cocci
+++ b/scripts/coccinelle/misc/add_namespace.cocci
@@ -6,6 +6,8 @@
 /// add a missing namespace tag to a module source file.
 ///

+virtual report
+
 @has_ns_import@
 declarer name MODULE_IMPORT_NS;
 identifier virtual.ns;



Adding virtual report make the coccicheck go ahead smoothly.

> 
> Should the coccinelle directory be only for things that work with make
> coccicheck, or for all Coccinelle scripts?
> 
> julia
> 
> .
> 

