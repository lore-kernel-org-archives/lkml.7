Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07601C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC552133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="OUQvDO4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfJBPEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:04:38 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:35424 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbfJBPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:04:37 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92ElNI7011345;
        Wed, 2 Oct 2019 11:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Fne4wKYhGsShISfTecSpQhEctBbJgVgrRkq91FzVd5M=;
 b=OUQvDO4+eIjflLJTbjhxIGyelEz/AqhnS08zQkc07qEmrNq9q+MHiPjTVrXHMdvHNPXV
 ZkhVDKrQEytftQmDTA47U0RmvHUPXjazSql86E1EZUH98RsGHpdT2tAwPhxnRBbWv1aI
 dx5+mmUR6A+VMPRKhaQOXiUg4SVA1SokjBdAZhAIXmC9t1MxGbQ0jyjcq4Nnsmuo/+f3
 Kpjay24+Bbf6niW8oraaa4wg4PhfqW7TEy+qkYfNMasLqCpEY5mCnqZIvVfnVN3A9eSV
 Uh5m8Ae1XOiXoSkbArPHURkO6iDhseMBg/y6eDWqKXSiFiVShvBH7QxVZjUPSuheAvu6 Pw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2va238bk2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Oct 2019 11:04:36 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x92F3RIK123751;
        Wed, 2 Oct 2019 11:04:35 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2vca1war6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Oct 2019 11:04:35 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="467769692"
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
Thread-Index: AQHVeEzShOhklesInk+gx9St4A7986dGAqiggAFZDQCAABiIsA==
Date:   Wed, 2 Oct 2019 15:04:33 +0000
Message-ID: <46d927da41d9430196f9aed10ed33d91@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-18-mika.westerberg@linux.intel.com>
 <184c95fc476146939b240557e54ee2c9@AUSX13MPC105.AMER.DELL.COM>
 <20191002083446.GF2714@lahna.fi.intel.com>
In-Reply-To: <20191002083446.GF2714@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-02T15:04:31.9392793Z;
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
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910020138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Wednesday, October 2, 2019 3:35 AM
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
> On Tue, Oct 01, 2019 at 05:05:09PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > @@ -322,9 +398,21 @@ static int tb_switch_nvm_add(struct tb_switch *s=
w)
> > >  	u32 val;
> > >  	int ret;
> > >
> > > -	if (!sw->dma_port)
> > > +	if (!nvm_readable(sw))
> > >  		return 0;
> > >
> > > +	/*
> > > +	 * The NVM format of non-Intel hardware is not known so
> > > +	 * currently restrict NVM upgrade for Intel hardware. We may
> > > +	 * relax this in the future when we learn other NVM formats.
> > > +	 */
> > > +	if (sw->config.vendor_id !=3D PCI_VENDOR_ID_INTEL) {
> > > +		dev_info(&sw->dev,
> > > +			 "NVM format of vendor %#x is not known, disabling
> NVM
> > > upgrade\n",
> > > +			 sw->config.vendor_id);
> > > +		return 0;
> > > +	}
> > > +
> >
> > Don't you actually have an attribute you can use here for this exact pu=
rpose
> that you
> > could  be setting rather than returning immediately?
> > sw->no_nvm_upgrade
> >
> > Then potentially you can at least let users "dump out" the nvm on !Inte=
l but
> don't let
> > it be written until ready to relax further.
>=20
> Problem is that we currently read NVM version and size from a known
> location in the NVM. If we don't know the format we can't do that so
> that would mean we need to expose active NVM with some size and hide
> nvm_version. I would rather have this support included in the kernel
> driver and expose standard set of attributes but no strong feelings from
> one way or another.

I agree with you; this is a safer and smarter approach to wait until detail=
s of format
for other vendors is known and export attributes only when it is.  This wil=
l also
encourage other vendors to open up their format if the only way to access N=
VM is
to document the headers.
