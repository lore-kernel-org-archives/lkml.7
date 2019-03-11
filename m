Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47A6214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k+Tahy/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfCKUZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:25:57 -0400
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:43972
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728117AbfCKUZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFfzFY182PyRetnhDtSYR09rqH1k3Z7kLlNDp4NM5Jw=;
 b=k+Tahy/WkoKF/2SlNtpxxdrWwlvzqAzUAC1kgkoMXJSMIPr745wuEaWsKiw1Ef3AFxMcUYmmuimDantXC2w05LPebIaqhPIOplXZNgpbcXw3xl0jr0OMiQU8SOY7jzsWzhfHdO2Gt+/3iAwmqr2OSnsKgP8YLaknEGZbsQlfWdQ=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2798.namprd12.prod.outlook.com (52.135.107.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Mon, 11 Mar 2019 20:25:53 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 20:25:53 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>
Subject: RE: [PATCH] x86, mce: Fix machine_check_poll() tests for which errors
 to log
Thread-Topic: [PATCH] x86, mce: Fix machine_check_poll() tests for which
 errors to log
Thread-Index: AQHU2DtsQDXo+RWhv0y/sb6komHrxqYG4DzQ
Date:   Mon, 11 Mar 2019 20:25:53 +0000
Message-ID: <SN6PR12MB26399CBAEFB6C500D456255DF8480@SN6PR12MB2639.namprd12.prod.outlook.com>
References: <20190311185118.32667-1-tony.luck@intel.com>
In-Reply-To: <20190311185118.32667-1-tony.luck@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-originating-ip: [165.204.84.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 183d8aa7-ec0e-4e73-1d56-08d6a65fc260
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2798;
x-ms-traffictypediagnostic: SN6PR12MB2798:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2798;20:YzoxRBzU1FGBGp4POkWJUyx/DC0EYAP1FE4GsmCIRV97SlTcapf4mMHi+eMOLzhYUxte74XE7X4kmzNbo2a2GjsOvdrakKbvpyMWLbEcobOBjl3ZlBveVM7Oxn4N09rHOkDHGmjOn+qctGSH+inE6J6+wufvsqtSa0pYeliwP9uL/Qd11iLHMVvq650xWtY7g6RBGhV5jz8zQseZvSnsHY9C9Qcme2R/jKwBvdUndu9EcIaIWyZk35QnBEFAqMp6
x-microsoft-antispam-prvs: <SN6PR12MB27984E60BA4D8807B85F3D5CF8480@SN6PR12MB2798.namprd12.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(13464003)(189003)(199004)(4326008)(6506007)(74316002)(53546011)(478600001)(6116002)(9686003)(53936002)(81166006)(6246003)(8936002)(81156014)(7696005)(3846002)(2906002)(102836004)(305945005)(99286004)(66066001)(76176011)(229853002)(14454004)(25786009)(68736007)(52536013)(186003)(55016002)(97736004)(476003)(72206003)(11346002)(105586002)(7736002)(446003)(33656002)(71190400001)(54906003)(110136005)(486006)(71200400001)(26005)(8676002)(6436002)(5660300002)(316002)(256004)(86362001)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2798;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0Ngrie0q8rmKKOEHoDPUJJvsUkRTh+pfNLzbJFcEfr7zAsKQQKEv2zS8ULxi6dY83Qd/YD0vuuSrM4SffmzlBUbRr68kqs+uYuv7NK+QAoQ69wH8Xz/q+QcEWpiXgEAcce91C50NbX4t/ArOsL9C20LZ/PURNzCifxFKMHTRai2XwCkA5r2HLIryT9hcdOYMakD8P5hC3um/J2AWXh/k358N6UEkchxWKH5sMV5claQbMp81MepetygR7OTTTNsPPompZ9AurBaKPJzOPBWWu2qNm6DlDsahFT+yRwnGWp6iHddCbvsqyI0nU+dJd7G2JHrUo9ihCLOQmDMe/v6J2EHn7FsEVR6jHbHAj0/QtNCOOyrUdfdYJC8nKPzyDNgMd7+I2ikGJMNqWpJ2hsoKjIP3yDMHYO6ipPjhBtYKSL4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 183d8aa7-ec0e-4e73-1d56-08d6a65fc260
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 20:25:53.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2798
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Tony Luck
> Sent: Monday, March 11, 2019 1:51 PM
> To: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>; x86@kernel.org; linux-kernel@vger.ke=
rnel.org; Ashok Raj <ashok.raj@intel.com>
> Subject: [PATCH] x86, mce: Fix machine_check_poll() tests for which error=
s to log
>=20
> There has been a lurking "TBD" in the machine check poll routine ever
> since it was first split out from the machine check handler. The potentia=
l
> issue is that the poll routine may have just begun a read from the STATUS
> register in a machine check bank when the hardware logs an error in that
> bank and signals a machine check. That race used to be pretty small back
> when machine checks were broadcast, but the addition of local machine che=
ck
> means that the poll code could continue running and clear the error from =
the
> bank before the local machine check handler on another CPU gets around to
> reading it.
>=20
> Fix the code to be sure to only process errors that need to be processed
> in the poll code, leaving other logged errors alone for the machine check
> handler to find and process.
>=20
> Fixes: b79109c3bbcf ("x86, mce: separate correct machine check poller and=
 fatal exception handler")
> Fixes: ed7290d0ee8f ("x86, mce: implement new status bits")
> Reported-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 42 ++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/cor=
e.c
> index 6ce290c506d9..806551b381ae 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -712,19 +712,47 @@ bool machine_check_poll(enum mcp_flags flags, mce_b=
anks_t *b)
>=20
>  		barrier();
>  		m.status =3D mce_rdmsrl(msr_ops.status(i));
> +
> +		/* If this entry is not valid, ignore it */
>  		if (!(m.status & MCI_STATUS_VAL))
>  			continue;
>=20
>  		/*
> -		 * Uncorrected or signalled events are handled by the exception
> -		 * handler when it is enabled, so don't process those here.
> -		 *
> -		 * TBD do the same check for MCI_STATUS_EN here?
> +		 * If we are logging everything (at CPU online) or this
> +		 * is a corrected error, then we must log it.
>  		 */
> -		if (!(flags & MCP_UC) &&
> -		    (m.status & (mca_cfg.ser ? MCI_STATUS_S : MCI_STATUS_UC)))
> -			continue;
> +		if ((flags & MCP_UC) || (m.status & MCI_STATUS_UC) =3D=3D 0)
> +			goto log_it;
> +
> +		/*
> +		 * Older systems that do not support software error recovery
> +		 * should skip over uncorrected errors, but log everything else
> +		 */
> +		if (!mca_cfg.ser) {
> +			if (m.status & MCI_STATUS_UC)
> +				continue;
> +			goto log_it;
> +		}
> +
> +		/* Log "not enabled" (speculative) errors */
> +		if (!(m.status & MCI_STATUS_EN))
> +			goto log_it;
> +
> +		/*
> +		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
> +		 * UC =3D=3D 1 && PCC =3D=3D 0 && S =3D=3D 0
> +		 */
> +		if (!(m.status & MCI_STATUS_PCC) && !(m.status & MCI_STATUS_S))
> +			goto log_it;
> +

Can you please include a vendor check with this? MCi_STATUS[56] is not defi=
ned the same way on AMD systems.

Thanks,
Yazen

