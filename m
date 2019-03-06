Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCC8206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfCFPId convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:08:33 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:59306 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfCFPId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:08:33 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id CE00E14CEA; Wed,  6 Mar 2019 15:08:31 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: deconfuse configuration
References: <20190301184816.784-1-mans@mansr.com>
        <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
Date:   Wed, 06 Mar 2019 15:08:31 +0000
In-Reply-To: <CANiq72=H1Gubbr+eoEKUR+m49fkcC7Sr_hsyP3azzpk=i-au+Q@mail.gmail.com>
        (Miguel Ojeda's message of "Wed, 6 Mar 2019 11:14:45 +0100")
Message-ID: <yw1xtvgg3us0.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Fri, Mar 1, 2019 at 7:48 PM Mans Rullgard <mans@mansr.com> wrote:
>>
>> The auxdisplay Kconfig is confusing.  It creates two separate menus
>> even though the settings are closely related.  Moreover, the options
>> for setting the boot message depend on CONFIG_PARPORT even though they
>> are used by drivers that do not.
>>
>> Clear up the confustion by moving the "Parallel port LCD/Keypad" menu
>
> "confustion" -> "confusion"

Darn, must have been confused while typing.

>> under auxdisplay where it logically belongs.  Change the boot message
>> options to depend only on CONFIG_CHARLCD, making them accessible also
>> when only the HD44780 is selected.
>>
>> Since the "Parallel port LCD/Keypad" driver now has a new dependency
>> on CONFIG_AUXDISPLAY, rename its Kconfig symbol and keep the old one
>> such that make oldconfig will not disable the driver.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>>  drivers/auxdisplay/Kconfig  | 17 ++++++++++++-----
>>  drivers/auxdisplay/Makefile |  2 +-
>>  2 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
>> index 57410f9c5d44..7d3fe27d6868 100644
>> --- a/drivers/auxdisplay/Kconfig
>> +++ b/drivers/auxdisplay/Kconfig
>> @@ -164,9 +164,7 @@ config ARM_CHARLCD
>>           line and the Linux version on the second line, but that's
>>           still useful.
>>
>> -endif # AUXDISPLAY
>> -
>> -menuconfig PANEL
>> +menuconfig PARPORT_PANEL
>
> Do we want the PARPORT_ prefix here but not on the suboptions?

I was trying to bring some sanity to it without changing more than
necessary.

> Also, having PANEL_PARPORT and PARPORT_PANEL seems confusing...

It is...

>>         tristate "Parallel port LCD/Keypad Panel support"
>>         depends on PARPORT
>>         select CHARLCD
>> @@ -178,7 +176,7 @@ menuconfig PANEL
>>           compiled as a module, or linked into the kernel and started at boot.
>>           If you don't understand what all this is about, say N.
>>
>> -if PANEL
>> +if PARPORT_PANEL
>>
>>  config PANEL_PARPORT
>>         int "Default parallel port number (0=LPT1)"
>> @@ -419,8 +417,11 @@ config PANEL_LCD_PIN_BL
>>
>>           Default for the 'BL' pin in custom profile is '0' (uncontrolled).
>>
>> +endif # PARPORT_PANEL
>> +
>>  config PANEL_CHANGE_MESSAGE
>>         bool "Change LCD initialization message ?"
>> +       depends on CHARLCD
>>         default "n"
>>         ---help---
>>           This allows you to replace the boot message indicating the kernel version
>> @@ -444,7 +445,13 @@ config PANEL_BOOT_MESSAGE
>>           An empty message will only clear the display at driver init time. Any other
>>           printf()-formatted message is valid with newline and escape codes.
>>
>> -endif # PANEL
>> +endif # AUXDISPLAY
>> +
>> +config PANEL
>> +       tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"
>
> Hm... what do you mean by "OLD OPTION"? Should we keep it? (I don't
> see any other place using this marking).

The option is there so 'make oldconfig' on existing configurations
doesn't silently drop that driver since it now depends on AUXDISPLAY.
There have been similar cases when shuffling options.  Maybe they used a
different tag.  We could of course let the three people using that
driver deal with it themselves.

>> +       depends on PARPORT
>> +       select AUXDISPLAY
>> +       select PARPORT_PANEL
>
> I agree the menu was a bit convoluted and we didn't get to clean it.
>
> Since you are touching the panel.c options, CC'ing the maintainers
> (please do run get_maintainer.pl in that case!)

I always run get_maintainer.pl on patches.  Sometimes it isn't clever
enough to figure out all the people who might be interested.

-- 
Måns Rullgård
