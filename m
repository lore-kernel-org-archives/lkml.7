Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8005CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8518021734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PveQaMb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfKATUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:20:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727473AbfKATUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572636047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAxCReDvzOOVANEvxTcXcQTXnDAm8MoZjxGkABYHRaQ=;
        b=PveQaMb2Ve9lzbOSZbrw0i02Dk/9AP3qxwHmRR9zqiY2XgEHxL24O2eJgSwjSpUPd70RKn
        TM4cgG1jI9pY40XidJJ2HCqxdd+o3uFOnSZKYRqbFv4TwXEd11fBbyi6CG9Y4s/9HYv2+m
        EEd4ntjRmYoU/q7AqIksUVR381Lg7lo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-8g-9MqUZP8CAWcDvn2O8kQ-1; Fri, 01 Nov 2019 15:20:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E85321005502;
        Fri,  1 Nov 2019 19:20:42 +0000 (UTC)
Received: from [10.36.116.26] (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD1D5C21B;
        Fri,  1 Nov 2019 19:20:41 +0000 (UTC)
Subject: Re: [PATCH] drivers/base/memory.c: memory subsys init: skip search
 for missing blocks
From:   David Hildenbrand <david@redhat.com>
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com
References: <20191101181054.11521-1-cheloha@linux.vnet.ibm.com>
 <c702b775-4a38-bc97-c67f-83f986bbe5fa@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8e769009-b69c-8a2f-a7b3-46e1ce0fe8be@redhat.com>
Date:   Fri, 1 Nov 2019 20:20:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <c702b775-4a38-bc97-c67f-83f986bbe5fa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 8g-9MqUZP8CAWcDvn2O8kQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.19 20:00, David Hildenbrand wrote:
> On 01.11.19 19:10, Scott Cheloha wrote:
>> Add a flag to init_memory_block() to  enable/disable searching for a
>> matching block before creating a device for the block and adding it to
>> the memory subsystem's bus.
>>
>> When the memory subsystem is being initialized there is no need to check
>> if a given block has already been added to its bus.  The bus is new, so =
the
>> block in question cannot yet have a corresponding device.
>>
>> The search for a missing block is O(n) so this saves substantial time at
>> boot if there are many such blocks to add.
>>
>> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
>> ---
>>    drivers/base/memory.c | 18 +++++++++++-------
>>    1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>> index 55907c27075b..1160df4a8feb 100644
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -643,17 +643,21 @@ int register_memory(struct memory_block *memory)
>>    }
>>   =20
>>    static int init_memory_block(struct memory_block **memory,
>> -=09=09=09     unsigned long block_id, unsigned long state)
>> +=09=09=09     unsigned long block_id, unsigned long state,
>> +=09=09=09     bool may_exist)
>>    {
>>    =09struct memory_block *mem;
>>    =09unsigned long start_pfn;
>>    =09int ret =3D 0;
>>   =20
>> -=09mem =3D find_memory_block_by_id(block_id);
>> -=09if (mem) {
>> -=09=09put_device(&mem->dev);
>> -=09=09return -EEXIST;
>> +=09if (may_exist) {
>> +=09=09mem =3D find_memory_block_by_id(block_id);
>> +=09=09if (mem) {
>> +=09=09=09put_device(&mem->dev);
>> +=09=09=09return -EEXIST;
>> +=09=09}
>=20
> No, I don't really like that. Can we please speed up the lookup via a
> radix tree as noted in the comment of "find_memory_block()".
>=20
> /*
>    * For now, we have a linear search to go find the appropriate
>    * memory_block corresponding to a particular phys_index. If
>    * this gets to be a real problem, we can always use a radix
>    * tree or something here.
>    *
>    * This could be made generic for all device subsystems.
>    */
>=20
> This will speed up all users of walk_memory_blocks() similarly.
> Especially, it will also speed up link_mem_sections() used during boot,
> which relies on walk_memory_blocks().
>=20

Also, I think this check that I added back than should not happen in the=20
wild. If we care, we could turn that into a=20
VM_BUG_ON(find_memory_block_by_id(block_id)).

--=20

Thanks,

David / dhildenb

