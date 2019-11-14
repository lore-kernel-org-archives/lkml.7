Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEB1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB5120740
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKNS0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:26:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfKNS0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:26:33 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAEIOglV053909;
        Thu, 14 Nov 2019 13:26:00 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9asgbpmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 13:26:00 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAEIPPMW058214;
        Thu, 14 Nov 2019 13:26:00 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w9asgbpjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 13:25:59 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAEIKbKw018534;
        Thu, 14 Nov 2019 18:25:58 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2w5n36us65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 18:25:58 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAEIPvKF40632580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Nov 2019 18:25:57 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70D75AE064;
        Thu, 14 Nov 2019 18:25:57 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A68A6AE05C;
        Thu, 14 Nov 2019 18:25:55 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.18.235.137])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 14 Nov 2019 18:25:55 +0000 (GMT)
Message-ID: <b358d9ac8872856ae7e1f317c96c8169e619a2f4.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] powerpc/pseries/hotplug-memory.c: Change rc
 variable to bool
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>
Date:   Thu, 14 Nov 2019 15:25:51 -0300
In-Reply-To: <47DFxW5FGsz9sPh@ozlabs.org>
References: <47DFxW5FGsz9sPh@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-DDhjZtf+5bJmCC+DjWgf"
User-Agent: Evolution 3.34.1 (3.34.1-1.fc31) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911140156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DDhjZtf+5bJmCC+DjWgf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-14 at 20:07 +1100, Michael Ellerman wrote:
> On Fri, 2019-08-02 at 13:39:15 UTC, Leonardo Bras wrote:
> > Changes the return variable to bool (as the return value) and
> > avoids doing a ternary operation before returning.
> >=20
> > Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
>=20
> Series applied to powerpc next, thanks.
>=20
> https://git.kernel.org/powerpc/c/b948aaaf3e39cc475e45fea727638f191a5cb1b4
>=20
> cheers

Thanks!

--=-DDhjZtf+5bJmCC+DjWgf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAl3NnC8ACgkQlQYWtz9S
ttQHeA/+LfV/kX0swl5Bxz3eXJJSAbqV+WftYOV4GlSFgcTVdrXE8ze/eMCH/AoQ
U/Hi8G98fXNh5lh1G3VGDmK86dqofOFXgBwDRsbtpMeb5yBPDF1j0eqYq9c4R8qt
NSuLrTWdmucL4m7kb4oHxo3u8OcVwCGYli60xvEMBqHEcdc6r52M9D5GNHNGZJHq
54VM63+vYI6B6kXQwFit+f7Wl1CDvDq4hki3ig8LkbXEUfj7OIkFdAAYtuKpOlCb
r2wsbUd6teVbYAWpuNqmB6FKjsPPfygIVCGENC8lbbgAS3SiZB7nXrSjlnDNB22l
ms/OUyl0ihwbXTBc5pB2IB2iwZ68xd+Sns954Gd96c5Ysfom9z681owv6HGtiy55
ivv1S/8pIVOrJEKOWydGW9oRKBBJiqHGoilspEnigu2zdjEXwjn6r8EVtS9Y1vTw
/LgYZccMObXvTE7NFklFjtymgLYi61+AteeJZyD6yPvlUPmohFBAaZHVn9Er5C2+
OJuTdoaisr9hyLrsy7SN/OIczvPcPpUnoJupKMt7r+x5QP/aXSN0AYL2ziN+QmlS
pwAY1PPyAeRWflf2VXV39gCxGi5Jg8keObIlNM0cibiJzFSzZXvKhA3zxVK9ytwL
nLzF1owPk1PqzTxi0vmME/4TtNqMdN2LfYQp93QAythQKYTe4wE=
=kyjx
-----END PGP SIGNATURE-----

--=-DDhjZtf+5bJmCC+DjWgf--

