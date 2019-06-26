Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5B5C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64382208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 18:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfFZSBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 14:01:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:58027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfFZSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 14:01:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 11:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="245510059"
Received: from ray.jf.intel.com (HELO [10.7.201.139]) ([10.7.201.139])
  by orsmga001.jf.intel.com with ESMTP; 26 Jun 2019 11:01:28 -0700
Subject: xarray soft lockups on 5.2-rc's
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190603162215.6390707f@canb.auug.org.au>
 <a6c98d75-078a-797f-a582-9687324e8c02@intel.com>
 <20190603225954.GD23346@bombadil.infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
Message-ID: <ea5575ae-39fc-db07-e1c7-8f50a22269ed@intel.com>
Date:   Wed, 26 Jun 2019 11:01:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190603225954.GD23346@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/19 3:59 PM, Matthew Wilcox wrote:
>> I'm seeing a similar softlockup:
> I've taken that commit out of my xarray tree.  It's only a performance
> optimisation, so I don't mind dropping it until it's debugged.

I'm also seeing these on mainline pretty regularly (~once a week).  The
latest was on -rc4, but the xarray code doesn't look like it's been
updated in mainline since 5.1.

I only seem to see these for the swap cache path, never the page cache
path, which makes me suspicious (typical dump is below).  The stack is
always the same path, but the exact instruction pointer address seems to
bounce around between find_get_entry() and deeper into the xarray code.

find_get_entry() seems to have some recent changes, and this patch of
backtraces would be consistent with it getting stuck in a "goto repeat"
loop in there.

     12 RIP: 0010:xas_load+0x35/0x80
      9 RIP: 0010:xas_load+0x27/0x80
      7 RIP: 0010:xas_load+0x13/0x80
      4 RIP: 0010:xas_load+0x66/0x80
      4 RIP: 0010:xas_load+0x45/0x80
      2 RIP: 0010:xas_start+0x0/0x90
      2 RIP: 0010:xas_load+0x3f/0x80
      2 RIP: 0010:xas_load+0x31/0x80
      2 RIP: 0010:xas_load+0x20/0x80
      2 RIP: 0010:xas_load+0x0/0x80
      2 RIP: 0010:find_get_entry+0x87/0x1a0
      2 RIP: 0010:find_get_entry+0x74/0x1a0
      1 RIP: 0010:xas_start+0x57/0x90
      1 RIP: 0010:xas_start+0x42/0x90
      1 RIP: 0010:xas_load+0xb/0x80
      1 RIP: 0010:xas_load+0x72/0x80
      1 RIP: 0010:xas_load+0x5e/0x80
      1 RIP: 0010:xas_load+0x43/0x80
      1 RIP: 0010:xas_load+0x39/0x80
      1 RIP: 0010:xas_load+0x24/0x80
      1 RIP: 0010:find_get_entry+0x63/0x1a0
      1 RIP: 0010:dev_watchdog+0x273/0x280


> CPU: 2 PID: 1025 Comm: TaskSchedulerFo Not tainted 5.2.0-rc4 #15
> Hardware name: LENOVO 20F5S7V800/20F5S7V800, BIOS R02ET70W (1.43 ) 01/28/2019
> RIP: 0010:xas_start+0x0/0x90
> Code: 48 85 d2 75 e3 48 8b 17 b8 00 00 80 00 89 f1 d3 e0 8b 7a 18 85 c7 75 07 09 f8 89 42 18 f3 c3 f3 c3 f3 c3 0f 1f 80 00 00 00 00 <48> 8b 47 18 48 89 c2 83 e2 03 74 19 48 83 fa 02 75 26 48 3d 05 c0
> RSP: 0000:ffffc9000996fcf0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000000 RBX: ffffc9000996fd08 RCX: 0000000000000000 
> RDX: 0000000000000021 RSI: ffff888168184490 RDI: ffffc9000996fd08
> RBP: 000000000027db21 R08: 000fffffffe00000 R09: ffff8884216fa5c0 
> R10: ffff8884216fa000 R11: 0000000000000822 R12: 0000000000000000
> R13: ffff888409fc9018 R14: 000000000027db21 R15: 0000000000000001 
> FS:  00007f4f44d01700(0000) GS:ffff888411900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f4f4cb21048 CR3: 000000029751a003 CR4: 00000000003626e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  xas_load+0x9/0x80
>  find_get_entry+0x74/0x1a0
>  pagecache_get_page+0x27/0x250
>  lookup_swap_cache+0x40/0x130
>  do_swap_page+0x84/0x860
>  __handle_mm_fault+0x865/0xfb0
>  handle_mm_fault+0x103/0x210
>  __do_page_fault+0x2f5/0x530
>  ? page_fault+0x8/0x30
>  page_fault+0x1e/0x30
> RIP: 0033:0x7f4ff44cb836
> Code: 39 f7 0f 84 48 fd ff ff 44 89 ca 83 4b 04 04 e9 f3 fe ff ff 48 8b 53 68 49 8d 04 2f 4c 39 62 18 75 30 48 81 3c 24 ff 03 00 00 <4c> 89 60 18 48 89 50 10 48 89 43 68 48 89 42 18 0f 86 55 fe ff ff
> RSP: 002b:00007f4f44cffa50 EFLAGS: 00010212 
> RAX: 00007f4f4cb21030 RBX: 00007f4f4c000020 RCX: 00007f4f4c75c5f0
> RDX: 00007f4f4c000078 RSI: 00000000000030f1 RDI: 00000000007117f0 
> RBP: 00000000001eda40 R08: 00007f4f4c350370 R09: 0000000004422604
> R10: 0000000000184cb5 R11: 0000000000000000 R12: 00007f4f4c000078
> R13: 00007f4f4c75c5f0 R14: 00000000008ff230 R15: 00007f4f4c9335f0
> watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [TaskSchedulerFo:1025]
