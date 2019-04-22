Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B155C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01F120896
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLnlTenx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfDVTc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:32:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfDVTc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:32:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MJUDBB049863;
        Mon, 22 Apr 2019 19:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WH/Ljdr8TJUTrAi5oLGMpFDZ+oLv/QGAaimWLH/RF5Y=;
 b=oLnlTenxF7nnPodU74CKxVdtTdurZTHC2c+IYDHYu4ConBppy1DQR5ZRD2yjJFvZgGWr
 s4yQwwuUvTu9u+sFyoVUu0Ps8OuhhW0poWi1ZMLvaVC5TBbAF1wwcZr5XAReyOOTF+by
 uC0TnLDiZT5r3TKE6PPp1vUjAz4Kig9RayQOAPeSyneDjrd8g3giZqr3VY0DWHpHGibW
 +Tp8jlms4x1+K3jD0LKvfWig3toDL2oxHG0Gk75UGHP6ZXqvAC5kZivppkWtzcLz1h9X
 XEAwsf7cBrXzU2kQ/Ajn/P/r+v3zskWbTDpMTbY0n+hrjLQtUDBZ3bbfv/WSjVOTlFLG 6g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2ryv2q001q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 19:30:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3MJUfFP107047;
        Mon, 22 Apr 2019 19:30:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2s0dwdv8c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Apr 2019 19:30:52 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3MJUjCf011034;
        Mon, 22 Apr 2019 19:30:46 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Apr 2019 12:30:45 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     Kees Cook <keescook@google.com>, Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Julian Stecklina <jsteckli@amazon.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu <iommu@lists.linux-foundation.org>,
        X86 ML <x86@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave@sr71.net>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
 <56A175F6-E5DA-4BBD-B244-53B786F27B7F@gmail.com>
 <20190417172632.GA95485@gmail.com>
 <063753CC-5D83-4789-B594-019048DE22D9@gmail.com>
 <alpine.DEB.2.21.1904172317460.3174@nanos.tec.linutronix.de>
 <CAHk-=wgBMg9P-nYQR2pS0XwVdikPCBqLsMFqR9nk=wSmAd4_5g@mail.gmail.com>
 <alpine.DEB.2.21.1904180129000.3174@nanos.tec.linutronix.de>
 <CAHk-=whUwOjFW6RjHVM8kNOv1QVLJuHj2Dda0=mpLPdJ1UyatQ@mail.gmail.com>
 <CALCETrXm9PuUTEEmzA8bQJmg=PHC_2XSywECittVhXbMJS1rSA@mail.gmail.com>
 <CAGXu5jL-qJtW7eH8S2yhqciE+J+FWz8HHzTrGJTgVUbd55n6dQ@mail.gmail.com>
 <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
Organization: Oracle Corp
Message-ID: <302e3d5b-d2fd-3c25-335b-466ba83035c5@oracle.com>
Date:   Mon, 22 Apr 2019 13:30:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <8f9d059d-e720-cd24-faa6-45493fc012e0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904220147
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9235 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904220147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 8:34 AM, Khalid Aziz wrote:
> On 4/17/19 11:41 PM, Kees Cook wrote:
>> On Wed, Apr 17, 2019 at 11:41 PM Andy Lutomirski <luto@kernel.org> wro=
te:
>>> I don't think this type of NX goof was ever the argument for XPFO.
>>> The main argument I've heard is that a malicious user program writes =
a
>>> ROP payload into user memory (regular anonymous user memory) and then=

>>> gets the kernel to erroneously set RSP (*not* RIP) to point there.
>>
>> Well, more than just ROP. Any of the various attack primitives. The NX=

>> stuff is about moving RIP: SMEP-bypassing. But there is still basic
>> SMAP-bypassing for putting a malicious structure in userspace and
>> having the kernel access it via the linear mapping, etc.
>>
>>> I find this argument fairly weak for a couple reasons.  First, if
>>> we're worried about this, let's do in-kernel CFI, not XPFO, to
>>
>> CFI is getting much closer. Getting the kernel happy under Clang, LTO,=

>> and CFI is under active development. (It's functional for arm64
>> already, and pieces have been getting upstreamed.)
>>
>=20
> CFI theoretically offers protection with fairly low overhead. I have no=
t
> played much with CFI in clang. I agree with Linus that probability of
> bugs in XPFO implementation itself is a cause of concern. If CFI in
> Clang can provide us the same level of protection as XPFO does, I
> wouldn't want to push for an expensive change like XPFO.
>=20
> If Clang/CFI can't get us there for extended period of time, does it
> make sense to continue to poke at XPFO?

Any feedback on continued effort on XPFO? If it makes sense to have XPFO
available as a solution for ret2dir issue in case Clang/CFI does not
work out, I will continue to refine it.

--
Khalid

