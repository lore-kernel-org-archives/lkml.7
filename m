Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAB7ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F89D21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="D21jo5mC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbfJASO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:14:29 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:31444 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728408AbfJASO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:14:29 -0400
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91I5J5X028164;
        Tue, 1 Oct 2019 14:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RaiO7KgO6Gkx38Eh2brE9qaYaKO5NtDoBJB5Djv5Ffs=;
 b=D21jo5mCVVQT2GxX9Tn0E2EPPBBvGJWlpSGI/2MfWlKeG238UBHuGhQ3bI91SbG5rj2q
 3wCnCLw4q4Y28UXjUT5LcFz1WDxCwDhzOZRvudoug+4EqnfLYXjL02uBdPqBkz3QtKDv
 9Aum42g8jL3/Df143aRkxiqrHAegamXuU9fy+JSD0c4CtvxIZKkVk4MVOuddkscBdrAM
 fUPXZQiyR5PuAJjuF3tslyLIygFrIW0NBojOy15Od9vE8PDj9V1Z/iUQfkPmzFX+EB9h
 4wE7pLOPKsB7IBadDOwNDdcAyUgdROTjpFFvJpKQ2avw0qnQRnXOBQNYQk9/A3Y0xHVu GA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2va46neqxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 14:14:27 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91I8DaF105726;
        Tue, 1 Oct 2019 14:14:26 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 2vc2rut7h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 14:14:26 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="429845825"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <linux-usb@vger.kernel.org>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Topic: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAATYiA=
Date:   Tue, 1 Oct 2019 18:14:23 +0000
Message-ID: <5357cb96013445d79f5c2016df8a194e@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
In-Reply-To: <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T17:05:07.4414478Z;
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
 definitions=2019-10-01_08:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=931 mlxscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010147
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Limonciello, Mario
> Sent: Tuesday, October 1, 2019 12:05 PM
> To: 'Mika Westerberg'; linux-usb@vger.kernel.org
> Cc: Andreas Noever; Michael Jamet; Yehezkel Bernat; Rajmohan Mani; Nichol=
as
> Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern; Anthony Wong; linu=
x-
> kernel@vger.kernel.org
> Subject: RE: [RFC PATCH 17/22] thunderbolt: Add initial support for USB4
>=20
> > @@ -322,9 +398,21 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
> >  	u32 val;
> >  	int ret;
> >
> > -	if (!sw->dma_port)
> > +	if (!nvm_readable(sw))
> >  		return 0;
> >
> > +	/*
> > +	 * The NVM format of non-Intel hardware is not known so
> > +	 * currently restrict NVM upgrade for Intel hardware. We may
> > +	 * relax this in the future when we learn other NVM formats.
> > +	 */
> > +	if (sw->config.vendor_id !=3D PCI_VENDOR_ID_INTEL) {
> > +		dev_info(&sw->dev,
> > +			 "NVM format of vendor %#x is not known, disabling NVM
> > upgrade\n",
> > +			 sw->config.vendor_id);
> > +		return 0;
> > +	}
> > +
>=20
> Don't you actually have an attribute you can use here for this exact purp=
ose that
> you
> could  be setting rather than returning immediately?
> sw->no_nvm_upgrade
>=20

One more thought; would you consider exporting to sysfs sw->config.vendor_i=
d?
Maybe an attribute that is switch_vendor?

Userland fwupd also does validation on the NVM and will need to follow this=
.
The same check will go into fwupd to match the vendor and lack of nvm_non_a=
ctive0
to mark the device as not updatable.  When the checks in the kernel get rel=
axed,
some NVM parsing will have to make it over to fwupd too to relax the check =
at that point.

> Then potentially you can at least let users "dump out" the nvm on !Intel =
but don't
> let
> it be written until ready to relax further.
>=20
> >  	nvm =3D kzalloc(sizeof(*nvm), GFP_KERNEL);
> >  	if (!nvm)
> >  		return -ENOMEM;

