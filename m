Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2133FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36802133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfFXL5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:57:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:48688 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfFXL5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:57:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 04:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,412,1557212400"; 
   d="scan'208";a="161598821"
Received: from eyasman-mobl.ger.corp.intel.com (HELO [10.249.90.21]) ([10.249.90.21])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2019 04:56:59 -0700
Subject: Re: [Intel-wired-lan] Opportunistic S0ix blocked by e1000e when
 ethernet is in use
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <074E1145-A512-4835-9A6D-8FB6634DBD3C@canonical.com>
 <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <95f88f45-fd6c-52e4-de8c-2db1b4c6c04e@intel.com>
Date:   Mon, 24 Jun 2019 14:56:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <E2D5225B-D683-4895-AC4F-EE01C339262B@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/2019 10:03, Kai-Heng Feng wrote:
> Hi Jeffrey,
> 
> at 19:08, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
>> Hi Jeffrey,
>>
>> There are several platforms that uses e1000e can’t enter Opportunistic 
>> S0ix (PC10) when the ethernet has a link partner.
>>
>> This behavior also exits in out-of-tree e1000e driver 3.4.2.1, but 
>> seems like 3.4.2.3 fixes the issue.
>>
>> A quick diff between the two versions shows that this code section may 
>> be our solution:
>>
>>         /* Read from EXTCNF_CTRL in e1000_acquire_swflag_ich8lan function
>>          * may occur during global reset and cause system hang.
>>          * Configuration space access creates the needed delay.
>>          * Write to E1000_STRAP RO register 
>> E1000_PCI_VENDOR_ID_REGISTER value
>>          * insures configuration space read is done before global reset.
>>          */
>>         pci_read_config_word(hw->adapter->pdev, 
>> E1000_PCI_VENDOR_ID_REGISTER,
>>                              &pci_cfg);
>>         ew32(STRAP, pci_cfg);
>>         e_dbg("Issuing a global reset to ich8lan\n");
>>         ew32(CTRL, (ctrl | E1000_CTRL_RST));
>>         /* cannot issue a flush here because it hangs the hardware */
>>         msleep(20);
>>
>>         /* Configuration space access improve HW level time sync 
>> mechanism.
>>          * Write to E1000_STRAP RO register E1000_PCI_VENDOR_ID_REGISTER
>>          * value to insure configuration space read is done
>>          * before any access to mac register.
>>          */
>>         pci_read_config_word(hw->adapter->pdev, 
>> E1000_PCI_VENDOR_ID_REGISTER,
>>                              &pci_cfg);
>>         ew32(STRAP, pci_cfg);
> 
> Turns out the "extra sauce” is not this part, it’s called “Dynamic LTR 
> support”.
> >>
>> Is there any plan to support this in the upstream kernel?
> 
> Is there any plan to support Dynamic LTR in upstream e1000e?
> 
Dynamic LTR is not stable solution. So, we can not put this solution to 
upstream. I hope we will be able to fix this in HW for a future projects.
S0ix support is under discussion with our architecture. We will try 
enable S0ix in our e1000e OOT driver as first step.
> Kai-Heng
> 
>>
>> Kai-Heng
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Thanks
Sasha
