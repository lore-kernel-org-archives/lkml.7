Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D8C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1BF2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 06:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407833AbfJQGdI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 02:33:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60611 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389397AbfJQGdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 02:33:07 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iKzLN-0002ha-U9
        for linux-kernel@vger.kernel.org; Thu, 17 Oct 2019 06:33:06 +0000
Received: by mail-pf1-f198.google.com with SMTP id q127so921719pfc.17
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 23:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tGYrofeMsi6WLwI3Dz7U750VAtFDzMl2rD6wl365C0A=;
        b=pnkNon+jLF5u54pk7LWkfi31VpVTUu/vOl2iDH4fPGa6b9n4alGEfe/Su1xN7e+Yp5
         5dlKMTQiZ2aWM2DJmgyqp4upS1Y3fJhwquRS2ovb3d0ThD7lgRExwQjmtmLB0Rvvfr/U
         3jh5/QDtDno4wRE00pKWkO8aOj/Z5Aertmhk8NJBfdL7wXO8uN/IZACTTAfNizhK9C21
         q5lvSo+6bmqvxk6gdLFgtb1gjSDkasjEuVL2P+6bUMtNjJbIcAR+XEzAwt0Ag62P7FZa
         lW7uq7N3XN2clXGZXPxd2LaRIHrSDCzPQPSrRzT8DXNoxgRsW3EaX+6zl3SYM16isqLH
         83GA==
X-Gm-Message-State: APjAAAUHbhgWMuRqetuyMYz7jSXhGrATYbF33E/orYwyL98GjkTuE9KE
        Z/VJy8HrPlotsjOzxOM6j6dFrQ8S+jZ39Q1g08CjVvfHnL+hclo3mZTk1VHp7y6j2sgEbfOmCyw
        ultA6dXmYuHkQbD3t5ktyfC7tDBbIvbkOt20K30mhVQ==
X-Received: by 2002:a17:902:bb92:: with SMTP id m18mr2192508pls.297.1571293984461;
        Wed, 16 Oct 2019 23:33:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8pPXJFTb7A7IxyfW6KqXT1cRak4W/djJ0ZN5Y4ypeLdO1IytJeV/F+rOeyHPn748rdoUmXg==
X-Received: by 2002:a17:902:bb92:: with SMTP id m18mr2192479pls.297.1571293983993;
        Wed, 16 Oct 2019 23:33:03 -0700 (PDT)
Received: from 2001-b011-380f-3c42-c02c-3cd8-f108-bd7e.dynamic-ip6.hinet.net (2001-b011-380f-3c42-c02c-3cd8-f108-bd7e.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:c02c:3cd8:f108:bd7e])
        by smtp.gmail.com with ESMTPSA id a8sm1114282pff.5.2019.10.16.23.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 23:33:02 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601\))
