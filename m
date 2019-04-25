Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8960DC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52106214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 11:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfDYLIB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 07:08:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:32998 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDYLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 07:08:00 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 47D02CF35C;
        Thu, 25 Apr 2019 13:16:09 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: Ignore CC events not matching the last HCI
 command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190425063812.14509-1-jprvita@endlessm.com>
Date:   Thu, 25 Apr 2019 13:07:57 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, bgodavar@codeaurora.org,
        ytkim@qca.qualcomm.com, "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C4118FC8-1589-44D5-97C4-E18892448985@holtmann.org>
References: <CA+A7VXVa9pFizfQ8C8QUS=3=YDjojmScOKPS=Yhcx-w8G=wsVw@mail.gmail.com>
 <20190425063812.14509-1-jprvita@endlessm.com>
To:     =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joao,

> This commit makes the kernel not send the next queued HCI command until
> a command complete arrives for the last HCI command sent to the
> controller. This change avoids a problem with some buggy controllers
> (seen on two SKUs of QCA9377) that send an extra command complete event
> for the previous command after the kernel had already sent a new HCI
> command to the controller.
> 
> The problem was reproduced when starting an active scanning procedure,
> where an extra command complete event arrives for the LE_SET_RANDOM_ADDR
> command. When this happends the kernel ends up not processing the
> command complete for the following commmand, LE_SET_SCAN_PARAM, and
> ultimately behaving as if a passive scanning procedure was being
> performed, when in fact controller is performing an active scanning
> procedure. This makes it impossible to discover BLE devices as no device
> found events are sent to userspace.
> 
> This problem is reproducible on 100% of the attempts on the affected
> controllers. The extra command complete event can be seen at timestamp
> 27.420131 on the btmon logs bellow.
> 
> Bluetooth monitor ver 5.50
> = Note: Linux version 5.0.0+ (x86_64)                                  0.352340
> = Note: Bluetooth subsystem version 2.22                               0.352343
> = New Index: 80:C5:F2:8F:87:84 (Primary,USB,hci0)               [hci0] 0.352344
> = Open Index: 80:C5:F2:8F:87:84                                 [hci0] 0.352345
> = Index Info: 80:C5:F2:8F:87:84 (Qualcomm)                      [hci0] 0.352346
> @ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.352347
> @ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.352366
> @ MGMT Open: btmgmt (privileged) version 1.14                {0x0003} 27.302164
> @ MGMT Command: Start Discovery (0x0023) plen 1       {0x0003} [hci0] 27.302310
>        Address type: 0x06
>          LE Public
>          LE Random
> < HCI Command: LE Set Random Address (0x08|0x0005) plen 6   #1 [hci0] 27.302496
>        Address: 15:60:F2:91:B2:24 (Non-Resolvable)
>> HCI Event: Command Complete (0x0e) plen 4                 #2 [hci0] 27.419117
>      LE Set Random Address (0x08|0x0005) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7  #3 [hci0] 27.419244
>        Type: Active (0x01)
>        Interval: 11.250 msec (0x0012)
>        Window: 11.250 msec (0x0012)
>        Own address type: Random (0x01)
>        Filter policy: Accept all advertisement (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                 #4 [hci0] 27.420131
>      LE Set Random Address (0x08|0x0005) ncmd 1
>        Status: Success (0x00)
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      #5 [hci0] 27.420259
>        Scanning: Enabled (0x01)
>        Filter duplicates: Enabled (0x01)
>> HCI Event: Command Complete (0x0e) plen 4                 #6 [hci0] 27.420969
>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>        Status: Success (0x00)
>> HCI Event: Command Complete (0x0e) plen 4                 #7 [hci0] 27.421983
>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>        Status: Success (0x00)
> @ MGMT Event: Command Complete (0x0001) plen 4        {0x0003} [hci0] 27.422059
>      Start Discovery (0x0023) plen 1
>        Status: Success (0x00)
>        Address type: 0x06
>          LE Public
>          LE Random
> @ MGMT Event: Discovering (0x0013) plen 2             {0x0003} [hci0] 27.422067
>        Address type: 0x06
>          LE Public
>          LE Random
>        Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2             {0x0002} [hci0] 27.422067
>        Address type: 0x06
>          LE Public
>          LE Random
>        Discovery: Enabled (0x01)
> @ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 27.422067
>        Address type: 0x06
>          LE Public
>          LE Random
>        Discovery: Enabled (0x01)
> 
> Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 5 +++++
> net/bluetooth/hci_event.c        | 3 +++
> 3 files changed, 9 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 094e61e07030..85bed4e916d3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -364,6 +364,7 @@ struct hci_dev {
> 	struct sk_buff_head	cmd_q;
> 
> 	struct sk_buff		*sent_cmd;
> +	__u8			sent_cmd_pending_cc;

is there anything wrong with a bool type? And frankly using a flag seems more safe than just a boolean.

> 
> 	struct mutex		req_lock;
> 	wait_queue_head_t	req_wait_q;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d6b2540ba7f8..37893b0c6077 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4380,9 +4380,13 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status,
> 		if (test_bit(HCI_INIT, &hdev->flags) && opcode == HCI_OP_RESET)
> 			hci_resend_last(hdev);
> 
> +		bt_dev_err(hdev,
> +			   "unexpected CC event for opcode 0x%4.4x", opcode);

Have you tested this? This will cause many error from tools like hciconfig or hcitool.

> 		return;
> 	}
> 
> +	hdev->sent_cmd_pending_cc = 0;
> +
> 	/* If the command succeeded and there's still more commands in
> 	 * this request the request is not yet complete.
> 	 */
> @@ -4493,6 +4497,7 @@ static void hci_cmd_work(struct work_struct *work)
> 
> 		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
> 		if (hdev->sent_cmd) {
> +			hdev->sent_cmd_pending_cc = 1;
> 			atomic_dec(&hdev->cmd_cnt);
> 			hci_send_frame(hdev, skb);
> 			if (test_bit(HCI_RESET, &hdev->flags))

Fun part is actually that even commands injected via hcitool etc. will be added to the sent_cmd queue unless they are vendor specific commands. However some manufactures choose to use command complete for their vendor commands as well (others don’t).

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd6871c5a..7541a4bc9444 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3404,6 +3404,9 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 	hci_req_cmd_complete(hdev, *opcode, *status, req_complete,
> 			     req_complete_skb);
> 
> +	if (hdev->sent_cmd_pending_cc)
> +		return;
> +
> 	if (atomic_read(&hdev->cmd_cnt) && !skb_queue_empty(&hdev->cmd_q))
> 		queue_work(hdev->workqueue, &hdev->cmd_work);

I rather see this done super cleanly. We have a pending cmd request from the kernel, make sure it gets answered with the corresponding command complete or command status and not just some other event. If there is a command complete or command status for a command that we don’t have pending, then ignore.

Frankly, you are just hacking around here.

Regards

Marcel

