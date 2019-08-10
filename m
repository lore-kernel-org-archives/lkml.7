Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CEC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70988217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="TYC+KmTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfHJImv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:42:51 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:19943 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfHJImu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:50 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvM3cyDz6q;
        Sat, 10 Aug 2019 10:41:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426479; bh=PVk1v4GgHvJZbQuvUfM4PS4zUT/EbZlO47ifuNqQpsQ=;
        h=Date:From:Subject:To:Cc:From;
        b=TYC+KmTLTA9uxs1C96BElSKXuP1M4QW/GHMHAqkFZe9Bpm+Y9QIOtW1gsHspIb2jd
         tU9GVxKa1uQYZeNjWm/pfOumhjsMrBF0QKUGqyU9z4dPfzsUu/uN2LG/6xr7ZJmZk7
         C1G7BEhcPau/NYfeD3Fx8SBdAhoTD/at/zA1udpKkvn46hMRXTqE1ZQv4ww5O+adGc
         2iNuuybDAq8+9oaE+vevt+BQycmNtTXAHXnjBqDi4R0Ze7WUDQb000KSAmthYon7Ju
         AoVjhUIoyO1mxtnlSjSplxrZN/REVGzEuSCyjM4nW2EUahpCye7C9Xowa7T0xSYFmx
         YXSs5XMY05yLA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:47 +0200
Message-Id: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 0/7] usb: gadget: u_serial: console improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series makes it possible to have more control over console using
USB serial gadget ports. This can be useful when you need more than
one USB console or are configuring multiple serial port function via
configfs.

The patches are against balbi/testing/next tree. You can also pull from:
   https://rere.qmqm.pl/git/linux  usb-console

Michał Mirosław (7):
  usb: gadget: u_serial: add missing port entry locking
  usb: gadget: u_serial: reimplement console support
  usb: gadget: u_serial: make OBEX port not a console
  usb: gadget: u_serial: allow more console gadget ports
  usb: gadget: u_serial: diagnose missed console messages
  usb: gadget: legacy/serial: allow dynamic removal
  usb: gadget: u_serial: use mutex for serialising open()s

 drivers/usb/gadget/function/f_acm.c    |  21 +
 drivers/usb/gadget/function/f_obex.c   |   2 +-
 drivers/usb/gadget/function/f_serial.c |  21 +
 drivers/usb/gadget/function/u_serial.c | 532 +++++++++++++------------
 drivers/usb/gadget/function/u_serial.h |   8 +
 drivers/usb/gadget/legacy/serial.c     |  49 ++-
 6 files changed, 370 insertions(+), 263 deletions(-)

-- 
2.20.1

