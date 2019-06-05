Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026ECC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF42B2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 04:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfFEElI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 00:41:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:45064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfFEElI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 00:41:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DBC8AEEC;
        Wed,  5 Jun 2019 04:41:07 +0000 (UTC)
Subject: Re: bcache: oops when writing to writeback_percent without a cache
 device
To:     =?UTF-8?Q?Bj=c3=b8rn_Forsman?= <bjorn.forsman@gmail.com>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <CAEYzJUH1L5qyWKN3_s4Sz81frho6nKB9bkyDoGxXCvLNO484ew@mail.gmail.com>
 <6823d3ab-5f93-da74-0dbc-19bdb7be6907@suse.de>
 <3399cad5-4387-dd23-77f1-a70e551fb531@suse.de>
 <CAEYzJUE0SuO3uHm1TTxfr1kPtLic1ggUPnGFYTSPcwk6nfq82g@mail.gmail.com>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <78880cf8-07c6-e00d-0084-ce9c211eeec6@suse.de>
Date:   Wed, 5 Jun 2019 12:41:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAEYzJUE0SuO3uHm1TTxfr1kPtLic1ggUPnGFYTSPcwk6nfq82g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/6/5 1:24 上午, Bjørn Forsman wrote:
> On Tue, 4 Jun 2019 at 17:41, Coly Li <colyli@suse.de> wrote:
>>
>> On 2019/6/4 10:59 下午, Coly Li wrote:
>>> On 2019/6/4 7:00 下午, Bjørn Forsman wrote:
>>>> Hi all,
>>>>
>>>> I get a kernel oops from bcache when writing to
>>>> /sys/block/bcache0/bcache/writeback_percent and there is no attached
>>>> cache device. See the oops itself below my signature.
>>>>
>>>> This is on Linux 4.19.46. I looked in git and see many commits to
>>>> bcache lately, but none seem to address this particular issue.
>>>>
>>>> Background: I'm writing to .../writeback_percent with
>>>> systemd-tmpfiles. I'd rather not replace it with a script that figures
>>>> out whether or not the kernel will oops if writing to the sysfs file
>>>> -- the kernel should not oops in the first place.
>>>
>>> Hi Bjorn,
>>>
>>> Thank you for the reporting. I believe this is a case we missed in
>>> testings. When a bcache device is not attached, it does not make sense
>>> to update the writeback rate in period by the changing of writeback_percent.
>>>
>>> I will post a patch for your testing soon.
>>
>> Hi Bjorn,
>>
>> Could you please to try this patch ? Hope it may help a bit.
> 
> Hi Coly,
> 
> Thanks for the quick patch! I tested it on linux 5.2-rc2 and it indeed
> fixes the problem.
> 
> There is one typo in the patch/commit message: s/writebac/writeback/
> 

Hi Bjorn,

Thanks for the patch review. Do you mind if I add Reviewed-By: tag with
your name and email address ?

-- 

Coly Li
