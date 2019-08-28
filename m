Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32EDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773F92339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 23:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oaMw+YOD";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YgW2TBec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfH1XEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 19:04:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726896AbfH1XEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 19:04:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7SMltLu022592;
        Wed, 28 Aug 2019 16:03:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vgiCeqdoQWJ9lUz99JBHW5G97YEQ/nRUwnldWcHZG2w=;
 b=oaMw+YOD6k7EA24If0G/iGoa8kPlLXBhDmOlH5vg5AnrkGWexTU4WevEBXX8HA7GQ5k8
 NfgXfgF8w/mA8vDMUoSzBw/OzQcR23Q0ncjG8gvXke3EIKC93jBvXFomcBRpGG0nplOT
 iVEov6uA69b/KJ2vUXK7zNlmBER43FhvcAI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2une015cca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 28 Aug 2019 16:03:06 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 28 Aug 2019 16:03:04 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 28 Aug 2019 16:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqxVRQ2F2zPhjGJy/t+V1Znldcbb6fo+Wkg6azUot1ZehKpqWcESvebf1ZhMagpLVqRnfNlhDpDpOs20SHTjZCSjpzuhvj+adrsr1tk5ncbfDlP2by+I/+xHqOqJuUAdBFMmNkKRmLIDFQwpOSkw4GToAC/kyrj8Y3iaALuPAj+9d/TW1wQcEd4kdcXNWfDGLQ6G4RSIAowVfoaikN84wJXQuaYqW0lSqGKN2xN6yCDkvRPbHUozAku/7Fcyaj8/dPNNJjxQQHhqAgh+x2WOwtpijD6Er0TRCSGXtQsF6tFmSxgDzWrnmcJwQ1U0R8gLD/3gKCchxNh9vxD4+JzZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgiCeqdoQWJ9lUz99JBHW5G97YEQ/nRUwnldWcHZG2w=;
 b=GhkanbppeJ/Phq5YPxjqjiCyPBD19b61ExdjiQY49jt/PyoeCyga1LB1wy9MRDr4zH7N8xHcSEH5bJDBXK2pPOBOVrkbRC3fZUPEnaxSPu/+8j1sjYaXVOtL50/UnVdB5RGXqY6g8rV4RRJQpxx5Jui3PuCW8NhOAow8pUjKKGX9dQetydSXUUcc/TWGgSrRhcxW1Kq2G1CEpSnohx2zWYS4Odk3arKwZH1d2Jybf/xNrQVpohpBR2+xncT6/udhuSa5X3u6M7R2oEAoPmOkDtMCW7hetp4eghyzfXOcv0VYRUG4q7EMRH38hrNlB80jFdauznnO12ZieiMuieAs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgiCeqdoQWJ9lUz99JBHW5G97YEQ/nRUwnldWcHZG2w=;
 b=YgW2TBecpZ820J1qavdMEcqF2QaHIf7x/FB9rRmqHfh6QL/yflpT3cBMpG5j6iMNC8FMnIijHo4YvbmYP6oGnU1mUQiJ4RFgp0nBYBwJZIUsuSVZyXW8ctl6NlUiunzWjohVmSQ2F0eoDdhRRUEgMPNGb+mq7G5fiIPL6aQg7mI=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1901.namprd15.prod.outlook.com (10.174.99.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Wed, 28 Aug 2019 23:03:03 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::45ee:bc50:acfa:60a5%3]) with mapi id 15.20.2199.021; Wed, 28 Aug 2019
 23:03:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rik van Riel" <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] x86/mm/cpa: Prevent large page split when ftrace flips RW
 on kernel text
Thread-Topic: [PATCH] x86/mm/cpa: Prevent large page split when ftrace flips
 RW on kernel text
