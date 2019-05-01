Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DCAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782D620866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="I9Qp7BDc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TpBrdADA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEAFST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 01:18:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 01:18:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 46705608D4; Wed,  1 May 2019 05:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556687897;
        bh=0cbJzVY0zO4lj0dldr9fMr5wsQchbzVWfQyEH0ZJ7HE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9Qp7BDcaCYyUWIXxZ03lH23tQiEUAQFETX4jN+q0K+4wQ5cumAbls8g9kwx/GoUC
         veZ8DyCOkjQgPsxvtGQlanIImbmWCFuJ1xg17E64GjWPhhePYVy4IblrBM0f3laCU1
         WrW9lLEsxWf434dymuysJrxFKs55VXndBf5ksycU=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 1B6A360314;
        Wed,  1 May 2019 05:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556687896;
        bh=0cbJzVY0zO4lj0dldr9fMr5wsQchbzVWfQyEH0ZJ7HE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TpBrdADAFcUQCsVvQ0/ammJ0Llm1ovo8ut81/lDZwBhywomQBRR2u/J8Szw+/Xmqx
         8X/iL06oopWh+Nqu/nbKvo0v7C1U62vqHBha09CrlFs4VnuSzT4MYpVJoePKJVZJ6+
         i4HqHnffa2BzWMtgOSvvAOcBBgWrMk0KczVhe96o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 01 May 2019 10:48:16 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harish Bandi <c-hbandi@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>
Subject: Re: [PATCH v8] Bluetooth: btqca: inject command complete event during
 fw download
In-Reply-To: <20190430153811.GK112750@google.com>
References: <20190430001024.209688-1-mka@chromium.org>
 <201904301409.dhHyM2xm%lkp@intel.com> <20190430153811.GK112750@google.com>
Message-ID: <48bfdc75ce46edcf3b472849a36a2f0c@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harish,

On 2019-04-30 21:08, Matthias Kaehlcke wrote:
> On Tue, Apr 30, 2019 at 02:27:33PM +0800, kbuild test robot wrote:
>> Hi Matthias,
>> 
>> Thank you for the patch! Yet something to improve:
>> 
>> [auto build test ERROR on bluetooth-next/master]
>> [also build test ERROR on next-20190429]
>> [cannot apply to v5.1-rc7]
>> [if your patch is applied to the wrong git tree, please drop us a note 
>> to help improve the system]
>> 
>> url:    
>> https://github.com/0day-ci/linux/commits/Matthias-Kaehlcke/Bluetooth-btqca-inject-command-complete-event-during-fw-download/20190430-125407
>> base:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git 
>> master
>> config: xtensa-allyesconfig (attached as .config)
>> compiler: xtensa-linux-gcc (GCC) 8.1.0
>> reproduce:
>>         wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
>> 
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>> 
>> All errors (new ones prefixed by >>):
>> 
>>    drivers/bluetooth/btqca.c: In function 
>> 'qca_inject_cmd_complete_event':
>> >> drivers/bluetooth/btqca.c:286:18: error: 'QCA_HCI_CC_SUCCESS' undeclared (first use in this function); did you mean 'QCA_HCI_CC_OPCODE'?
>>      skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
>>                      ^~~~~~~~~~~~~~~~~~
>>                      QCA_HCI_CC_OPCODE
>>    drivers/bluetooth/btqca.c:286:18: note: each undeclared identifier 
>> is reported only once for each function it appears in
>> 
>> vim +286 drivers/bluetooth/btqca.c
>> 
>>    267
>>    268	static int qca_inject_cmd_complete_event(struct hci_dev *hdev)
>>    269	{
>>    270		struct hci_event_hdr *hdr;
>>    271		struct hci_ev_cmd_complete *evt;
>>    272		struct sk_buff *skb;
>>    273
>>    274		skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, 
>> GFP_KERNEL);
>>    275		if (!skb)
>>    276			return -ENOMEM;
>>    277
>>    278		hdr = skb_put(skb, sizeof(*hdr));
>>    279		hdr->evt = HCI_EV_CMD_COMPLETE;
>>    280		hdr->plen = sizeof(*evt) + 1;
>>    281
>>    282		evt = skb_put(skb, sizeof(*evt));
>>    283		evt->ncmd = 1;
>>    284		evt->opcode = HCI_OP_NOP;
>>    285
>>  > 286		skb_put_u8(skb, QCA_HCI_CC_SUCCESS);
> 
> Oh, I changed it in my tree, but somehow missed to include this file
> in the commit ...
> 
> I'll fix it in the next version. Since I expect the change to remain
> controversial I'll wait a bit for other comments before sending out
> v9.
> 
> Thanks
> 
> Matthias

[Bala]: can you check whether this change  is applicable for wcn3998 as 
well.

@Matthias, Thanks Matthias for taking Up :)

-- 
Regards
Balakrishna.
