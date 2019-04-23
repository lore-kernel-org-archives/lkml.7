Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2877D2077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFaacJws"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfDWHXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:23:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32911 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWHXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:23:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id h5so7015475pfo.0;
        Tue, 23 Apr 2019 00:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xa1xSFB3woawtkgAJlIMcQ2+F4nty/W9uui7RIpeaU=;
        b=EFaacJwsUk+vTVfhJB7Q885rzGo/I3oqbznSZEDuRxAfKvo/IQ75lK4fj6hnEBAkOp
         IPH1JD+HpJFvby3TxLbhZT0DriGU33IpVAaV9wfA+i+DRimjyzPu5tbUzhd543iWGzQ+
         JZI3c+17H/erXdOi+cu0Vo7Zsmv9rOOFkAayU38a7+9wz/cyHYZ6yS3bh4AP2g0Mx+iX
         JxlYwzQYH591RwCgOfnrQseiHmkYmUBhki4Cn4aUvAH9OhOBN/Wel1w5ZeNwk/pnQrwR
         FVUgmVgMZwSYGzgV0P7GT5fiqtMyKZSq8LD4WPrwVkJhRdrz7DOQOM/AIoHF7dByiBJC
         6u7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xa1xSFB3woawtkgAJlIMcQ2+F4nty/W9uui7RIpeaU=;
        b=HZ6zsgk8yW/eB57klpCzLj+RfvhykXSXag7Hb6oCrxF3gwpLNVglQVqVVH1klJU0hC
         Ou5uP9jb+/jTfKu65A/oZ2bgcOn/RGKa3OJBeZfEo2ymE9bK9/7jYxwSDL12tgt48gc7
         KmvTIadi8LBwddJpFwKOj+VrQx7xABszK2SmjU5ubrn6oKKpw0n0BvGC6/Xp9x840sxz
         Bui/SLTYfXvhx+8a7bfzAhxAGRpvO4WpeAhjEeFD8kCqQl99nrcxvfGv4iii+38nj5P/
         WBMs9O+88jjQ4JtjSGxyTjyyEAAALOhuxHQZDTQn8fSEiPIWxN6qe6ND1TpAHIqwItTX
         MWdw==
X-Gm-Message-State: APjAAAUhB+B+dFkblUzIZeO4iYPGLsT8/ujeRf76oBGu/3YdPP3SIMpy
        AdpYZhrVD0Ec3NbdolSQlEo=
X-Google-Smtp-Source: APXvYqybzLnEa5MjKxK0gPyTtQNZd/ryYQVqjH+s1Q9TxU4c7EdfvW1Xbg35crtrCoU5JccmELHC/Q==
X-Received: by 2002:aa7:9465:: with SMTP id t5mr25309442pfq.247.1556004178993;
        Tue, 23 Apr 2019 00:22:58 -0700 (PDT)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id p20sm12560594pgj.86.2019.04.23.00.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 00:22:58 -0700 (PDT)
From:   "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
X-Google-Original-From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     bgodavar@codeaurora.org, ytkim@qca.qualcomm.com,
        "David S . Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
Subject: [PATCH 0/2] Quirk to enable QCA9377 to discover BLE devices
Date:   Tue, 23 Apr 2019 15:22:34 +0800
Message-Id: <20190423072236.24999-1-jprvita@endlessm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported previously on [1], it is currently not possible to discover
BLE devices with QCA9377 controllers. When trying to start an active
scanning procedure with this controller, three commands are queued,
LE_SET_RANDOM_ADDR, LE_SET_SCAN_PARAM and LE_SET_SCAN_ENABLE. After the
first command is sent to the controller, a command complete event for it
is received, and the second command is sent, an extra command complete
for the first command is received. At this point the kernel sends the
next command and fails to process the command complete event for the
LE_SET_SCAN_PARAM command, because when it arrives it does not match the
last command that was sent. This makes hdev->le_scan_type never be
updated and the kernel behaves as if a passive scanning procedure was
being performed, thus no device found events are sent to userspace.

[1] https://www.spinics.net/lists/linux-bluetooth/msg79102.html

I have received no replies on the previous report and on further
attempts to contact the QCA addresses that have submitted Bluetooth
firmware blobs to linux-firmware upstream. This series avoids the
problem described above, but I believe ideally the controller should not
be sending this extra command complete event.

