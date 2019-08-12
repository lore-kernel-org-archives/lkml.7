Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FCBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D57720679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfHLQhI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:37:08 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46080 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfHLQhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:37:08 -0400
Received: from marcel-macbook.fritz.box (p4FEFC580.dip0.t-ipconnect.de [79.239.197.128])
        by mail.holtmann.org (Postfix) with ESMTPSA id 2B53BCECF3;
        Mon, 12 Aug 2019 18:45:48 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] Bluetooth: btqca: release_firmware after
 qca_inject_cmd_complete_event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190806095629.88769-1-tientzu@chromium.org>
Date:   Mon, 12 Aug 2019 18:37:06 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, johan@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        bgodavar@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5AFCA924-5A3E-471D-83A8-5C59B7AD8049@holtmann.org>
References: <20190806095629.88769-1-tientzu@chromium.org>
To:     Claire Chang <tientzu@chromium.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claire,

> commit 32646db8cc28 ("Bluetooth: btqca: inject command complete event
> during fw download") added qca_inject_cmd_complete_event() for certain
> qualcomm chips. However, qca_download_firmware() will return without
> calling release_firmware() in this case.
> 
> This leads to a memory leak like the following found by kmemleak:
> 
> unreferenced object 0xfffffff3868a5880 (size 128):
>  comm "kworker/u17:5", pid 347, jiffies 4294676481 (age 312.157s)
>  hex dump (first 32 bytes):
>    ac fd 00 00 00 00 00 00 00 d0 7e 17 80 ff ff ff  ..........~.....
>    00 00 00 00 00 00 00 00 00 59 8a 86 f3 ff ff ff  .........Y......
>  backtrace:
>    [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
>    [<000000006ea0398c>] _request_firmware+0x74/0x4e4
>    [<000000004da31ca0>] request_firmware+0x44/0x64
>    [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
>    [<00000000b24d615a>] qca_uart_setup+0xc0/0x2b0 [btqca]
>    [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
>    [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
>    [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
>    [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
>    [<00000000d4151583>] process_one_work+0x210/0x420
>    [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
>    [<000000007ccaf055>] kthread+0x124/0x134
>    [<00000000bef1f723>] ret_from_fork+0x10/0x18
>    [<00000000c36ee3dd>] 0xffffffffffffffff
> unreferenced object 0xfffffff37b16de00 (size 128):
>  comm "kworker/u17:5", pid 347, jiffies 4294676873 (age 311.766s)
>  hex dump (first 32 bytes):
>    da 07 00 00 00 00 00 00 00 50 ff 0b 80 ff ff ff  .........P......
>    00 00 00 00 00 00 00 00 00 dd 16 7b f3 ff ff ff  ...........{....
>  backtrace:
>    [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
>    [<000000006ea0398c>] _request_firmware+0x74/0x4e4
>    [<000000004da31ca0>] request_firmware+0x44/0x64
>    [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
>    [<000000000cde20a9>] qca_uart_setup+0x144/0x2b0 [btqca]
>    [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
>    [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
>    [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
>    [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
>    [<00000000d4151583>] process_one_work+0x210/0x420
>    [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
>    [<000000007ccaf055>] kthread+0x124/0x134
>    [<00000000bef1f723>] ret_from_fork+0x10/0x18
>    [<00000000c36ee3dd>] 0xffffffffffffffff
> 
> Make sure release_firmware() is called aftre
> qca_inject_cmd_complete_event() to avoid the memory leak.
> 
> Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event during fw download")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
> drivers/bluetooth/btqca.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

