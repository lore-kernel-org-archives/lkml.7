Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E62C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FBB21783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="ERRPzXlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfJCOlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:41:16 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:14348 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729951AbfJCOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:41:16 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93Ee6VL012477;
        Thu, 3 Oct 2019 10:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=V3BR9F8aqsjZnQsqhqhOQjBxvidnv8ceqAJIifPiUoE=;
 b=ERRPzXlLY4u0/LGIVNRbE+xSRivcyhxE4ZJUfh4j+3oQDryBP5KzRtm/h/vhM8mpzmpJ
 v2QNk/MbP6yzvcH0OW6DzRzK8Eb+bBcf5HeIC8akZYDK+OZ2WyUd2YiAQ+l/Uo0bZ1Zk
 U5qzsYf9lAkHUHxRvHy9eOZTUH/m5pzaZIIaVeZ2Vw+gwCdixQqWNpWsSO6BMpEYznGZ
 vYVHJ1i6cK0LdK4h5TWoMqa1DZ0VmU+ZtLBM5KUaEdiWKqMeHVlZSKRHR5k4MT0PPyeu
 anMuh/GHfTMe83uVRmkdUHuzBxIOJj1M71RMSefrSo4QuccPySApLw7sO+vxLTSzEF8V sg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2uk8r2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 10:41:14 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93EcWbj006028;
        Thu, 3 Oct 2019 10:41:13 -0400
Received: from ausxipps306.us.dell.com (AUSXIPPS306.us.dell.com [143.166.148.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2vdb1fw178-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Oct 2019 10:41:13 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="382884374"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <yehezkelshb@gmail.com>, <linux-usb@vger.kernel.org>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiCAAUbqgIAAF+AwgABczAD//7D1UIABYeAAgAAaodA=
Date:   Thu, 3 Oct 2019 14:41:11 +0000
Message-ID: <06a04bff94494da99c5359a7fb645d19@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com>
 <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
 <CA+CmpXs4YsTA3QnD77SaXq3mRYX6oFwx+pm-3wEErwkF-02M+A@mail.gmail.com>
 <bb84da73d1df468da1707a2af09eb2de@AUSX13MPC105.AMER.DELL.COM>
 <20191003080028.GK2819@lahna.fi.intel.com>
In-Reply-To: <20191003080028.GK2819@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-03T14:41:10.3587326Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_05:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030137
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Thursday, October 3, 2019 3:00 AM
> To: Limonciello, Mario
> Cc: yehezkelshb@gmail.com; linux-usb@vger.kernel.org;
> andreas.noever@gmail.com; michael.jamet@intel.com;
> rajmohan.mani@intel.com; nicholas.johnson-opensource@outlook.com.au;
> lukas@wunner.de; gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Oct 02, 2019 at 04:00:55PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > It's not even "same location - another meaning", the vendor ID comes =
from
> the
> > > DROM section, so it takes a few internal jumps inside the NVM to find=
 the
> > > location. One of the "pointers" or section headers will be broken for=
 sure.
> > >
> > > And after this, we need to find the NVM in LVFS and it has to pass va=
lidation
> in
> > > a few other locations. The chances are so low that I'd think it isn't=
 worth
> > > worrying about it.
> >
> > And now I remember why the back of my mind was having this thought of
> wanting
> > sysfs attribute in the first place.  The multiple jumps means that a lo=
t more of
> the
> > NVM has to be dumped to get that data, which slows down fwupd startup
> significantly.
>=20
> IIRC currently fwupd does two reads of total 128 bytes from the active
> NVM. Is that really slowing down fwupd startup significantly?

Yeah, I timed it with fwupd.  Here's the averages:

Without doing the reads to jump to this it's 0:00.06 seconds to probe a tre=
e of
Host controller and dock plugged in.

With doing the reads and just host controller:
0:04.40 seconds

With doing the reads and host controller and dock plugged in:
0:10.73 seconds

>=20
> > However the kernel has this information handy already from thunderbolt =
init
> and can
> > easily export an attribute which can then come from udev with no startu=
p
> penalty.
>=20
> Indeed kernel has this information but I'm bit hesitant to add new
> attributes if that same information is already available to the
> userspace rather easily. IMHO we can always add this to the driver later
> as we learn new NVM formats that require more parsing from fwupd side
> slowing it down considerably.

I guess we can wait until new NVM formats come and cross the bridge at that=
 point.
If we encounter a new NVM format that kernel recognizes but old fwupd doesn=
't it
will reject it anyway (just the error won't be super clear why).
