Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94759CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6592F2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 07:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfJaHGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 03:06:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726575AbfJaHGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 03:06:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D5F6AE04;
        Thu, 31 Oct 2019 07:06:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Oct 2019 08:06:10 +0100
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
In-Reply-To: <BYAPR04MB5749158C2EBD47FC48A79FF286600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <BYAPR04MB5749158C2EBD47FC48A79FF286600@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <82e496f61183ebdf7924d660d3b8c90e@suse.de>
X-Sender: jthumshirn@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-30 20:58, Chaitanya Kulkarni wrote:
> On 10/30/2019 08:24 AM, Daniel Wagner wrote:
>> Hi,
>> 
>> I've got following oops:
>> 
>> PID: 79413  TASK: ffff92f03a814ec0  CPU: 19  COMMAND: "kworker/19:2"
>> #0 [ffffa5308b8c3c58] machine_kexec at ffffffff8e05dd02
>> #1 [ffffa5308b8c3ca8] __crash_kexec at ffffffff8e12102a
>> #2 [ffffa5308b8c3d68] crash_kexec at ffffffff8e122019
>> #3 [ffffa5308b8c3d80] oops_end at ffffffff8e02e091
>> #4 [ffffa5308b8c3da0] general_protection at ffffffff8e8015c5
>>      [exception RIP: nvmet_async_event_work+94]
>>      RIP: ffffffffc0d9a80e  RSP: ffffa5308b8c3e58  RFLAGS: 00010202
>>      RAX: dead000000000100  RBX: ffff92dcbc7464b0  RCX: 
>> 0000000000000002
>>      RDX: 0000000000040002  RSI: 38ffff92dc9814cf  RDI: 
>> ffff92f217722f20
>>      RBP: ffff92dcbc746418   R8: 0000000000000000   R9: 
>> 0000000000000000
>>      R10: 000000000000035b  R11: ffff92efb8dd2091  R12: 
>> ffff92dcbc7464a0
>>      R13: ffff92dbe03a5f29  R14: 0000000000000000  R15: 
>> 0ffff92f92f26864
>>      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
>> #5 [ffffa5308b8c3e78] process_one_work at ffffffff8e0a3b0c
>> #6 [ffffa5308b8c3eb8] worker_thread at ffffffff8e0a41e7
>> #7 [ffffa5308b8c3f10] kthread at ffffffff8e0a93af
>> #8 [ffffa5308b8c3f50] ret_from_fork at ffffffff8e800235
>> 
>> this maps to nvmet_async_event_results. So it looks like this function
>> access a stale aen pointer:
>> 
>> static u32 nvmet_async_event_result(struct nvmet_async_event *aen)
>> {
>>          return aen->event_type | (aen->event_info << 8) | 
>> (aen->log_page << 16);
>> }
> Can you please explain the test setup ? Is that coming from the tests
> present in the blktests ? if so you can please provide test number ?

No unfortunately this is coming from a customer bug report. We _think_ 
we're having a race between AEN processing and nvmet_sq_destroy(), but 
we're not 100% sure. Hence this RFC.


