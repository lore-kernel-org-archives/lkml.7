Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A6DC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F7B206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfDZRBp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:01:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:57780 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfDZRBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:01:45 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE2B7CEEAE;
        Fri, 26 Apr 2019 19:09:54 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH v3] Bluetooth: Ignore CC events not matching the last HCI
 command
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190426085635.3363-1-jprvita@endlessm.com>
Date:   Fri, 26 Apr 2019 19:01:43 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, bgodavar@codeaurora.org,
        ytkim@qca.qualcomm.com, "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?utf-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <39A065B6-DA45-497F-9EC4-CA1AD42FCDDA@holtmann.org>
References: <CA+A7VXWss=RAXMYb9FfWi=xPCF4Fg+A5tAbYX594HPX2b151fQ@mail.gmail.com>
 <20190426085635.3363-1-jprvita@endlessm.com>
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
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_core.c    |  5 +++++
> net/bluetooth/hci_event.c   | 12 ++++++++++++
> net/bluetooth/hci_request.c |  4 ----
> net/bluetooth/hci_request.h |  4 ++++
> 5 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index fbba43e9bef5..883a8c25ccfb 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -221,6 +221,8 @@ enum {
> 	HCI_RAW,
> 
> 	HCI_RESET,
> +
> +	HCI_CMD_PENDING,
> };

no new flags here please. This is userspace visible use the hdev->dev_flags.

Regards

Marcel

