Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC653C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F602071B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfKRKYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:24:04 -0500
Received: from spam01.hygon.cn ([110.188.70.11]:50976 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbfKRKYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:24:04 -0500
Received: from MK-FE.hygon.cn ([172.23.18.61])
        by spam1.hygon.cn with ESMTP id xAIAKXCl085098;
        Mon, 18 Nov 2019 18:20:33 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-FE.hygon.cn with ESMTP id xAIAKNwP014116;
        Mon, 18 Nov 2019 18:20:23 +0800 (GMT-8)
        (envelope-from linjiasen@hygon.cn)
Received: from [172.20.21.12] (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 18 Nov
 2019 18:20:28 +0800
Subject: Re: [PATCH] NTB: Fix an error in get link status
To:     Jon Mason <jdmason@kudzu.us>
CC:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-ntb <linux-ntb@googlegroups.com>, <linjiasen007@gmail.com>
References: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
 <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
From:   Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <933f74c7-7249-618c-13dc-9e4e47ad75d7@hygon.cn>
Date:   Mon, 18 Nov 2019 18:17:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wAJz=Hqb6Os=9AHHv_NGpZ8uCaAuOC=aUTkASKdfs9WQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex01.Hygon.cn (172.23.18.10) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn xAIAKXCl085098
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/18 7:00, Jon Mason wrote:
> On Thu, Nov 7, 2019 at 4:37 AM Jiasen Lin <linjiasen@hygon.cn> wrote:
>>
>> The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
>> but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 0x68.
>> It is offset of Device Capabilities Reg rather than Link Control Reg.
>>
>> This code trigger an error in get link statsus:
>>
>>          cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>>                  LNK STA -               0x8fa1
>>                  Link Status -           Up
>>                  Link Speed -            PCI-E Gen 0
>>                  Link Width -            x0
>>
>> This patch use pcie_capability_read_dword to get link status.
>> After fix this issue, we can get link status accurately:
>>
>>          cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
>>                  LNK STA -               0x11030042
>>                  Link Status -           Up
>>                  Link Speed -            PCI-E Gen 3
>>                  Link Width -            x16
> 
> No response from AMD maintainers, but it looks like you are correct.
> 
> This needs a "Fixes:" line here.  I took the liberty of adding one to
> this patch.
> 

Thank you for your suggestions. Yes, this patch fix the commit id: 
a1b3695 ("NTB: Add support for AMD PCI-Express Non-Transparent Bridge").

>> Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
>> ---
>>   drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
>>   drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> index 156c2a1..ae91105 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
>> @@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
>>
>>          ndev->cntl_sta = reg;
>>
>> -       rc = pci_read_config_dword(ndev->ntb.pdev,
>> -                                  AMD_LINK_STATUS_OFFSET, &stat);
>> +       rc = pcie_capability_read_dword(ndev->ntb.pdev,
>> +                                  PCI_EXP_LNKCTL, &stat);
>>          if (rc)
>>                  return 0;
>>          ndev->lnk_sta = stat;
>> @@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
>>   static const struct pci_device_id amd_ntb_pci_tbl[] = {
>>          { PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
>>          { PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
>> +       { PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
> 
> This should be a separate patch.  I took the liberty of splitting it
> off into a unique patch and attributing it to you.  I've pushed them
> to the ntb-next branch on
> https://github.com/jonmason/ntb
>
Thank you for your comment. We appreciate the time and effort you have 
spent to split it off, I will test it ASAP.

> Please verify everything looks acceptable to you (given the changes I
> did above that are attributed to you).  Also, testing of the latest
> code is always appreciated.
> 
> Thanks,
> Jon
> 
> 
>>          { 0, }
>>   };
>>   MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
>> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> index 139a307..39e5d18 100644
>> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
>> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
>> @@ -53,7 +53,6 @@
>>   #include <linux/pci.h>
>>
>>   #define AMD_LINK_HB_TIMEOUT    msecs_to_jiffies(1000)
>> -#define AMD_LINK_STATUS_OFFSET 0x68
>>   #define NTB_LIN_STA_ACTIVE_BIT 0x00000002
>>   #define NTB_LNK_STA_SPEED_MASK 0x000F0000
>>   #define NTB_LNK_STA_WIDTH_MASK 0x03F00000
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1573119336-107732-1-git-send-email-linjiasen%40hygon.cn.

Thanks,

Jiasen Lin
