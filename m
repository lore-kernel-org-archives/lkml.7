Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584ACC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233D020693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfCLPsI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:48:08 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:42346 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:48:08 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 0B02014CEA; Tue, 12 Mar 2019 15:48:06 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] auxdisplay: charlcd: make backlight initial state configurable
References: <20190301184816.784-1-mans@mansr.com>
        <20190301184816.784-3-mans@mansr.com>
        <CAHp75VfZUN0PVwveB9FM6QvyJicVE5WjCX3b5rfCGZOQs9hO8A@mail.gmail.com>
Date:   Tue, 12 Mar 2019 15:48:06 +0000
In-Reply-To: <CAHp75VfZUN0PVwveB9FM6QvyJicVE5WjCX3b5rfCGZOQs9hO8A@mail.gmail.com>
        (Andy Shevchenko's message of "Tue, 12 Mar 2019 17:45:24 +0200")
Message-ID: <yw1xo96g2ix5.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Fri, Mar 1, 2019 at 9:14 PM Mans Rullgard <mans@mansr.com> wrote:
>>
>> The charlcd driver currently flashes the backlight once on init.
>> This may not be desirable.  Thus, add options for turning the
>> backlight off or on as well.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/auxdisplay/Kconfig   | 21 +++++++++++++++++++++
>>  drivers/auxdisplay/charlcd.c | 10 +++++++++-
>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
>> index 7d3fe27d6868..c52c738e554a 100644
>> --- a/drivers/auxdisplay/Kconfig
>> +++ b/drivers/auxdisplay/Kconfig
>> @@ -445,6 +445,27 @@ config PANEL_BOOT_MESSAGE
>>           An empty message will only clear the display at driver init time. Any other
>>           printf()-formatted message is valid with newline and escape codes.
>>
>> +choice
>> +       prompt "Backlight initial state"
>> +       default CHARLCD_BL_FLASH
>
> LGTM, but I don't agree on this default. I would prefer either on or
> off, not flashing for sure.
> Though it seems the case before the patch...

The current code unconditionally flashes the light once.  I though it
best to keep that behaviour as default, even if it's not seen as ideal.

-- 
Måns Rullgård
