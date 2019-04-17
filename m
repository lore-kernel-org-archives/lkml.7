Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59014C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSc54vhj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbfDQQvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:51:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37418 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:51:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HGnG3X054958;
        Wed, 17 Apr 2019 16:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Pt0iK48BFNYGn2PcXPZIgKCS+ChPFURYRr28gHDNt5M=;
 b=QSc54vhjKse2Gq1rcTB1KDv+n5ZNYuiktD723uSnPsQg7/lU0erFzUS/U+FBFZ5v5LN9
 4iDgkm0iqKmiYtxwHEIhhS/dZpybhW0dtoiBsKHfsRiNS/33zdpDmnSeEYaMYsWJC471
 dCGjeqzxijoOujPRbY2v3RHQK3LQ0lDNqJDLxAdspRBmSrV8REgdAzENjYqfKctb9EN3
 ONxMYYcd+On4oXsuj8M0FhxjRbw/Mu/K0czjCGbHDVfpbP3Gtg6t7AiiaqxMW+yFQXEF
 2d2DLE521La9q/IPFvG820wM8B3HmquyOp/lJk9noCrcYUs7OpW7XPbO3bgHsYkbl4gL UQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rvwk3v9bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 16:49:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HGmQda049331;
        Wed, 17 Apr 2019 16:49:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2rv2tvg02m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 16:49:34 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3HGnUSU030371;
        Wed, 17 Apr 2019 16:49:30 GMT
Received: from [10.65.150.207] (/10.65.150.207)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Apr 2019 09:49:29 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Ingo Molnar <mingo@kernel.org>
Cc:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        keescook@google.com, konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Date:   Wed, 17 Apr 2019 10:49:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417161042.GA43453@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904170113
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904170113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 10:15 AM, Ingo Molnar wrote:
>=20
> [ Sorry, had to trim the Cc: list from hell. Tried to keep all the=20
>   mailing lists and all x86 developers. ]
>=20
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>=20
>> From: Juerg Haefliger <juerg.haefliger@canonical.com>
>>
>> This patch adds basic support infrastructure for XPFO which protects=20
>> against 'ret2dir' kernel attacks. The basic idea is to enforce=20
>> exclusive ownership of page frames by either the kernel or userspace, =

>> unless explicitly requested by the kernel. Whenever a page destined fo=
r=20
>> userspace is allocated, it is unmapped from physmap (the kernel's page=
=20
>> table). When such a page is reclaimed from userspace, it is mapped bac=
k=20
>> to physmap. Individual architectures can enable full XPFO support usin=
g=20
>> this infrastructure by supplying architecture specific pieces.
>=20
> I have a higher level, meta question:
>=20
> Is there any updated analysis outlining why this XPFO overhead would be=
=20
> required on x86-64 kernels running on SMAP/SMEP CPUs which should be al=
l=20
> recent Intel and AMD CPUs, and with kernel that mark all direct kernel =

> mappings as non-executable - which should be all reasonably modern=20
> kernels later than v4.0 or so?
>=20
> I.e. the original motivation of the XPFO patches was to prevent executi=
on=20
> of direct kernel mappings. Is this motivation still present if those=20
> mappings are non-executable?
>=20
> (Sorry if this has been asked and answered in previous discussions.)

Hi Ingo,

That is a good question. Because of the cost of XPFO, we have to be very
sure we need this protection. The paper from Vasileios, Michalis and
Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
and 6.2.

Thanks,
Khalid


