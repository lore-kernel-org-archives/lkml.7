Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F77C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335542085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="O5SwATPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfCRUji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:39:38 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:29476 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbfCRUji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1552941575;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=agDPtw/n3WgKjUcJkDAc7cIWnYbVRIjr3hxno9Di6O4=;
        b=O5SwATPgeUoj7tWcbd1RhktTHEIMrODySadH3/GK0c8wtT3sijrfwmsenHBl855CNd
        ODUoNvVyZFS+aqH4eA+nfMAfKZqBq8B9P/tPKsVpy/0KdSNR1mXknC7CW7FzOGhhAh33
        4nQ09jrz9gp9GN7snPZDl1hS7CbwEoUiq/6hIz3Mxls58KxmqyLr9rZmUMvRNEjzz/uB
        ydyHF9DKfHzhVn4z0TVhekOp5xQa172+KZd2/aeB38Y3X52g5wY1Nld+IjXvCOjSmuuD
        83JVafyEhWzCWi8ZIs2LJ3hcVC20O5YiIXEP9bDJ5gjGpEUEQrHLyGhlw2Q7ILENKSDd
        ikAQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UNf2M7O2CKNdGj"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.16 DYNA|AUTH)
        with ESMTPSA id h04075v2IKdYFyi
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 18 Mar 2019 21:39:34 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [RFC 0/4] iio-input-bridge so that accelerometers which only have an iio driver can still present evdev input events
Date:   Mon, 18 Mar 2019 21:39:30 +0100
Message-Id: <cover.1552941573.git.hns@goldelico.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some user spaces (e.g. some Android) use /dev/input/event* for handling the 3D
position of the device with respect to the center of gravity (earth). This can
be used for gaming input, rotation of screens etc.

This should be the standard because this interface is an abstraction of how
this data is acquired from sensor chips. Sensor chips may be connected through
different interfaces and in different positions. They may also have different
parameters. And, if a chip is replaced by a different one, the values reported
by the device position interface should remain the same.

But nowadays, new accelerometer chips usually just get iio drivers and rarely
an evdev input driver.

Therefore we need something like a protocol stack: input device vs. raw data.
It can be seen as a similar layering like TCP/IP vs. bare Ethernet. Or keyboard
input events vs. raw gpio or raw USB access.

This patch set bridges the gap between raw iio data and the input device abstraction
so that accelerometer measurements can also be presented as X/Y/Z accelerometer
channels (INPUT_PROP_ACCELEROMETER) through /dev/input/event*.


H. Nikolaus Schaller (4):
  iio: input-bridge: optionally bridge iio acceleometers to create a
    /dev/input
  iio: input-bridge: add iio-input-bridge to Makefile
  iio: input-bridge: add IIO_INPUT_BRIDGE kernel config option
  iio: input-bridge: make the iio-input-bridge driver called by iio-core

 drivers/iio/Kconfig                    |   7 +
 drivers/iio/Makefile                   |   1 +
 drivers/iio/industrialio-core.c        |  12 +
 drivers/iio/industrialio-inputbridge.c | 420 +++++++++++++++++++++++++
 drivers/iio/industrialio-inputbridge.h |  28 ++
 5 files changed, 468 insertions(+)
 create mode 100644 drivers/iio/industrialio-inputbridge.c
 create mode 100644 drivers/iio/industrialio-inputbridge.h

-- 
2.19.1

