Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA669C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14022084C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V61GFUMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfGUKFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:05:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40397 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGUKFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:05:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so24543929lff.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ab4AY1I6LrR/ReXjxUOKYLj6fHVdkvCygqhrXYOUBmc=;
        b=V61GFUMcAlDsWe+YxGeOKEvzQJ/9ZghbnE0JdH0GTKL4a7THhkHHlx1f6Yvd9HS6St
         nHNoD/AupkA2D7ZxjZpb0DnOEJhciFsBJLu9k8pVVqwvXmzjYJSfmZiKqe7vbtyJ0oxq
         yb2WJv0pusQCybZFQAyBHCoPTe6nkZ0dwZerJz2dv+rQPiDZqVWu/I1tcBcEifcx8UHb
         rfX0jp06pZ9Zim8J86wqbpjXLqm/UM/I1xe8AP0/4O0RrCq7hnI7jTK6vv/qXOS9Dgtv
         lqUUBg20dkyRRZFx+kTjo+zRN2NPuaN7SwPc4FSMvjPZkaVAleNGJhUFyLAF86VDyoUc
         wrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ab4AY1I6LrR/ReXjxUOKYLj6fHVdkvCygqhrXYOUBmc=;
        b=JVrwMsnf4Gdleu1Uc4AfaUfhk5aokOOAPH1gmHMwq/pRQmIt2/A0A7ASSiHGLlWYSE
         DLecXXooue9Y22XK34wTJT90giqOCgoU+vWkf/oX+VlwVTp6qzhFOmWdMl0ZsN/HFHhj
         RLIONRH+Vj6xOTVHwGB15Yz8SFzABtE8MHoWgg50qVpLsrzFI3+F3FPyNaFDNBRvYuTh
         3nGtuGTXOSCDnGP6EJHzJWBznoxFwv5PiPkmAbr24ahU7m40LuMLi7jpJ6RsWRCoLNpd
         vMPCBP71bAzzRBm4+oDKaNkUMljegF3nFp2pRfZ9bM3vlePk5RMRQtDFdJj0pfysyyWv
         vD7w==
X-Gm-Message-State: APjAAAUExKPbCBmuBR6xXgHpl2MdTFs99NdYcF9l65sxSxybfQczJYh/
        o6DEyu20saQ4vziSjkVF72+Fk9mkyqSJyixSerY=
X-Google-Smtp-Source: APXvYqzUYIASXRrCGPSPoAoHHB1LCS+G62oBH5et5QRolE/s5ZvU7PPoHY4h6pcR9brFygqQPq1yUHur4PS8/f5Mv0M=
X-Received: by 2002:ac2:5225:: with SMTP id i5mr28667864lfl.157.1563703513579;
 Sun, 21 Jul 2019 03:05:13 -0700 (PDT)
MIME-Version: 1.0
From:   CIJOML CIJOMLovic <cijoml@gmail.com>
Date:   Sun, 21 Jul 2019 12:05:01 +0200
Message-ID: <CAB0z4NruSjTRttnvmwFJD2FnGo__o08XadzEJkS+2Oqc6yGbSQ@mail.gmail.com>
Subject: Kernel 4.19.42 and newer have broke my Bluetooth keyboard/mouse support
To:     marcel@holtmann.org, YangX92@hotmail.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello guys,

I own a very old Logitech diNovo media set with Keyboard, Mouse MX1000
for Bluetooth and Mediapad.
Since 4.19.41 I was able to use it without problem, but kernel 4.19.42
introduced two patches which one of them problably broke my Bluetooth
setup support.
According to the changelog those might be:

commit 38f092c41cebaff589e88cc22686b289a6840559
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Wed Apr 24 22:19:17 2019 +0200

    Bluetooth: Align minimum encryption key size for LE and BR/EDR connections

    commit d5bb334a8e171b262e48f378bd2096c0ea458265 upstream.

    The minimum encryption key size for LE connections is 56 bits and to
    align LE with BR/EDR, enforce 56 bits of minimum encryption key size for
    BR/EDR connections as well.

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
    Cc: stable@vger.kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit c6d1f9b4b2cb768e29f5d44af143f25ad89062b1
Author: Young Xiao <YangX92@hotmail.com>
Date:   Fri Apr 12 15:24:30 2019 +0800

    Bluetooth: hidp: fix buffer overflow

    commit a1616a5ac99ede5d605047a9012481ce7ff18b16 upstream.

    Struct ca is copied from userspace. It is not checked whether the "name"
    field is NULL terminated, which allows local users to obtain potentially
    sensitive information from kernel stack memory, via a HIDPCONNADD command.

    This vulnerability is similar to CVE-2011-1079.

    Signed-off-by: Young Xiao <YangX92@hotmail.com>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
    Cc: stable@vger.kernel.org
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

My current working setup with 4.19.41 is as follows:

root@thinkpad:/home/cijoml# hcitool con
Connections:
    > ACL 00:07:61:49:2A:6A handle 69 state 1 lm MASTER AUTH ENCRYPT
    > ACL 00:07:61:3E:1C:71 handle 71 state 1 lm MASTER AUTH ENCRYPT
    > ACL 00:07:61:49:E0:3D handle 68 state 1 lm MASTER

root@thinkpad:/home/cijoml# hcitool info 00:07:61:3E:1C:71
Requesting information ...
    BD Address:  00:07:61:3E:1C:71
    OUI Company: Logitech Europe SA (00-07-61)
    Device Name: Logitech diNovo Keyboard
    LMP Version: 1.2 (0x2) LMP Subversion: 0x545
    Manufacturer: Cambridge Silicon Radio (10)
    Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
        <encryption> <slot offset> <timing accuracy> <role switch>
        <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
        <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
        <CVSD> <paging scheme> <power control> <transparent SCO>
        <AFH cap. slave> <AFH cap. master>
root@thinkpad:/home/cijoml# hcitool info 00:07:61:49:E0:3D
Requesting information ...
    BD Address:  00:07:61:49:E0:3D
    OUI Company: Logitech Europe SA (00-07-61)
    Device Name: Logitech MX1000 mouse
    LMP Version: 1.2 (0x2) LMP Subversion: 0x545
    Manufacturer: Cambridge Silicon Radio (10)
    Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
        <encryption> <slot offset> <timing accuracy> <role switch>
        <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
        <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
        <CVSD> <paging scheme> <power control> <transparent SCO>
        <AFH cap. slave> <AFH cap. master>
root@thinkpad:/home/cijoml# hcitool info 00:07:61:49:2A:6A
Requesting information ...
    BD Address:  00:07:61:49:2A:6A
    OUI Company: Logitech Europe SA (00-07-61)
    Device Name: Logitech Mediapad
    LMP Version: 1.2 (0x2) LMP Subversion: 0x545
    Manufacturer: Cambridge Silicon Radio (10)
    Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
        <encryption> <slot offset> <timing accuracy> <role switch>
        <hold mode> <sniff mode> <park state> <RSSI> <channel quality>
        <SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
        <CVSD> <paging scheme> <power control> <transparent SCO>
        <AFH cap. slave> <AFH cap. master>


Can anybody please look at this and fix the support for my Bluetooth
set so I do not need to throw it into dustbin?

Thank you in advance

Michal
