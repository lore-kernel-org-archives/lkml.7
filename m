Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07094ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1752053B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 02:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407159AbfJQCeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 22:34:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392062AbfJQCeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 22:34:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED16410DCC97;
        Thu, 17 Oct 2019 02:34:07 +0000 (UTC)
Received: from [10.72.12.185] (ovpn-12-185.pek2.redhat.com [10.72.12.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 138295D9DC;
        Thu, 17 Oct 2019 02:34:00 +0000 (UTC)
Subject: Re: [PATCH 2/2] virtio_ring: Use DMA API if memory is encrypted
To:     Christoph Hellwig <hch@lst.de>, Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        benh@kernel.crashing.org, david@gibson.dropbear.id.au,
        mpe@ellerman.id.au, paulus@ozlabs.org, mdroth@linux.vnet.ibm.com,
        aik@linux.ibm.com, paul.burton@mips.com, robin.murphy@arm.com,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        andmike@us.ibm.com, sukadev@linux.vnet.ibm.com
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-2-git-send-email-linuxram@us.ibm.com>
 <1570843519-8696-3-git-send-email-linuxram@us.ibm.com>
 <20191015073501.GA32345@lst.de>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <398dce4b-9290-0b14-28b1-e521331ec309@redhat.com>
Date:   Thu, 17 Oct 2019 10:33:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015073501.GA32345@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 17 Oct 2019 02:34:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/10/15 下午3:35, Christoph Hellwig wrote:
> On Fri, Oct 11, 2019 at 06:25:19PM -0700, Ram Pai wrote:
>> From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>>
>> Normally, virtio enables DMA API with VIRTIO_F_IOMMU_PLATFORM, which must
>> be set by both device and guest driver. However, as a hack, when DMA API
>> returns physical addresses, guest driver can use the DMA API; even though
>> device does not set VIRTIO_F_IOMMU_PLATFORM and just uses physical
>> addresses.
> Sorry, but this is a complete bullshit hack.  Driver must always use
> the DMA API if they do DMA, and if virtio devices use physical addresses
> that needs to be returned through the platform firmware interfaces for
> the dma setup.  If you don't do that yet (which based on previous
> informations you don't), you need to fix it, and we can then quirk
> old implementations that already are out in the field.
>
> In other words: we finally need to fix that virtio mess and not pile
> hacks on top of hacks.


I agree, the only reason for IOMMU_PLATFORM is to make sure guest works 
for some old and buggy qemu when vIOMMU is enabled which seems useless 
(note we don't even support vIOMMU migration in that case).

Thanks

