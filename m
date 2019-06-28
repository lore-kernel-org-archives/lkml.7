Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98352C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C320645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfF1Q5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:57:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57278 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfF1Q5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:57:02 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 24204260E01
Subject: Re: linux-next: build failure after merge of the battery tree
To:     Sebastian Reichel <sre@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
References: <20190628140304.76caf572@canb.auug.org.au>
 <20190628153146.c2lh4y55qvcmqhry@earth.universe>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d3515009-c922-7aa6-2ded-4ca39ed324f2@collabora.com>
Date:   Fri, 28 Jun 2019 18:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190628153146.c2lh4y55qvcmqhry@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/6/19 17:31, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Jun 28, 2019 at 02:03:04PM +1000, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the battery tree, today's linux-next build (x86_64
>> allmodconfig) failed like this:
>>
>> drivers/power/supply/wilco-charger.c: In function 'wilco_charge_get_property':
>> drivers/power/supply/wilco-charger.c:104:8: error: implicit declaration of function 'wilco_ec_get_byte_property'; did you mean 'wilco_charge_get_property'? [-Werror=implicit-function-declaration]
>>   ret = wilco_ec_get_byte_property(ec, property_id, &raw);
>>         ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>         wilco_charge_get_property
>> drivers/power/supply/wilco-charger.c: In function 'wilco_charge_set_property':
>> drivers/power/supply/wilco-charger.c:130:10: error: implicit declaration of function 'wilco_ec_set_byte_property'; did you mean 'wilco_charge_set_property'? [-Werror=implicit-function-declaration]
>>    return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
>>           ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>           wilco_charge_set_property
>>
>> Caused by commit
>>
>>   0736343e4c56 ("power_supply: wilco_ec: Add charging config driver")
>>

Hmm, I just applied this patch on top of linux-next and it build with
allmodconfig on x86_64

I am wondering if the build was done without this commit, which is in
chrome-platform for-next branch. Could be this the problem?

commit 0c0b7ea23aed0b55ef2f9803f13ddaae1943713d
Author: Nick Crews <ncrews@chromium.org>
Date:   Wed Apr 24 10:56:50 2019 -0600

    platform/chrome: wilco_ec: Add property helper library


Anyway, I think the proper way to do it is create an immutable branch for
Sebastian as the patch he picked depends on the above commit. I'll create one,
sorry about that missing dependency.

Thanks,
~ Enric


>> I have reverted that commit for today.
> 
> Oops, thanks for the hint. I did not notice this with ARM
> allmodconfig. I dropped the patch for this cycle.
> 
> -- Sebastian
> 
