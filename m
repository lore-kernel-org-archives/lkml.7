Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9F6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7430720821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hHbyQcR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733097AbfDQReH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:34:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57212 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfDQReG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:34:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HHO5lG087083;
        Wed, 17 Apr 2019 17:33:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=n6AW0KFZfBWQXIF3BLuGRaqvWHMs7VP7kbUpQyzZLCQ=;
 b=hHbyQcR+kqdRDbS1HXGo+9Imp9OxI6FtwGiqAsx93fBWBDk7CX4jIet+aGdG1y6ekO8C
 Ti2Do+GqJOBrEB5x67xr+rylVhRtLSeWIi9OyRLpnSoEJ7MlPeL6aVzmxNJeu5NT+0V1
 BY9E+QKXPaHaEI9l3DsywXK8Nwo+WtmwCh/ApxHEC5zeBkDVLjReK64fxhjMPnODAvgB
 BwCVpKk3nhXq1aNu8Vhevz8BvIfHlKJN4MJ+qs43AbfU/nYZ0/Hdd7eOfR2rrofEznbE
 AbhTNE7XqQeWKp1Di9iYW9dQmATPYclZx6QHSHuLjZEw77+iY0XumcJRb03aj+gUI3WP Wg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2rvwk3vhf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 17:33:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HHWBSB165901;
        Wed, 17 Apr 2019 17:33:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2rv2tvgqhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 17:33:09 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3HHX7ls006927;
        Wed, 17 Apr 2019 17:33:07 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Apr 2019 10:33:07 -0700
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
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
 <20190417170918.GA68678@gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
Date:   Wed, 17 Apr 2019 11:33:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190417170918.GA68678@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904170117
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904170117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 11:09 AM, Ingo Molnar wrote:
>=20
> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>=20
>>> I.e. the original motivation of the XPFO patches was to prevent execu=
tion=20
>>> of direct kernel mappings. Is this motivation still present if those =

>>> mappings are non-executable?
>>>
>>> (Sorry if this has been asked and answered in previous discussions.)
>>
>> Hi Ingo,
>>
>> That is a good question. Because of the cost of XPFO, we have to be ve=
ry
>> sure we need this protection. The paper from Vasileios, Michalis and
>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>,
>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.1
>> and 6.2.
>=20
> So it would be nice if you could generally summarize external arguments=
=20
> when defending a patchset, instead of me having to dig through a PDF=20
> which not only causes me to spend time that you probably already spent =

> reading that PDF, but I might also interpret it incorrectly. ;-)

Sorry, you are right. Even though that paper explains it well, a summary
is always useful.

>=20
> The PDF you cited says this:
>=20
>   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enforce=
d=20
>    in many platforms, including x86-64.  In our example, the content of=
=20
>    user address 0xBEEF000 is also accessible through kernel address=20
>    0xFFFF87FF9F080000 as plain, executable code."
>=20
> Is this actually true of modern x86-64 kernels? We've locked down W^X=20
> protections in general.
>=20
> I.e. this conclusion:
>=20
>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and=20
>    triggering the kernel to dereference it, an attacker can directly=20
>    execute shell code with kernel privileges."
>=20
> ... appears to be predicated on imperfect W^X protections on the x86-64=
=20
> kernel.
>=20
> Do such holes exist on the latest x86-64 kernel? If yes, is there a=20
> reason to believe that these W^X holes cannot be fixed, or that any fix=
=20
> would be more expensive than XPFO?

Even if physmap is not executable, return-oriented programming (ROP) can
still be used to launch an attack. Instead of placing executable code at
user address 0xBEEF000, attacker can place an ROP payload there. kfptr
is then overwritten to point to a stack-pivoting gadget. Using the
physmap address aliasing, the ROP payload becomes kernel-mode stack. The
execution can then be hijacked upon execution of ret instruction. This
is a gist of the subsection titled "Non-executable physmap" under
section 6.2 and it looked convincing enough to me. If you have a
different take on this, I am very interested in your point of view.

Thanks,
Khalid


