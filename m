Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73EDCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60462086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 19:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KdbRxK26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfKATAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 15:00:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27019 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727381AbfKATAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 15:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572634851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9M57mRafhBKlBx7kyeW2rEjhMq2trSs4j5mP/Onx38Y=;
        b=KdbRxK26s4kz6StrKxfZzfTvERz7nKcocRhodrEjJW/EmiwXrgWrw+9fJkYa4IUEXyloIu
        HLB8V6odQ4+gJwZDbXdl50UTpPBCKWFCY98+acEoTu7OoFOdHu3JvipEAhXlKGmf50HSzN
        gvdr7lkwBwW7SgbIUGBlUnXSUVL3LmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-oksEyQXnPEiMEhhCu8H4DQ-1; Fri, 01 Nov 2019 15:00:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DEF8800EB6;
        Fri,  1 Nov 2019 19:00:46 +0000 (UTC)
Received: from [10.36.116.26] (ovpn-116-26.ams2.redhat.com [10.36.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34182165DA;
        Fri,  1 Nov 2019 19:00:44 +0000 (UTC)
Subject: Re: [PATCH] drivers/base/memory.c: memory subsys init: skip search
 for missing blocks
To:     Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nathanl@linux.ibm.com, ricklind@linux.vnet.ibm.com
References: <20191101181054.11521-1-cheloha@linux.vnet.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c702b775-4a38-bc97-c67f-83f986bbe5fa@redhat.com>
Date:   Fri, 1 Nov 2019 20:00:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191101181054.11521-1-cheloha@linux.vnet.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: oksEyQXnPEiMEhhCu8H4DQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.11.19 19:10, Scott Cheloha wrote:
> Add a flag to init_memory_block() to  enable/disable searching for a
> matching block before creating a device for the block and adding it to
> the memory subsystem's bus.
>=20
> When the memory subsystem is being initialized there is no need to check
> if a given block has already been added to its bus.  The bus is new, so t=
he
> block in question cannot yet have a corresponding device.
>=20
> The search for a missing block is O(n) so this saves substantial time at
> boot if there are many such blocks to add.
>=20
> Signed-off-by: Scott Cheloha <cheloha@linux.vnet.ibm.com>
> ---
>   drivers/base/memory.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 55907c27075b..1160df4a8feb 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -643,17 +643,21 @@ int register_memory(struct memory_block *memory)
>   }
>  =20
>   static int init_memory_block(struct memory_block **memory,
> -=09=09=09     unsigned long block_id, unsigned long state)
> +=09=09=09     unsigned long block_id, unsigned long state,
> +=09=09=09     bool may_exist)
>   {
>   =09struct memory_block *mem;
>   =09unsigned long start_pfn;
>   =09int ret =3D 0;
>  =20
> -=09mem =3D find_memory_block_by_id(block_id);
> -=09if (mem) {
> -=09=09put_device(&mem->dev);
> -=09=09return -EEXIST;
> +=09if (may_exist) {
> +=09=09mem =3D find_memory_block_by_id(block_id);
> +=09=09if (mem) {
> +=09=09=09put_device(&mem->dev);
> +=09=09=09return -EEXIST;
> +=09=09}

No, I don't really like that. Can we please speed up the lookup via a=20
radix tree as noted in the comment of "find_memory_block()".

/*
  * For now, we have a linear search to go find the appropriate
  * memory_block corresponding to a particular phys_index. If
  * this gets to be a real problem, we can always use a radix
  * tree or something here.
  *
  * This could be made generic for all device subsystems.
  */

This will speed up all users of walk_memory_blocks() similarly.
Especially, it will also speed up link_mem_sections() used during boot,=20
which relies on walk_memory_blocks().

--=20

Thanks,

David / dhildenb

