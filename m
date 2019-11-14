Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F731C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4612D2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="sGJtJ6df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKNSuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:50:25 -0500
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:29524 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbfKNSuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:50:25 -0500
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEIeMBw017965;
        Thu, 14 Nov 2019 13:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=sZFGNfZ2DG3LR7lUZjUFvxpuyRguwkKOcS+Q4/EZkXo=;
 b=sGJtJ6dfJ7jtJB6ScanNIBbtSuA0azwzK//bRHmDlaG1IgxR7X9BGJ72ctvfg5iulF7F
 0C6fSmTRy6K8a1xmIxdoo1g8GH1xhdiscDIuOamSQndbawmdGq/IOQe6YkD83quCK6+H
 bvb5cUFsYRqng2ngucacSXl0KToryuUcB5XgPt/IRUaypwprpOPF2HFw8u6vL9qP2xOg
 Wzrg5D7Hh2NNfJyRqoYdd0LMdnN/pJxvXlOUCbDaOstOP4l44KRa9gw8IP376WycVRY9
 FXlGrqYHuI/x3uV+uv1AQriLY4xMHtRZR8n2beDi6POYpO4MseM1m9yD1QdTQZfTTCMo jQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2w7pqcdvsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 13:50:24 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEIceVf191639;
        Thu, 14 Nov 2019 13:50:23 -0500
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0b-00154901.pphosted.com with ESMTP id 2w91u9kp36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 13:50:22 -0500
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="487653472"
From:   <Mario.Limonciello@dell.com>
To:     <gayatri.kammela@intel.com>, <platform-driver-x86@vger.kernel.org>
CC:     <vishwanath.somayaji@intel.com>, <dvhart@infradead.org>,
        <linux-kernel@vger.kernel.org>, <charles.d.prestopine@intel.com>,
        <peterz@infradead.org>, <srinivas.pandruvada@intel.com>,
        <andriy.shevchenko@linux.intel.com>, <kan.liang@intel.com>,
        <david.e.box@intel.com>, <rajneesh.bhardwaj@intel.com>,
        <tony.luck@intel.com>
Subject: RE: [PATCH v3 7/7] platform/x86: Add Comet Lake (CML) platform
 support to intel_pmc_core driver
Thread-Topic: [PATCH v3 7/7] platform/x86: Add Comet Lake (CML) platform
 support to intel_pmc_core driver
Thread-Index: AQHVmw07yStVNeDMPEaQYhzmHi5q/KeLAfQg
Date:   Thu, 14 Nov 2019 18:50:20 +0000
Message-ID: <3acd91d2694c456da2af7256ed1dcf9c@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1573750525.git.gayatri.kammela@intel.com>
 <d43af9c7b3c536c489cdb925adb2204256099952.1573750525.git.gayatri.kammela@intel.com>
In-Reply-To: <d43af9c7b3c536c489cdb925adb2204256099952.1573750525.git.gayatri.kammela@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-11-14T18:50:18.5668120Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=991 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140157
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911140157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Gayatri Kammela
> Sent: Thursday, November 14, 2019 11:01 AM
> To: platform-driver-x86@vger.kernel.org
> Cc: vishwanath.somayaji@intel.com; dvhart@infradead.org; linux-
> kernel@vger.kernel.org; charles.d.prestopine@intel.com; Gayatri Kammela; =
Peter
> Zijlstra; Srinivas Pandruvada; Andy Shevchenko; Kan Liang; David E . Box;=
 Rajneesh
> Bhardwaj; Tony Luck
> Subject: [PATCH v3 7/7] platform/x86: Add Comet Lake (CML) platform suppo=
rt to
> intel_pmc_core driver
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Add Comet Lake to the list of the platforms that intel_pmc_core driver
> supports for pmc_core device.
>=20
> Just like Ice Lake, Tiger Lake and Elkhart Lake, Comet Lake can also
> reuse all the Cannon Lake PCH IPs. No additional effort is needed to
> enable but to simply reuse them.
>=20
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Kan Liang <kan.liang@intel.com>
> Cc: David E. Box <david.e.box@intel.com>
> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/platform/x86/intel_pmc_core.c
> b/drivers/platform/x86/intel_pmc_core.c
> index 94081710e0de..a9b33ac4e52d 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -165,6 +165,7 @@ static const struct pmc_reg_map spt_reg_map =3D {
>=20
>  /* Cannon Lake: PGD PFET Enable Ack Status Register(s) bitmap */
>  static const struct pmc_bit_map cnp_pfear_map[] =3D {
> +	/* Reserved for Cannon Lake but valid for Comet Lake */
>  	{"PMC",                 BIT(0)},
>  	{"OPI-DMI",             BIT(1)},
>  	{"SPI/eSPI",            BIT(2)},
> @@ -879,6 +880,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] =
=3D {
>  	INTEL_CPU_FAM6(TIGERLAKE_L, tgl_reg_map),
>  	INTEL_CPU_FAM6(TIGERLAKE, tgl_reg_map),
>  	INTEL_CPU_FAM6(ATOM_TREMONT, tgl_reg_map),
> +	INTEL_CPU_FAM6(COMETLAKE, cnp_reg_map),
> +	INTEL_CPU_FAM6(COMETLAKE_L, cnp_reg_map),
>  	{}
>  };
>=20

Just a nit, that I'm not sure if there is a policy around.
Shouldn't the order of these reflect the actual order they're available to =
the
marketplace?  So CML may want to come earlier in the patch series to reflec=
t
that aspect.

