Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE78C10F06
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D427206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T/6lVXUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfC2BSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:18:38 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10959 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2BSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 21:18:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d726f0000>; Thu, 28 Mar 2019 18:18:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 18:18:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 18:18:35 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 01:18:35 +0000
Subject: Re: [PATCH v2 02/11] mm/hmm: use reference counting for HMM struct v2
To:     Jerome Glisse <jglisse@redhat.com>, Ira Weiny <ira.weiny@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-3-jglisse@redhat.com>
 <20190328110719.GA31324@iweiny-DESK2.sc.intel.com>
 <20190328191122.GA5740@redhat.com>
 <c8fd897f-b9d3-a77b-9898-78e20221ba44@nvidia.com>
 <20190328212145.GA13560@redhat.com>
 <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
 <20190328165708.GH31324@iweiny-DESK2.sc.intel.com>
 <20190329010059.GB16680@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <55dd8607-c91b-12ab-e6d7-adfe6d9cb5e2@nvidia.com>
Date:   Thu, 28 Mar 2019 18:18:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190329010059.GB16680@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553822319; bh=2/FR0Ry1UStrvREskYdSc/DwdYAa2zhZDQ2e+lmbW5g=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=T/6lVXUUap0qBw04TUUtpmg+YkSegkIY+NWmt+r0UgJpBDI/sNDaIVYbN7B5qqVgE
         axRubf5TBqIjxm2nnQj44JyIOwX+sXT+Kv+WwuH4wxHAEz7nKO7rSsrQnFwJxorWAb
         tq9Fx1iIkpy9ljeb3FRY9efNCjzrUKHoenFrpHPXUvqT+2PYKG1aLKbOq1VIEA9Amk
         bn2G/PxOxqVkAPRd2lMamaztqw6UjEG7spn30p1VeztwxgiOwZBmMhESCctVGZSeUh
         6hyOmd+r2twzUt+LUKUgu/3CnHCK6u0o/bwaMsx/z7dVNkMMohlK4DpCrxswuUebE1
         vzVgCN0ft9zUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:00 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 09:57:09AM -0700, Ira Weiny wrote:
>> On Thu, Mar 28, 2019 at 05:39:26PM -0700, John Hubbard wrote:
>>> On 3/28/19 2:21 PM, Jerome Glisse wrote:
>>>> On Thu, Mar 28, 2019 at 01:43:13PM -0700, John Hubbard wrote:
>>>>> On 3/28/19 12:11 PM, Jerome Glisse wrote:
>>>>>> On Thu, Mar 28, 2019 at 04:07:20AM -0700, Ira Weiny wrote:
>>>>>>> On Mon, Mar 25, 2019 at 10:40:02AM -0400, Jerome Glisse wrote:
>>>>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>> [...]
>>>>>>>> @@ -67,14 +78,9 @@ struct hmm {
>>>>>>>>   */
>>>>>>>>  static struct hmm *hmm_register(struct mm_struct *mm)
>>>>>>>>  {
>>>>>>>> -	struct hmm *hmm =3D READ_ONCE(mm->hmm);
>>>>>>>> +	struct hmm *hmm =3D mm_get_hmm(mm);
>>>>>>>
>>>>>>> FWIW: having hmm_register =3D=3D "hmm get" is a bit confusing...
>>>>>>
>>>>>> The thing is that you want only one hmm struct per process and thus
>>>>>> if there is already one and it is not being destroy then you want to
>>>>>> reuse it.
>>>>>>
>>>>>> Also this is all internal to HMM code and so it should not confuse
>>>>>> anyone.
>>>>>>
>>>>>
>>>>> Well, it has repeatedly come up, and I'd claim that it is quite=20
>>>>> counter-intuitive. So if there is an easy way to make this internal=20
>>>>> HMM code clearer or better named, I would really love that to happen.
>>>>>
>>>>> And we shouldn't ever dismiss feedback based on "this is just interna=
l
>>>>> xxx subsystem code, no need for it to be as clear as other parts of t=
he
>>>>> kernel", right?
>>>>
>>>> Yes but i have not seen any better alternative that present code. If
>>>> there is please submit patch.
>>>>
>>>
>>> Ira, do you have any patch you're working on, or a more detailed sugges=
tion there?
>>> If not, then I might (later, as it's not urgent) propose a small cleanu=
p patch=20
>>> I had in mind for the hmm_register code. But I don't want to duplicate =
effort=20
>>> if you're already thinking about it.
>>
>> No I don't have anything.
>>
>> I was just really digging into these this time around and I was about to
>> comment on the lack of "get's" for some "puts" when I realized that
>> "hmm_register" _was_ the get...
>>
>> :-(
>>
>=20
> The get is mm_get_hmm() were you get a reference on HMM from a mm struct.
> John in previous posting complained about me naming that function hmm_get=
()
> and thus in this version i renamed it to mm_get_hmm() as we are getting
> a reference on hmm from a mm struct.

Well, that's not what I recommended, though. The actual conversation went l=
ike
this [1]:

---------------------------------------------------------------
>> So for this, hmm_get() really ought to be symmetric with
>> hmm_put(), by taking a struct hmm*. And the null check is
>> not helping here, so let's just go with this smaller version:
>>
>> static inline struct hmm *hmm_get(struct hmm *hmm)
>> {
>>     if (kref_get_unless_zero(&hmm->kref))
>>         return hmm;
>>
>>     return NULL;
>> }
>>
>> ...and change the few callers accordingly.
>>
>
> What about renaning hmm_get() to mm_get_hmm() instead ?
>

For a get/put pair of functions, it would be ideal to pass
the same argument type to each. It looks like we are passing
around hmm*, and hmm retains a reference count on hmm->mm,
so I think you have a choice of using either mm* or hmm* as
the argument. I'm not sure that one is better than the other
here, as the lifetimes appear to be linked pretty tightly.

Whichever one is used, I think it would be best to use it
in both the _get() and _put() calls.=20
---------------------------------------------------------------

Your response was to change the name to mm_get_hmm(), but that's not
what I recommended.

>=20
> The hmm_put() is just releasing the reference on the hmm struct.
>=20
> Here i feel i am getting contradicting requirement from different people.
> I don't think there is a way to please everyone here.
>=20

That's not a true conflict: you're comparing your actual implementation
to Ira's request, rather than comparing my request to Ira's request.

I think there's a way forward. Ira and I are actually both asking for the
same thing:

a) clear, concise get/put routines

b) avoiding odd side effects in functions that have one name, but do
additional surprising things.

[1] https://lore.kernel.org/r/1ccab0d3-7e90-8e39-074d-02ffbfc68480@nvidia.c=
om

thanks,
--=20
John Hubbard
NVIDIA

