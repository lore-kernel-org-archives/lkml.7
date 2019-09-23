Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1689C88CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A28207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389800AbfIWUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389052AbfIWUtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:49:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NKkwRM135938;
        Mon, 23 Sep 2019 16:48:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v72aqwu2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 16:48:34 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8NKlkf4142544;
        Mon, 23 Sep 2019 16:48:33 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v72aqwu1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 16:48:33 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8NKjFNG008412;
        Mon, 23 Sep 2019 20:48:32 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04wdc.us.ibm.com with ESMTP id 2v5bg6xjm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 20:48:32 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NKmVNo16057158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 20:48:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B4DAC060;
        Mon, 23 Sep 2019 20:48:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EA1CAC059;
        Mon, 23 Sep 2019 20:48:28 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 20:48:27 +0000 (GMT)
Message-ID: <007934281451e843a0428dc1e674f9dae149b75b.camel@linux.ibm.com>
Subject: Re: [PATCH v2 02/11] asm-generic/pgtable: Adds dummy functions to
 monitor lockless pgtable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Keith Busch <keith.busch@intel.com>,
        Linux-MM <linux-mm@kvack.org>
Date:   Mon, 23 Sep 2019 17:48:24 -0300
In-Reply-To: <cb7d4196-c646-82c7-d61f-b28ee9ab47b9@nvidia.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
         <20190920195047.7703-3-leonardo@linux.ibm.com>
         <cb7d4196-c646-82c7-d61f-b28ee9ab47b9@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-gscBM7V3X0iJvvOlmKSv"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gscBM7V3X0iJvvOlmKSv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback,

On Mon, 2019-09-23 at 13:39 -0700, John Hubbard wrote:
> Please remember to include linux-mm if there is a v2.

Sure, I will include on v3.

> Nit: seems like it would be nicer to just put it all in one place, and us=
e
> positive logic, and also I think people normally don't compress the empty
> functions quite that much. So like this:

I did this by following the default on the rest of this file.
As you can see, all other features use the standard of=20
#ifndef SOMETHING
dummy/generic functions
#endif

Declaring the functions become responsibility of the arch.

> #ifdef __HAVE_ARCH_LOCKLESS_PGTBL_WALK_COUNTER
> void start_lockless_pgtbl_walk(struct mm_struct *mm);=20
> void end_lockless_pgtbl_walk(struct mm_struct *mm);=20
> int running_lockless_pgtbl_walk(struct mm_struct *mm);=20
>=20
> #else
> static inline void start_lockless_pgtbl_walk(struct mm_struct *mm)
> {
> }
> static inline void end_lockless_pgtbl_walk(struct mm_struct *mm)
> {
> }
> static inline int running_lockless_pgtbl_walk(struct mm_struct *mm)
> {
>         return 0;
> }
> #endif
>=20
> thanks,

--=-gscBM7V3X0iJvvOlmKSv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2JL5gACgkQlQYWtz9S
ttQ/dxAAmqh1JwzGgrYEa6AI0XaKTKXfH+bFIB1fqsi0Gli4dmGUVNOz/qhFJa4d
HVBKm2Xq2FoNnqNfrihl527mry0pJnpUZTJLHiga3Pu9c6oY8bdSAeqfTh4xR74S
FIP+zgEvZBk6IKZaNit1tlHCkD1dRaPLcCaYUBmSVf0nsya+5zE3hkCgHU0vcsRc
ttmSNmOtglF+Y5zrOhBDrXcHUkHR5242AraOWaqAEh++ijgu4zMP3gsUitjtPPOF
4ZDNSg9/98JUZWd15+29J1f6Zknn8XhCQpiKCzAZQecNZ3xkWiWf0Mtgl7XDKZn6
bHOKBEyKXXLcgwlljlhW5QBHmmwGwPYhOuUhl49eM00jIebyU9JZFjyFR7907dGT
eziIXPFrQDndRxZNbpjTKH9bO7+MUj3X7fdL4RqPM3dJghMGD3SsfQpHVydMCod6
VHNxF3x/uHuqY0lH7zJt98v+qk5TycFFARZGOO0IZ5OCsqNzKxkPqCyVZlK1PiIY
vs0FExh8GZbJ2g2rX0QZqKY4OcgNxKpKRlpAhIHGIV1GQchV8PHcj1icghNzXzX9
7bNyoczCO5atCCJDlrGaNLVE22+LKCciaDKFAN8noZFzhMGGWzGhrfQ/mSbOvAxt
3IuAflLfYMrYZRlyu+Zx8YVXlG6nqzyJpIK2rlTQ/YR2IR19bno=
=ZXCk
-----END PGP SIGNATURE-----

--=-gscBM7V3X0iJvvOlmKSv--

