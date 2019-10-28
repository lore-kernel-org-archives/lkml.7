Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B668CA9EC1
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 112BE214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 11:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metanate.com header.i=@metanate.com header.b="ZcWYUtkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388691AbfJ1LnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:43:13 -0400
Received: from dougal.metanate.com ([90.155.101.14]:47568 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731145AbfJ1LnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 07:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com;
         s=stronger; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cdv0xQgJ2n1vBJ41Mjz8xUKcn4I+hqoHmHVbH34HW+0=; b=ZcWYUtkd4cKXClSd8/G6UDrnex
        KWGwycrxFAtYcy51bL1YLlMwqZfTAU3QOIabfhG7m4TpXRfYFn9RwETrrqbRPN2B7h4Dndgitf81F
        iHTRM4iSV0F8sht5bD5AnIoogk/pGXmRwDS97DheiqkqIodX2K+IwetSRMqaMuV/9CYPCIWBIWPRT
        +gcAe5uvQfgmdsml6jNwxeAXWOTnihg4aFwIwYXcCIypkD3rnjfA91VcxnvPgbuopv5Fhee1jPVCo
        BBmEYL4EaxJPW06tiOf2bK/qaaxdqrgGQNWl5IGs0Gh4hvO9EoyIQnoTeSCMRlUiamfcb79mfYnDC
        wSQx6tEg==;
Received: from dougal.metanate.com ([192.168.88.1] helo=localhost.localdomain)
        by email.metanate.com with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <john@metanate.com>)
        id 1iP3QH-00010o-5C; Mon, 28 Oct 2019 11:42:57 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, John Keeping <john@metanate.com>
Subject: [PATCH v2 0/6] USB: gadget: f_hid: fix lifetime issues
Date:   Mon, 28 Oct 2019 11:42:22 +0000
Message-Id: <20191028114228.3679219-1-john@metanate.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024164538.3161474-1-john@metanate.com>
References: <20191024164538.3161474-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File descriptors referencing the /dev/hidgN device created by the HID
gadget can outlive the underlying gadget function, which creates easy to
trigger use-after-frees in the kernel.

A simple reproduction for this using the libusbgx example programs is:

	$ gadget-hid
	$ exec 3<> /dev/hidg0
	$ gadget-vid-pid-remove
	$ exec 3<&-

Closing the file descriptor on the last line triggers a use-after-free
which can be seen immediately with slub_debug=P.

This series fixes this by making the struct cdev associated with the
module rather than dynamically allocated for the gadget and changing
struct f_hidg to be refcounted instead of tied to the gadget lifetime.

v2:
- Fix compiling as a module

John Keeping (6):
  USB: gadget: f_hid: move chardev setup to module init
  USB: gadget: f_hid: switch to IDR for tracking minors
  USB: gadget: f_hid: find f_hidg by IDR lookup on open
  USB: gadget: f_hid: decouple cdev from f_hidg lifetime
  USB: gadget: f_hid: refcount f_hidg structure
  USB: gadget: f_hid: return ENODEV from read/write after deletion

 drivers/usb/gadget/function/f_hid.c | 150 +++++++++++++++++++---------
 drivers/usb/gadget/function/u_hid.h |   3 -
 2 files changed, 103 insertions(+), 50 deletions(-)

-- 
2.23.0

