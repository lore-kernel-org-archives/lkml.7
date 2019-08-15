Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA5C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A12084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 06:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfHOGKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 02:10:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:38956 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbfHOGKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 02:10:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 23:10:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,388,1559545200"; 
   d="scan'208";a="260733295"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2019 23:10:20 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jbergsagel@ti.com, nsekhar@ti.com,
        nm@ti.com, sureshp@cadence.com, jpawar@cadence.com,
        kurahul@cadence.com, aniljoy@cadence.com
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <8eb0194a-ee7d-3880-81a7-482ed6e3f759@ti.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com> <1563733939-21214-6-git-send-email-pawell@cadence.com> <8eb0194a-ee7d-3880-81a7-482ed6e3f759@ti.com>
Date:   Thu, 15 Aug 2019 09:10:19 +0300
Message-ID: <87lfvvt0vo.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Roger Quadros <rogerq@ti.com> writes:

> On 21/07/2019 21:32, Pawel Laszczak wrote:
>> This patch introduce new Cadence USBSS DRD driver to Linux kernel.
>> 
>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
>> Host Only (XHCI)configurations.
>> 
>> The current driver has been validated with FPGA platform. We have
>> support for PCIe bus, which is used on FPGA prototyping.
>> 
>> The host side of USBSS-DRD controller is compliant with XHCI
>> specification, so it works with standard XHCI Linux driver.
>> 
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/Kconfig                |    2 +
>>  drivers/usb/Makefile               |    2 +
>>  drivers/usb/cdns3/Kconfig          |   46 +
>>  drivers/usb/cdns3/Makefile         |   17 +
>>  drivers/usb/cdns3/cdns3-pci-wrap.c |  203 +++
>>  drivers/usb/cdns3/core.c           |  554 +++++++
>>  drivers/usb/cdns3/core.h           |  109 ++
>>  drivers/usb/cdns3/debug.h          |  171 ++
>>  drivers/usb/cdns3/debugfs.c        |   87 ++
>>  drivers/usb/cdns3/drd.c            |  390 +++++
>>  drivers/usb/cdns3/drd.h            |  166 ++
>>  drivers/usb/cdns3/ep0.c            |  914 +++++++++++
>>  drivers/usb/cdns3/gadget-export.h  |   28 +
>>  drivers/usb/cdns3/gadget.c         | 2338 ++++++++++++++++++++++++++++
>>  drivers/usb/cdns3/gadget.h         | 1321 ++++++++++++++++
>>  drivers/usb/cdns3/host-export.h    |   28 +
>>  drivers/usb/cdns3/host.c           |   71 +
>>  drivers/usb/cdns3/trace.c          |   11 +
>>  drivers/usb/cdns3/trace.h          |  493 ++++++
>>  19 files changed, 6951 insertions(+)
>>  create mode 100644 drivers/usb/cdns3/Kconfig
>>  create mode 100644 drivers/usb/cdns3/Makefile
>>  create mode 100644 drivers/usb/cdns3/cdns3-pci-wrap.c
>>  create mode 100644 drivers/usb/cdns3/core.c
>>  create mode 100644 drivers/usb/cdns3/core.h
>>  create mode 100644 drivers/usb/cdns3/debug.h
>>  create mode 100644 drivers/usb/cdns3/debugfs.c
>>  create mode 100644 drivers/usb/cdns3/drd.c
>>  create mode 100644 drivers/usb/cdns3/drd.h
>>  create mode 100644 drivers/usb/cdns3/ep0.c
>>  create mode 100644 drivers/usb/cdns3/gadget-export.h
>>  create mode 100644 drivers/usb/cdns3/gadget.c
>>  create mode 100644 drivers/usb/cdns3/gadget.h
>>  create mode 100644 drivers/usb/cdns3/host-export.h
>>  create mode 100644 drivers/usb/cdns3/host.c
>>  create mode 100644 drivers/usb/cdns3/trace.c
>>  create mode 100644 drivers/usb/cdns3/trace.h
>> 
>
> <snip>
>
> It is getting really hard to review this patch as it is so large.
> I would still suggest to split host/gadget/drd if possible.
> Felipe, any objections?

Maybe you guys can do a few rounds off-list then?

-- 
balbi
