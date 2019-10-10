Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD68C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19D420679
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJJKRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:17:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:51926 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfJJKRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:17:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 03:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="369031774"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga005.jf.intel.com with ESMTP; 10 Oct 2019 03:17:15 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Roger Quadros <rogerq@ti.com>, Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@nxp.com>
Cc:     "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel\@ti.com" <jbergsagel@ti.com>,
        "nsekhar\@ti.com" <nsekhar@ti.com>, "nm\@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH] usb:cdns3: Fix for CV CH9 running with g_zero driver.
In-Reply-To: <80047a82-4b01-8f54-7efa-c32f696ced43@ti.com>
References: <1570430355-26118-1-git-send-email-pawell@cadence.com> <20191008065619.GE5670@b29397-desktop> <87a7abv1f2.fsf@gmail.com> <BYAPR07MB4709490136F8F65A008C219EDD950@BYAPR07MB4709.namprd07.prod.outlook.com> <80047a82-4b01-8f54-7efa-c32f696ced43@ti.com>
Date:   Thu, 10 Oct 2019 13:17:15 +0300
Message-ID: <87a7a8vr9w.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

Roger Quadros <rogerq@ti.com> writes:
>>> Peter Chen <peter.chen@nxp.com> writes:
>>>> On 19-10-07 07:39:11, Pawel Laszczak wrote:
>>>>> Patch fixes issue with Halt Endnpoint Test observed
>>>>
>>>> %s/Endnpoint/Endpoint
>>>>
>>>>>
>>>>> during using g_zero
>>>>> driver as DUT. Bug occurred only on some testing board.
>>>>
>>>> g_zero is legacy, please use configfs function source_sink or loopback
>>>> instead.
>>>
>>> We still want fixes for those ;-)
>> 
>> So, if my understanding is correct in new production systems
>> using legacy gadget drivers is not recommended and we are not going to fix
>> any more bugs there.
>
> We can't really control who uses what. So we need to support legacy
> drivers as well.
>
> The issue detected by using g_zero is a controller driver issue and not an
> issue with g_zero itself.

thanks for clarifying, Roger.

Pawel, Roger is correct here. But in any case, if *real* bugs are found
on the legacy gadget drivers, let's see if they happen with
configfs-based interface as well. They should behave exactly the same
nowadays since legacy driver were converted to simply programmatically
spawn the configfs interface.

If there are bugs in legacy gadget drivers, we *WANT* to fix those.

-- 
balbi
