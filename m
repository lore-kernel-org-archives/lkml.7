Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01C1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2B6206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="RzE3uQcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCVyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:54:32 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:37749 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbfDCVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1554328470; x=1585864470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DbZ3Tb/koDmpGY5plQFT5CHMdwrED/2qUzFpbcuPr4A=;
  b=RzE3uQcCMeVNbNzOY9YzcjOL4YPLwKkHXFMFgtGlQwSiHb2dWnDgtAoA
   l8YjIu0MEoWrqA6RAgzTYuR1FNuMTLqu3CGmCcfHfcRJYS9UHwjRHW9m7
   BwMA9vuATGjywDUNQxqPV/YQaxp+Vmzilnw+Hmx10+HHI2NIhFYa1+e15
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EBAAC1KaVchyWd50NlGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUQUBAQEBCwGCZxFxEicKjCBfjEmJOI8HFIFnDgEBIwuEPgK?=
 =?us-ascii?q?FZzQJDQEBAwEBCQEDAgEBAhABAQEVCQgpIwyCOiIcTWsBAQEBAQEjAg1jAQE?=
 =?us-ascii?q?BAQMSZwwEAgEIEQQBAQEuIS4IAgQOBQgagwABgV0DFQ+gYD0Cb4EBiQcBAQG?=
 =?us-ascii?q?CHogCDYIaBYEvAY1IgRGDEj6CGkcEGIEUARIBbIUUA5IckxE2BwKHfog2gzw?=
 =?us-ascii?q?ilEaRZYFCjAwCBAIEBQIVgU03Z3FwgzyCJIhohT8/AQExAY1/gR+BHwEB?=
X-IPAS-Result: =?us-ascii?q?A2EBAAC1KaVchyWd50NlGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?QUBAQEBCwGCZxFxEicKjCBfjEmJOI8HFIFnDgEBIwuEPgKFZzQJDQEBAwEBC?=
 =?us-ascii?q?QEDAgEBAhABAQEVCQgpIwyCOiIcTWsBAQEBAQEjAg1jAQEBAQMSZwwEAgEIE?=
 =?us-ascii?q?QQBAQEuIS4IAgQOBQgagwABgV0DFQ+gYD0Cb4EBiQcBAQGCHogCDYIaBYEvA?=
 =?us-ascii?q?Y1IgRGDEj6CGkcEGIEUARIBbIUUA5IckxE2BwKHfog2gzwilEaRZYFCjAwCB?=
 =?us-ascii?q?AIEBQIVgU03Z3FwgzyCJIhohT8/AQExAY1/gR+BHwEB?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa5.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2019 16:54:29 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33Lrjkp090335;
        Wed, 3 Apr 2019 17:54:29 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0b-00154901.pphosted.com with ESMTP id 2rn2e1gw9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Apr 2019 17:54:29 -0400
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.60,306,1549951200"; 
   d="scan'208";a="1219483800"
From:   <Mario.Limonciello@dell.com>
To:     <dvhart@infradead.org>
CC:     <andy.shevchenko@gmail.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
Thread-Topic: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
Thread-Index: AQHU5Kj/gxMqgDyHnUGMU1hr9IeRM6YrQL0A///BDvA=
Date:   Wed, 3 Apr 2019 21:54:27 +0000
Message-ID: <643bcf131bc642cb821ba57f69707fc9@ausx13mpc120.AMER.DELL.COM>
References: <1553696734-31282-1-git-send-email-mario.limonciello@dell.com>
 <20190403202338.GB39081@wrath>
In-Reply-To: <20190403202338.GB39081@wrath>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=803 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Darren Hart <dvhart@infradead.org>
> Sent: Wednesday, April 3, 2019 3:24 PM
> To: Limonciello, Mario
> Cc: Andy Shevchenko; LKML; platform-driver-x86@vger.kernel.org
> Subject: Re: [PATCH] platform/x86: dell-laptop: fix rfkill functionality
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, Mar 27, 2019 at 09:25:34AM -0500, Mario Limonciello wrote:
> > When converting the driver two arguments were transposed leading
> > to rfkill not working.
> >
> > BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D201427
> > Reported-by: Pepijn de Vos <pepijndevos@gmail.com>
> > Fixes: 549b49 ("platform/x86: dell-smbios: Introduce dispatcher for SMM=
 calls")
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > Acked-by: Pali Roh=E1r <pali.rohar@gmail.com>
>=20
> Looks like this broken in 4.14? So Cc stable back to then? I'm surprised =
it's
> been broken that long :-(
>=20

Not many "newer" platforms actually use this radio control anymore.  It's b=
een
superseded by other technologies.  So I think that would be the main reason=
.

Can you CC it to stable when it's committed or do I need to re-send or anyt=
hing?
