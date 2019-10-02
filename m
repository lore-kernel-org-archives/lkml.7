Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B058C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E54D21920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="aaLEiDcG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfJBPJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:09:51 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:10708 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfJBPJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:09:51 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92F66Tl012263;
        Wed, 2 Oct 2019 11:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=sOn88WoOOxEAiUXFVWykYOhOLqPInXGGzmg9K0K8ST8=;
 b=aaLEiDcG1f5UlZk5jXoe4NyoxFez0DBA2MS1LYYZlO9rDhD5F5/r+6e12aXcbW8z17Rs
 ySTfJEi4MOvu7rz+HTJXJnzWAd61+KNHE3PnIZiygv3YWVAfP/NF1H2t6b3fJZMS0nK1
 MpkeIJd7lGHjhy4WEAuxefi9jjqdk/9RQX02bM78pTxN/uNGQEDUUv07PTiWY7WvUGtQ
 PDG1omgZb5o96sSJmzEZMAUnmzRPd8jSPQxhrtWkBgwZurbzaaA3mmc2F6ZAAJWOx38P
 3WRpXU2gThzyIVsSSXPpXqa6Sg9zDB/I76vM9Qi2bx+IXugOSRR/eOjtyQrRIbPZuck/ FA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va2nyugcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 11:09:49 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92F3Jfg141215;
        Wed, 2 Oct 2019 11:09:49 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2vcp03n1h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 11:09:48 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1305371468"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiCAAUbqgIAAF+Aw
Date:   Wed, 2 Oct 2019 15:09:46 +0000
Message-ID: <767f2f97059e4e9f861080672aaa18d3@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
 <20191002083913.GG2714@lahna.fi.intel.com>
In-Reply-To: <20191002083913.GG2714@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-02T15:09:45.1313028Z;
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
 definitions=2019-10-02_07:2019-10-01,2019-10-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910020139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910020139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Wednesday, October 2, 2019 3:39 AM
> To: Limonciello, Mario
> Cc: linux-usb@vger.kernel.org; andreas.noever@gmail.com;
> michael.jamet@intel.com; YehezkelShB@gmail.com; rajmohan.mani@intel.com;
> nicholas.johnson-opensource@outlook.com.au; lukas@wunner.de;
> gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Oct 01, 2019 at 06:14:23PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > One more thought; would you consider exporting to sysfs sw-
> >config.vendor_id?
> > Maybe an attribute that is switch_vendor?
> >
> > Userland fwupd also does validation on the NVM and will need to follow =
this.
> > The same check will go into fwupd to match the vendor and lack of
> nvm_non_active0
> > to mark the device as not updatable.  When the checks in the kernel get
> relaxed,
> > some NVM parsing will have to make it over to fwupd too to relax the ch=
eck at
> that point.
>=20
> The original idea was that the kernel does the basic validation and
> userspace then does more complex checks. Currently you can compare the
> two NVM images (active one and the new) and find that information there.
> I think fwupd is doing just that already. Is that not enough?

I guess for fwupd we can do this without the extra attribute:

1) If no NVM files or nvm_version: means unsupported vendor -show that mess=
aging somewhere.
This means kernel doesn't know the vendor.

2) If NVM file and nvm_version: means kernel knows it
*fwupd checks the vendor offset for intel.
-> intel: good, proceed
->something else: fwupd needs to learn the format for the new vendor, show =
messaging

There is the unlikely case that kernel knows new vendor format and vendor N=
VM happened to have
same value as Intel vendor ID in same location of Intel NVM but another mea=
ning.
Hopefully that doesn't happen :)
