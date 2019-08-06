Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185DFC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E254D20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LiYPummN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ESZqsS8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfHFLMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:12:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731309AbfHFLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:12:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 411E2607DE; Tue,  6 Aug 2019 11:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565089933;
        bh=PXqe5y9a718vUQSQUOxmfZGDIqCtip464Gcvxtjj4zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LiYPummNg1KAHClUPC5DEMTpP4DOooxFBDHNhSucbNmUnY1KGXXfEKgVdw4d0O6Fx
         5TdizQ2A4EnvZ/ca/Gs0Diqe+AgvBBRGRTwGCQ7xBqDdGdz3RsXlaMj4DobPFcPk3B
         84+t4EnMIfPNzH4rMEcESDA1HZsOat8I4eONCCdI=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 307746053B;
        Tue,  6 Aug 2019 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565089932;
        bh=PXqe5y9a718vUQSQUOxmfZGDIqCtip464Gcvxtjj4zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ESZqsS8VblOMAJdQViDaUiA4jfHfE0FXzpZjnWRi9/Fapc2wPyLYgn66ReFe8k7y9
         Aau3PopZGRte19uvjXU0Mznhk32zMVPlsduCv2NbFBvaK+gp2HwHV+bO+U8bVjaCN+
         DjeNHnPLCjgKOjOCy3jf0i33qWgCB6j799dxZZa4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 06 Aug 2019 16:42:12 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, johan@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantg@codeaurora.org, rjliao@codeaurora.org
Subject: Re: [PATCH] Bluetooth: btqca: release_firmware after
 qca_inject_cmd_complete_event
In-Reply-To: <20190806095629.88769-1-tientzu@chromium.org>
References: <20190806095629.88769-1-tientzu@chromium.org>
Message-ID: <e1c1e48cb4c79d958fef7d66539b0a86@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-08-06 15:26, Claire Chang wrote:
> commit 32646db8cc28 ("Bluetooth: btqca: inject command complete event
> during fw download") added qca_inject_cmd_complete_event() for certain
> qualcomm chips. However, qca_download_firmware() will return without
> calling release_firmware() in this case.
> 
> This leads to a memory leak like the following found by kmemleak:
> 
> unreferenced object 0xfffffff3868a5880 (size 128):
>   comm "kworker/u17:5", pid 347, jiffies 4294676481 (age 312.157s)
>   hex dump (first 32 bytes):
>     ac fd 00 00 00 00 00 00 00 d0 7e 17 80 ff ff ff  ..........~.....
>     00 00 00 00 00 00 00 00 00 59 8a 86 f3 ff ff ff  .........Y......
>   backtrace:
>     [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
>     [<000000006ea0398c>] _request_firmware+0x74/0x4e4
>     [<000000004da31ca0>] request_firmware+0x44/0x64
>     [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
>     [<00000000b24d615a>] qca_uart_setup+0xc0/0x2b0 [btqca]
>     [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
>     [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
>     [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
>     [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
>     [<00000000d4151583>] process_one_work+0x210/0x420
>     [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
>     [<000000007ccaf055>] kthread+0x124/0x134
>     [<00000000bef1f723>] ret_from_fork+0x10/0x18
>     [<00000000c36ee3dd>] 0xffffffffffffffff
> unreferenced object 0xfffffff37b16de00 (size 128):
>   comm "kworker/u17:5", pid 347, jiffies 4294676873 (age 311.766s)
>   hex dump (first 32 bytes):
>     da 07 00 00 00 00 00 00 00 50 ff 0b 80 ff ff ff  .........P......
>     00 00 00 00 00 00 00 00 00 dd 16 7b f3 ff ff ff  ...........{....
>   backtrace:
>     [<00000000978ce31d>] kmem_cache_alloc_trace+0x194/0x298
>     [<000000006ea0398c>] _request_firmware+0x74/0x4e4
>     [<000000004da31ca0>] request_firmware+0x44/0x64
>     [<0000000094572996>] qca_download_firmware+0x74/0x6e4 [btqca]
>     [<000000000cde20a9>] qca_uart_setup+0x144/0x2b0 [btqca]
>     [<00000000364a6d5a>] qca_setup+0x204/0x570 [hci_uart]
>     [<000000006be1a544>] hci_uart_setup+0xa8/0x148 [hci_uart]
>     [<00000000d64c0f4f>] hci_dev_do_open+0x144/0x530 [bluetooth]
>     [<00000000f69f5110>] hci_power_on+0x84/0x288 [bluetooth]
>     [<00000000d4151583>] process_one_work+0x210/0x420
>     [<000000003cf3dcfb>] worker_thread+0x2c4/0x3e4
>     [<000000007ccaf055>] kthread+0x124/0x134
>     [<00000000bef1f723>] ret_from_fork+0x10/0x18
>     [<00000000c36ee3dd>] 0xffffffffffffffff
> 
> Make sure release_firmware() is called aftre
> qca_inject_cmd_complete_event() to avoid the memory leak.
> 
> Fixes: 32646db8cc28 ("Bluetooth: btqca: inject command complete event
> during fw download")
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/bluetooth/btqca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 2221935fac7e..8f0fec5acade 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -344,7 +344,7 @@ static int qca_download_firmware(struct hci_dev 
> *hdev,
>  	 */
>  	if (config->dnld_type == ROME_SKIP_EVT_VSE_CC ||
>  	    config->dnld_type == ROME_SKIP_EVT_VSE)
> -		return qca_inject_cmd_complete_event(hdev);
> +		ret = qca_inject_cmd_complete_event(hdev);
> 
>  out:
>  	release_firmware(fw);

Change look fine to me.

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>

-- 
Regards
Balakrishna.
