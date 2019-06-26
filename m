Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CFC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB532085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfFZG04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:26:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:52868 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfFZG04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:26:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 23:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,418,1557212400"; 
   d="scan'208";a="188550973"
Received: from sneftin-mobl1.ger.corp.intel.com (HELO [10.185.23.132]) ([10.185.23.132])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jun 2019 23:26:53 -0700
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
From:   "Neftin, Sasha" <sasha.neftin@intel.com>
Message-ID: <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
Date:   Wed, 26 Jun 2019 09:26:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/2019 09:14, Kai Heng Feng wrote:
> Hi Sasha
> 
> at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
>> Hi Jeffrey,
>>
>> We’ve encountered another issue, which causes multiple CRC errors and 
>> renders ethernet completely useless, here’s the network stats:
> 
> I also tried ignore_ltr for this issue, seems like it alleviates the 
> symptom a bit for a while, then the network still becomes useless after 
> some usage.
> 
> And yes, it’s also a Whiskey Lake platform. What’s the next step to 
> debug this problem?
> 
> Kai-Heng
CRC errors not related to the LTR. Please, try to disable the ME on your 
platform. Hope you have this option in BIOS. Another way is to contact 
your PC vendor and ask to provide NVM without ME. Let's start debugging 
with these steps.
> 
>>
>> /sys/class/net/eno1/statistics$ grep . *
>> collisions:0
>> multicast:95
>> rx_bytes:1499851
>> rx_compressed:0
>> rx_crc_errors:1165
>> rx_dropped:0
>> rx_errors:2330
>> rx_fifo_errors:0
>> rx_frame_errors:0
>> rx_length_errors:0
>> rx_missed_errors:0
>> rx_nohandler:0
>> rx_over_errors:0
>> rx_packets:4789
>> tx_aborted_errors:0
>> tx_bytes:864312
>> tx_carrier_errors:0
>> tx_compressed:0
>> tx_dropped:0
>> tx_errors:0
>> tx_fifo_errors:0
>> tx_heartbeat_errors:0
>> tx_packets:7370
>> tx_window_errors:0
>>
>> Same behavior can be observed on both mainline kernel and on your 
>> dev-queue branch.
>> OTOH, the same issue can’t be observed on out-of-tree e1000e.
>>
>> Is there any plan to close the gap between upstream and out-of-tree 
>> version?
>>
>> Kai-Heng
> 
> 

