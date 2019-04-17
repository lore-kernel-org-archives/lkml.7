Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA80CC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8552620674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfDQPdY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:33:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2539 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729940AbfDQPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:33:24 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 1F1C43DCC1DB0F3A4AAC;
        Wed, 17 Apr 2019 23:33:21 +0800 (CST)
Received: from dggeme761-chm.china.huawei.com (10.3.19.107) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 17 Apr 2019 23:33:20 +0800
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 dggeme761-chm.china.huawei.com (10.3.19.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 17 Apr 2019 23:33:20 +0800
Received: from dggeme762-chm.china.huawei.com ([10.8.68.53]) by
 dggeme762-chm.china.huawei.com ([10.8.68.53]) with mapi id 15.01.1591.008;
 Wed, 17 Apr 2019 23:33:20 +0800
From:   "zhuyan (M)" <zhuyan34@huawei.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "zhuyan (M)" <zhuyan34@huawei.com>
Subject: Re: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
Thread-Topic: [PATCH] usb:host: fix divide-by-zero in function fhci_queue_urb
Thread-Index: AdT1MnwO+lcz9XnHRgGSjwdOkKXG4g==
Date:   Wed, 17 Apr 2019 15:33:20 +0000
Message-ID: <3b062edaaafa45e2b7fb191187ef1f31@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.40.99.186]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, 9:45 -400, Alan Stern wrote:
> On Wed, 17 Apr 2019, zhuyan (M) wrote:
> > On Tue, 16 Apr 2019 11:07:56 -0400, Alan Stern wrote:
> > > On Tue, 16 Apr 2019, zhuyan (M) wrote:
> > > > On Tue, 16 Apr 2019 at 11:45:45 +0200, Greg KH wrote:
> > > > > On Tue, Apr 09, 2019 at 10:37:12PM +0800, zhuyan wrote:
> > > > > > In function fhci_queue_urb, the divisor of expression 
> > > > > > (urb->transfer_buffer_length % usb_maxpacket(urb->dev, 
> > > > > > urb->pipe,
> > > > > > usb_pipeout(urb->pipe))) may be zero.
> > > > > 
> > > > > How can you hit that?
> > > > > 
> > > > > > When it is zero, unexpected results may occur, so it is 
> > > > > > necessary to ensure that the divisor is not zero.
> > > > > > 
> > > > > > Signed-off-by: zhuyan <zhuyan34@huawei.com>
> > > > > 
> > > > > I need a "Full" name here, not just a single name.  Whatever you use to sign documents is good.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > In function usb_maxpacket, when ep is NULL, its return value is 0.  
> > > 
> > > fhci_queue_urb() shouldn't use urb->pipe to compute the maxpacket 
> > > size anyway.  It should use usb_endpoint_maxp(&urb->ep->desc).
> > 
> > Currently, fhci_queue_urb(), call usb_maxpacket() multiple times to 
> > calculate  the maxpacket size. The usb_maxpacket() will call 
> > usb_endpoint_maxp() to compute the maxpacket size.
> 
> I know that.  What fhci_queue_urb() is doing is wrong.  You should change
> it: Make it call usb_endpoint_maxp directly instead of calling usb_maxpacket.

ok, I will resubmit a patch to repair it.

Best wish to you!
zhuyan
