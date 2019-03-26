Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAD7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE4B20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfCZRhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:37:10 -0400
Received: from gecko.sbs.de ([194.138.37.40]:36585 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZRhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:37:08 -0400
X-Greylist: delayed 928 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 13:37:08 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x2QHLN8r032214
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 18:21:23 +0100
Received: from [167.87.1.199] ([167.87.1.199])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x2QHLLwu030986;
        Tue, 26 Mar 2019 18:21:22 +0100
Subject: Re: [PATCH 3/4] scripts/gdb: Add rb tree iterating utilities
To:     Stephen Boyd <swboyd@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nikolay Borisov <n.borisov.lkml@gmail.com>,
        Jackie Liu <liuyun01@kylinos.cn>
References: <20190325184522.260535-1-swboyd@chromium.org>
 <20190325184522.260535-4-swboyd@chromium.org>
 <227f1a1f-d8dd-72f4-4eb9-43bba714d52a@kernel.org>
 <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ff5bffea-2689-0ace-9c77-2aaa6605342c@siemens.com>
Date:   Tue, 26 Mar 2019 18:21:21 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <155361993610.20095.762425616683725063@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.19 18:05, Stephen Boyd wrote:
> Quoting Kieran Bingham (2019-03-26 01:52:10)
>> Hi Stephen,
>>
>> On 25/03/2019 18:45, Stephen Boyd wrote:
>>> Implement gdb functions for rb_first(), rb_last(), rb_next(), and
>>> rb_prev(). These can be useful to iterate through the kernel's red-black
>>> trees.
>>
>> I definitely approve of getting data-structure helpers into scripts/gdb,
>> as it will greatly assist debug options but my last attempt to do this
>> was with the radix-tree which I had to give up on as the internals were
>> changing rapidly and caused continuous breakage to the helpers.
> 
> Thanks for the background on radix-tree. I haven't looked at that yet,
> but I suppose I'll want to have that too at some point.
> 
>>
>> Do you foresee any similar issue here? Or is the corresponding RB code
>> in the kernel fairly 'stable'?
>>
>>
>> Please could we make sure whomever maintains the RBTree code is aware of
>> the python implementation?
>>
>> That said, MAINTAINERS doesn't actually seem to list any ownership over
>> the rb-tree code, and get_maintainers.pl [0] seems to be pointing at
>> Andrew as the probable route in for that code so perhaps that's already
>> in place :D
> 
> I don't think that the rb tree implementation is going to change. It
> feels similar to the list API. I suppose this problem of keeping things
> in sync is a more general problem than just data-structures changing.
> The only solution I can offer is to have more testing and usage of these
> scripts. Unless gdb can "simulate" or run arbitrary code for us then I
> think we're stuck reimplementing kernel internal code in gdb scripts so
> that we can get debug info out.
> 

Could we possibly leave some link in form of comment in the related headers or 
implementations? Won't magically solve the problem but at least increase changes 
that author actually read them when they start changing the C implementations.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
