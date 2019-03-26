Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E512C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603D520823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="hxDQVLio"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbfCZTxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:53:00 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:65280 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730605AbfCZTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1553629954; x=1585165954;
  h=from:cc:to:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fq5SxuMOtRUTbnyMNSL2EHU4TvTVFvwas2ChAyC4nrg=;
  b=hxDQVLio17hY4ma/d6UOJVhdPteB7pllBVKl0aSYEpHgC+lBMlsqSomS
   tsRSk5AiJJyCfOiolGeexVbJZU/ZOIHMR6GPIFMugW8rcDfQt965Qc/RA
   SgaTvCpN187L1CCsfaTHKhb17p7Y3e11Vv5GYCSW2K1OICCF1Ixtn4x+Y
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E5AAC6PJpchyeV50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBZQKCZoEUJwqMf4xTmE+BEANUDQEBhGwChSMiOBIBAQMBAQk?=
 =?us-ascii?q?BAwIBAQIQAQEBCgsJCCkvQgEOAYFoIoJvAQEBBBIoPwwEAgEIEQMBAQEfEE8?=
 =?us-ascii?q?IAgQTCBqDAIF2oRg9Am+BAYkHAQEBgh6KM4EvAYsxghaBEYMSPoQRARIBCGS?=
 =?us-ascii?q?FFAOMRJhVBwKTMyGUAi2eIgIEAgQFAhWBZFcwcXCDPIIkjidAATGKNYNJgR+?=
 =?us-ascii?q?BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2E5AAC6PJpchyeV50NkGgEBAQEBAgEBAQEHAgEBAQGBZ?=
 =?us-ascii?q?QKCZoEUJwqMf4xTmE+BEANUDQEBhGwChSMiOBIBAQMBAQkBAwIBAQIQAQEBC?=
 =?us-ascii?q?gsJCCkvQgEOAYFoIoJvAQEBBBIoPwwEAgEIEQMBAQEfEE8IAgQTCBqDAIF2o?=
 =?us-ascii?q?Rg9Am+BAYkHAQEBgh6KM4EvAYsxghaBEYMSPoQRARIBCGSFFAOMRJhVBwKTM?=
 =?us-ascii?q?yGUAi2eIgIEAgQFAhWBZFcwcXCDPIIkjidAATGKNYNJgR+BHwEB?=
Received: from mx0a-00154901.pphosted.com ([67.231.149.39])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2019 14:52:33 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QGs3IE149357;
        Tue, 26 Mar 2019 15:52:58 -0400
Received: from esa3.dell-outbound2.iphmx.com (esa3.dell-outbound2.iphmx.com [68.232.154.63])
        by mx0a-00154901.pphosted.com with ESMTP id 2rfnght6p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Mar 2019 15:52:57 -0400
From:   <Mario.Limonciello@dell.com>
Cc:     <linux-usb@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hayeswang@realtek.com>,
        <sjg@google.com>, <campello@google.com>, <Ryan.Hong@Dell.com>,
        <Crag.Wang@dell.com>
Received: from ausxippc106.us.dell.com ([143.166.85.156])
  by esa3.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 27 Mar 2019 01:52:37 +0600
X-LoopCount0: from 10.166.135.95
X-IronPort-AV: E=Sophos;i="5.60,274,1549951200"; 
   d="scan'208";a="374164227"
To:     <davem@davemloft.net>
Subject: RE: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
Thread-Topic: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
Thread-Index: AQHU4xTHuLEGWwasfk+zBAknUygSNqYel1KA//+9ILA=
Date:   Tue, 26 Mar 2019 19:52:50 +0000
Message-ID: <f1d2f070fd124fe3bc83a7d6535a61ef@ausx13mpc120.AMER.DELL.COM>
References: <1553523143-23072-1-git-send-email-mario.limonciello@dell.com>
 <20190326.115051.1713861149387592628.davem@davemloft.net>
In-Reply-To: <20190326.115051.1713861149387592628.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Miller <davem@davemloft.net>
> Sent: Tuesday, March 26, 2019 1:51 PM
> To: Limonciello, Mario
> Cc: linux-usb@vger.kernel.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; hayeswang@realtek.com; sjg@google.com;
> campello@google.com; Hong, Ryan; Wang, Crag
> Subject: Re: [PATCH] r8152: Refresh MAC address during USBDEVFS_RESET
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> From: Mario Limonciello <mario.limonciello@dell.com>
> Date: Mon, 25 Mar 2019 09:12:23 -0500
>=20
> > On some platforms it is possible to dynamically change the policy
> > of what MAC address is selected from the ASL at runtime.
> >
> > These tools will reset the USB device and expect the change to be
> > made immediately.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>=20
> You are going to have to emit CHANGEADDR notifications and such if
> necessary when you do this.

Thanks for the feedback, I'll add that call.  Do you feel a need that the M=
AC
address needs to be tracked and compared to what was previously in ACPI
table to know it "really" changed or just emit CHANGEADDR because it "might=
"
have changed?
