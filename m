Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745DEC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C14C217D7
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN/UrSSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405561AbfHBRhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:37:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729364AbfHBRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:37:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so36390436pfn.5;
        Fri, 02 Aug 2019 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3A3pbOgwFhjFnz3NQu9aTmrqyprDDhamfU4+FFzAI/g=;
        b=kN/UrSSoMHtqbF2jRZsmqb2lM8GzsO8d6QlXWREikrD+5Y6k9OWXkb9nqdBqLkaBcG
         ouI/jjrn6w/4pWK1nro8re5zmfvKQWuxWxCgm2pdY42eFt2U5+ynkFdL9eZfB1ZKwTGW
         o0m7xKyz1uSuIlFCIdWsxfMeddnP/3mWtm4gvc8AdcqGSaoLCZt9ocKIUJJ9vE0p6VzD
         eN37X4JfH9sgLYZEcXgB507R/s81NgcPaR1dse98YZFTpDimDZhO1kGGVYdLkvvegObG
         jvZhsq/pKI/XMNY67IbQUvfhzqvOq8a08wPSicRH8XBzBzIqMOwu8GANTiAmkY4CuI10
         SBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3A3pbOgwFhjFnz3NQu9aTmrqyprDDhamfU4+FFzAI/g=;
        b=PvbIyAHhBlYA7QAaJzVkDMiYri8/4ptgvR4+DJTFYEOAvL4k4Hq3uiNbqnlSv0dMP3
         OewwkpWAcS46u3+SRnJFn/ijMzii6jJdKIcSQtw9qxvRxbWZ2vCJXytRtGP3HRCqLOBs
         gJyOxNPKy8/exfoheDu0r3vT+G3aO9qUZq5DX/9WTmBVgzfmXtNgRNSLnEtNjuZlfh7Z
         36q81+MnU8IPxmjrPgJ1nhUl0J71Ave1znwDJJlqoOKHkKSpgVqC5ykyNjPJ0Tv+spde
         ETtXqJ1A2QtbbVwKcO/DzgrMz95VrKsqaEezQU4Ew6LXOaDCg36TrUYuCDh5N6GM8JwB
         XC0Q==
X-Gm-Message-State: APjAAAUr2S8EuHMaUC1ELORrtlB1IbU+hiI3c3Un/x9HaZPMaXXMCBwd
        7MtOfy7+MQT7q9kuIndj0yk=
X-Google-Smtp-Source: APXvYqzylh5DzajqtUmGKoN3LqhovnJw3q3WgbTpKnDw+tjY5Yg1kQoX8prM4gUCoMN6lydYCj/o6g==
X-Received: by 2002:a17:90a:3544:: with SMTP id q62mr5415998pjb.53.1564767419767;
        Fri, 02 Aug 2019 10:36:59 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.googlemail.com with ESMTPSA id a20sm7992911pjo.0.2019.08.02.10.36.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 10:36:59 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v3 0/2] usbip: Implement SG support
Date:   Sat,  3 Aug 2019 02:36:49 +0900
Message-Id: <20190802173651.22247-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are bugs on vhci with usb 3.0 storage device. Currently, vhci
doesn't supported SG, so USB storage driver on vhci breaks SG list
into multiple URBs and it causes error that a transfer got terminated
too early because the transfer length for one of the URBs was not
divisible by the maxpacket size.
 
In this patch, vhci supports SG regardless of whether the server's
host controller supports SG or not, because stub driver splits SG
list into several URBs if the server's host controller doesn't
support SG.
 
To support SG, vhci_map_urb_for_dma() sets URB_DMA_MAP_SG flag in
urb->transfer_flags if URB has SG list and this flag will tell stub
driver to use SG list.
 
vhci sends each SG list entry to stub driver. Then, stub driver sees
the total length of the buffer and allocates SG table and pages
according to the total buffer length calling sgl_alloc(). After stub
driver receives completed URB, it again sends each SG list entry to
vhci.
 
If the server's host controller doesn't support SG, stub driver
breaks a single SG request into several URBs and submits them to
the server's host controller. When all the split URBs are completed,
stub driver reassembles the URBs into a single return command and
sends it to vhci.

Alan fixed vhci bug with the USB 3.0 storage device by modifying
USB storage driver.
("usb-storage: Set virt_boundary_mask to avoid SG overflows")
But the fundamental solution of it is to add SG support to vhci.

This patch works well with the USB 3.0 storage devices without Alan's
patch, and we can revert Alan's patch if it causes some troubles.

Suwan Kim (2):
  usbip: Skip DMA mapping and unmapping for urb at vhci
  usbip: Implement SG support to vhci-hcd and stub driver

 drivers/usb/usbip/stub.h         |   7 +-
 drivers/usb/usbip/stub_main.c    |  55 ++++++---
 drivers/usb/usbip/stub_rx.c      | 203 ++++++++++++++++++++++---------
 drivers/usb/usbip/stub_tx.c      |  99 +++++++++++----
 drivers/usb/usbip/usbip_common.c |  59 ++++++---
 drivers/usb/usbip/vhci_hcd.c     |  34 +++++-
 drivers/usb/usbip/vhci_tx.c      |  63 ++++++++--
 7 files changed, 394 insertions(+), 126 deletions(-)

-- 
2.20.1

