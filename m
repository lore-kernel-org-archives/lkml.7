Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C4C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B23620880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 15:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfDOPG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 11:06:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfDOPG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 11:06:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2DADA281898
Subject: Re: [PATCH v3] platform: chrome: Add ChromeOS EC ISHTP driver
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Gwendal Grignou <gwendal@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1554639014-28363-1-git-send-email-rushikesh.s.kadam@intel.com>
 <CAK+PMK4U0MNAYvrCjRyZb=o+hz6DuaFk-8yY_Ak7WXH4xhpkkg@mail.gmail.com>
 <0c3f090e-7c59-8399-f6c3-71d1b8fbae0e@collabora.com>
 <20190411111057.GA20718@intel.com>
 <0480e3a2-118c-c9dc-feb8-8b78c4fba85b@collabora.com>
 <f7884be2d145d7ebd6a558cdae90254b076889e3.camel@linux.intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <89f3829e-5f9c-b205-802b-18e8a0236779@collabora.com>
Date:   Mon, 15 Apr 2019 17:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f7884be2d145d7ebd6a558cdae90254b076889e3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/19 17:22, Srinivas Pandruvada wrote:
> On Thu, 2019-04-11 at 15:54 +0200, Enric Balletbo i Serra wrote:
>> Hi,
>>
>> On 11/4/19 13:10, Rushikesh S Kadam wrote:
>>> Hi Enric, Srinivas
>>>
>>> On Thu, Apr 11, 2019 at 12:55:13PM +0200, Enric Balletbo i Serra
>>> wrote:
>>>> Hi,
>>>>
>>>> On 10/4/19 17:31, Jett Rink wrote:
>>>>> Reviewed-by: Jett Rink <jettrink@chromium.org>
>>>>> Tested-by: Jett Rink <jettrink@chromium.org>
>>>>>
>>>>>
>>>>> On Sun, Apr 7, 2019 at 6:10 AM Rushikesh S Kadam
>>>>> <rushikesh.s.kadam@intel.com> wrote:
>>>>>>
>>>>>> This driver implements a slim layer to enable the ChromeOS
>>>>>> EC kernel stack (cros_ec) to communicate with ChromeOS EC
>>>>>> firmware running on the Intel Integrated Sensor Hub (ISH).
>>>>>>
>>>>>> The driver registers a ChromeOS EC MFD device to connect
>>>>>> with cros_ec kernel stack (upper layer), and it registers a
>>>>>> client with the ISH Transport Protocol bus (lower layer) to
>>>>>> talk with the ISH firwmare. See description of the ISHTP
>>>>>> protocol at Documentation/hid/intel-ish-hid.txt
>>>>>>
>>>>>> Signed-off-by: Rushikesh S Kadam <rushikesh.s.kadam@intel.com
>>>>>>>
>>>>>> ---
>>>>>>
>>>>>> v3
>>>>>>  - Made several changes to improve code readability. Replaced
>>>>>>    multiple cl_data_to_dev(client_data) with dev variable.
>>>>>> Use
>>>>>>    reverse Xmas tree for variable defintion where it made
>>>>>> sense.
>>>>>>    Dropped few debug prints. Add docstring for function
>>>>>>    prepare_cros_ec_rx().
>>>>>>  - Fix code in function prepare_cros_ec_rx() under label
>>>>>>    end_cros_ec_dev_init_error.
>>>>>>  - Recycle buffer in process_recv() on failing to obtain the
>>>>>>    semaphore.
>>>>>>  - Increase ISHTP TX/RX ring buffer size to 8.
>>>>>>  - Alphabetically ordered CROS_EC_ISHTP entries in Makefile
>>>>>> and
>>>>>>    Kconfig.
>>>>>>  - Updated commit message.
>>>>>>
>>>>>> v2
>>>>>>  - Dropped unused "reset" parameter in function
>>>>>> cros_ec_init()
>>>>>>  - Change driver name to cros_ec_ishtp to be consistent with
>>>>>> other
>>>>>>    references in the code.
>>>>>>  - Fixed a few typos.
>>>>>>
>>>>>> v1
>>>>>>  - Initial version
>>>>>>
>>>>>>  drivers/platform/chrome/Kconfig         |  13 +
>>>>>>  drivers/platform/chrome/Makefile        |   1 +
>>>>>>  drivers/platform/chrome/cros_ec_ishtp.c | 765
>>>>>> ++++++++++++++++++++++++++++++++
>>>>>>  3 files changed, 779 insertions(+)
>>>>>>  create mode 100644 drivers/platform/chrome/cros_ec_ishtp.c
>>>>>>
>>>>>> diff --git a/drivers/platform/chrome/Kconfig
>>>>>> b/drivers/platform/chrome/Kconfig
>>>>>> index 16b1615..5848179 100644
>>>>>> --- a/drivers/platform/chrome/Kconfig
>>>>>> +++ b/drivers/platform/chrome/Kconfig
>>>>>> @@ -62,6 +62,19 @@ config CROS_EC_I2C
>>>>>>           a checksum. Failing accesses will be retried three
>>>>>> times to
>>>>>>           improve reliability.
>>>>>>
>>>>>> +config CROS_EC_ISHTP
>>>>>> +       tristate "ChromeOS Embedded Controller (ISHTP)"
>>>>>> +       depends on MFD_CROS_EC
>>>>>> +       depends on INTEL_ISH_HID
>>>>>> +       help
>>>>>> +         If you say Y here, you get support for talking to
>>>>>> the ChromeOS EC
>>>>>> +         firmware running on Intel Integrated Sensor Hub
>>>>>> (ISH), using the
>>>>>> +         ISH Transport protocol (ISH-TP). This uses a simple
>>>>>> byte-level
>>>>>> +         protocol with a checksum.
>>>>>> +
>>>>>> +         To compile this driver as a module, choose M here:
>>>>>> the
>>>>>> +         module will be called cros_ec_ishtp.
>>>>>> +
>>>>>>  config CROS_EC_SPI
>>>>>>         tristate "ChromeOS Embedded Controller (SPI)"
>>>>>>         depends on MFD_CROS_EC && SPI
>>>>>> diff --git a/drivers/platform/chrome/Makefile
>>>>>> b/drivers/platform/chrome/Makefile
>>>>>> index cd591bf..4efe102 100644
>>>>>> --- a/drivers/platform/chrome/Makefile
>>>>>> +++ b/drivers/platform/chrome/Makefile
>>>>>> @@ -7,6 +7,7 @@ cros_ec_ctl-objs                        :=
>>>>>> cros_ec_sysfs.o cros_ec_lightbar.o \
>>>>>>                                            cros_ec_vbc.o
>>>>>> cros_ec_debugfs.o
>>>>>>  obj-$(CONFIG_CROS_EC_CTL)              += cros_ec_ctl.o
>>>>>>  obj-$(CONFIG_CROS_EC_I2C)              += cros_ec_i2c.o
>>>>>> +obj-$(CONFIG_CROS_EC_ISHTP)            += cros_ec_ishtp.o
>>>>>>  obj-$(CONFIG_CROS_EC_SPI)              += cros_ec_spi.o
>>>>>>  cros_ec_lpcs-objs                      := cros_ec_lpc.o
>>>>>> cros_ec_lpc_reg.o
>>>>>>  cros_ec_lpcs-$(CONFIG_CROS_EC_LPC_MEC) += cros_ec_lpc_mec.o
>>>>>> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c
>>>>>> b/drivers/platform/chrome/cros_ec_ishtp.c
>>>>>> new file mode 100644
>>>>>> index 0000000..b1d19c4
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
>>>>>> @@ -0,0 +1,765 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>> +/*
>>>>>> + * ISHTP client driver for talking to the Chrome OS EC
>>>>>> firmware running
>>>>>> + * on Intel Integrated Sensor Hub (ISH) using the ISH
>>>>>> Transport protocol
>>>>>> + * (ISH-TP).
>>>>>> + *
>>>>>> + * Copyright (c) 2019, Intel Corporation.
>>>>>> + */
>>>>>> +
>>>>>> +#include <linux/delay.h>
>>>>>> +#include <linux/mfd/core.h>
>>>>>> +#include <linux/mfd/cros_ec.h>
>>>>>> +#include <linux/mfd/cros_ec_commands.h>
>>>>>> +#include <linux/module.h>
>>>>>> +#include <linux/pci.h>
>>>>>> +#include <linux/intel-ish-client-if.h>
>>>>>> +
>>>>
>>>> I think that this patch depends on another patchset that's in
>>>> linux-next but
>>>> diddn't land yet to mainline. Do you know if the dependencies are
>>>> queued for
>>>> next merge window? Can you provide the exact patches that this
>>>> patch depends on?
>>>
>>> Enric, 
>>> Sorry I missed mentioning this. 
>>>  
>>> The patch have dependency on intel-ish-hid stack on hid git tree,
>>> branch for-5.2/ish
>>>
> https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/log/?h=for-5.2/ish
>>>
>>> Srinivas, 
>>> Could you tell if the patches are queued for next merge window?
>>>
> Yes they are queued up for the next merge window. They are already in
> linux-next. One option is to check if Jiri pick this patch as part of
> his pull request. I am assuming that this patch doesn't depend on any
> other ChromeOS EC patches.
> 

Ok, in such case a v4 will be needed, just few style changes that was thinking
to change myself if had the patch had gone through the platform tree.

Thanks,
 Enric
