Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8992820C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="mRm1HZ8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfB1XKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:10:14 -0500
Received: from esa3.dell-outbound.iphmx.com ([68.232.153.94]:30657 "EHLO
        esa3.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726437AbfB1XKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:10:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1551395326; x=1582931326;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=my7SKwWhI/hQ5uodBQQXXTJZM+kP68VxLNCAiH8KLy0=;
  b=mRm1HZ8aK0COwsaZKwnqH7JvJYUwCRguuLobEXdPghBdUZm8WEpEzCNv
   b4Iitc1RU3XODx1g/r+F0jatqSfHHgMnRXhhccUGxS+mMS/HnGWikgIrc
   c0rQxmoDP1uRxjrcR2O9xQk/nGUbjfeUmq+DyW59/qQSPEEoPP0gVoXu+
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ERAADEaXhchieV50NlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBgVWBBoEUFRIKjBhfjH2BfZYjFIFnCwEBhGyEFyI0CQ0BAwE?=
 =?us-ascii?q?BAwEDAgEBAhABAQEKCQsIKS+COiKCcAEBAQMSKD8QAgEIGB4QVwIEAQ0FCBq?=
 =?us-ascii?q?CfoFzn1o9Am+BAYkHAQEBgh6KM4xIghaBEYJkLoROARIBBwEBFoVhAooJAYI?=
 =?us-ascii?q?Il1gHApJiIZMch2+CbpIXAgQCBAUCFIFHgR5xcIM8gigOCY4eQAExjWaBH4E?=
 =?us-ascii?q?fAQE?=
X-IPAS-Result: =?us-ascii?q?A2ERAADEaXhchieV50NlHAEBAQQBAQcEAQGBUQcBAQsBg?=
 =?us-ascii?q?VWBBoEUFRIKjBhfjH2BfZYjFIFnCwEBhGyEFyI0CQ0BAwEBAwEDAgEBAhABA?=
 =?us-ascii?q?QEKCQsIKS+COiKCcAEBAQMSKD8QAgEIGB4QVwIEAQ0FCBqCfoFzn1o9Am+BA?=
 =?us-ascii?q?YkHAQEBgh6KM4xIghaBEYJkLoROARIBBwEBFoVhAooJAYIIl1gHApJiIZMch?=
 =?us-ascii?q?2+CbpIXAgQCBAUCFIFHgR5xcIM8gigOCY4eQAExjWaBH4EfAQE?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa3.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Feb 2019 17:08:45 -0600
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SN8taq028875
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:10:13 -0500
Received: from esa6.dell-outbound2.iphmx.com (esa6.dell-outbound2.iphmx.com [68.232.154.99])
        by mx0a-00154901.pphosted.com with ESMTP id 2qxjmjjtc0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 18:10:13 -0500
From:   <Austin.Bolen@dell.com>
To:     <hch@infradead.org>, <Austin.Bolen@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa6.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 01 Mar 2019 05:10:12 +0600
X-LoopCount0: from 10.166.134.83
X-IronPort-AV: E=Sophos;i="5.58,425,1544508000"; 
   d="scan'208";a="278513540"
CC:     <Alex_Gagniuc@Dellteam.com>, <torvalds@linux-foundation.org>,
        <keith.busch@intel.com>, <sagi@grimberg.me>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@fb.com>, <mr.nuke.me@gmail.com>, <hch@lst.de>,
        <jonathan.derrick@intel.com>
Subject: Re: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Topic: [PATCH] nvme-pci: Prevent mmio reads if pci channel offline
Thread-Index: AQHUyksezlXXaxBLsUa+kQskBqUhAw==
Date:   Thu, 28 Feb 2019 23:10:11 +0000
Message-ID: <883e2fad8f6e4791bfee2ec08992da39@AUSX13MPC131.AMER.DELL.COM>
References: <CAHk-=wjmjHyovjtzaq=HSegEpiO2SXWaYfJ6qsJrZhXg_YSx5g@mail.gmail.com>
 <2b7d8f45d11c47e69f56ad1bc3324dd1@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wg_e5M0b5aJJf8V_UYaqX12YYA9MEg=gHNp6ALE5fK23w@mail.gmail.com>
 <cbe2ed1562a64609be6538f5816ec1b6@ausx13mps321.AMER.DELL.COM>
 <20190225155501.GI10237@localhost.localdomain>
 <b35ebf928ed743cca6649a191c76957b@ausx13mps321.AMER.DELL.COM>
 <CAHk-=wgRdATtsBzo-LDkWn_sW-PJvq95SahZcsTxxDMPzLWxKA@mail.gmail.com>
 <940d608e1a044a54abcb9d65923951f3@ausx13mps317.AMER.DELL.COM>
 <f6704855445b44639f023a48f3003309@AUSX13MPC131.AMER.DELL.COM>
 <443262761d0e41fbb46a46dab28759c2@AUSX13MPC131.AMER.DELL.COM>
 <20190228141655.GA18319@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2019 8:17 AM, Christoph Hellwig wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Wed, Feb 27, 2019 at 08:04:35PM +0000, Austin.Bolen@dell.com wrote:=0A=
>> Confirmed this issue does not apply to the referenced Dell servers so I=
=0A=
>> don't not have a stake in how this should be handled for those systems.=
=0A=
>> It may be they just don't support surprise removal.  I know in our case=
=0A=
>> all the Linux distributions we qualify (RHEL, SLES, Ubuntu Server) have=
=0A=
>> told us they do not support surprise removal.  So I'm guessing that any=
=0A=
>> issues found with surprise removal could potentially fall under the=0A=
>> category of "unsupported".=0A=
>>=0A=
>> Still though, the larger issue of recovering from other types of PCIe=0A=
>> errors that are not due to device removal is still important.  I would=
=0A=
>> expect many system from many platform makers to not be able to recover=
=0A=
>> PCIe errors in general and hopefully the new DPC CER model will help=0A=
>> address this and provide added protection for cases like above as well.=
=0A=
> =0A=
> FYI, a related issue I saw about a year two ago with Dell servers was=0A=
> with a dual ported NVMe add-in (non U.2) card, is that once you did=0A=
> a subsystem reset, which would cause both controller to retrain the link=
=0A=
> you'd run into Firmware First error handling issue that would instantly=
=0A=
> crash the system.  I don't really have the hardware anymore, but the=0A=
> end result was that I think the affected product ended up shipping=0A=
> with subsystem resets only enabled for the U.2 form factor.=0A=
> =0A=
=0A=
Yes, that's another good one.  For add-in cards, they are not =0A=
hot-pluggable and so the platform will not set the Hot-Plug Surprise bit =
=0A=
in the port above them.  So when the surprise link down happens the =0A=
platform will generate a fatal error.  For U.2, the Hot-Plug Surprise =0A=
bit is set on these platforms which suppresses the fatal error.  It's ok =
=0A=
to suppress in this case since OS will get notified via hot-plug =0A=
interrupt.  In the case of the add-in card there is no hot-plug =0A=
interrupt and so the platform has no idea if the OS will handle the =0A=
surprise link down or not so platform has to err on the side of caution. =
=0A=
  This is another case where the new containment error recovery model =0A=
will help by allowing platform to know if OS can recover from this error =
=0A=
or not.=0A=
=0A=
Even if the system sets the Hot-Plug Surprise bit, the system can still =0A=
crater if OS does an NSSR and then some sort of MMIO is generated to the =
=0A=
downed port.  Platforms that suppress errors for removed devices will =0A=
still escalate this error as fatal since the device is still present. =0A=
But again the error containment model should protect this case as well.=0A=
=0A=
I'd also note that in PCIe, things that intentionally take the link down =
=0A=
like SBR or Link Disable suppress surprise down error reporting.  But =0A=
NSSR doesn't have this requirement to suppress surprise down reporting. =0A=
I think that's a gap on the part of the NVMe spec.=0A=
=0A=
-Austin=0A=
