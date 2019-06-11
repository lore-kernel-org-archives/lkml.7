Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A336FC0650E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF4620874
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406323AbfFKRbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:31:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406203AbfFKRbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:31:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BHJB3f094638
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:31:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2eug5u1f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 13:31:36 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <leonardo@linux.ibm.com>;
        Tue, 11 Jun 2019 18:31:35 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 18:31:27 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BHVPUl15401272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 17:31:25 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5393F112061;
        Tue, 11 Jun 2019 17:31:25 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89B10112065;
        Tue, 11 Jun 2019 17:31:18 +0000 (GMT)
Received: from leobras.br.ibm.com (unknown [9.86.24.233])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 17:31:18 +0000 (GMT)
Subject: Re: [RFC V3] mm: Generalize and rename notify_page_fault() as
 kprobe_page_fault()
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Tony Luck <tony.luck@intel.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Date:   Tue, 11 Jun 2019 14:31:12 -0300
In-Reply-To: <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
References: <1559903655-5609-1-git-send-email-anshuman.khandual@arm.com>
         <ec764ff4-f68a-fce5-ac1e-a4664e1123c7@c-s.fr>
         <97e9c9b3-89c8-d378-4730-841a900e6800@arm.com>
         <8dd6168592437378ff4a7c204e0f2962d002b44f.camel@linux.ibm.com>
         <7b0a7afd-2776-0d95-19c5-3e15959744eb@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+TvBOjv046XEorglXBMQ"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19061117-0064-0000-0000-000003ECE701
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216523; UDB=6.00639641; IPR=6.00997622;
 MB=3.00027266; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 17:31:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061117-0065-0000-0000-00003DDA7110
Message-Id: <bec5983d50e37953b3962a6e53fca0a243c7158b.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=675 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+TvBOjv046XEorglXBMQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-06-11 at 10:44 +0530, Anshuman Khandual wrote:
>=20
> On 06/10/2019 08:57 PM, Leonardo Bras wrote:
> > On Mon, 2019-06-10 at 08:09 +0530, Anshuman Khandual wrote:
> > > > > +    /*
> > > > > +     * To be potentially processing a kprobe fault and to be all=
owed
> > > > > +     * to call kprobe_running(), we have to be non-preemptible.
> > > > > +     */
> > > > > +    if (kprobes_built_in() && !preemptible() && !user_mode(regs)=
) {
> > > > > +        if (kprobe_running() && kprobe_fault_handler(regs, trap)=
)
> > > >=20
> > > > don't need an 'if A if B', can do 'if A && B'
> > >=20
> > > Which will make it a very lengthy condition check.
> >=20
> > Well, is there any problem line-breaking the if condition?
> >=20
> > if (A && B && C &&
> >     D && E )
> >=20
> > Also, if it's used only to decide the return value, maybe would be fine
> > to do somethink like that:
> >=20
> > return (A && B && C &&
> >         D && E );=20
>=20
> Got it. But as Dave and Matthew had pointed out earlier, the current x86
> implementation has better readability. Hence will probably stick with it.
>=20
Sure, I agree with them. It's way more readable.

--=-+TvBOjv046XEorglXBMQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEMdeUgIzgjf6YmUyOlQYWtz9SttQFAlz/5WAACgkQlQYWtz9S
ttSg4A/6A45T2BOxIm5qp+PJ+LwF0fbX0ZI762cE3X6nXDk5fJuRrjyQifBfrD0V
IVWSUrnOXqarYOmPT3CxT33rW05vGtDWObX+OI6J/QW6qU7jSOD1Db1ZUHL0W3WL
7B27RA3gNmEMugnjmM+JvtMkf5SwTdk3ZLr2IA22revoOBxOF5b8iICzA0HfaXg6
8lFSegTY8C2nNQipkeSS4d3KiObNEA1TVJUFqhwJ/VA6qYMnOpKD6WR58QCOxFaF
NIP4ln+HJccwleioGnQ+Q7jFGRD8Hb9zqLKNccpN1MfuZdE9OXcbFB5MXVuPyE/h
JVYbITwMXbIxpZe8o6/Yoc875Tz1phA2GeprZlEF3FDbw/tH0tyb6U5o+8UNpOXp
YdrNxy1oJRK6ZzhW0+FqgMJVo/BBh/8OV3r9ECwYxR3o8ELPVFAcyqrx2XEU7E6p
fBWN/cYXuZFizM0/b2yKd3kO/JIemEdz58/aPOTgJevEb996p7JohS8H8/3lm4gu
VcnlAsH9ivKDmkoFzz6JuXWJB19OSohPW8j2p9fqP5LA5snz8o+ehsewTjaVQsPJ
eNlp1HQzVumviM07wrZmXzVc0zoUb3YhWHrUL26xcfvtfDZVQ+gIOCH9baNsgcoe
U0uI1HQuuUreC4L10sgC2qrlYqbWMUmK5uj6T8fjTRaHlzP1UX8=
=i2hD
-----END PGP SIGNATURE-----

--=-+TvBOjv046XEorglXBMQ--

