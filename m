Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C437C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED226218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eX2VKtNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbfC2UHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:07:48 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3062 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfC2UHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:07:47 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9e7b150000>; Fri, 29 Mar 2019 13:07:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 29 Mar 2019 13:07:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 29 Mar 2019 13:07:45 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 20:07:45 +0000
Subject: Re: [PATCH v2 02/11] mm/hmm: use reference counting for HMM struct v2
To:     Jerome Glisse <jglisse@redhat.com>, Ira Weiny <ira.weiny@intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190328110719.GA31324@iweiny-DESK2.sc.intel.com>
 <20190328191122.GA5740@redhat.com>
 <c8fd897f-b9d3-a77b-9898-78e20221ba44@nvidia.com>
 <20190328212145.GA13560@redhat.com>
 <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
 <20190328165708.GH31324@iweiny-DESK2.sc.intel.com>
 <20190329010059.GB16680@redhat.com>
 <55dd8607-c91b-12ab-e6d7-adfe6d9cb5e2@nvidia.com>
 <20190329015003.GE16680@redhat.com>
 <20190328182100.GJ31324@iweiny-DESK2.sc.intel.com>
 <20190329022519.GJ16680@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <144f034d-9688-5aad-7b68-34e1d4b08228@nvidia.com>
Date:   Fri, 29 Mar 2019 13:07:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190329022519.GJ16680@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553890069; bh=GSqEMrrxwhxreIUm3fGaxmGkN2Y6WWPBPr8DyC7ajdk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eX2VKtNMLTYQHApWKfo7Py4nw6DR6FufYnyTH7xN4/q7QHLQD4wa6pyTXQ8yQIOxu
         37jg/uGN19UB4Wnf8zGU0jz9+URnrPDJSCGL9ii8yJY9Vd67CKrmaaZwfpkeZ8tfmA
         +7IoQ7vzHyMuQFJ9ClsU8RL0znbOjUymNa8Iza2TeqQhpdRkpajBzGilV2Q4RYimLW
         FcPW5d8bhLF395MQsSi15im16UUj2Lw4cKorTKdV6+ahGKIMcQvEupqXqogfjsvFaY
         MLRyJC2y/5BmmZcUvpqJDq+6eLiALwHMWLJ7YoBVuarVFIoavfG2Ln8j4ur9eM4CdS
         j+rDjaJoVGyJQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 7:25 PM, Jerome Glisse wrote:
[...]
>> The input value is not the problem.  The problem is in the naming.
>>
>> obj = get_obj( various parameters );
>> put_obj(obj);
>>
>>
>> The problem is that the function is named hmm_register() either "gets" a
>> reference to _or_ creates and gets a reference to the hmm object.
>>
>> What John is probably ready to submit is something like.
>>
>> struct hmm *get_create_hmm(struct mm *mm);
>> void put_hmm(struct hmm *hmm);
>>
>>
>> So when you are reading the code you see...
>>
>> foo(...) {
>> 	struct hmm *hmm = get_create_hmm(mm);
>>
>> 	if (!hmm)
>> 		error...
>>
>> 	do stuff...
>>
>> 	put_hmm(hmm);
>> }
>>
>> Here I can see a very clear get/put pair.  The name also shows that the hmm is
>> created if need be as well as getting a reference.
>>
> 
> You only need to create HMM when you either register a mirror or
> register a range. So they two pattern:
> 
>     average_foo() {
>         struct hmm *hmm = mm_get_hmm(mm);
>         ...
>         hmm_put(hmm);
>     }
> 
>     register_foo() {
>         struct hmm *hmm = hmm_register(mm);
>         ...
>         return 0;
>     error:
>         ...
>         hmm_put(hmm);
>     }
> 

1. Looking at this fresh this morning, Ira's idea of just a single rename
actually clarifies things a lot more than I expected. I think the following
tiny patch would suffice here (I've updated documentation to match, and added
a missing "@Return:" line too):

iff --git a/mm/hmm.c b/mm/hmm.c
index fd143251b157..37b1c5803f1e 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -50,14 +50,17 @@ static inline struct hmm *mm_get_hmm(struct mm_struct *mm)
 }
 
 /*
- * hmm_register - register HMM against an mm (HMM internal)
+ * hmm_get_create - returns an HMM object, either by referencing the existing
+ * (per-process) object, or by creating a new one.
  *
- * @mm: mm struct to attach to
+ * @mm: the mm_struct to attach to
+ * @Return: a pointer to the HMM object, or NULL upon failure. This pointer must
+ * be released, when done, via hmm_put().
  *
- * This is not intended to be used directly by device drivers. It allocates an
- * HMM struct if mm does not have one, and initializes it.
+ * This is an internal HMM function, and is not intended to be used directly by
+ * device drivers.
  */
-static struct hmm *hmm_register(struct mm_struct *mm)
+static struct hmm *hmm_get_create(struct mm_struct *mm)
 {
        struct hmm *hmm = mm_get_hmm(mm);
        bool cleanup = false;
@@ -288,7 +291,7 @@ int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)
        if (!mm || !mirror || !mirror->ops)
                return -EINVAL;
 
-       mirror->hmm = hmm_register(mm);
+       mirror->hmm = hmm_get_create(mm);
        if (!mirror->hmm)
                return -ENOMEM;
 
@@ -915,7 +918,7 @@ int hmm_range_register(struct hmm_range *range,
        range->start = start;
        range->end = end;
 
-       range->hmm = hmm_register(mm);
+       range->hmm = hmm_get_create(mm);
        if (!range->hmm)
                return -EFAULT;




2. A not directly related point: did you see my minor comment on patch 0001? I think it might have been missed in all the threads yesterday.



thanks,
-- 
John Hubbard
NVIDIA
