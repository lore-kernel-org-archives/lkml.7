Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61229C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDF9206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGaQYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:24:14 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:57591 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfGaQYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:24:13 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id x6VGNsMW016786
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 18:23:54 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x6VGNsUO025479;
        Wed, 31 Jul 2019 18:23:54 +0200
Subject: Re: [PATCH] scripts/gdb: Handle split debug
To:     Doug Anderson <dianders@chromium.org>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20190730234052.148744-1-dianders@chromium.org>
 <34bbd6b5-2e37-159a-b75b-36a6be11c506@siemens.com>
 <CAD=FV=Uqa79UyFFj6zrr_B=rrwfmJAFLLatf8wQ73V70U-frvA@mail.gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9e3604b2-57dd-7f79-392d-47bb34eb5137@siemens.com>
Date:   Wed, 31 Jul 2019 18:23:53 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Uqa79UyFFj6zrr_B=rrwfmJAFLLatf8wQ73V70U-frvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.07.19 17:44, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jul 31, 2019 at 7:24 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>>
>> On 31.07.19 01:40, Douglas Anderson wrote:
>>> Some systems (like Chrome OS) may use "split debug" for kernel
>>> modules.  That means that the debug symbols are in a different file
>>> than the main elf file.  Let's handle that by also searching for debug
>>> symbols that end in ".ko.debug".
>>
>> Is this split-up depending on additional kernel patches, is this already
>> possible with mainline, or is this purely a packaging topic? Wondering because
>> of testability in case it's downstream-only.
> 
> It is a packaging topic.  You can take a normal elf file and split the
> debug out of it using objcopy.  Try "man objcopy" and then take a look
> at the "--only-keep-debug" option.  It'll give you a whole recipe for
> doing splitdebug.  The suffix used for the debug symbols is arbitrary.
> If people have other another suffix besides ".ko.debug" then we could
> presumably support that too...
> 
> For portage (which is the packaging system used by Chrome OS) split
> debug is supported by default (and the suffix is .ko.debug).  ...and
> so in Chrome OS we always get the installed elf files stripped and
> then the symbols stashed away.
> 
> At the moment we don't actually use the normal portage magic to do
> this for the kernel though since it affects our ability to get good
> stack dumps in the kernel.  We instead pass a script as "strip" [1].
> 
> 
> [1] https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay/+/refs/heads/master/eclass/cros-kernel/strip_splitdebug
> 
> 
> -Doug
> 

Thanks, makes perfect sense to me. You may add my

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
