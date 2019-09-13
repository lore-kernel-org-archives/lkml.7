Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD276C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8DE20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbfIMOvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 10:51:43 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:41603 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388958AbfIMOvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 10:51:42 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46VJVz0cMsz1rQBD;
        Fri, 13 Sep 2019 16:51:34 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46VJVt04K9z1qqkR;
        Fri, 13 Sep 2019 16:51:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pn63FZNt3yCi; Fri, 13 Sep 2019 16:51:32 +0200 (CEST)
X-Auth-Info: es9SV5MCsNKuZE81a1bCK7kQgeIbSZlFROOU+XfNAiQ=
Received: from [192.168.1.106] (82-131-128-245.pool.digikabel.hu [82.131.128.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 13 Sep 2019 16:51:31 +0200 (CEST)
Subject: Re: [PATCH] tty: 8250_of: Use software emulated RS485 direction
 control
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        John Garry <john.garry@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20190913050105.1132080-1-hs@denx.de>
 <20190913102409.GF2680@smile.fi.intel.com>
Reply-To: hs@denx.de
From:   Heiko Schocher <hs@denx.de>
Message-ID: <51a21dde-a471-6e8e-8048-50437d740f7f@denx.de>
Date:   Fri, 13 Sep 2019 16:51:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190913102409.GF2680@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

Am 13.09.2019 um 12:24 schrieb Andy Shevchenko:
> On Fri, Sep 13, 2019 at 07:01:05AM +0200, Heiko Schocher wrote:
>> Use software emulated RS485 direction control to provide RS485 API
>>
>> Currently it is not possible to use rs485 as pointer to
>> rs485_config struct in struct uart_port is NULL in case we
>> configure the port through device tree.
> 
> Thank you for the patch, few recommendations for the future submissions.
> 
>> Patch is based on:
>> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> commit:
>> 505a8ec7e11a - Revert "drm/i915/userptr: Acquire the page lock around set_page_dirty()"
> 
> More reliably is to base on corresponding subsystem tree, i.e. tty-next for
> this case.

Ok, should I send a rebased v2 (I tend to wait for other comments)?

>> checkpatch output:
>> $ ./scripts/checkpatch.pl 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch
>> total: 0 errors, 0 warnings, 43 lines checked
>>
>> 0001-tty-8250_of-Use-software-emulated-RS485-direction-co.patch has no obvious style problems and is ready for submission.
> 
> There is no need to mention this. It's supposed that submitter did that
> themselves.

Hmm... ok.

> When you gather people to send the patch to, I recommend to use some threshold,
> e.g. `scripts/get_maintainer.pl --git --git-min-percent=67 ...`

Ah, good tip, thanks!

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
