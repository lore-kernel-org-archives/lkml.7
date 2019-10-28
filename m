Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91876CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E17A20578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfJ1Mms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:42:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:44069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389163AbfJ1Mmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:42:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 05:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="374218666"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.197]) ([10.237.72.197])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2019 05:42:44 -0700
Subject: Re: [PATCH 0/2] add regulator driver and mfd cell for Intel Cherry
 Trail Whiskey Cove PMIC
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
References: <20191024142939.25920-1-andrey.zhizhikin@leica-geosystems.com>
 <20191025075335.GC32742@smile.fi.intel.com>
 <20191025075540.GD32742@smile.fi.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <166c9855-910d-a70c-ba86-6aebe5f2346d@intel.com>
Date:   Mon, 28 Oct 2019 14:41:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025075540.GD32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/19 10:55 AM, Andy Shevchenko wrote:
> On Fri, Oct 25, 2019 at 10:53:35AM +0300, Andy Shevchenko wrote:
>> On Thu, Oct 24, 2019 at 02:29:37PM +0000, Andrey Zhizhikin wrote:
>>> This patchset introduces additional regulator driver for Intel Cherry
>>> Trail Whiskey Cove PMIC. It also adds a cell in mfd driver for this
>>> PMIC, which is used to instantiate this regulator.
>>>
>>> Regulator support for this PMIC was present in kernel release from Intel
>>> targeted Aero platform, but was not entirely ported upstream and has
>>> been omitted in mainline kernel releases. Consecutively, absence of
>>> regulator caused the SD Card interface not to be provided with Vqcc
>>> voltage source needed to operate with UHS-I cards.
>>>
>>> Following patches are addessing this issue and making sd card interface
>>> to be fully operable with UHS-I cards. Regulator driver lists an ACPI id
>>> of the SD Card interface in consumers and exposes optional "vqmmc"
>>> voltage source, which mmc driver uses to switch signalling voltages
>>> between 1.8V and 3.3V. 
>>>
>>> This set contains of 2 patches: one is implementing the regulator driver
>>> (based on a non upstreamed version from Intel Aero), and another patch
>>> registers this driver as mfd cell in exising Whiskey Cove PMIC driver.
>>
>> Thank you.
>> Hans, Cc'ed, has quite interested in these kind of patches.
>> Am I right, Hans?
> 
> Since it's about UHS/SD, Cc to Adrian as well.
> 

My only concern is that the driver might conflict with ACPI methods trying
to do the same thing, e.g. there is one ACPI SDHC instance from GPDWin DSDT
with code like this:

  If ((Arg2 == 0x03))
   {
       ADBG ("DSM 1p8")
       If ((^^I2C7.AVBL == One))
       {
           If ((PMID == One))
           {
               DATA = 0x59
               ^^I2C7.DL03 = BUFF /* \_SB_.PCI0.SHC1.BUFF */
           }
           ElseIf ((PMID == 0x02))
           {
               BUFF = ^^I2C7.XD31 /* \_SB_.PCI0.I2C7.XD31 */
               If ((STAT == Zero))
               {
                   DATA |= 0x10
                   ^^I2C7.XD31 = BUFF /* \_SB_.PCI0.SHC1.BUFF */
               }

               BUFF = ^^I2C7.XD32 /* \_SB_.PCI0.I2C7.XD32 */
               If ((STAT == Zero))
               {
                   DATA |= 0x0B
                   DATA &= 0xEB
                   ^^I2C7.XD32 = BUFF /* \_SB_.PCI0.SHC1.BUFF */
               }

               Sleep (0x0A)
               BUFF = ^^I2C7.XD31 /* \_SB_.PCI0.I2C7.XD31 */
               If ((STAT == Zero))
               {
                   DATA |= 0x20
                   ^^I2C7.XD31 = BUFF /* \_SB_.PCI0.SHC1.BUFF */
               }
           }
           ElseIf ((PMID == 0x03))
           {
               Local0 = ^^I2C7.PMI5.GET (One, 0x6E, 0x67)
               Sleep (0x0A)
               Local0 &= 0xF8
               ^^I2C7.PMI5.SET (One, 0x6E, 0x67, Local0)
               Sleep (0x64)
               Local0 = ^^I2C7.PMI5.GET (One, 0x6E, 0x67)
               Sleep (0x0A)
               Local0 |= One
               Local0 &= 0xF9
               ^^I2C7.PMI5.SET (One, 0x6E, 0x67, Local0)
               Sleep (0x0A)
               ^^I2C7.PMI5.SET (One, 0x6E, 0xC6, 0x1F)
               Sleep (0x0A)
           }
       }

       SDVL = One
       Return (0x03)
   }



