Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB13ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414C020815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 13:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="l7oGVofo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbfJANgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 09:36:55 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:36900 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726853AbfJANgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 09:36:55 -0400
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DJJSu010574;
        Tue, 1 Oct 2019 09:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=sBQw2szhcF/O2fk7gdS40QsmnuIWV7+V8uGsBYxCNOc=;
 b=l7oGVofod+uYjmbhaMqtOUDQOSbE9t1C1FBeNpaKHLrwOStdQ8W5Ws27345+Vu9oc3o8
 BNief8WYc+KiWVB4xQ/nNM6O/fWtABpW+zowbOS7oijhcecfMFZ3x23oP9jORKMNRm5L
 QKIT1dIDmivsH5SQ/LyVGUUhr5hiM4otv3NS28yzVH7bMPosUs8V9hlBu9oP9PAHYNDM
 TZPty+4r/k0+D15y55T2uQSuhzIjT4d1343nZHlirCwlM8bUK4TdKLVwb0JV7SGbofvP
 /gwE+iClKsB9EPQhannTxK/oM8pYhKF3tnqLaTBhZMkhXDTOQDKoHWbJZptPL5A9BLx+ 6g== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2va3hcwekb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 09:36:53 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91DWnNU082779;
        Tue, 1 Oct 2019 09:36:52 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0b-00154901.pphosted.com with ESMTP id 2vc0wmq9gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 09:36:52 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="403781742"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <stern@rowland.harvard.edu>, <anthony.wong@canonical.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Thread-Topic: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
Thread-Index: AQHVeEzM1s+3ejBj70m/VgDp/AQpCadGBYmAgAAKNgD//7mOMA==
Date:   Tue, 1 Oct 2019 13:36:49 +0000
Message-ID: <bc3be927d5fd41efa6e0828f78a41d7a@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-2-mika.westerberg@linux.intel.com>
 <20191001121005.GA2951658@kroah.com>
 <20191001124638.GL2714@lahna.fi.intel.com>
In-Reply-To: <20191001124638.GL2714@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T13:36:48.4760965Z;
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
 mlxlogscore=810 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010123
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxlogscore=909 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909280083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, October 1, 2019 7:47 AM
> To: Greg Kroah-Hartman
> Cc: linux-usb@vger.kernel.org; Andreas Noever; Michael Jamet; Yehezkel Be=
rnat;
> Rajmohan Mani; Nicholas Johnson; Lukas Wunner; Alan Stern; Limonciello, M=
ario;
> Anthony Wong; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 01/22] thunderbolt: Introduce tb_switch_is_icm()
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Oct 01, 2019 at 02:10:05PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 01, 2019 at 02:38:09PM +0300, Mika Westerberg wrote:
> > > We currently differentiate between SW CM and ICM by looking directly =
at
> >
> > You should spell out what "SW CM" and "ICM" means please :)
>=20
> Indeed, sorry about that. I will spell them out in next version.
>=20
> SW CM is Software Connection manager, essentially
> drivers/thunderbolt/tb.c.

In some of the documentation I've seen non-internal connection manager refe=
rred to
as ECM, which I guess is an external connection manager?  To be consistent =
with various
documentations maybe that would be better than "SW CM".

>=20
> ICM is the Firmware Connection manager, essentially what is done in
> drivers/thunderbolt/icm.c. I think the I in ICM comes from Internal.