Thread-Index: AQHVXfBrwy7DRssuAUKml0PBV9k636cRLZyA
Date:   Wed, 28 Aug 2019 23:03:03 +0000
Message-ID: <704BDFE2-E6E7-4B34-8C94-01152B5C9CCD@fb.com>
References: <20190828142445.454151604@linutronix.de>
 <20190828143123.971884723@linutronix.de>
 <55bb026c-5d54-6ebf-608f-3f376fbec4e5@intel.com>
 <alpine.DEB.2.21.1908281750410.1938@nanos.tec.linutronix.de>
 <309E5006-E869-4761-ADE2-ADB7A1A63FF1@fb.com>
 <alpine.DEB.2.21.1908282029550.1938@nanos.tec.linutronix.de>
 <9B34E971-20ED-4A58-B086-AB94990B5A26@fb.com>
 <alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908282355340.1938@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::cae3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9192e40c-28a4-4be1-244b-08d72c0be195
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1901;
x-ms-traffictypediagnostic: MWHPR15MB1901:
x-microsoft-antispam-prvs: <MWHPR15MB19014F84EEC1C415A70B41C6B3A30@MWHPR15MB1901.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39860400002)(136003)(376002)(189003)(199004)(4326008)(102836004)(33656002)(186003)(476003)(2906002)(53546011)(6486002)(229853002)(46003)(478600001)(6246003)(305945005)(6436002)(446003)(8936002)(486006)(8676002)(2616005)(14444005)(256004)(7736002)(5660300002)(81166006)(81156014)(11346002)(6916009)(86362001)(50226002)(14454004)(36756003)(71200400001)(54906003)(76176011)(66946007)(64756008)(71190400001)(99286004)(6116002)(66476007)(76116006)(66556008)(66446008)(6506007)(25786009)(6512007)(53936002)(316002)(57306001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1901;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cNoIA1lqfPLgtJowjRhwv2TVv4M4zaVv+IOC8ClXXbdagwu2+ZJgRajaoBzyYE08yDFfTHp5E19Z9utB2GPP+m/bN+kMHKDA+EhHfDjPrAsatoMR7yeul4iIi9KFpNUGOI5zs4mAZhF+EDRfkGKc9/X0DfCjPs0TK5wFFrt6hwk5hbikcLL1zXnGih8V9/2w3MK473RDD4pjnM0C/SU0JDBP8SJ41UxsPIKW8p/pjWONKH02Z5fKCavEMYXlZioOZ5Yx2GnFUO/Y7MQlplVqUbjRYO5CNY/Df3kjIeLHc73MFvG4Kv02sMdPBsOFv/eqZB6lpip7vJv6WMJTL7Coqi/omWKrmaNPLNKZjR/t2p0Nfqgg+rdRvOVumgqDnuPVdTdXEyZNIHSYvhMj3FqK7DivVWg1Mh2QxVjBQO3QxzY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A031268B319BD64AAE77E9090F8AF6D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9192e40c-28a4-4be1-244b-08d72c0be195
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 23:03:03.5405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aimKWkiTVxv/kYkB0Q38yMvG4wooq1rQfU8yCNVMjRU11jvnCSgYoqraoC34wDa1VZasUVhESzVqC4HPQthmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1901
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-28_12:2019-08-28,2019-08-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908280218
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 28, 2019, at 3:31 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> ftrace does not use text_poke() for enabling trace functionality. It uses
> its own mechanism and flips the whole kernel text to RW and back to RO.
>=20
> The CPA rework removed a loop based check of 4k pages which tried to
> preserve a large page by checking each 4k page whether the change would
> actually cover all pages in the large page.
>=20
> This resulted in endless loops for nothing as in testing it turned out th=
at
> it actually never preserved anything. Of course testing missed to include
> ftrace, which is the one and only case which benefitted from the 4k loop.
>=20
> As a consequence enabling function tracing or ftrace based kprobes result=
s
> in a full 4k split of the kernel text, which affects iTLB performance.
>=20
> The kernel RO protection is the only valid case where this can actually
> preserve large pages.
>=20
> All other static protections (RO data, data NX, PCI, BIOS) are truly
> static.  So a conflict with those protections which results in a split
> should only ever happen when a change of memory next to a protected regio=
n
> is attempted. But these conflicts are rightfully splitting the large page
> to preserve the protected regions. In fact a change to the protected
> regions itself is a bug and is warned about.
>=20
> Add an exception for the static protection check for kernel text RO when
> the to be changed region spawns a full large page which allows to preserv=
e
> the large mappings. This also prevents the syslog to be spammed about CPA
> violations when ftrace is used.
>=20
> The exception needs to be removed once ftrace switched over to text_poke(=
)
> which avoids the whole issue.
>=20
> Fixes: 585948f4f695 ("x86/mm/cpa: Avoid the 4k pages check completely")
> Reported-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org

This looks great. Much cleaner than my workaround.=20

Thanks!

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

We need this for v4.20 to v5.3 (assuming Peter's patches will land in 5.4).=
=20


> ---
> arch/x86/mm/pageattr.c |   26 ++++++++++++++++++--------
> 1 file changed, 18 insertions(+), 8 deletions(-)
>=20
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -516,7 +516,7 @@ static inline void check_conflict(int wa
>  */
> static inline pgprot_t static_protections(pgprot_t prot, unsigned long st=
art,
> 					  unsigned long pfn, unsigned long npg,
> -					  int warnlvl)
> +					  unsigned long lpsize, int warnlvl)
> {
> 	pgprotval_t forbidden, res;
> 	unsigned long end;
> @@ -535,9 +535,17 @@ static inline pgprot_t static_protection
> 	check_conflict(warnlvl, prot, res, start, end, pfn, "Text NX");
> 	forbidden =3D res;
>=20
> -	res =3D protect_kernel_text_ro(start, end);
> -	check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
> -	forbidden |=3D res;
> +	/*
> +	 * Special case to preserve a large page. If the change spawns the
> +	 * full large page mapping then there is no point to split it
> +	 * up. Happens with ftrace and is going to be removed once ftrace
> +	 * switched to text_poke().
> +	 */
> +	if (lpsize !=3D (npg * PAGE_SIZE) || (start & (lpsize - 1))) {
> +		res =3D protect_kernel_text_ro(start, end);
> +		check_conflict(warnlvl, prot, res, start, end, pfn, "Text RO");
> +		forbidden |=3D res;
> +	}
>=20
> 	/* Check the PFN directly */
> 	res =3D protect_pci_bios(pfn, pfn + npg - 1);
> @@ -819,7 +827,7 @@ static int __should_split_large_page(pte
> 	 * extra conditional required here.
> 	 */
> 	chk_prot =3D static_protections(old_prot, lpaddr, old_pfn, numpages,
> -				      CPA_CONFLICT);
> +				      psize, CPA_CONFLICT);
>=20
> 	if (WARN_ON_ONCE(pgprot_val(chk_prot) !=3D pgprot_val(old_prot))) {
> 		/*
> @@ -855,7 +863,7 @@ static int __should_split_large_page(pte
> 	 * protection requirement in the large page.
> 	 */
> 	new_prot =3D static_protections(req_prot, lpaddr, old_pfn, numpages,
> -				      CPA_DETECT);
> +				      psize, CPA_DETECT);
>=20
> 	/*
> 	 * If there is a conflict, split the large page.
> @@ -906,7 +914,8 @@ static void split_set_pte(struct cpa_dat
> 	if (!cpa->force_static_prot)
> 		goto set;
>=20
> -	prot =3D static_protections(ref_prot, address, pfn, npg, CPA_PROTECT);
> +	/* Hand in lpsize =3D 0 to enforce the protection mechanism */
> +	prot =3D static_protections(ref_prot, address, pfn, npg, 0, CPA_PROTECT=
);
>=20
> 	if (pgprot_val(prot) =3D=3D pgprot_val(ref_prot))
> 		goto set;
> @@ -1503,7 +1512,8 @@ static int __change_page_attr(struct cpa
> 		pgprot_val(new_prot) |=3D pgprot_val(cpa->mask_set);
>=20
> 		cpa_inc_4k_install();
> -		new_prot =3D static_protections(new_prot, address, pfn, 1,
> +		/* Hand in lpsize =3D 0 to enforce the protection mechanism */
> +		new_prot =3D static_protections(new_prot, address, pfn, 1, 0,
> 					      CPA_PROTECT);
>=20
> 		new_prot =3D pgprot_clear_protnone_bits(new_prot);

