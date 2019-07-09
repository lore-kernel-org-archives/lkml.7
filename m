Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3262AC606D8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B34216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGIHWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:22:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:26090 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfGIHWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:22:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 00:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="188746591"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2019 00:22:41 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "hdegoede\@redhat.com" <hdegoede@redhat.com>,
        "heikki.krogerus\@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "robh+dt\@kernel.org" <robh+dt@kernel.org>,
        "rogerq\@ti.com" <rogerq@ti.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen\@nxp.com" <peter.chen@nxp.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v9 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
In-Reply-To: <BYAPR07MB47092C1E19FD36FB336A55C2DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <87r274lmqk.fsf@linux.intel.com> <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7dpm442.fsf@linux.intel.com> <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com> <87pnmj67ee.fsf@linux.intel.com> <BYAPR07MB47092C1E19FD36FB336A55C2DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Tue, 09 Jul 2019 10:22:40 +0300
Message-ID: <87muhn65a7.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>>>> IRQF_ONESHOT can be used  only in threaded handled.
>>>>> "
>>>>>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>>>  *                Used by threaded interrupts which need to keep the
>>>>>  *                irq line disabled until the threaded handler has been run.
>>>>> "
>>>>
>>>>so?
>>>
>>> I don't understand why If I don't have threaded handler why I need IRQF_ONESHOT.
>>> Why interrupt cannot be reenabled after hardirq handler finished ?
>>> I do not use threaded handler so this flag seem unnecessary.
>>
>>Unless this has changed over the years, it was a requirement from IRQ susbystem.
>>
>>	/*
>>	 * Drivers are often written to work w/o knowledge about the
>>	 * underlying irq chip implementation, so a request for a
>>	 * threaded irq without a primary hard irq context handler
>>	 * requires the ONESHOT flag to be set. Some irq chips like
>>	 * MSI based interrupts are per se one shot safe. Check the
>>	 * chip flags, so we can avoid the unmask dance at the end of
>>	 * the threaded handler for those.
>>	 */
>>	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
>>		new->flags &= ~IRQF_ONESHOT;
>
> From description I understand that it should be set when driver uses only 
> threaded handler without hard irq handler.
> eg. 
>
> 	ret = devm_request_threaded_irq(dev, data->usb_id_irq,
> 					NULL, int3496_thread_isr,
> 					IRQF_SHARED | IRQF_ONESHOT |
> 					IRQF_TRIGGER_RISING |
> 					IRQF_TRIGGER_FALLING,
> 					dev_name(dev), data);
>
> It make sense, we don't have hard irq handler so we can't clear source of interrupt. 
> If we clear it immediately in interrupt controller then the same interrupt could 
> be raised again, because it was not cleared e.g in controller register. 

You are correct. Big mistake on my side. Apologies.

-- 
balbi
