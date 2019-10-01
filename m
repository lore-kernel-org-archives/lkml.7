Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5088ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6421924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="OAcVf9xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388826AbfJANuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:50:16 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:44014 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388575AbfJANuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:50:16 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DiwRJ003076;
        Tue, 1 Oct 2019 09:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=4wKxxsQwYyeOuJT6kt7svtW4PWqZIe2NNaEtlutCVgA=;
 b=OAcVf9xdUwPWEyvBewGeaPP+K7tW88aBJ9BwJPY8rfLHyEfMdqNzNV5AEeQnvTLCa++p
 4EWiDL/dqJOHoJOTJ3++Oilso4AJ5rZcUZfVUoSzyarNKFS8vMZjWW44RPoiuhLpGDJh
 XnZcHU9wSAJUDjgq5Bxp+bzSrPj4P77mMMdUiIw3oTK5Foqhyrc7vWWoEPre+j17M1Tx
 OW2PxiKGunDgPPK2vgMAaq09nSfNWO7ney+o7670asU9LkjDEjYjzf9lQ2fL+/WzOhMI
 XhAuMu0ylIu3yRchZp1lRLX9LfARWz7uZ2ycFEsPju3pYAjJlEC+xryaADGhrNXR9H+0 nQ== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2va2rangpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 09:50:15 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DhnSI104543;
        Tue, 1 Oct 2019 09:50:14 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2vc0wmqgyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:50:14 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1304905771"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <stern@rowland.harvard.edu>, <anthony.wong@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Thread-Topic: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Thread-Index: AQHVeEzM1s+3ejBj70m/VgDp/AQpCadGBYmAgAAKNgD//7mOMIAAV7kA//+sbJA=
Date:   Tue, 1 Oct 2019 13:50:13 +0000
Message-ID: <b3f621c4bb6f45e796b19e545240bd0f@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-2-mika.westerberg@linux.intel.com>
 <20191001121005.GA2951658@kroah.com>
 <20191001124638.GL2714@lahna.fi.intel.com>
 <bc3be927d5fd41efa6e0828f78a41d7a@AUSX13MPC105.AMER.DELL.COM>
 <20191001134828.GU2714@lahna.fi.intel.com>
In-Reply-To: <20191001134828.GU2714@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T13:50:11.5620584Z;
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
 definitions=2019-10-01_07:2019-10-01,2019-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010125
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, October 1, 2019 8:48 AM
> To: Limonciello, Mario
> Cc: gregkh@linuxfoundation.org; linux-usb@vger.kernel.org;
> andreas.noever@gmail.com; michael.jamet@intel.com; YehezkelShB@gmail.com;
> rajmohan.mani@intel.com; nicholas.johnson-opensource@outlook.com.au;
> lukas@wunner.de; stern@rowland.harvard.edu; anthony.wong@canonical.com;
> linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Oct 01, 2019 at 01:36:49PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Tuesday, October 1, 2019 7:47 AM
> > > To: Greg Kroah-Hartman
> > > Cc: linux-usb@vger.kernel.org; Andreas Noever; Michael Jamet; Yehezke=
l
> Bernat;
> > > Rajmohan Mani; Nicholas Johnson; Lukas Wunner; Alan Stern; Limonciell=
o,
> Mario;
> > > Anthony Wong; linux-kernel@vger.kernel.org
> > > Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_ic=
m()
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > On Tue, Oct 01, 2019 at 02:10:05PM +0200, Greg Kroah-Hartman wrote:
> > > > On Tue, Oct 01, 2019 at 02:38:09PM +0300, Mika Westerberg wrote:
> > > > > We currently differentiate between SW CM and ICM by looking direc=
tly at
> > > >
> > > > You should spell out what "SW CM" and "ICM" means please :)
> > >
> > > Indeed, sorry about that. I will spell them out in next version.
> > >
> > > SW CM is Software Connection manager, essentially
> > > drivers/thunderbolt/tb.c.
> >
> > In some of the documentation I've seen non-internal connection manager
> referred to
> > as ECM, which I guess is an external connection manager?  To be consist=
ent with
> various
> > documentations maybe that would be better than "SW CM".
>=20
> That's the first time I hear about ECM ;-)
>=20
> Here at Intel we use term "SW CM" and "FW CM" and IMHO they are better
> than ECM/ICM. But if people insist I can change them.

I do agree with you, SW CM and FW CM are clearer than ECM/ICM, maybe just r=
eference
both in the comments so if someone is aware of ECM/ICM from some documents =
they
can relate the two concepts.
