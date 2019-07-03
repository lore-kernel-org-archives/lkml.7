Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238E2C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFB5218AD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="dKPauEKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfGCA7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:59:24 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:56588 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727082AbfGCA7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:59:23 -0400
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
        by m0050096.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x630vIWU025766;
        Wed, 3 Jul 2019 01:59:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=jan2016.eng;
 bh=9pZ9ryOnK9wPGkn/8i9iDreAG7ft/sEEwlO0Jad2gyA=;
 b=dKPauEKr1U+hKOcxAbDA3CdO7vPFfawP4q3i3TnfwGqfrGAa5bVNgS1y75IQXyuYvUl0
 ouiP1+d1bU0ABupEdIW85+F6c51eNeaJ9NAXu7nFQAfIG0jKQnUusdC3qil+Yw7wFwmM
 8GCn/NupllEeNGO9DjraXi0Lqy98oxs7X1lN2UtrUAij4xCA7avfPu0vEAlo5dgKyhjw
 BId897T0SZbP4INdfyVZawM5JiPr1SuV/mkHQcUe5tFx+my7WxJdcq2yNKNDS+6NDuoM
 0YAFMf4Uh1c9fZdrMCVydHEj5ifIC4P3hb8X/haEPqiLX86Oq16Yy4a2K24j97/icH0+ oA== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050096.ppops.net-00190b01. with ESMTP id 2tg2s5kq8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:59:11 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x630ljCc002837;
        Tue, 2 Jul 2019 20:59:10 -0400
Received: from email.msg.corp.akamai.com ([172.27.25.30])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2te3awh4vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 20:59:09 -0400
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com (172.27.27.105) by
 ustx2ex-dag1mb4.msg.corp.akamai.com (172.27.27.104) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 19:58:34 -0500
Received: from USTX2EX-DAG1MB5.msg.corp.akamai.com ([172.27.27.105]) by
 ustx2ex-dag1mb5.msg.corp.akamai.com ([172.27.27.105]) with mapi id
 15.00.1473.004; Tue, 2 Jul 2019 19:58:34 -0500
From:   "Lubashev, Igor" <ilubashe@akamai.com>
To:     James Morris <jmorris@namei.org>
CC:     Serge Hallyn <serge@hallyn.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
Thread-Topic: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
Thread-Index: AQHVIkp2KrFaTjvuWkqWuYjnYmNLQ6aa7f2AgAD6xpCAAIJWAIAbwq2g
Date:   Wed, 3 Jul 2019 00:58:34 +0000
Message-ID: <127af0e711e747279742b2aa13a658fb@ustx2ex-dag1mb5.msg.corp.akamai.com>
References: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
 <alpine.LRH.2.21.1906141445010.7150@namei.org>
 <720751180a9543cfa205cd527248df7c@ustx2ex-dag1mb5.msg.corp.akamai.com>
 <alpine.LRH.2.21.1906142049480.3646@namei.org>
In-Reply-To: <alpine.LRH.2.21.1906142049480.3646@namei.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.19.37.5]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030009
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: James Morris <jmorris@namei.org>  on Friday, June 14, 2019 11:54 PM=
:
> On Sat, 15 Jun 2019, Lubashev, Igor wrote:
>=20
> > Unfortunately, perf is using uid=3D=3D0 and euid=3D=3D0 as a "capabilit=
y bits".
> >
> >
> > In tools/perf/util/evsel.c:
> > 	static bool perf_event_can_profile_kernel(void)
> > 	{
> > 		return geteuid() =3D=3D 0 || perf_event_paranoid() =3D=3D -1;
> > 	}
> >
> > In tools/perf/util/symbol.c:
> > 	static bool symbol__read_kptr_restrict(void)
> > 	{
> > 	...
> > 		value =3D ((geteuid() !=3D 0) || (getuid() !=3D 0)) ?
> > 				(atoi(line) !=3D 0) :
> > 				(atoi(line) =3D=3D 2);
> > 	...
> > 	}
>=20
> These are bugs. They should be checking for CAP_SYS_ADMIN.

Thanks for the suggestion.

Actually, the former one should be checking CAP_SYS_ADMIN, while the latter=
 -- CAP_SYSLOG (see lib/vsprintf.c).

Just posted a patch to perf (http://lists.infradead.org/pipermail/linux-arm=
-kernel/2019-July/664552.html).

Thank you,

- Igor
