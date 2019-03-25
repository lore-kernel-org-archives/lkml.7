Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB85C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB5E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="qZzO0JNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfCYNbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:31:00 -0400
Received: from esa7.dell-outbound.iphmx.com ([68.232.153.96]:42740 "EHLO
        esa7.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725355AbfCYNbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:31:00 -0400
X-Greylist: delayed 501 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 09:30:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1553520647; x=1585056647;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ROyksJjAvcYlTiTuuvmd0UTkcb9Pd1gejylKjq4GPA=;
  b=qZzO0JNVTa6P0C8tYabMAZ5EgQ7K+ENOYh0WmB5eLMSQkEgyxmW6vTLp
   QKXHASv2TFaDnOiW1yEmf7cRnlLgx80vk0TCTUyPpdrvYKazOrkxlTlY5
   bdE1bhVKS7YeG7DFz4FRsQhw6TWgIGNHXDswe7/vLZcJ3hsYdek0YgOxE
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EJAADz1JhchyeV50NjGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBVAIBAQEBCwGCZ4ECEicKjH+MTok3jxeBZw0BAYRsAoU0NwY?=
 =?us-ascii?q?NAQEDAQEJAQMCAQECEAEBAQoLCQgpL4I6IoJvAQEBAQMSZwwEAgEIEQQBAQE?=
 =?us-ascii?q?uIS4IAgQBDQUIGoMAgV4DFaFwPQJvgQGJBwEBAYIeh3wNgh+BLwGNR4QjPoI?=
 =?us-ascii?q?agXcBEgGGAAOKModGgR2RSzYHAo96gzchk34tim+HP4trAgQCBAUCFYFjgQh?=
 =?us-ascii?q?xcIM8ghYOCY4eQAExjWiBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EJAADz1JhchyeV50NjGgEBAQEBAgEBAQEHAgEBAQGBV?=
 =?us-ascii?q?AIBAQEBCwGCZ4ECEicKjH+MTok3jxeBZw0BAYRsAoU0NwYNAQEDAQEJAQMCA?=
 =?us-ascii?q?QECEAEBAQoLCQgpL4I6IoJvAQEBAQMSZwwEAgEIEQQBAQEuIS4IAgQBDQUIG?=
 =?us-ascii?q?oMAgV4DFaFwPQJvgQGJBwEBAYIeh3wNgh+BLwGNR4QjPoIagXcBEgGGAAOKM?=
 =?us-ascii?q?odGgR2RSzYHAo96gzchk34tim+HP4trAgQCBAUCFYFjgQhxcIM8ghYOCY4eQ?=
 =?us-ascii?q?AExjWiBH4EfAQE?=
Received: from mx0a-00154901.pphosted.com (HELO mx0b-00154901.pphosted.com) ([67.231.149.39])
  by esa7.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Mar 2019 08:21:45 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PDJ3pf111971
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:22:37 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2rewragst4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:22:37 -0400
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps301.us.dell.com ([143.166.148.223])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 25 Mar 2019 19:22:36 +0600
X-LoopCount0: from 10.166.132.190
X-IronPort-AV: E=Sophos;i="5.60,269,1549951200"; 
   d="scan'208";a="313004579"
To:     <rostedt@goodmis.org>, <tzanussi@gmail.com>
CC:     <pali.rohar@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: RE: dell_smbios KASAN bug
Thread-Topic: dell_smbios KASAN bug
Thread-Index: AQHU30rc/MYxSW6xVki94Qbql+mk96YVLl8AgAAGuYCAAAJBgIAHJYnQ
Date:   Mon, 25 Mar 2019 13:22:35 +0000
Message-ID: <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
References: <1553106560.2080.5.camel@gmail.com>
        <20190320144146.08ecd5e4@gandalf.local.home>
        <1553108749.2079.1.camel@gmail.com>
 <20190320151353.1a223c0e@gandalf.local.home>
In-Reply-To: <20190320151353.1a223c0e@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903250099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Steven Rostedt <rostedt@goodmis.org>
> Sent: Wednesday, March 20, 2019 2:14 PM
> To: Tom Zanussi
> Cc: Pali Roh=E1r; Limonciello, Mario; linux-kernel@vger.kernel.org
> Subject: Re: dell_smbios KASAN bug
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> On Wed, 20 Mar 2019 14:05:49 -0500
> Tom Zanussi <tzanussi@gmail.com> wrote:
>=20
> > On Wed, 2019-03-20 at 14:41 -0400, Steven Rostedt wrote:
> > > On Wed, 20 Mar 2019 13:29:20 -0500
> > > Tom Zanussi <tzanussi@gmail.com> wrote:
> > >
> > > > Hi,
> > > >
> > > > While looking into an unrelated problem, I hit this KASAN use-
> > > > after-
> > > > free warning, so thought I'd let you know.
> > > >
> > > > I have no idea how to fix it, but let me know if you need more
> > > > info.
> > > >
> > >
> > > Could you run with debug in the kernel command line, and see if you
> > > hit
> > > any failed messages from the dell_smbios_init() call?
> > >
> >
> > Not much, but this looks relevant:
> >
> > [   26.783749] dell_smbios: No SMBIOS backends available (wmi: -19,
> > smm: -19)
> > [   26.963648] dell_smbios: No dell-smbios drivers are loaded
> >
>=20
> And does this fix you problem?
>=20
> -- Steve
>=20
> diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x=
86/dell-
> smbios-base.c
> index 9dc282ed5a9e..c3825c674522 100644
> --- a/drivers/platform/x86/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell-smbios-base.c
> @@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
>=20
>  fail_platform_driver:
>  	kfree(da_tokens);
> +	da_num_tokens =3D 0;
>  	return ret;
>  }
>=20

Steven,

Since Tom confirmed this works will you send a formal patch to the ML with =
this fix?

Thanks,
