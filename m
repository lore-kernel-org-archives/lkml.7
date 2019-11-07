Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB917C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8345B207FA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="AW6NahFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbfKGO3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:29:02 -0500
Received: from mout.web.de ([212.227.17.12]:48123 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbfKGO3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573136855;
        bh=xfq8NmZ01//2dj0J+4udAqyTzRt6oBxWwdKEDBbhuWU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=AW6NahFngo8o317o8MSmC5mRV2HRKY9ZxyhMvwdV035BwAvrd5nrD2CoQiKkBfnPQ
         yXJ511rx3X7NfV3N++SjBWalDH55IlkxrLvQ1T7BdV24DOaRlID2XSMOdYWACUN0ZG
         BpZB3P3CCHV9HQd7vvY8SYVRgtrl3p93N17HTQII=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.68.124]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MKrLo-1iSil43u52-0003Ae; Thu, 07
 Nov 2019 15:27:35 +0100
Subject: Re: s390/pkey: Use memdup_user() rather than duplicating its
 implementation
To:     =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Joe Perches <joe@perches.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>
References: <08422b7e-2071-ee52-049e-c3ac55bc67a9@web.de>
 <6137855bb4170c438c7436cbdb7dfd21639a8855.camel@perches.com>
 <deb7893f-3cfe-18fc-3feb-b26b290bf3c6@web.de>
 <833d7d5e-6ede-6bdd-a2cc-2da7f0b03908@de.ibm.com>
 <1b65bc81-f47a-eefa-f1f4-d5af6a1809c0@web.de>
 <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8f98f9fc-57df-5993-44b5-5ea4c0de7ef9@web.de>
Date:   Thu, 7 Nov 2019 15:27:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <733b29df-207e-a165-ee80-46be8720c0c4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:byxNkzyZ2+FkZGXVmoJodFaD0F2BaWzbCSN8UPd1UHnzQE/Aqcw
 uRZlx7zHxYeInRqqApRvXL7SIqKp+vXaX2I7KPxpgccLewNH1txrW8ejUMrZJmuC1Apttpj
 0LAXsWxGpEZVta5i3H/s+afznhFZAIkcSU/+0qDTeHvMKS0657qqLtcjuakGgfFV6idYCxT
 L07qZMq4W29EM1/i5iwLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EB3JhrJR6Ec=:sO6u6VU7g2W8aS/Ei2D4/2
 uVThiKrAoFsILXI3ooLbiRzxH2gKxs9Gx/V0lSGJDM0KWUDZxSLoN0THw9ASsVUT8QFEHhGjG
 Z9KzfQ07FV06tznanY9bKRt8bIIW9CrGJqiR+dr8J849aKrkLpDuNzsi4UiciAifd+t+mbcfG
 B5Bg5QZANAQiQGE5ZjcNCBBuAw8NLV29ktaVZ8HiXwvEy6iobbAcL1lysztcSAfzLWhlnPShl
 tJWGVPKM9D8oHqX4Ez3kE0mQxusJsHiPV6JRX3seF6qwsddyjlYpJA6vEsplElfrG2pf+zlzV
 0EPGi/sKbF3H+5cwesZBwL9AkW4OWRYIKya8Ch1T9OFt4bMi/zvkLJTcgmohq0ao3dkb5l8UL
 Dx5yYeL3KPILfQ/HPXNM9VMTedIdoA04WFihlkIDuZt1zkpSVs9sSgKOBriB5qpixvI4sOu8r
 SCV92hlLFVZ8XYVY4XV5p4Cc/d3OmUhn+oi81bJ9c+6RIwfOVe0NO1YeLdDFznd1eRxwiycZb
 Dl6UP7XA7Hyxst5WMlwBfqQQ67+brS+zTesJwA0RyMGsUqwem3G1mIFxBOPTSF53GIuyhTmq6
 9IdXkEa6BTcEPHvssok/3ccc86qb8DFmOOxshGGKx5hCCzrk10t7tbWA3VvtuHLXE1jC/805X
 q8wGZF5+D8YY3tdYBF4erU0ofpzz5DHgvNrgKkRqgqqdMA49C4vBhZD0mOp1YdfXV8n625sAa
 4XI/tcOCncveM37Jn9uGCMRlT7jZ08Ot5T1j5hLs9HkXkfKb3fmPtXS9Wi6f5GhLuN07sRScT
 c2e0Sg9IMOvPqFJY8VZGwTeMTgWpbNYjIBfuDkrZUljqHRVKjWnQy7QmhruEB45BCBOd2PVk6
 oo+FzvY7ebscmdg+5y0R3EfnfI5wGzm7mcQ8uxwtoOoQD3VEkxlra07PLnChzk3waY3QB3BvT
 2ozjRHfjstn9+6hEYAEqIK9xyv4vLsOBUgDsnEhW3ZXopKgCAHgso2mGzLADBBgh51exe0fnE
 iEMM7in/HJEjcEn1K9X2ykEYx/jnVuSSPfpOF25IQigTi4PIuacSHzAYREf8S+2Qc4yuiVOZ4
 3dzOTBRHm9Nbq8BqSnh0XJEmAc/8NrIvVQv3DhjMm9ydWJOx9wq0pLbpw0BMgcGSocEzujmpy
 XEKxY81IMSk05O0nYosV/ADn4QFAx1DvLQrzbhbSzluFyWZsi7XKBHv1Ii8RRLSgul577ZWbK
 p1qQp+v/95yaPuRnH28Uo0md+4JXyZ69bzgLxDJr9i96Jp/sS+NshVCpW1Bs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Reuse existing functionality from memdup_user() instead of keeping
>>>> duplicate source code.
>>>>
>>>> Generated by: scripts/coccinelle/api/memdup_user.cocci
>>>>
>>>> Delete local variables which became unnecessary with this refactoring
>>>> in two function implementations.
>>>>
>>>> Fixes: f2bbc96e7cfad3891b7bf9bd3e566b9b7ab4553d ("s390/pkey: add CCA =
AES cipher key support")
>>>
>>> With that patch description, the Fixes tag is wrong...but (see below)
>>
>> I wonder about such a conclusion together with your subsequent feedback=
.
>
> Please try to read and understand what other people write.

I am also trying as usual.


> My point was that your patch description only talks about refactoring
> and avoiding code duplication.

These implementation details are mentioned.


> So you do not claim to have fixed anything.

We have got a different understanding for the provided wording.


> You claim to have refactored things to avoid code duplication.

The reused code can reduce the probability for programming mistakes,
can't it?


> And no, refactoring is NOT a fix.

Software development opinions vary around such a view, don't they?


> That fact that you fix a bug was obviously just by accident.

I can follow this view to some degree.


> So you have not even noticed that your change was actually chaning
> the logical flow of the code.

I suggested to improve two function implementations.


> Now: When you change the patch description explaining what you fix,
> a Fixes tag is appropriate.

Can such a disagreement be resolved by adding the information
to the change description that an incomplete exception handling
(which can trigger a memory leak) should be replaced by hopefully
better functionality?

Regards,
Markus
