Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B07C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4312067C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfpmtvoM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfLPOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 09:36:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728014AbfLPOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 09:36:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576506962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ14lO5GOkJM4i4EgKkkmU/5WKLUz08i5Wp26RDpbTE=;
        b=KfpmtvoMC0JkRcir48ehy2vDNu+0f1n5X7ryS7ThwA3WgP/qwMkEM2M6p7MrHlENW0HOUo
        vQaQ9uu/78x197BYUVdoifsg+aJLFwipZP/nCskWvUC53iTaMp1d1Yiy8y98qDDuK71fZW
        55ZMguZ7JwrfXQCRr8LqMK+G1Rfavtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-LXB21lBOPK2lm7ONM2TbaA-1; Mon, 16 Dec 2019 09:35:59 -0500
X-MC-Unique: LXB21lBOPK2lm7ONM2TbaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 002521005502;
        Mon, 16 Dec 2019 14:35:58 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96C215C28C;
        Mon, 16 Dec 2019 14:35:55 +0000 (UTC)
Subject: Re: [PATCH v3] iommu: fix KASAN use-after-free in
 iommu_insert_resv_region
To:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     eric.auger.pro@gmail.com, Joerg Roedel <joro@8bytes.org>,
        hch@lst.de, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20191126102743.3269-1-eric.auger@redhat.com>
 <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <80da76c4-395a-18cc-1ffa-c3a0471921b0@redhat.com>
Date:   Mon, 16 Dec 2019 15:35:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0DE725CD-01CD-4E01-B817-9CC7F4768FBC@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 12/16/19 3:24 PM, Qian Cai wrote:
> 
> 
>> On Nov 26, 2019, at 5:27 AM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> In case the new region gets merged into another one, the nr
>> list node is freed. Checking its type while completing the
>> merge algorithm leads to a use-after-free. Use new->type
>> instead.
>>
>> Fixes: 4dbd258ff63e ("iommu: Revisit iommu_insert_resv_region()
>> implementation")
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Qian Cai <cai@lca.pw>
>> Cc: Stable <stable@vger.kernel.org> #v5.3+
> 
> 
> Looks like Joerg is away for a few weeks. Could Andrew or Linus pick up this 
> use-after-free?
Thanks for the heads up. Indeed I was wondering why it hasn't been taken
yet.

Note the right version to pick up is the v4, reviewed by Jerry:
https://www.mail-archive.com/iommu@lists.linux-foundation.org/msg36226.html

Thanks

Eric
> 
>>
>> ---
>>
>> v2 -> v3:
>> - directly use new->type
>>
>> v1 -> v2:
>> - remove spurious new line
>> ---
>> drivers/iommu/iommu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index d658c7c6a2ab..285ad4a4c7f2 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -313,7 +313,7 @@ int iommu_insert_resv_region(struct iommu_resv_region *new,
>> 		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
>>
>> 		/* no merge needed on elements of different types than @nr */
>> -		if (iter->type != nr->type) {
>> +		if (iter->type != new->type) {
>> 			list_move_tail(&iter->list, &stack);
>> 			continue;
>> 		}
>> -- 
>> 2.20.1
>>
> 

