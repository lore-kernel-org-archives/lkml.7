Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BDDC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E526720663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 07:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfHMHas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 03:30:48 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:55542 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726789AbfHMHas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 03:30:48 -0400
X-UUID: 2f2b0143cd3e40c9bcb0e0e98dbafa8a-20190813
X-UUID: 2f2b0143cd3e40c9bcb0e0e98dbafa8a-20190813
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 972925513; Tue, 13 Aug 2019 15:30:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 13 Aug
 2019 15:30:32 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 13 Aug 2019 15:30:31 +0800
Message-ID: <1565681434.23705.66.camel@mhfsdcap03>
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "Rahul Kumar" <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Date:   Tue, 13 Aug 2019 15:30:34 +0800
In-Reply-To: <679b82bc-9f33-91ad-4acf-bf6a29e51bc1@ti.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
         <1563733939-21214-6-git-send-email-pawell@cadence.com>
         <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
         <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
         <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com>
         <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
         <20190812103147.GA4691@kuha.fi.intel.com>
         <d3bba104-9a85-df8d-c62d-6acb8913c3fe@ti.com> <874l2mtuu6.fsf@gmail.com>
         <679b82bc-9f33-91ad-4acf-bf6a29e51bc1@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 233011D5CB765319D937F8AAFF09E4447CF6C202C05D790FC71AAF3EC6A173412000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-08-12 at 16:04 +0300, Roger Quadros wrote:
> 
> On 12/08/2019 15:46, Felipe Balbi wrote:
> > 
> > Hi,
> > 
> > Roger Quadros <rogerq@ti.com> writes:
> >>> The sysfs file we expose from the class for the role switches is
> >>> primarily meant for supporting proprietary protocols that require us
> >>> to basically override the connector USB data role. The default role
> >>> should always be selected in the drivers.
> >>
> >> OK. Let's take this example
> >> - Port is dual-role port micro AB.
> >> - microAB to type-A adapter is connected which pulls ID low. port transitions
> >> to "host" role by the controller driver.
> >> - proprietary protocol want to switch role to device role so writes "device" to
> >> mode switch sysfs. port transitions to "device" role.
> >>
> >> Now, how does controller driver know to fall back to HW based role switching?
> > 
> > Use a 'disconnect' or 'suspend' event to go reset it? But that should,
> > probably, be done at kernel space, no?
> > 
> 
> Yes that could be one option.
> So after a disconnect, sysfs role should reflect actual hardware role. correct?

Maybe it's difficult to support both HW based role switch and SW based
role switch by sysfs at the same if the HW's FSM rely on, such as, the
state of Vbus pin or ID pin. Likes the upper example, when user writes
"device" to mode switch sysfs, the driver should skip the HW state of ID
pin, due to it's state is Low, or force it as High.

Another option way is that introduces a property in DTS to indicate the
way the driver want to use (HW based or SW based, usb_role_switch
doesn't provide this information for the controller driver), but is not
flexible enough.
 
> 
> cheers,
> -roger


