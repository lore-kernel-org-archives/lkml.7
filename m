Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1293C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6320665
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 06:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGIGhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 02:37:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:22628 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfGIGhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 02:37:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 23:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="165673567"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2019 23:36:57 -0700
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
In-Reply-To: <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1562324238-16655-1-git-send-email-pawell@cadence.com> <1562324238-16655-6-git-send-email-pawell@cadence.com> <87r274lmqk.fsf@linux.intel.com> <BYAPR07MB4709EF3753AC0B87606B1182DDF70@BYAPR07MB4709.namprd07.prod.outlook.com> <87a7dpm442.fsf@linux.intel.com> <BYAPR07MB47094B372CEC6DFD25FC78E1DDF10@BYAPR07MB4709.namprd07.prod.outlook.com>
Date:   Tue, 09 Jul 2019 09:36:57 +0300
Message-ID: <87pnmj67ee.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Pawel Laszczak <pawell@cadence.com> writes:
>>> IRQF_ONESHOT can be used  only in threaded handled.
>>> "
>>>  * IRQF_ONESHOT - Interrupt is not reenabled after the hardirq handler finished.
>>>  *                Used by threaded interrupts which need to keep the
>>>  *                irq line disabled until the threaded handler has been run.
>>> "
>>
>>so?
>
> I don't understand why If I don't have threaded handler why I need IRQF_ONESHOT. 
> Why interrupt cannot be reenabled after hardirq handler finished ?
> I do not use threaded handler so this flag seem unnecessary. 

Unless this has changed over the years, it was a requirement from IRQ susbystem.

	/*
	 * Drivers are often written to work w/o knowledge about the
	 * underlying irq chip implementation, so a request for a
	 * threaded irq without a primary hard irq context handler
	 * requires the ONESHOT flag to be set. Some irq chips like
	 * MSI based interrupts are per se one shot safe. Check the
	 * chip flags, so we can avoid the unmask dance at the end of
	 * the threaded handler for those.
	 */
	if (desc->irq_data.chip->flags & IRQCHIP_ONESHOT_SAFE)
		new->flags &= ~IRQF_ONESHOT;

>>>>> +	} else {
>>>>> +		struct usb_request *request;
>>>>> +
>>>>> +		if (priv_dev->eps[index]->flags & EP_WEDGE) {
>>>>> +			cdns3_select_ep(priv_dev, 0x00);
>>>>> +			return 0;
>>>>> +		}
>>>>> +
>>>>> +		cdns3_dbg(priv_ep->cdns3_dev, "Clear Stalled endpoint %s\n",
>>>>> +			  priv_ep->name);
>>>>
>>>>why do you need your own wrapper around dev_dbg()? This looks quite unnecessary.
>>>
>>> It's generic function used for adding message to trace.log.  It's not wrapper to dev_dbg
>>>
>>> void cdns3_dbg(struct cdns3_device *priv_dev, const char *fmt, ...)
>>> {
>>> 	struct va_format vaf;
>>> 	va_list args;
>>>
>>> 	va_start(args, fmt);
>>> 	vaf.fmt = fmt;
>>> 	vaf.va = &args;
>>> 	trace_cdns3_log(priv_dev, &vaf);
>>> 	va_end(args);
>>> }
>>
>>oh. Don't do it like that. Add a proper trace event that actually
>>decodes the information you want. These random messages will give you
>>trouble in the future. I had this sort of construct in dwc3 for a while
>>and it became clear that it's a bad idea. It's best to have trace events
>>that decode information coming from the HW. That way your trace logs
>>have a "predictable" shape/format and you can easily find problem areas.
>
> Ok , I will change this.
> I used such solution because I didn't want to create to many trace events. 
> I used it only for rely used messages. 

If you have these messages that are *really* needed, then you should add
a trace event for it. Look at the events we have on dwc3 if you need
some inspiration. Could also look at the history of our trace events to
figure out how things changed over time.

cheers

-- 
balbi
