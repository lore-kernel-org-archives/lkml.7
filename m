Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814ADC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D824218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="QcjSz+Lc";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="DxN2j7+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfCTOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:49:03 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60780 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbfCTOtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:49:03 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2KEfI9K002823;
        Wed, 20 Mar 2019 07:48:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=1t5/vJWVGDj7VV2LHpgiwYm4EnFNtY7tFccjZgh/34I=;
 b=QcjSz+Lc9Z+X8N7aPxC4qyoXd1V8cXj3dQD49emB0YwzjuNEZSV0J2HXTJwxVkvUgKrK
 L2LBQeEHEvms7SpMR/O5VrOOpdT9x7rNQkPJEqSnGj/1gyZcA5/GPo8AybtukjzB0wg+
 gaSj83xVEO2zfi0bvDHq8V8dI7cfE6ita9BPg09VMUTA0Z4P8z0L7uTX38mZaVcTD1Nd
 gnPGUwWqIBwMbGsW9bFDSrSpbJpd6IjzAC94rwtASqeRUbfa1PHh4FtBko2WAc8Xqfqc
 NO57lS+F9VjosS8FIXn46LiUv5e6Xx2B0Tvnj3qYcxMNxoqhCzH0PHstBYpC2iB9WzX+ iw== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2rbjvm0y2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 20 Mar 2019 07:48:47 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 20 Mar
 2019 07:48:36 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.52) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 20 Mar 2019 07:48:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t5/vJWVGDj7VV2LHpgiwYm4EnFNtY7tFccjZgh/34I=;
 b=DxN2j7+aHI0CyoQZvCoDhNyDRfnoGiQkwMFgmrFutP0kP/ZEggHTCOHWqNw+WtGM116d/uli36PbR3De/8Y27WKKbZy1TJ8rjCID1oTlbz8J7jMXHUEI0/7NoE0pVblp3LOuVWhQJt4KVgsYBBxDOtJDvI9JY4Nh5MbrxR90n/8=
Received: from BL0PR18MB2305.namprd18.prod.outlook.com (52.132.30.25) by
 BL0PR18MB2195.namprd18.prod.outlook.com (52.132.29.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 14:48:34 +0000
Received: from BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6]) by BL0PR18MB2305.namprd18.prod.outlook.com
 ([fe80::d42:95e4:7e1c:76b6%5]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 14:48:34 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     Marcin Benka <mbenka@marvell.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>
Subject: Re: [PATCH] efi: Unify dmi setup code over architectures arm/arm64,
 io64 and x86
Thread-Topic: [PATCH] efi: Unify dmi setup code over architectures arm/arm64,
 io64 and x86
Thread-Index: AQHU3x8X2rcfIh633keoeruImJvrSKYUmbYA
Date:   Wed, 20 Mar 2019 14:48:34 +0000
Message-ID: <20190320144828.a7iui7v5cwt45myr@rric.localdomain>
References: <20190320130502.16667-1-rrichter@marvell.com>
 <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
In-Reply-To: <20190320131607.vgst3r7ynha55ikw@rric.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0601CA0044.eurprd06.prod.outlook.com
 (2603:10a6:203:68::30) To BL0PR18MB2305.namprd18.prod.outlook.com
 (2603:10b6:207:43::25)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [77.191.24.140]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: beb5459f-8eb4-4a66-4bde-08d6ad432072
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR18MB2195;
x-ms-traffictypediagnostic: BL0PR18MB2195:
x-microsoft-antispam-prvs: <BL0PR18MB21951F7750D7149F763C12D5D9410@BL0PR18MB2195.namprd18.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(396003)(376002)(189003)(199004)(76176011)(14454004)(476003)(99286004)(6506007)(305945005)(7416002)(7736002)(386003)(3846002)(26005)(53546011)(102836004)(6116002)(478600001)(446003)(86362001)(25786009)(52116002)(486006)(186003)(11346002)(4326008)(81156014)(110136005)(97736004)(8676002)(2501003)(81166006)(5660300002)(71190400001)(6436002)(316002)(4744005)(1076003)(105586002)(53936002)(6486002)(68736007)(106356001)(6512007)(229853002)(71200400001)(66066001)(9686003)(54906003)(256004)(6246003)(8936002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR18MB2195;H:BL0PR18MB2305.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hjSqZ+Ei9i6Tl4F3Lf8pAM0HtLzriDruWziROd5OeFyP0IpLAL9QamfCcHvwYPvlsmh7eQdgRAGEtAybrR/i00SwfWEIt7pYRZtjlbYnct+NXf3HoXOZN1flC6tmqFZ/lYzIZwmiKu3KL44ZeroJylm5u3Y+4abxEOtQkfi5hSPcpEoSBMXxC7iia+be9L7IAOYOsmw7pQkECvGdCf653fu1+oxKEhOee4mD9GIGuBv9ZaNOtXPPaUnkJh5A1U9K1Ht1dT8Czp+U3UYP9aHel+gv5rUIoTwjBkzjT8pxy7ixnJPDFguXm50VNXr6X8PDK2JIwxvSq2SaD1HvCCdhT7nY1ZA4u4mD+CZyd39ti7BdfWR4M+oo63ZYxIDaP8lJUShTfQmCuPxVfAP+43eu4Qbp4Fk8KASgAC6l5otZk0g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91E9DFF65CD8DA40980FD4A23D35FDB4@namprd18.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: beb5459f-8eb4-4a66-4bde-08d6ad432072
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 14:48:34.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB2195
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-20_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.19 13:16:13, Robert Richter wrote:

> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/ar=
m-runtime.c
> index 4a0dfe4ab829..c250b767030e 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -162,14 +162,10 @@ void efi_virtmap_unload(void)
>  static int __init arm_dmi_init(void)
>  {
>  	/*
> -	 * On arm64/ARM, DMI depends on UEFI, and dmi_scan_machine() needs to
> +	 * On arm64/ARM, DMI depends on UEFI, and dmi_setup() needs to
>  	 * be called early because dmi_id_init(), which is an arch_initcall
>  	 * itself, depends on dmi_scan_machine() having been called already.
>  	 */
> -	dmi_scan_machine();
> -	dmi_memdev_walk();
> -	if (dmi_available)
> -		dmi_set_dump_stack_arch_desc();

This went wrong in the last stage of a comment rework. A dmi_setup()
should be here. Will resubmit. Sorry.

-Robert

>  	return 0;
>  }
