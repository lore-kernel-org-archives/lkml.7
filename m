Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E515DC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14DD2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 04:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfLZEOD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 23:14:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:25113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfLZEOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 23:14:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 20:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,357,1571727600"; 
   d="scan'208";a="230019852"
Received: from pgsmsx108.gar.corp.intel.com ([10.221.44.103])
  by orsmga002.jf.intel.com with ESMTP; 25 Dec 2019 20:13:59 -0800
Received: from pgsmsx102.gar.corp.intel.com ([169.254.6.183]) by
 PGSMSX108.gar.corp.intel.com ([169.254.8.26]) with mapi id 14.03.0439.000;
 Thu, 26 Dec 2019 12:13:58 +0800
From:   "Pan, Harry" <harry.pan@intel.com>
To:     AceLan Kao <acelan.kao@canonical.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mathieu Malaterre <malat@debian.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: hub: move resume delay at the head of all USB
 access functions
Thread-Topic: [PATCH] usb: hub: move resume delay at the head of all USB
 access functions
Thread-Index: AQHVtuF8vF42Fbh98kKiQOV38Geg2KfCpgQAgAP5R4CAAkjxAIAAxuoAgAIoH9Q=
Date:   Thu, 26 Dec 2019 04:13:58 +0000
Message-ID: <6089B7674E6F464F847AB76B599E0EAA78A86A7A@PGSMSX102.gar.corp.intel.com>
References: <CAFv23Qn9h=pwaHkiMB2ci-OaR54gY6fdc1Q_7ZMz5mH7wHr9+w@mail.gmail.com>
 <Pine.LNX.4.44L0.1912241021580.28718-100000@netrider.rowland.org>,<CAFv23Qmc82p3o=1vDvmX5jkfbcOzoQFX7grxrKGwf1KD_vebig@mail.gmail.com>
In-Reply-To: <CAFv23Qmc82p3o=1vDvmX5jkfbcOzoQFX7grxrKGwf1KD_vebig@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.3.86.137]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AceLan,

Would you mind to read this thread and evaluate whether it is helpful or not by kernel downgrade?
https://bugzilla.kernel.org/show_bug.cgi?id=202541

BTW, would you mind to the shared pcap file permission as well? 

-Harry
________________________________________
從: AceLan Kao [acelan.kao@canonical.com]
寄件日期: 2019年12月25日 上午 11:15
至: Alan Stern
副本: Greg Kroah-Hartman; Kai-Heng Feng; Thinh Nguyen; Pan, Harry; David Heinzelmann; Andrey Konovalov; Nicolas Saenz Julienne; Mathieu Malaterre; linux-usb@vger.kernel.org; Linux-Kernel@Vger. Kernel. Org
主旨: Re: [PATCH] usb: hub: move resume delay at the head of all USB access functions

Here[1] are the dmesg and the usbmon log from wireshark, and
/sys/kernel/debug/usb/usbmon/0u.

I verified this issue on Dell XPS 13 + Dell Salomon WD19 docking
station(plug-in 3 USB disk on it)
After s2idle 7 times, 2 usb disks lost. But from wireshark log, the
packets look normal, no error.

So, I re-do the test again and log the usbmon/0u output, but it's greek to me.
Hope you can help to find some clues in the logs.
Thanks.

1. https://people.canonical.com/~acelan/bugs/usb_issue/
