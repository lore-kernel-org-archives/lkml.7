Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93BEC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D0321E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfHGHYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:24:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:22902 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727603AbfHGHYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:24:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 00:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="373677960"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.185.23.132]) ([10.185.23.132])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2019 00:23:59 -0700
Subject: Re: [Intel-wired-lan] MDI errors during resume from ACPI S3 (suspend
 to ram)
To:     Mario.Limonciello@dell.com, pmenzel@molgen.mpg.de,
        jeffrey.t.kirsher@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <81004059-6d91-d8be-c80e-70c52359350d@molgen.mpg.de>
 <2277f25bc44c4aebaac59942de2e24bb@AUSX13MPC105.AMER.DELL.COM>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <d0aaa0f8-b94c-be65-7a4e-f5592aa65647@intel.com>
Date:   Wed, 7 Aug 2019 10:23:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2277f25bc44c4aebaac59942de2e24bb@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/2019 18:53, Mario.Limonciello@dell.com wrote:
>> -----Original Message-----
>> From: Paul Menzel <pmenzel@molgen.mpg.de>
>> Sent: Tuesday, August 6, 2019 10:36 AM
>> To: Jeff Kirsher
>> Cc: intel-wired-lan@lists.osuosl.org; Linux Kernel Mailing List; Limonciello, Mario
>> Subject: MDI errors during resume from ACPI S3 (suspend to ram)
>>
>> Dear Linux folks,
>>
>>
>> Trying to decrease the resume time of Linux 5.3-rc3 on the Dell OptiPlex
>> 5040 with the device below
>>
>>      $ lspci -nn -s 00:1f.6
>>      00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2)
>> I219-V [8086:15b8] (rev 31)
>>
>> pm-graph’s script `sleepgraph.py` shows, that the driver *e1000e* takes
>> around 400 ms, which is quite a lot. The call graph trace shows that
>> `e1000e_read_phy_reg_mdic()` is responsible for a lot of those. From
>> `drivers/net/ethernet/intel/e1000e/phy.c` [1]:
>>
>>          for (i = 0; i < (E1000_GEN_POLL_TIMEOUT * 3); i++) {
>>                  udelay(50);
>>                  mdic = er32(MDIC);
>>                  if (mdic & E1000_MDIC_READY)
>>                          break;
>>          }
>>          if (!(mdic & E1000_MDIC_READY)) {
>>                  e_dbg("MDI Read did not complete\n");
>>                  return -E1000_ERR_PHY;
>>          }
>>          if (mdic & E1000_MDIC_ERROR) {
>>                  e_dbg("MDI Error\n");
>>                  return -E1000_ERR_PHY;
>>          }
>>
>> Unfortunately, errors are not logged if dynamic debug is disabled,
>> so rebuilding the Linux kernel with `CONFIG_DYNAMIC_DEBUG`, and
>>
>>      echo "file drivers/net/ethernet/* +p" | sudo tee
>> /sys/kernel/debug/dynamic_debug/control
>>
>> I got the messages below.
>>
>>      [ 4159.204192] e1000e 0000:00:1f.6 net00: MDI Error
>>      [ 4160.267950] e1000e 0000:00:1f.6 net00: MDI Write did not complete
>>      [ 4160.359855] e1000e 0000:00:1f.6 net00: MDI Error
>>
>> Can you please shed a little more light into these errors? Please
>> find the full log attached.
>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> [1]:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/n
>> et/ethernet/intel/e1000e/phy.c#n206
> 
> Strictly as a reference point you may consider trying the out-of-tree driver to see if these
> behaviors persist.
> 
> https://sourceforge.net/projects/e1000/
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan@osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
We are using external PHY. Required ~200 ms to complete MDIC transaction 
(depended on the project). You need to take to consider this time before 
access to the PHY. I do not recommend decrease timer in a 
'e1000e_read_phy_reg_mdic()' method. We could hit on wrong MDI access.
