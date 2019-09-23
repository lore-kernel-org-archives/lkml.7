Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324D7C00300
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048F420665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 21:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502919AbfIWVCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:02:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502584AbfIWVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 17:02:32 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NL0l66006094;
        Mon, 23 Sep 2019 17:02:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v75kf81f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 17:02:04 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8NL0oxS006303;
        Mon, 23 Sep 2019 17:02:04 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v75kf81e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 17:02:04 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8NL0fZ7022838;
        Mon, 23 Sep 2019 21:02:02 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04wdc.us.ibm.com with ESMTP id 2v5bg6xnbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 21:02:02 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NL21tO48038320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 21:02:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D9D07805F;
        Mon, 23 Sep 2019 21:02:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 568D87805E;
        Mon, 23 Sep 2019 21:01:56 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 21:01:56 +0000 (GMT)
Message-ID: <907304d0599684b3caa6773197fd40e09191b48e.camel@linux.ibm.com>
Subject: Re: [PATCH v2 03/11] mm/gup: Applies counting method to monitor
 gup_pgd_range
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Richard Fontana <rfontana@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Ganesh Goudar <ganeshgr@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Allison Randal <allison@lohutok.net>
Date:   Mon, 23 Sep 2019 18:01:54 -0300
In-Reply-To: <2e060677-eadf-c32e-d8c5-8e22c8ca118e@nvidia.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
         <20190920195047.7703-4-leonardo@linux.ibm.com>
         <2e060677-eadf-c32e-d8c5-8e22c8ca118e@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-tW3aXB7tmQ0op8qOIhbV"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tW3aXB7tmQ0op8qOIhbV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-23 at 13:27 -0700, John Hubbard wrote:
> I'd also like a second opinion from the "core" -mm maintainers, but it se=
ems like
> there is now too much code around the gup_pgd_range() call. Especially si=
nce there
> are two places where it's called--did you forget the other one in=20
> __get_user_pages_fast(), btw??
>=20
Oh, sorry, I missed this one. I will put it on v3.
(Also I will make sure to include linux-mm on v3.)

> Maybe the irq handling and atomic counting should be moved into start/fin=
ish
> calls, like this:
>=20
>      start_gup_fast_walk()
>      gup_pgd_range()
>      finish_gup_fast_walk()

There are cases where interrupt disable/enable is not done around the
lockless pagetable walk.
It may come from functions called above on stack, that's why I opted it
to be only the atomic operation.

--=-tW3aXB7tmQ0op8qOIhbV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2JMsMACgkQlQYWtz9S
ttRQ0g//YQQCVV8UsFOhuPWAkbMot1RxhjkbduibAKFnSgd4mYSqLLz6n4ikZW+k
qI4EbNxkdtBL5qiqM1PlXubAk8M1ShbBVRk7+cFbCyzPSWWbuzy4MsNJJY9YV8tR
QuZEfqhaKyz+SCIz3yWUrVSwQjRkjkAkvRnipBuYa0eRcXtIuKFb2XRU4U085Ocg
3KZFb+z+4QIiVoSSH03p9yFhh/k89S3ToHHEWdhbKpEblqiY64fsexSsoKOggcJ5
R01gGhnaVcKxNNCnGvhA/uMF/Bcl6W3cV4MfwNluypWn6AqzxK3i97GtwHdESqez
aNgyMyuCkLoxPsiBk1nh/AbeGL18dgiU+HXrQ5l49UbLAeW18LL/y3GC+UmITQKA
F2tSnB8oq9k2lyJtoYj+5++ywSQDiyXxhLrUvgpQScgDV5IoQ5U4q2GgeRcy9CxN
5ehqygvFulOdz099CrjZd2Nwna5GWEOgdeszgvFIzNZX7wHmOp2lbh6QbpgLerUC
n/KNTIGN40KTBBm9YFNbMiMW3eBEdyf8hu7tapnO2mll8mWs2g/5+vwt5XDjkwei
09uJNIRCsA68+8hyPC2c1I+U8ris1ZEFtJf4AL3F+yRtgLgcmlD/UI1xFOe5tdOH
FUQvh2QN6u0xJfm8Mk+22PVVkadrS6F9BCxai/XpUZtQ73h1p9U=
=svcq
-----END PGP SIGNATURE-----

--=-tW3aXB7tmQ0op8qOIhbV--

