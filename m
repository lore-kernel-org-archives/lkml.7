Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3562C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA320674
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 06:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTU/uhsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfHZGld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 02:41:33 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37075 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbfHZGld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 02:41:33 -0400
Received: by mail-ua1-f66.google.com with SMTP id f9so5350826uaj.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjtXwc6uWBjbYeNxWQINJLUvFHZALBu2ElRrlxI08CE=;
        b=aTU/uhsSlzt3jbOo33gPmFrycabLXGD/C6tt2tgF++HjYTVydmg4zuqQEsztine73C
         5jYXXM3EkRQJRBAb7NLGRRmd2mf1+PHPWR6Tra2r+JJzR3jZuDOAtNOTJhKHT1XKGt0w
         r+FABLjqHTysV+z7OllVBO0m634fsN9DkUBQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjtXwc6uWBjbYeNxWQINJLUvFHZALBu2ElRrlxI08CE=;
        b=bXuez2M8w7s60/GREACptoEX9kA0XPY0iKXU1ucWyJGo9Ylyi98FSILkgtP2KP4K6l
         S7WwtXw1h5ujN2GOlyX+qm7nOs7I0/rk1B0qOEhNYg9NXdZmTyiXTgIqK/0pX49+NmW2
         nBUt+YHMSypOgj4aMAFYXqoFHnhvLfyYTS3/rp//kIT856SZoAdMq5F7r319xNq3/dYn
         ZANZ6LV2ERbz+VAq6JmAtndAs8imppYOjzmkVKUGmxg9w6K0IaJ45+w1VcSIa0sTHUGq
         woziPW/Wkomb7UN3TjwXBYa1Ha94FT9FCfSIj46Mcq2ZO0Ms5dAKi6Pf4GMeLZylgYiY
         XQfA==
X-Gm-Message-State: APjAAAXikhlMRSrewPhSUM4lBJIRYxUTf6ycl4g/vFGw3p0DmCHDN352
        lPrMq74f3xCI4gC8QQ2IHeE9N4+zSIyPz3bY3UhWmw==
X-Google-Smtp-Source: APXvYqwLbZcqHI2wPAOid4O9hqiaSnC0DXWaGF2mtwqPLBOEk7SRUuKhGaJaSJtIcGUQoOCzxQ1jaBuSXCY87AhqeWI=
X-Received: by 2002:ab0:136d:: with SMTP id h42mr7786917uae.123.1566801691824;
 Sun, 25 Aug 2019 23:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190811082259.48176-1-ikjn@chromium.org> <5883d03d-31c4-206a-26c1-ca641dbf845c@linux.intel.com>
In-Reply-To: <5883d03d-31c4-206a-26c1-ca641dbf845c@linux.intel.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Mon, 26 Aug 2019 14:41:20 +0800
Message-ID: <CAATdQgA4z+hqM=U+1dRLQOq7obH3kq7C+pR8BzmzfvskxNKRng@mail.gmail.com>
Subject: Re: [PATCH] xhci: fix memleak on setup address fails.
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 9:57 PM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 11.8.2019 11.22, Ikjoon Jang wrote:
> > Xhci re-enables a slot on transaction error in set_address using
> > xhci_disable_slot() + xhci_alloc_dev().
> >
> > But in this case, xhci_alloc_dev() creates debugfs entries upon an
> > existing device without cleaning up old entries, thus memory leaks.
> >
> > So this patch simply moves calling xhci_debugfs_free_dev() from
> > xhci_free_dev() to xhci_disable_slot().
> >
>
> Othwerwise this looks good, but xhci_alloc_dev() will call xhci_disable_slot()
> in some failure cases before the slot debugfs entry is created.
>
> In these cases xhci_debugfs_remove_slot() will be called without
> xhci_debugfs_create_slot() ever being called.
>
> This might not be an issue as xhci_debugfs_remove_slot() checks
> if (!dev || !dev->debugfs_private) before doing anything, but should
> be checked out.
>

I checked out the case by adding simple fault injection on xhci_alloc_dev(),
to simulate xhci_debugfs_remove_slot() can be called without
xhci_debugfs_create_slot() being called.

Here is the test codes used in a test:
---
 drivers/usb/host/xhci-debugfs.c | 11 ++++++++++-
 drivers/usb/host/xhci.c         |  4 ++++
 drivers/usb/host/xhci.h         |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 7ba6afc7ef23..4dd3873856e7 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -13,6 +13,8 @@
 #include "xhci.h"
 #include "xhci-debugfs.h"

+static DECLARE_FAULT_ATTR(fail_default_attr);
+
 static const struct debugfs_reg32 xhci_cap_regs[] = {
  dump_register(CAPLENGTH),
  dump_register(HCSPARAMS1),
@@ -500,8 +502,10 @@ void xhci_debugfs_remove_slot(struct xhci_hcd
*xhci, int slot_id)
  struct xhci_slot_priv *priv;
  struct xhci_virt_device *dev = xhci->devs[slot_id];

- if (!dev || !dev->debugfs_private)
+ if (!dev || !dev->debugfs_private) {
+ xhci_warn(xhci, "trying to remove a non-existent debugfs on slot
%d.\n", slot_id);
  return;
+ }

  priv = dev->debugfs_private;

@@ -585,6 +589,11 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
  xhci->debugfs_slots = debugfs_create_dir("devices", xhci->debugfs_root);

  xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
+
+ xhci->fail_alloc_dev = fail_default_attr;
+
+ fault_create_debugfs_attr("fail_alloc_dev", xhci->debugfs_root,
+ &xhci->fail_alloc_dev);
 }

 void xhci_debugfs_exit(struct xhci_hcd *xhci)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 8c5cbd065edd..b01f2a2e7b91 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
+#include <linux/fault-inject.h>

 #include "xhci.h"
 #include "xhci-trace.h"
@@ -3880,6 +3881,9 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct
usb_device *udev)

  xhci_free_command(xhci, command);

+ if (should_fail(&xhci->fail_alloc_dev, 1))
+ goto disable_slot;
+
  if ((xhci->quirks & XHCI_EP_LIMIT_QUIRK)) {
  spin_lock_irqsave(&xhci->lock, flags);
  ret = xhci_reserve_host_control_ep_resources(xhci);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5dad11d223e0..2ab4d2b5e935 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/fault-inject.h>

 /* Code sharing between pci-quirks and xhci hcd */
 #include "xhci-ext-caps.h"
@@ -1895,6 +1896,8 @@ struct xhci_hcd {
  struct dentry *debugfs_slots;
  struct list_head regset_list;

+ struct fault_attr fail_alloc_dev;
+
  void *dbc;
  /* platform-specific data -- must come last */
  unsigned long priv[0] __aligned(sizeof(s64));
-- 

and here is the test result:
[  117.528523] FAULT_INJECTION: forcing a failure.
[  117.528523] name fail_alloc_dev, interval 1, probability 100, space
0, times 1
...
[  117.600764] xxxx.xhci: trying to remove a non-existent debugfs on slot 0.
[  117.608943] usb 1-1.2-port2: couldn't allocate usb_device


> -Mathias
