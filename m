Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLACK autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E922081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=dell.com header.i=@dell.com header.b="rqpfRlj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfCGXO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:14:27 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:59354 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726172AbfCGXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1552000466; x=1583536466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=63xsQBaVlqCrS5f8YNGnAuaHYyKeT8FqQmjINiy7uJo=;
  b=rqpfRlj0b4aMky6fXMJAZ/zLWHfZzHBiPFMMSdaV/u+dtkZ9NK+MA5rD
   gtzKuB6gNEtO/8w2y1qZgrdW+QdzR2PB8WaGheYwuT1GPK8ZKeyTQrR0f
   HDnIx32sF4DzOdBuNEu0OxVU7NxUa/sWJ3aQiOr8HYD7FM+gy1wlQ16h0
   E=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EFAAAnpYFchyWd50NkGgEBAQEBAgE?=
 =?us-ascii?q?BAQEHAgEBAQGBUgQBAQEBCwGCZoECEicKjHiMW5gjFIFnCwEBGIRUAoRYNQg?=
 =?us-ascii?q?NAQEDAQEHAQMCAQECEAEBARUJCCkvgjoigm8BAQEBAgEBESg/DAQCAQgRBAE?=
 =?us-ascii?q?BHxAoJwgCBAENBQgagwCBbgifCj0Cb4EBiQcBAQGCHooogS8BjUGBEYMShE4?=
 =?us-ascii?q?BEgGGAAKMHZd4BwKOTYQwIZM1LYpEkjgCBAIEBQIUgUgBNWdxcIM8ghYOCY4?=
 =?us-ascii?q?eQAExi0CBH4EfAQE?=
X-IPAS-Result: =?us-ascii?q?A2EFAAAnpYFchyWd50NkGgEBAQEBAgEBAQEHAgEBAQGBU?=
 =?us-ascii?q?gQBAQEBCwGCZoECEicKjHiMW5gjFIFnCwEBGIRUAoRYNQgNAQEDAQEHAQMCA?=
 =?us-ascii?q?QECEAEBARUJCCkvgjoigm8BAQEBAgEBESg/DAQCAQgRBAEBHxAoJwgCBAENB?=
 =?us-ascii?q?QgagwCBbgifCj0Cb4EBiQcBAQGCHooogS8BjUGBEYMShE4BEgGGAAKMHZd4B?=
 =?us-ascii?q?wKOTYQwIZM1LYpEkjgCBAIEBQIUgUgBNWdxcIM8ghYOCY4eQAExi0CBH4EfA?=
 =?us-ascii?q?QE?=
Received: from mx0b-00154901.pphosted.com (HELO mx0a-00154901.pphosted.com) ([67.231.157.37])
  by esa6.dell-outbound.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2019 17:14:25 -0600
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x27N7uoZ020290;
        Thu, 7 Mar 2019 18:14:24 -0500
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0b-00154901.pphosted.com with ESMTP id 2r35hg2q31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Mar 2019 18:14:24 -0500
From:   <Mario.Limonciello@dell.com>
Received: from ausxipps306.us.dell.com ([143.166.148.156])
  by esa4.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA256; 08 Mar 2019 05:14:22 +0600
X-LoopCount0: from 10.166.132.169
X-IronPort-AV: E=Sophos;i="5.58,453,1544508000"; 
   d="scan'208";a="281673644"
To:     <jiaxun.yang@flygoat.com>, <ibm-acpi@hmh.eng.br>
CC:     <dvhart@infradead.org>, <andy@infradead.org>,
        <ibm-acpi-devel@lists.sourceforge.net>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
Thread-Topic: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
 machines
Thread-Index: AQHU1L3R7XMaBHjarE+WkPyjavlri6YAzRxQ
Date:   Thu, 7 Mar 2019 23:14:21 +0000
Message-ID: <28af3c22ad144cf69284aa6f91ee6565@ausx13mpc124.AMER.DELL.COM>
References: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
In-Reply-To: <20190307080820.9723-1-jiaxun.yang@flygoat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-07_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903070152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 -----Original Message-----
> From: platform-driver-x86-owner@vger.kernel.org <platform-driver-x86-
> owner@vger.kernel.org> On Behalf Of Jiaxun Yang
> Sent: Thursday, March 7, 2019 2:08 AM
> To: ibm-acpi@hmh.eng.br
> Cc: dvhart@infradead.org; andy@infradead.org; ibm-acpi-
> devel@lists.sourceforge.net; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Jiaxun Yang
> Subject: [PATCH] platform/x86: thinkpad_acpi: disable bluetooth for some
> machines
>=20
>=20
> [EXTERNAL EMAIL]
>=20
> Some AMD based ThinkPads have a firmware bug that calling
> "GBDC" will cause bluetooth on Intel wireless cards blocked.

Since this is considered a firmware bug; has the OEM (and IBV) been notifie=
d?  Is it
fixed in a newer version of the firmware?

If so, then this should probably only match particular broken firmware vers=
ions.

>=20
> Probe these models by DMI match and disable bluetooth subdriver
> if specified Intel wireless card exist.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 70 ++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c
> b/drivers/platform/x86/thinkpad_acpi.c
> index 726341f2b638..29e835f9368a 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -79,6 +79,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/workqueue.h>
>  #include <linux/acpi.h>
> +#include <linux/pci.h>
>  #include <linux/pci_ids.h>
>  #include <linux/power_supply.h>
>  #include <sound/core.h>
> @@ -4501,11 +4502,80 @@ static void bluetooth_exit(void)
>  	bluetooth_shutdown();
>  }
>=20
> +static const struct dmi_system_id bt_fwbug_list[] __initconst =3D {
> +	{
> +		.ident =3D "ThinkPad E485",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20KU"),
> +		},
> +	},
> +	{
> +		.ident =3D "ThinkPad E585",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20KV"),
> +		},
> +	},
> +	{
> +		.ident =3D "ThinkPad A285 - 20MW",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20MW"),
> +		},
> +	},
> +	{
> +		.ident =3D "ThinkPad A285 - 20MX",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20MX"),
> +		},
> +	},
> +	{
> +		.ident =3D "ThinkPad A485 - 20MU",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20MU"),
> +		},
> +	},
> +	{
> +		.ident =3D "ThinkPad A485 - 20MV",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_BOARD_NAME, "20MV"),
> +		},
> +	},
> +	{}
> +};
> +
> +static int __init have_bt_fwbug(void)
> +{
> +	/* Some AMD based ThinkPads have a firmware bug that calling
> +	 * "GBDC" will cause bluetooth on Intel wireless cards blocked
> +	 */
> +	if (dmi_check_system(bt_fwbug_list)) {
> +		if (pci_get_device(PCI_VENDOR_ID_INTEL, 0x24F3, NULL) || \
> +		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x24FD, NULL) || \
> +		    pci_get_device(PCI_VENDOR_ID_INTEL, 0x2526, NULL))
> +			return 1;
> +		else
> +			return 0;
> +	} else {
> +			return 0;
> +	}
> +}
> +
>  static int __init bluetooth_init(struct ibm_init_struct *iibm)
>  {
>  	int res;
>  	int status =3D 0;
>=20
> +	if (have_bt_fwbug()) {
> +		vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
> +			FW_BUG "disable bluetooth subdriver for Intel cards\n");
> +		return 1;
> +	}
> +
>  	vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
>  			"initializing bluetooth subdriver\n");
>=20
> --
> 2.20.1

