Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB44BECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C242168B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="AOughgZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbfJAQzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:55:19 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:39426 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731011AbfJAQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:55:16 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91Gsqni021941;
        Tue, 1 Oct 2019 12:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=iSPiFeopsOpYhHpx1hqRJ4BtqLz6VkDHwgz5yWZ0WPw=;
 b=AOughgZ92wyBrEeyO9Ogyvy2KbY2LsOMUkr2ptDeDfyVPOJeR82FJ2OUtgqI+MQUjHR+
 roLMpnYPO805iLZxIpzx+9xc6yfyi82amuWTXjKebRhXlLu31g6vthQ3m/E+EeYHIj7y
 PM94hdwbhwk2NRJbdqlpHYnYE8jGdQ/bPDnGMX/ovte5XEPUM1WmuNUfcUcz6KFnsour
 mcIfzrIm1tKIN0IkUgTjh/Abzb+Fkhx2dPq65RFXho+OO2Yp59SbAhxWqhHmHYXm0mH/
 6RRhFW3tEpJVjKMl37/XCU5qAI+y86oaJA4b+nXIu5+zodo/6xdrzm4hrbCXkjs1TTuM Yg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 2va2rapgks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 12:55:14 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x91GrSLd123237;
        Tue, 1 Oct 2019 12:55:14 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2vc0wmua0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 12:55:14 -0400
X-LoopCount0: from 10.166.132.133
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="467383014"
From:   <Mario.Limonciello@dell.com>
To:     <mika.westerberg@linux.intel.com>
CC:     <linux-usb@vger.kernel.org>, <andreas.noever@gmail.com>,
        <michael.jamet@intel.com>, <YehezkelShB@gmail.com>,
        <rajmohan.mani@intel.com>,
        <nicholas.johnson-opensource@outlook.com.au>, <lukas@wunner.de>,
        <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <anthony.wong@canonical.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless asked
 by the user
Thread-Topic: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless
 asked by the user
Thread-Index: AQHVeEzP00v40G7xFkaR9Ok+Xa9iBadF18vQgABc5AD//8mS8A==
Date:   Tue, 1 Oct 2019 16:53:54 +0000
Message-ID: <1cec43f38ccd42d9a4d9a9c86365a24a@AUSX13MPC105.AMER.DELL.COM>
References: <20191001113830.13028-1-mika.westerberg@linux.intel.com>
 <20191001113830.13028-23-mika.westerberg@linux.intel.com>
 <10cccc5a8d1a43fd9769ab6c4b53aeba@AUSX13MPC105.AMER.DELL.COM>
 <20191001145850.GZ2714@lahna.fi.intel.com>
In-Reply-To: <20191001145850.GZ2714@lahna.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-10-01T16:53:52.6773593Z;
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
 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910010142
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910010142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> Sent: Tuesday, October 1, 2019 9:59 AM
> To: Limonciello, Mario
> Cc: linux-usb@vger.kernel.org; andreas.noever@gmail.com;
> michael.jamet@intel.com; YehezkelShB@gmail.com; rajmohan.mani@intel.com;
> nicholas.johnson-opensource@outlook.com.au; lukas@wunner.de;
> gregkh@linuxfoundation.org; stern@rowland.harvard.edu;
> anthony.wong@canonical.com; linux-kernel@vger.kernel.org
> Subject: Re: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless =
asked by
> the user
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Tue, Oct 01, 2019 at 02:43:15PM +0000, Mario.Limonciello@dell.com wrot=
e:
> > > -----Original Message-----
> > > From: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Sent: Tuesday, October 1, 2019 6:39 AM
> > > To: linux-usb@vger.kernel.org
> > > Cc: Andreas Noever; Michael Jamet; Mika Westerberg; Yehezkel Bernat;
> Rajmohan
> > > Mani; Nicholas Johnson; Lukas Wunner; Greg Kroah-Hartman; Alan Stern;
> > > Limonciello, Mario; Anthony Wong; linux-kernel@vger.kernel.org
> > > Subject: [RFC PATCH 22/22] thunderbolt: Do not start firmware unless =
asked by
> the
> > > user
> > >
> > >
> > > [EXTERNAL EMAIL]
> > >
> > > Since now we can do pretty much the same thing in the software
> > > connection manager than the firmware would do, there is no point
> > > starting it by default. Instead we can just continue using the softwa=
re
> > > connection manager.
> > >
> > > Make it possible for user to switch between the two by adding a modul=
e
> > > pararameter (start_icm) which is by default false. Having this abilit=
y
> > > to enable the firmware may be useful at least when debugging possible
> > > issues with the software connection manager implementation.
> >
> > If the host system firmware didn't start the ICM, does that mean SW con=
nection
> > manager would just take over even on systems with discrete AR/TR contro=
llers?
>=20
> Yes. This is pretty much the case with Apple systems now.

