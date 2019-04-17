Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB7C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23BE20651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Df6X8xST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfDQUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:14:13 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56052 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:14:13 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HK43l6027377;
        Wed, 17 Apr 2019 20:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=I6O8XHipCkxtNyBt5qT+WpjDhWybwFMx3dhCuUMlgX4=;
 b=Df6X8xSTnNbjlECiEEs0dM9pTTEuLaAWILYb+3FVHnTbzbRso80tWiMiCCKew3u1ut8b
 TLcWUbhG84sQH6SBFXaKI0Klt2uj/wv2CDPlzS3kqc877AX2RJpKLwBkvITz4J0dX+yy
 nY6rZ4iQzgA18SgoM2aT776fbQxl8SfVpBLf8ds9rKnTkPfGv841EMFoH7SxWqH6nvV0
 mwMRs7X+y11GdS97TrUt9gGKo8kqHakyrK+CUQVNsG9TAPxQsD89RZjRY8GJnbu5OyCq
 Vq/stihExhIzf4UfNBgjSHL9K+YL+YtmzhEltW0PrZ2Kquq0Bruw1aaQqw+gs9dr/CwR cQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2rvwk3wa96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 20:13:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3HKC8qv117201;
        Wed, 17 Apr 2019 20:13:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2rwe7aky1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Apr 2019 20:13:04 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3HKD2Bt022023;
        Wed, 17 Apr 2019 20:13:03 GMT
Received: from [192.168.1.16] (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Apr 2019 13:13:02 -0700
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Juerg Haefliger <juergh@gmail.com>,
        Tycho Andersen <tycho@tycho.ws>, jsteckli@amazon.de,
        Kees Cook <keescook@google.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris hyser <chris.hyser@oracle.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Jon Masters <jcm@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org, X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <8d314750-251c-7e6a-7002-5df2462ada6b@oracle.com>
 <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <96ea344b-c86b-f64d-a944-871196941a38@oracle.com>
Date:   Wed, 17 Apr 2019 14:12:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXFzWFMrV-zDa4QFjB=4WnC9RZmorBko65dLGhymDpeQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904170129
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9230 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 1:49 PM, Andy Lutomirski wrote:
> On Wed, Apr 17, 2019 at 10:33 AM Khalid Aziz <khalid.aziz@oracle.com> w=
rote:
>>
>> On 4/17/19 11:09 AM, Ingo Molnar wrote:
>>>
>>> * Khalid Aziz <khalid.aziz@oracle.com> wrote:
>>>
>>>>> I.e. the original motivation of the XPFO patches was to prevent exe=
cution
>>>>> of direct kernel mappings. Is this motivation still present if thos=
e
>>>>> mappings are non-executable?
>>>>>
>>>>> (Sorry if this has been asked and answered in previous discussions.=
)
>>>>
>>>> Hi Ingo,
>>>>
>>>> That is a good question. Because of the cost of XPFO, we have to be =
very
>>>> sure we need this protection. The paper from Vasileios, Michalis and=

>>>> Angelos - <http://www.cs.columbia.edu/~vpk/papers/ret2dir.sec14.pdf>=
,
>>>> does go into how ret2dir attacks can bypass SMAP/SMEP in sections 6.=
1
>>>> and 6.2.
>>>
>>> So it would be nice if you could generally summarize external argumen=
ts
>>> when defending a patchset, instead of me having to dig through a PDF
>>> which not only causes me to spend time that you probably already spen=
t
>>> reading that PDF, but I might also interpret it incorrectly. ;-)
>>
>> Sorry, you are right. Even though that paper explains it well, a summa=
ry
>> is always useful.
>>
>>>
>>> The PDF you cited says this:
>>>
>>>   "Unfortunately, as shown in Table 1, the W^X prop-erty is not enfor=
ced
>>>    in many platforms, including x86-64.  In our example, the content =
of
>>>    user address 0xBEEF000 is also accessible through kernel address
>>>    0xFFFF87FF9F080000 as plain, executable code."
>>>
>>> Is this actually true of modern x86-64 kernels? We've locked down W^X=

>>> protections in general.
>>>
>>> I.e. this conclusion:
>>>
>>>   "Therefore, by simply overwriting kfptr with 0xFFFF87FF9F080000 and=

>>>    triggering the kernel to dereference it, an attacker can directly
>>>    execute shell code with kernel privileges."
>>>
>>> ... appears to be predicated on imperfect W^X protections on the x86-=
64
>>> kernel.
>>>
>>> Do such holes exist on the latest x86-64 kernel? If yes, is there a
>>> reason to believe that these W^X holes cannot be fixed, or that any f=
ix
>>> would be more expensive than XPFO?
>>
>> Even if physmap is not executable, return-oriented programming (ROP) c=
an
>> still be used to launch an attack. Instead of placing executable code =
at
>> user address 0xBEEF000, attacker can place an ROP payload there. kfptr=

>> is then overwritten to point to a stack-pivoting gadget. Using the
>> physmap address aliasing, the ROP payload becomes kernel-mode stack. T=
he
>> execution can then be hijacked upon execution of ret instruction. This=

>> is a gist of the subsection titled "Non-executable physmap" under
>> section 6.2 and it looked convincing enough to me. If you have a
>> different take on this, I am very interested in your point of view.
>=20
> My issue with all this is that XPFO is really very expensive.  I think
> that, if we're going to seriously consider upstreaming expensive
> exploit mitigations like this, we should consider others first, in
> particular CFI techniques.  grsecurity's RAP would be a great start.
> I also proposed using a gcc plugin (or upstream gcc feature) to add
> some instrumentation to any code that pops RSP to verify that the
> resulting (unsigned) change in RSP is between 0 and THREAD_SIZE bytes.
> This will make ROP quite a bit harder.
>=20

Yes, XPFO is expensive. I have been able to reduce the overhead of XPFO
from 2537% to 28% (on large servers) but 28% is still quite significant.
Alternative mitigation techniques with lower impact would easily be more
acceptable as long as they provide same level of protection. If we have
to go with XPFO, we will continue to look for more performance
improvement to bring that number down further from 28%. Hopefully what
Tycho is working on will yield better results. I am continuing to look
for improvements to XPFO in parallel.

Thanks,
Khalid

