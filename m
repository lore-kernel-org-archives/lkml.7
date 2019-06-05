Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D133C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8D2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYbklv09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfFELbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:31:04 -0400
Received: from mail-it1-f176.google.com ([209.85.166.176]:37360 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFELbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:31:03 -0400
Received: by mail-it1-f176.google.com with SMTP id s16so2911989ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HCA7PztVl5AfDMdu4s3KFunaNHWvX/ENgiqD0TMb5n8=;
        b=iYbklv09umpbphhonAptu/zKGDcB9n52XIf0xleo4gDDGZAdytrI/nzJKcT+HwAk2t
         VOLoYLYkv7JQydQ715TEo5BD7HT7I9cU2ilyCizxpr4/6M5edkWGPMj4IY5ETz/xTOVO
         Fm+y1keShcrTnesoklxxAyCessRjeptwcYMvBfOWXDEOubOEDD0It60++Lnn2OXYEK2b
         IFwv6VsN9sDZzXsE7rAzHLhKI4WtBBDWFn/gZBW3Dx+i9KZYyX/hgYembpAcqWUCwKlb
         LQZ27qeHKb9jz1bxb3fK/1YmIFp2QOJdSkrA11Eurg0p8mKlUeA1kKtfeFq2KuByfPtB
         mCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=HCA7PztVl5AfDMdu4s3KFunaNHWvX/ENgiqD0TMb5n8=;
        b=PxY/v7zdy4NRRmbeADiFiyPE1vQFETpJx7CKhJq+NxG0sVGtOMy9J2oZai2F5Mjavm
         Eu74k/3UPgdFbMLh7L+K7Fz5EQfu3TyG+WZgsF7rZk1P+ng+HRDtxXWiYIKsmqUPinOp
         7e46OiwPEyWbD8Crtk5AhBg4I2FIl+Wyr46tQP7+3/q3CKTwO5tyJN5S9J8pn7xgnHI+
         oWiV+QKmWy+1zo0MHlJGPPJ4ungS63RGxp/tJibBGzGhFXk++BLXRUh2xAZ1jgAlD/se
         olKgAlBK/ezU6JczNRXsoDGHFk+T5SEdWTe94hmuhOoP0EF3c2j4NK+A6S+DZYQAwWZz
         a95Q==
X-Gm-Message-State: APjAAAUvq2UMwgzrxDh/+PpFWZdWKegjXvgwEeHZPwRioHb1q41ugpbj
        ghFpC0NWZ6M+SWNNug6JJFvcs7iuKALMPk7zZ3sW
X-Google-Smtp-Source: APXvYqyv0sBh2liP6sIDEgXmXPtJSdRC4K+OZqEabRCrfuycavg5unXAG/YqfjhwO9IwPDByRWFyN0ubP1V+RHNrMd4=
X-Received: by 2002:a24:8189:: with SMTP id q131mr14965646itd.27.1559734262570;
 Wed, 05 Jun 2019 04:31:02 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Wed, 5 Jun 2019 13:30:51 +0200
Message-ID: <CADDKRnDWhX25QPFNXA-uPcM_tD3Bep2ui=D5A2A8A5cZvrbJtA@mail.gmail.com>
Subject: [5.2.0-rcx] Bluetooth: hci0: unexpected event for opcode
To:     Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 5.2.0-rcx I see a new error message on startup probably after
loading the Bluetooth firmware:
[    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f

> dmesg | grep Bluetooth
[    0.130969] Bluetooth: Core ver 2.22
[    0.130973] Bluetooth: HCI device and connection manager initialized
[    0.130974] Bluetooth: HCI socket layer initialized
[    0.130975] Bluetooth: L2CAP socket layer initialized
[    0.130976] Bluetooth: SCO socket layer initialized
[    0.374716] Bluetooth: RFCOMM TTY layer initialized
[    0.374718] Bluetooth: RFCOMM socket layer initialized
[    0.374718] Bluetooth: RFCOMM ver 1.11
[    0.374719] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    0.374720] Bluetooth: BNEP socket layer initialized
[    0.374721] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.374722] Bluetooth: HIDP socket layer initialized
[    1.422530] Bluetooth: hci0: read Intel version: 370710018002030d00
[    1.422533] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[    1.609460] Bluetooth: hci0: unexpected event for opcode 0xfc2f
[    1.625557] Bluetooth: hci0: Intel firmware patch completed and activate=
d
[   21.986125] input: BluetoothMouse3600 Mouse as
/devices/virtual/misc/uhid/0005:045E:0916.0004/input/input15
[   21.986329] input: BluetoothMouse3600 Consumer Control as
/devices/virtual/misc/uhid/0005:045E:0916.0004/input/input16
[   21.986408] hid-generic 0005:045E:0916.0004: input,hidraw3:
BLUETOOTH HID v1.10 Mouse [BluetoothMouse3600] on 80:19:34:4D:31:44


The error message goes away if I revert following patch:
f80c5dad7b64 Bluetooth: Ignore CC events not matching the last HCI command

Thanks, J=C3=B6rg
