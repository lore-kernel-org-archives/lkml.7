Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BF2C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3952070B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 21:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ProG7Mrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfFTVKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:10:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39697 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFTVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 17:10:06 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so2354960pfe.6;
        Thu, 20 Jun 2019 14:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VDRRP2jmEvUN5ZqWT57WiSSliOdLym165LbfBV0ufl8=;
        b=ProG7MrqukcAFzBntWXUMlWrfhIllH3qkkZwM1jAHnq+KCuZlLyVDOcs2+IebU1DNM
         iE/jjhcfQH02JAU7QQx3ybWFBmWDoSyYgmsBbMUdNaxvr4qlRD4vk1MxcL04vg4GeYyq
         OW/nPOzDBtSrxll3A5JuFEDpkcBAyD9c/J0WbuGE5hryXgp48fvd0QK6v+/U16z3NAmg
         mhkIEV2ZIEFZ7sxlmO+YxuXRdID31STMycyajgpfy12BosBZ6lq72xlA678QnhUN54hI
         X+gBK5FaaVzxuQHPdQGTyYZ6PnaxeHMXMcAroCHxS6v4I3cYaRQftffmAGVp4m4RAwW7
         EEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VDRRP2jmEvUN5ZqWT57WiSSliOdLym165LbfBV0ufl8=;
        b=N/zpLgm9AjBqxjUpKAuAqYOP1t+nU8GuxMIAu2K2B4hjeNysMDQZtqY5+Z0foYnArC
         nW8GlLrkmJolOkHboeTuA5MtU7m8wW2J7Tb5XhzbLicrY7RV4NWDr0IQR0HKdylwi0Kn
         rVJhGySDmUfvT305MlqfdZTgg51MwxL08Qbhvua/bzseuPFisX3N1PBJKS5eSaSusYEx
         JR7KlvALt/Sa5zNv/xoeBAkIX8Akd+VXLRnPuRKIhWX9wUVExFZbz51lpZPne/WzNU2S
         EDZGf70cCDRjCki1NwiEjKu1VCwiu7sQX35rkNdKi8cs9vXnGHduzyzEArOL919Kyt6b
         dbLg==
X-Gm-Message-State: APjAAAXnP6gabqnOPOfJOqIFlUoJ/1vv4l6lSBng34SsofSWxPJ/WfvE
        lojz20TBeVESQazV8XW14fkX6STRWZE=
X-Google-Smtp-Source: APXvYqyQ5odUgn5ZZgvSZn9v3pmiiWD4iDlEZqt2f/eaEqEQLVMgRgHH0ifDvVE5bSvqc8cODvCaSw==
X-Received: by 2002:a63:db05:: with SMTP id e5mr14533284pgg.121.1561065005170;
        Thu, 20 Jun 2019 14:10:05 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p1sm386805pff.74.2019.06.20.14.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:10:04 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/6] usb: bdc: Updates and fixes to USB BDC driver
Date:   Thu, 20 Jun 2019 17:09:45 -0400
Message-Id: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of updates and fixes to the Broadcom USB BDC driver

Al Cooper (6):
  usb: bdc: driver runs out of buffer descriptors on large ADB transfers
  usb: bdc: Cleanup clock support
  usb: bdc: driver may fail to get USB PHY
  usb: bdc: Fix bug causing crash after multiple disconnects
  dt-bindings: usb: bdc: Update compatible strings
  usb: bdc: Update compatible match strings

 Documentation/devicetree/bindings/usb/brcm,bdc.txt |  4 ++--
 drivers/usb/gadget/udc/bdc/bdc.h                   |  2 +-
 drivers/usb/gadget/udc/bdc/bdc_core.c              | 26 ++++++++++++++++------
 drivers/usb/gadget/udc/bdc/bdc_ep.c                | 16 ++++++++-----
 4 files changed, 32 insertions(+), 16 deletions(-)

-- 
1.9.0.138.g2de3478

