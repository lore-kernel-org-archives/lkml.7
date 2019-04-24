Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD6A218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 06:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDXGpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 02:45:38 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49304 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfDXGph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 02:45:37 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 98CD6CF331;
        Wed, 24 Apr 2019 08:53:45 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH] Bluetooth: Ignore CC events not matching the last HCI
 command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190424060704.22721-1-jprvita@endlessm.com>
Date:   Wed, 24 Apr 2019 08:45:33 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, bgodavar@codeaurora.org,
        ytkim@qca.qualcomm.com, "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <547E8A62-51BF-4545-931E-40734134B27E@holtmann.org>
References: <20190424054335.30044-1-jprvita@endlessm.com>
 <20190424060704.22721-1-jprvita@endlessm.com>
To:     =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joao Paulo,

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
> net/bluetooth/hci_event.c | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd6871c5a..b349fc2b4123 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3071,6 +3071,19 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 	*opcode = __le16_to_cpu(ev->opcode);
> 	*status = skb->data[sizeof(*ev)];
> 
> +	if (*opcode != HCI_OP_RESET && !hci_sent_cmd_data(hdev, *opcode)) {
> +		/* Some buggy controllers generate an extra command complete
> +		 * event for the previous command after a new commend was
> +		 * already sent, so if the opcode does not match the last sent
> +		 * command we should ignore this event.
> +		 *
> +		 * HCI_OP_RESET is a special case handled in
> +		 * hci_req_cmd_complete.
> +		 */
> +		bt_dev_err(hdev, "unexpected CC event opcode 0x%4.4x", *opcode);
> +		return;
> +	}
> +

the return; here is not going to fly. You need to go through the switch statement since it actually does bookkeeping for a lot of features even if the command is not executed by hci_req and instead comes from user space or someone else.

What is the problem with handling this in hci_req_cmd_complete. We have hci_sent_cmd_data check there already. Lets extend this to ensure that command complete for random commands don’t trigger us to continue with the request.

Regards

Marcel

