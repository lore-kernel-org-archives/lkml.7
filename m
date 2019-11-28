Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9945CC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6894221741
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEPZhSOk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfK1LXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:23:18 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47376 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbfK1LXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574940195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=aGoVj5If+G1SY0s+s1S/adEuG3SMz1NIzlDkSDuLvRs=;
        b=PEPZhSOka6tg8IuKEjUYBWDO/LU2v7TYz3jai22DITBgja6s4HWt5XXWbxx94P4lhoJUY8
        RAXY+vds6xVXiznv8kqHqAiHbeqLaFm+DcFZaKqbQDET5SgZRD3MLHEXCE9p9UoiD5YdvI
        3hFuvqLdWHuSDizWTbZMtchE8DOmDY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-vJKzzGPfM6eHCC3LxifiOA-1; Thu, 28 Nov 2019 06:23:12 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0A01005510;
        Thu, 28 Nov 2019 11:23:10 +0000 (UTC)
Received: from [10.36.116.124] (ovpn-116-124.ams2.redhat.com [10.36.116.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 054C3600C8;
        Thu, 28 Nov 2019 11:23:08 +0000 (UTC)
Subject: Re: [PATCH v1] drivers/base/node.c: get rid of get_nid_for_pfn()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191128102051.GI26807@dhcp22.suse.cz>
 <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAj4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
 BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
 8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
 xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
 jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
 s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
 m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
 MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
 z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
 dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
 UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
 7ut6OL64oAq+uQINBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
 uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
 0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
 2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
 xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
 8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
 hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
 u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
 gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
 rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABiQIl
 BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
 KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
 NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
 YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
 lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
 qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
 C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
 W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
 TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
 +8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c8d2225f-9a90-65fa-5553-f4af8ca39b44@redhat.com>
Date:   Thu, 28 Nov 2019 12:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5E2F5866-0605-4DD2-9AEA-4B1C44E57D9F@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vJKzzGPfM6eHCC3LxifiOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.19 11:25, David Hildenbrand wrote:
>=20
>=20
>> Am 28.11.2019 um 11:20 schrieb Michal Hocko <mhocko@kernel.org>:
>>
>> =EF=BB=BFOn Wed 27-11-19 18:41:26, David Hildenbrand wrote:
>>> Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
>>> unregister_memory_block_under_nodes()") we only have a single user of
>>> get_nid_for_pfn(). Let's just inline that code and get rid of
>>> get_nid_for_pfn().
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>>> Cc: Michal Hocko <mhocko@kernel.org>
>>> Cc: Oscar Salvador <osalvador@suse.de>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> I am not really sure this is an improvement. The code is ugly as hell
>> and open coding it just makes register_mem_sect_under_node harder to
>> read.
>=20
> The issue I see is that this is a dangerous wrapper for pfn_to_nid() that=
 is absolutely not obvious. The old second user on the memory removal path =
was completely buggy. IMHO nobody should be reusing that function. But it l=
ooks like a general =E2=80=9Esafe wrapper to get a nid=E2=80=9C - it=E2=80=
=98s not.
>=20
> How can we make that more obvious instead?
>=20

What about something like this (untested):

From fc13fd540a1702592e389e821f6266098e41e2bd Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Wed, 27 Nov 2019 16:18:42 +0100
Subject: [PATCH] drivers/base/node.c: optimize get_nid_for_pfn()

Since commit d84f2f5a7552 ("drivers/base/node.c: simplify
unregister_memory_block_under_nodes()") we only have a single user of
get_nid_for_pfn(). The remaining user calls this function when booting -
where all added memory is online.

Make it clearer that this function should only be used during boot (
e.g., calling it on offline memory would be bad) by renaming the
function to something meaningful, optimize out the ifdef and the additional
system_state check, and add a comment why CONFIG_DEFERRED_STRUCT_PAGE_INIT
handling is in place at all.

Also, optimize the call site. There is no need to check against
page_nid < 0 - it will never match the nid (nid >=3D 0).

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/base/node.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 98a31bafc8a2..d525e30581de 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -744,14 +744,16 @@ int unregister_cpu_under_node(unsigned int cpu, unsig=
ned int nid)
 }
=20
 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-static int __ref get_nid_for_pfn(unsigned long pfn)
+static int __ref boot_pfn_to_nid(unsigned long pfn)
 {
 =09if (!pfn_valid_within(pfn))
 =09=09return -1;
-#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-=09if (system_state < SYSTEM_RUNNING)
+=09/*
+=09 * With deferred struct page initialization, the memmap will contain
+=09 * garbage - we have to rely on the early nid.
+=09 */
+=09if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
 =09=09return early_pfn_to_nid(pfn);
-#endif
 =09return pfn_to_nid(pfn);
 }
=20
@@ -766,8 +768,6 @@ static int register_mem_sect_under_node(struct memory_b=
lock *mem_blk,
 =09unsigned long pfn;
=20
 =09for (pfn =3D start_pfn; pfn <=3D end_pfn; pfn++) {
-=09=09int page_nid;
-
 =09=09/*
 =09=09 * memory block could have several absent sections from start.
 =09=09 * skip pfn range from absent section
@@ -783,13 +783,9 @@ static int register_mem_sect_under_node(struct memory_=
block *mem_blk,
 =09=09 * case, during hotplug we know that all pages in the memory
 =09=09 * block belong to the same node.
 =09=09 */
-=09=09if (system_state =3D=3D SYSTEM_BOOTING) {
-=09=09=09page_nid =3D get_nid_for_pfn(pfn);
-=09=09=09if (page_nid < 0)
-=09=09=09=09continue;
-=09=09=09if (page_nid !=3D nid)
-=09=09=09=09continue;
-=09=09}
+=09=09if (system_state =3D=3D SYSTEM_BOOTING &&
+=09=09    boot_pfn_to_nid(pfn) !=3D nid)
+=09=09=09continue;
=20
 =09=09/*
 =09=09 * If this memory block spans multiple nodes, we only indicate
--=20
2.21.0




--=20
Thanks,

David / dhildenb

