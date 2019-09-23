Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9700CC88CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E33207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfIWUu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:50:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387437AbfIWUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:50:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NKkwoi097671;
        Mon, 23 Sep 2019 16:50:13 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v72df5w06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 16:50:13 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8NKnpi9103691;
        Mon, 23 Sep 2019 16:50:12 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v72df5vyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 16:50:12 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8NKjFb4020590;
        Mon, 23 Sep 2019 20:50:12 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 2v5bg6pmpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Sep 2019 20:50:12 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NKo9di53281104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 20:50:09 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CFF8BE056;
        Mon, 23 Sep 2019 20:50:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6122BE058;
        Mon, 23 Sep 2019 20:50:04 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 20:50:04 +0000 (GMT)
Message-ID: <5492a97960d6991e578caa54ba1536a8e38c7175.camel@linux.ibm.com>
Subject: Re: [PATCH v2 01/11] powerpc/mm: Adds counting method to monitor
 lockless pgtable walks
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     John Hubbard <jhubbard@nvidia.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>
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
        Keith Busch <keith.busch@intel.com>
Date:   Mon, 23 Sep 2019 17:50:03 -0300
In-Reply-To: <90ceb0ca-9f04-65a5-586c-e37c2ecc6e4e@nvidia.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
         <20190920195047.7703-2-leonardo@linux.ibm.com>
         <90ceb0ca-9f04-65a5-586c-e37c2ecc6e4e@nvidia.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-BWWhve4qxaPrBo0dh95w"
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


--=-BWWhve4qxaPrBo0dh95w
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-09-23 at 13:42 -0700, John Hubbard wrote:
> Somewhere, there should be a short comment that explains how the followin=
g functions
> are meant to be used. And it should include the interaction with irqs, so=
 maybe
> if you end up adding that combined wrapper function that does both, that'=
s=20
> where the documentation would go. If not, then here is probably where it =
goes.

Thanks for the feedback.
I will make sure to add comments here for v3.

--=-BWWhve4qxaPrBo0dh95w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2JL/sACgkQlQYWtz9S
ttQPlRAAr5/zXU5MsA8IdhhjpUDWfsoINxRO1MdYODVN3wLbY3JzGRaDX4Gl4nX5
9pi4o1ghm49t3tq40uisluJEqhavnoGLrjjpfnKIyQCXY/1qg4zpBxPC87G136B6
wozHzkWXCwjSMbkb58DvPribUYBlxUfYSDnecgnens2axofbN0yQ23cX6Z4Eqce0
3fS6uTuSw3xy/Y1K81tBz3rStfHCjdBcD1rqf0zijDbXgX2CP3havAll7dVWs4cz
3WtT9T0EKGP2SQKeaXzKpG6gieuZN0UijRL524A+afKqc8rlY5Vk9MheHMHonLt2
zsMCcKct4Z+8KKo3KtGfFicVb+TJKl97XQRqiravh/Y6Tu/cd08qUxKT9VNFK47p
xdv+tuSUza8AvvY4PTzONiqCSODmYkeLpoyARa9/6QGfcURhgQxwKJenT3bUP5HI
MCR+s6YtqJwMRKPj12Je7k7lqinWD5I6RgUkhJ5E38/c+ei7NyZfDvsD3vfKPrZf
ey4a9mHuMiEKcTGeG4S11pAHpQOj0DTRl3M7HDJ0xJ1PcI3JbxcwCQFRBB9DDDDP
9/nKhW/WqaVNqj3AeSoMsKq32YKLsacni3xPGIp4Y1dCwXEM4wHKA0C5U3IjCexH
xmL/gvd4kx40YhA8RG2N4Uu0Kbv7nE0R+Iqgsa2a+GVPkA4iDp8=
=Nuqy
-----END PGP SIGNATURE-----

--=-BWWhve4qxaPrBo0dh95w--