Subject: Re: [PATCH v3] usb: Add a new quirk to let buggy hub enable and
 disable LPM during suspend and resume
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1910031503050.1797-100000@iolanthe.rowland.org>
Date:   Thu, 17 Oct 2019 14:33:00 +0800
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A6EC775D-CE42-4F34-9B87-478482EF683A@canonical.com>
References: <Pine.LNX.4.44L0.1910031503050.1797-100000@iolanthe.rowland.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3601)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 4, 2019, at 03:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Fri, 4 Oct 2019, Kai-Heng Feng wrote:
> 
>> Dell WD15 dock has a topology like this:
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
>>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>> 
>> Their IDs:
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp.
>> Bus 004 Device 004: ID 0bda:8153 Realtek Semiconductor Corp.
>> 
>> Ethernet cannot be detected after plugging ethernet cable to the dock,
>> the hub and roothub get runtime resumed and runtime suspended
>> immediately:
>> ...
>> [  433.315169] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_resume: 0
>> [  433.315204] usb usb4: usb auto-resume
>> [  433.315226] hub 4-0:1.0: hub_resume
>> [  433.315239] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10202e2, return 0x10343
>> [  433.315264] usb usb4-port1: status 0343 change 0001
>> [  433.315279] xhci_hcd 0000:3a:00.0: clear port1 connect change, portsc: 0x10002e2
>> [  433.315293] xhci_hcd 0000:3a:00.0: Get port status 4-2 read: 0x2a0, return 0x2a0
>> [  433.317012] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
>> [  433.422282] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10002e2, return 0x343
>> 
>> At this point the SMSC hub (usb 4-1) enters into compliance mode
>> (USB_SS_PORT_LS_COMP_MOD), and USB core tries to warm-reset it,
>> 
>> [  433.422307] usb usb4-port1: do warm reset
>> [  433.422311] usb 4-1: device reset not allowed in state 8
>> [  433.422339] hub 4-0:1.0: state 7 ports 2 chg 0002 evt 0000
>> [  433.422346] xhci_hcd 0000:3a:00.0: Get port status 4-1 read: 0x10002e2, return 0x343
>> [  433.422356] usb usb4-port1: do warm reset
>> [  433.422358] usb 4-1: device reset not allowed in state 8
>> [  433.422428] xhci_hcd 0000:3a:00.0: set port remote wake mask, actual port 0 status  = 0xf0002e2
>> [  433.422455] xhci_hcd 0000:3a:00.0: set port remote wake mask, actual port 1 status  = 0xe0002a0
>> [  433.422465] hub 4-0:1.0: hub_suspend
>> [  433.422475] usb usb4: bus auto-suspend, wakeup 1
>> [  433.426161] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
>> [  433.466209] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.510204] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.554051] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.598235] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.642154] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.686204] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.730205] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.774203] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.818207] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.862040] xhci_hcd 0000:3a:00.0: port 0 polling in bus suspend, waiting
>> [  433.862053] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
>> [  433.862077] xhci_hcd 0000:3a:00.0: xhci_suspend: stopping port polling.
>> [  433.862096] xhci_hcd 0000:3a:00.0: // Setting command ring address to 0x8578fc001
>> [  433.862312] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_suspend: 0
>> [  433.862445] xhci_hcd 0000:3a:00.0: PME# enabled
>> [  433.902376] xhci_hcd 0000:3a:00.0: restoring config space at offset 0xc (was 0x0, writing 0x20)
>> [  433.902395] xhci_hcd 0000:3a:00.0: restoring config space at offset 0x4 (was 0x100000, writing 0x100403)
>> [  433.902490] xhci_hcd 0000:3a:00.0: PME# disabled
>> [  433.902504] xhci_hcd 0000:3a:00.0: enabling bus mastering
>> [  433.902547] xhci_hcd 0000:3a:00.0: // Setting command ring address to 0x8578fc001
>> [  433.902649] pcieport 0000:00:1b.0: PME: Spurious native interrupt!
>> [  433.902839] xhci_hcd 0000:3a:00.0: Port change event, 4-1, id 3, portsc: 0xb0202e2
>> [  433.902842] xhci_hcd 0000:3a:00.0: resume root hub
>> [  433.902845] xhci_hcd 0000:3a:00.0: handle_port_status: starting port polling.
>> [  433.902877] xhci_hcd 0000:3a:00.0: xhci_resume: starting port polling.
>> [  433.902889] xhci_hcd 0000:3a:00.0: xhci_hub_status_data: stopping port polling.
>> [  433.902891] xhci_hcd 0000:3a:00.0: hcd_pci_runtime_resume: 0
>> [  433.902919] usb usb4: usb wakeup-resume
>> [  433.902942] usb usb4: usb auto-resume
>> [  433.902966] hub 4-0:1.0: hub_resume
>> ...
>> 
>> However the warm-reset never success, the asserted PCI PME keeps the
>> runtime-resume, warm-reset and runtime-suspend loop which never bring it back
>> and causing spurious interrupts floods.
>> 
>> After some trial and errors, the issue goes away if LPM on the SMSC hub
>> is disabled. Digging further, enabling and disabling LPM during runtime
>> resume and runtime suspend respectively can solve the issue.
>> 
>> So bring back the old LPM behavior as a quirk and use it for the SMSC
>> hub to solve the issue.
>> 
>> Fixes: d590c2311150 ("usb: Avoid unnecessary LPM enabling and disabling during suspend and resume")
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v3:
>> - Add forgotten patch revision changelog.
>> 
>> v2:
>> - Explained by Alan, the hub should properly handle U3 -> U0 transition.
>>  So use a quirk to target this buggy device only.
>> 
>> Documentation/admin-guide/kernel-parameters.txt |  3 +++
>> drivers/usb/core/hub.c                          | 15 +++++++++++++++
>> drivers/usb/core/quirks.c                       |  6 ++++++
>> include/linux/usb/quirks.h                      |  3 +++
>> 4 files changed, 27 insertions(+)
> 
> Mathias may want to try something different to fix this problem.  But
> if he doesn't, this patch is okay with me.
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>

If there's no objection, can we merge this patch?

Kai-Heng. 

> 
> Alan Stern

