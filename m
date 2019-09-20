Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62713C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35833205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfITT5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 15:57:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726835AbfITT5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 15:57:33 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8KJqVpw055501;
        Fri, 20 Sep 2019 15:57:07 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v51uh8jv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 15:57:06 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8KJv6KE065468;
        Fri, 20 Sep 2019 15:57:06 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2v51uh8ju4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 15:57:06 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8KJoH7a013688;
        Fri, 20 Sep 2019 19:57:04 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 2v3vc5rqxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Sep 2019 19:57:04 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8KJv2SX27394310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Sep 2019 19:57:02 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A23E57805E;
        Fri, 20 Sep 2019 19:57:02 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00CC57805C;
        Fri, 20 Sep 2019 19:56:57 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.184])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 20 Sep 2019 19:56:57 +0000 (GMT)
Message-ID: <56444e28eeb8e5ca7322112a7c8359d1d89ffe2d.camel@linux.ibm.com>
Subject: Re: [PATCH v2 00/11] Introduces new count-based method for
 monitoring lockless pagetable wakls
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
        John Hubbard <jhubbard@nvidia.com>,
        Keith Busch <keith.busch@intel.com>
Date:   Fri, 20 Sep 2019 16:56:56 -0300
In-Reply-To: <20190920195047.7703-1-leonardo@linux.ibm.com>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zBmeUsHIw6iPjGkcXUp7"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-20_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909200162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zBmeUsHIw6iPjGkcXUp7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-20 at 16:50 -0300, Leonardo Bras wrote:
> *** BLURB HERE ***

Sorry, something gone terribly wrong with my cover letter.
I will try to find it and send here, or rewrite it.

Best regards,

--=-zBmeUsHIw6iPjGkcXUp7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl2FLwgACgkQlQYWtz9S
ttS4pxAAyLJQGQqLn3/uCt8mF14TTKklTkgtYZYnjrUAkq41RmZdzGrnmqw2Doc6
a++i7yM121uUavh3aOJjh5lzFIg09k56oq6j0yKgbG6bFv78GxgHeoD18Cha6sma
H1GVGCBenJ5MlyVWRv5kMYVEzRJrQ0iB4x0mDeLHChjYOf6tvqlHTNfviTW5/vck
ZuMIrE1XYXjVRwyt6M5IX90gxpck15kz5e+thMr1a0RdXgCpIQSSYfrvcWfhYjQP
rrPooy7AFBb1HlMgkq9T3KNcvauier39RWnHqcoO6HC9hIW8GwDrA+oG0NhdU06z
u11JNHWp1o1K/cVpzpU5keDqUq6yypvoMrxsuqUHnc942ZP9TidK1x1BpxlbP/VR
o7aV7kXjmVPcdLbvzIAtitouyuerZApeC7kh7RcJ8/cz6FE6rQMAvpSc+rT+CJY2
3s/WH8YjND1+j1/1ronLW9wnFgC9/LFXkU1/uIFcZwLjv/PPVcvdXtuKkauCfByp
0M5qjbAKpQYmwGPda9i0M26JyUmIqeVv7XEqz6G3EXEpgJFPUU7YvmLtD6lHZr01
CenwanUxJqI+TCVm1L0dGFq0uhUMUR6BaDKMEtp5Kx5EZF1pXju/OPHMylsQSdHt
fN8APotYSE0C6exwJp6fV2sYVWzX9X1T1PItn7sZEyoj+fwL4qg=
=Fz6o
-----END PGP SIGNATURE-----

--=-zBmeUsHIw6iPjGkcXUp7--