Potentially if system firmware started ICM can we accomplish the same thing=
 by
resetting AR/TR that normally use ICM and then SW CM would take over?

Or is the ICM started up automatically when the controller is power cycled =
based
on something in the NVM?

I'm trying to find a way that I can usefully exercise some of this stuff on=
 pre-USB4
controllers like AR/TR/ICL-TBT.

>=20
> > >
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > ---
> > >  drivers/thunderbolt/icm.c | 14 +++++++++++---
> > >  drivers/thunderbolt/tb.c  |  4 ----
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> > > index 9c9c6ea2b790..c4a2de0f2a44 100644
> > > --- a/drivers/thunderbolt/icm.c
> > > +++ b/drivers/thunderbolt/icm.c
> > > @@ -11,6 +11,7 @@
> > >
> > >  #include <linux/delay.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/moduleparam.h>
> > >  #include <linux/pci.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/platform_data/x86/apple.h>
> > > @@ -43,6 +44,10 @@
> > >  #define ICM_APPROVE_TIMEOUT		10000	/* ms */
> > >  #define ICM_MAX_LINK			4
> > >
> > > +static bool start_icm;
> > > +module_param(start_icm, bool, 0444);
> > > +MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running
> (default:
> > > false)");
> > > +
> > >  /**
> > >   * struct icm - Internal connection manager private data
> > >   * @request_lock: Makes sure only one message is send to ICM at time
> > > @@ -1353,13 +1358,16 @@ static bool icm_ar_is_supported(struct tb *tb=
)
> > >  {
> > >  	struct pci_dev *upstream_port;
> > >  	struct icm *icm =3D tb_priv(tb);
> > > +	u32 val;
> > >
> > >  	/*
> > >  	 * Starting from Alpine Ridge we can use ICM on Apple machines
> > >  	 * as well. We just need to reset and re-enable it first.
> >
> > This comment doesn't really seem as relevant anymore.  The meaning of i=
t
> > has nothing to do with Apple anymore.
>=20
> Actually it is still relevant. For USB4 the intent is to have FW/SW CM
> switch in ACPI spec instead. But that is still under discussion.

Like read a hint from an ACPI table that indicates which one driver should =
use?

The idea being early USB4 systems would test and ship with this bit set to
FW CM and later USB4 systems can have it set to SW CM?

I like that idea, but I think that you almost want the module parameter to =
indicate
which CM you want to "use" instead so you would override what was set in AC=
PI
either way, but default to auto.

cm=3Dauto
TBT3 and less: follow NVM behavior
USB4: follow ACPI table, either use FW or SW CM.

cm=3Dicm
Start up ICM, or error out if you can't.

cm=3Dsw
Stop ICM if it's running, and initialize using kernel CM.

That would certainly allow running this across some more configurations rea=
lly easily then.

>=20
> > > +	 * However, only start it if explicitly asked by the user.
> > >  	 */
> > > -	if (!x86_apple_machine)
> > > -		return true;
> > > +	val =3D ioread32(tb->nhi->iobase + REG_FW_STS);
> > > +	if (!(val & REG_FW_STS_ICM_EN) && !start_icm)
> > > +		return false;
> >
> > This code is already in icm_firmware_start.  Maybe split it to a small =
function
> > So you can just have the more readable
> >
> > If (!icm_firmware_running(tb) && !start_icm))
>=20
> Good point. I'll do that.
