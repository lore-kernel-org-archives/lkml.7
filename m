Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD938C04A6B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8EF21743
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 01:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="tkB1ce0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEIBjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 21:39:40 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:52986 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfEIBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 21:39:39 -0400
X-Greylist: delayed 18665 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 21:39:38 EDT
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48KF0Mb019738
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 16:28:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=NBQDuoaJ1XrW6ALy4NvQGygfurvfzPp5iKN3XvrAFHM=;
 b=tkB1ce0/PlIyySHQi8pc9xhgf6WspqE+kR1rWxurx0p7T1Q4dMEhooftbSuduiLnUIR5
 TFHtcL8u51Y8ZyCVAV+o0SQN3KUY4B++ioNpVX2g/iIRBP2IJP5gv9Z685WCe2LBZELY
 x758QDI96ABHk28dT+kJKnDH+OJH8veV6DhOnsWHk3TlPSceP+iXSG103imIkA6WNFQ2
 C8Rf7xgcCWfV9Zx9IoUyacPsVu8YNG9szHAjPqYyMw92bfTitKPidLmySwwudN/zLU4R
 JWi6+DbCs+6LhPtrvn6s8LSo6Qf9Co42/o/VXyjdUhrf/WLY6gIkT8TiIAj5RNH1ujmj GA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2sbe014xgx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:28:33 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48KCfvI094764
        for <linux-kernel@vger.kernel.org>; Wed, 8 May 2019 16:28:33 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2sc32qjtac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 16:28:32 -0400
X-LoopCount0: from 10.166.132.128
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1233298866"
From:   <Mario.Limonciello@dell.com>
To:     <hch@lst.de>
CC:     <kai.heng.feng@canonical.com>, <kbusch@kernel.org>,
        <keith.busch@intel.com>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Topic: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Thread-Index: AQHVBdBS/xizqbOjGUOY5SKUREVH6KZh7T4AgAAD4gD//6zksIAAWSuA//+yBvA=
Date:   Wed, 8 May 2019 20:28:30 +0000
Message-ID: <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
In-Reply-To: <20190508195159.GA1530@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=624 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905080124
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=711 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905080124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, May 8, 2019 2:52 PM
> To: Limonciello, Mario
> Cc: kai.heng.feng@canonical.com; kbusch@kernel.org; keith.busch@intel.com=
;
> axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-nvme@lists.infradead.or=
g;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of=
 D3 on
> Suspend-to-Idle
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, May 08, 2019 at 07:38:50PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > The existing routines have an implied assumption that firmware will com=
e
> swinging
> > with a hammer to control the rails the SSD sits on.
> > With S2I everything needs to come from the driver side and it really is=
 a
> > different paradigm.
>=20
> And that is why is this patch is fundamentally broken.
>=20
> When using the simple pm ops suspend the pm core expects the device
> to be powered off.  If fancy suspend doesn't want that we need to
> communicate what to do to the device in another way, as the whole
> thing is a platform decision.  There probabl is one (or five) methods
> in dev_pm_ops that do the right thing, but please coordinate this
> with the PM maintainers to make sure it does the right thing and
> doesn't for example break either hibernate where we really don't
> expect just a lower power state, or=20

You might think this would be adding runtime_suspend/runtime_resume
callbacks, but those also get called actually at runtime which is not
the goal here.  At runtime, these types of disks should rely on APST which
should calculate the appropriate latencies around the different power state=
s.

This code path is only applicable in the suspend to idle state, which /does=
/
call suspend/resume functions associated with dev_pm_ops.  There isn't
a dedicated function in there for use only in suspend to idle, which is
why pm_suspend_via_s2idle() needs to get called.

SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
freeze (hibernate), so to avoid any changes to the hibernate case it seems
to me that there needs to be a new nvme_freeze() that calls into the existi=
ng
nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into the
existing nvme_reset_ctrl for the thaw pm op.

> enterprise class NVMe devices
> that don't do APST and don't really do different power states at
> all in many cases.

Enterprise class NVMe devices that don't do APST - do they typically
have a non-zero value for ndev->ctrl.npss?

If not, they wouldn't enter this new codepath even if the server entered in=
to S2I.