I'm not 100% sure if the approach taken here is the best way to work
around this problem in the kernel, as I am not super familiar with the
HCI layer. I'll be happy to hear suggestions of better approaches.

Full logs from btmon can be found bellow this message, and the extra
command complete event can be seen at timestamp 27.420131.

Best regards,

João Paulo Rechi Vita (2):
  Bluetooth: Create new HCI_QUIRK_WAIT_FOR_MATCHING_CC
  Bluetooth: Set HCI_QUIRK_WAIT_FOR_MATCHING_CC for QCA9377

 drivers/bluetooth/btusb.c        | 9 +++++++++
 include/net/bluetooth/hci.h      | 4 ++++
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_core.c         | 3 +++
 net/bluetooth/hci_event.c        | 4 ++++
 5 files changed, 21 insertions(+)

-- 
2.20.1

Bluetooth monitor ver 5.50
= Note: Linux version 5.0.0+ (x86_64)                                  0.352340
= Note: Bluetooth subsystem version 2.22                               0.352343
= New Index: 80:C5:F2:8F:87:84 (Primary,USB,hci0)               [hci0] 0.352344
= Open Index: 80:C5:F2:8F:87:84                                 [hci0] 0.352345
= Index Info: 80:C5:F2:8F:87:84 (Qualcomm)                      [hci0] 0.352346
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.352347
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.352366
@ MGMT Open: btmgmt (privileged) version 1.14                {0x0003} 27.302164
@ MGMT Command: Start Discovery (0x0023) plen 1       {0x0003} [hci0] 27.302310
        Address type: 0x06
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6   #1 [hci0] 27.302496
        Address: 15:60:F2:91:B2:24 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                 #2 [hci0] 27.419117
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7  #3 [hci0] 27.419244
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #4 [hci0] 27.420131
      LE Set Random Address (0x08|0x0005) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2      #5 [hci0] 27.420259
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                 #6 [hci0] 27.420969
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
> HCI Event: Command Complete (0x0e) plen 4                 #7 [hci0] 27.421983
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4        {0x0003} [hci0] 27.422059
      Start Discovery (0x0023) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2             {0x0003} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0002} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 27.422067
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
> HCI Event: LE Meta Event (0x3e) plen 39                   #8 [hci0] 27.434978
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: E8:95:19:72:73:CC (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -27 dBm (0xe5)
> HCI Event: LE Meta Event (0x3e) plen 12                   #9 [hci0] 27.435993
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: E8:95:19:72:73:CC (Static)
        Data length: 0
        RSSI: -27 dBm (0xe5)
> HCI Event: LE Meta Event (0x3e) plen 34                  #10 [hci0] 27.456126
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:42 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS 424362
        RSSI: -78 dBm (0xb2)
> HCI Event: LE Meta Event (0x3e) plen 15                  #11 [hci0] 27.458091
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:42 (HTC Corporation)
        Data length: 3
        TX power: 4 dBm
        RSSI: -79 dBm (0xb1)
> HCI Event: LE Meta Event (0x3e) plen 36                  #12 [hci0] 27.466127
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 88:C6:26:BC:47:E0 (Logitech, Inc)
        Data length: 24
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        Name (short): 
        128-bit Service UUIDs (complete): 1 entry
          Vendor specific (72daa6c3-29c2-6283-0c4a-2818e4d37e75)
        RSSI: -89 dBm (0xa7)
> HCI Event: LE Meta Event (0x3e) plen 43                  #13 [hci0] 27.483060
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 3E:AA:03:39:AF:93 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 0109200205f7919173c0503f361cb0bc3065cee7253049c23c8662
        RSSI: -86 dBm (0xaa)
> HCI Event: LE Meta Event (0x3e) plen 43                  #14 [hci0] 27.496132
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -75 dBm (0xb5)
> HCI Event: LE Meta Event (0x3e) plen 43                  #15 [hci0] 27.500136
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 25:56:82:C6:5F:D4 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092000318c08c684a9670c9e48b8594178670965955236d78ca8
        RSSI: -78 dBm (0xb2)
> HCI Event: LE Meta Event (0x3e) plen 43                  #16 [hci0] 27.521133
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 17:AD:7B:9D:81:0A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002bfe890ca48146f86fba1398c5baf6bd86df2f6b6b4cab3
        RSSI: -80 dBm (0xb0)
> HCI Event: LE Meta Event (0x3e) plen 34                  #17 [hci0] 27.524125
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -72 dBm (0xb8)
> HCI Event: LE Meta Event (0x3e) plen 15                  #18 [hci0] 27.526031
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 3
        TX power: 4 dBm
        RSSI: -72 dBm (0xb8)
> HCI Event: LE Meta Event (0x3e) plen 26                  #19 [hci0] 27.555065
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 4C:31:90:6F:B8:ED (Resolvable)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0714add576
        RSSI: -94 dBm (0xa2)
> HCI Event: LE Meta Event (0x3e) plen 40                  #20 [hci0] 27.578973
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 7A:AE:04:2B:99:83 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -52 dBm (0xcc)
> HCI Event: LE Meta Event (0x3e) plen 22                  #21 [hci0] 27.581128
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 7A:AE:04:2B:99:83 (Resolvable)
        Data length: 10
        Company: Google (224)
          Data: 0190ca3e7e6b
        RSSI: -52 dBm (0xcc)
> HCI Event: LE Meta Event (0x3e) plen 26                  #22 [hci0] 27.590133
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 50:32:37:8C:8E:8E (Apple, Inc.)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0114399c7d
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 43                  #23 [hci0] 27.604987
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 43                  #24 [hci0] 27.610981
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 17:AD:7B:9D:81:0A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002bfe890ca48146f86fba1398c5baf6bd86df2f6b6b4cab3
        RSSI: -82 dBm (0xae)
> HCI Event: LE Meta Event (0x3e) plen 39                  #25 [hci0] 27.646058
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: E8:95:19:72:73:CC (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -29 dBm (0xe3)
> HCI Event: LE Meta Event (0x3e) plen 27                  #26 [hci0] 27.647986
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 02:95:02:1D:EC:CA (Non-Resolvable)
        Data length: 15
        Flags: 0x1b
          LE Limited Discoverable Mode
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 03090a000098
        RSSI: -82 dBm (0xae)
> HCI Event: LE Meta Event (0x3e) plen 40                  #27 [hci0] 27.658984
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -76 dBm (0xb4)
> HCI Event: LE Meta Event (0x3e) plen 34                  #28 [hci0] 27.669971
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:42 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS 424362
        RSSI: -77 dBm (0xb3)
> HCI Event: LE Meta Event (0x3e) plen 27                  #29 [hci0] 27.685062
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B0:34:95:32:11:FA (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 035e0a0000d2
        RSSI: -89 dBm (0xa7)
> HCI Event: LE Meta Event (0x3e) plen 39                  #30 [hci0] 27.697970
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: E8:95:19:72:73:CC (Static)
        Data length: 27
        Name (complete): Designer Mouse
        Appearance: Mouse (0x03c2)
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Human Interface Device (0x1812)
        RSSI: -30 dBm (0xe2)
> HCI Event: LE Meta Event (0x3e) plen 43                  #31 [hci0] 27.706061
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -80 dBm (0xb0)
> HCI Event: LE Meta Event (0x3e) plen 34                  #32 [hci0] 27.768055
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:42 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS 424362
        RSSI: -74 dBm (0xb6)
> HCI Event: LE Meta Event (0x3e) plen 26                  #33 [hci0] 27.785060
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 50:32:37:8C:8E:8E (Apple, Inc.)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0114399c7d
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 40                  #34 [hci0] 27.792059
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -66 dBm (0xbe)
> HCI Event: LE Meta Event (0x3e) plen 22                  #35 [hci0] 27.794058
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 10
        Company: Google (224)
          Data: 01daca61698f
        RSSI: -66 dBm (0xbe)
> HCI Event: LE Meta Event (0x3e) plen 43                  #36 [hci0] 27.814973
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 33:FB:A2:A0:68:4A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002928d2b061d019431be7639a37405f42054032d52d23bb8
        RSSI: -70 dBm (0xba)
> HCI Event: LE Meta Event (0x3e) plen 34                  #37 [hci0] 27.830967
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -71 dBm (0xb9)
> HCI Event: LE Meta Event (0x3e) plen 40                  #38 [hci0] 27.847059
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 7A:AE:04:2B:99:83 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -57 dBm (0xc7)
> HCI Event: LE Meta Event (0x3e) plen 43                  #39 [hci0] 27.858061
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 0B:AC:03:90:E2:52 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028eaae368523854409d2335d8ae88bf82c1b6bc102ed5e7
        RSSI: -83 dBm (0xad)
> HCI Event: LE Meta Event (0x3e) plen 27                  #40 [hci0] 27.860041
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B0:34:95:32:11:FA (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 035e0a0000d2
        RSSI: -84 dBm (0xac)
> HCI Event: LE Meta Event (0x3e) plen 26                  #41 [hci0] 27.907985
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 69:A1:40:C3:13:0A (Resolvable)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0a1ca19d89
        RSSI: -90 dBm (0xa6)
> HCI Event: LE Meta Event (0x3e) plen 40                  #42 [hci0] 27.916124
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 43                  #43 [hci0] 27.919129
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 25:56:82:C6:5F:D4 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092000318c08c684a9670c9e48b8594178670965955236d78ca8
        RSSI: -73 dBm (0xb7)
> HCI Event: LE Meta Event (0x3e) plen 34                  #44 [hci0] 27.928123
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -71 dBm (0xb9)
> HCI Event: LE Meta Event (0x3e) plen 34                  #45 [hci0] 27.987233
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:42 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS 424362
        RSSI: -69 dBm (0xbb)
> HCI Event: LE Meta Event (0x3e) plen 43                  #46 [hci0] 27.995132
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 3E:AA:03:39:AF:93 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 0109200205f7919173c0503f361cb0bc3065cee7253049c23c8662
        RSSI: -85 dBm (0xab)
> HCI Event: LE Meta Event (0x3e) plen 43                  #47 [hci0] 28.027133
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 27                  #48 [hci0] 28.056066
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B0:34:95:32:11:FA (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 035e0a0000d2
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 40                  #49 [hci0] 28.122131
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 7A:AE:04:2B:99:83 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -56 dBm (0xc8)
> HCI Event: LE Meta Event (0x3e) plen 43                  #50 [hci0] 28.131132
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 33:FB:A2:A0:68:4A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002928d2b061d019431be7639a37405f42054032d52d23bb8
        RSSI: -86 dBm (0xaa)
> HCI Event: LE Meta Event (0x3e) plen 40                  #51 [hci0] 28.303237
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -67 dBm (0xbd)
> HCI Event: LE Meta Event (0x3e) plen 27                  #52 [hci0] 28.701239
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:34:6D:48:3C:41 (Non-Resolvable)
        Data length: 15
        Flags: 0x1b
          LE Limited Discoverable Mode
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 030cc0a80036
        RSSI: -89 dBm (0xa7)
> HCI Event: LE Meta Event (0x3e) plen 34                  #53 [hci0] 28.741233
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -71 dBm (0xb9)
> HCI Event: LE Meta Event (0x3e) plen 43                  #54 [hci0] 28.766131
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -77 dBm (0xb3)
> HCI Event: LE Meta Event (0x3e) plen 40                  #55 [hci0] 28.829237
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -66 dBm (0xbe)
> HCI Event: LE Meta Event (0x3e) plen 43                  #56 [hci0] 28.946115
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 33:FB:A2:A0:68:4A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002928d2b061d019431be7639a37405f42054032d52d23bb8
        RSSI: -88 dBm (0xa8)
> HCI Event: LE Meta Event (0x3e) plen 40                  #57 [hci0] 28.949131
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 22                  #58 [hci0] 28.951128
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 10
        Company: Google (224)
          Data: 1dd9ca8e7047
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 27                  #59 [hci0] 28.973131
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B0:34:95:32:11:FA (Apple, Inc.)
        Data length: 15
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Apple TV (9)
          Data: 035e0a0000d2
        RSSI: -84 dBm (0xac)
> HCI Event: LE Meta Event (0x3e) plen 43                  #60 [hci0] 30.553238
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 3D:93:75:B8:6E:09 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028e4b82ba058f2f37e060a1fa85e8a99c750384ec897b20
        RSSI: -91 dBm (0xa5)
> HCI Event: LE Meta Event (0x3e) plen 34                  #61 [hci0] 30.571128
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -70 dBm (0xba)
> HCI Event: LE Meta Event (0x3e) plen 40                  #62 [hci0] 30.768238
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -77 dBm (0xb3)
> HCI Event: LE Meta Event (0x3e) plen 43                  #63 [hci0] 30.965238
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 33:FB:A2:A0:68:4A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002928d2b061d019431be7639a37405f42054032d52d23bb8
        RSSI: -74 dBm (0xb6)
> HCI Event: LE Meta Event (0x3e) plen 40                  #64 [hci0] 31.159237
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -65 dBm (0xbf)
> HCI Event: LE Meta Event (0x3e) plen 12                  #65 [hci0] 31.250241
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Public (0x00)
        Address: 50:32:37:8C:8E:8E (Apple, Inc.)
        Data length: 0
        RSSI: -82 dBm (0xae)
> HCI Event: LE Meta Event (0x3e) plen 23                  #66 [hci0] 31.766241
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 4F:E2:1C:81:96:4D (Resolvable)
        Data length: 11
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0304
        RSSI: -94 dBm (0xa2)
> HCI Event: LE Meta Event (0x3e) plen 34                  #67 [hci0] 31.789124
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -70 dBm (0xba)
> HCI Event: LE Meta Event (0x3e) plen 40                  #68 [hci0] 31.803130
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 43                  #69 [hci0] 31.917135
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 2C:44:85:C3:1F:22 (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 010920028a9a16c0a22049fd76e5149c66d5703368ed3663413e54
        RSSI: -61 dBm (0xc3)
> HCI Event: LE Meta Event (0x3e) plen 26                  #70 [hci0] 31.978239
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: 69:A1:40:C3:13:0A (Resolvable)
        Data length: 14
        Flags: 0x1a
          LE General Discoverable Mode
          Simultaneous LE and BR/EDR (Controller)
          Simultaneous LE and BR/EDR (Host)
        Company: Apple, Inc. (76)
          Type: Unknown (16)
          Data: 0a1ca19d89
        RSSI: -81 dBm (0xaf)
> HCI Event: LE Meta Event (0x3e) plen 43                  #71 [hci0] 32.169240
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Non connectable undirected - ADV_NONCONN_IND (0x03)
        Address type: Random (0x01)
        Address: 33:FB:A2:A0:68:4A (Non-Resolvable)
        Data length: 31
        Company: Microsoft (6)
          Data: 01092002928d2b061d019431be7639a37405f42054032d52d23bb8
        RSSI: -75 dBm (0xb5)
> HCI Event: LE Meta Event (0x3e) plen 40                  #72 [hci0] 32.214242
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 4A:97:99:08:9E:89 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -66 dBm (0xbe)
> HCI Event: LE Meta Event (0x3e) plen 26                  #73 [hci0] 34.032239
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Random (0x01)
        Address: C2:A8:AB:46:C0:93 (Static)
        Data length: 14
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Nest Labs Inc. (0xfeaf)
        Name (complete): N0BM6
        RSSI: -86 dBm (0xaa)
> HCI Event: LE Meta Event (0x3e) plen 33                  #74 [hci0] 34.035125
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: C2:A8:AB:46:C0:93 (Static)
        Data length: 21
        Service Data (UUID 0xfeaf): 100100025a230900de1bb2000030b41800
        RSSI: -85 dBm (0xab)
> HCI Event: LE Meta Event (0x3e) plen 34                  #75 [hci0] 34.125232
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: 80:7A:BF:E1:B7:B2 (HTC Corporation)
        Data length: 22
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (complete): 1 entry
          Unknown (0xcb00)
        Name (complete): HTC BS B23CE4
        RSSI: -70 dBm (0xba)
> HCI Event: LE Meta Event (0x3e) plen 40                  #76 [hci0] 34.132131
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scannable undirected - ADV_SCAN_IND (0x02)
        Address type: Random (0x01)
        Address: 5B:16:F0:4E:F8:38 (Resolvable)
        Data length: 28
        16-bit Service UUIDs (complete): 1 entry
          Google (0xfe9f)
        Service Data (UUID 0xfe9f): 0000000000000000000000000000000000000000
        RSSI: -78 dBm (0xb2)
> HCI Event: LE Meta Event (0x3e) plen 12                  #77 [hci0] 36.036242
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Scan response - SCAN_RSP (0x04)
        Address type: Random (0x01)
        Address: 69:A1:40:C3:13:0A (Resolvable)
        Data length: 0
        RSSI: -81 dBm (0xaf)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2     #78 [hci0] 37.737722
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                #79 [hci0] 37.739124
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0003} [hci0] 37.739273
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0002} [hci0] 37.739273
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Event: Discovering (0x0013) plen 2             {0x0001} [hci0] 37.739273
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
@ MGMT Close: btmgmt                                         {0x0003} 37.739481
