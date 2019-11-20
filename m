Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFEC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BD522311
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZR6PatP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfKTKSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:18:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57972 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728513AbfKTKS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:18:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574245108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xWcoDmmt3hOnbNOgoE5dQlhwSeBPgNfYdupdAnlBkc8=;
        b=IZR6PatPkFleYIgXw9JCWzyGL3dpl3FVKNScKIxV80feWYoY8PH2Z4KDt6VF88JBQ8rGGz
        V2+/b5zZbhpBlHtF2UlBjUYUT6bvAjzG2yr/dCrixwiLugev29SzisH+lHEo/M1TJWi6xq
        Cbs1I4H6MqdKAQYH3jybe4v0W2BdySU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-5HWBhLnLMeGUl4cuPBFxxQ-1; Wed, 20 Nov 2019 05:18:25 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BA40801E6A;
        Wed, 20 Nov 2019 10:18:21 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 694F71968D;
        Wed, 20 Nov 2019 10:18:14 +0000 (UTC)
Subject: Re: [PATCH v9 00/11] SMMUv3 Nested Stage Setup (VFIO part)
To:     Tomasz Nowicki <tnowicki@marvell.com>,
        "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
Cc:     "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
        "vincent.stehle@arm.com" <vincent.stehle@arm.com>,
        "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>,
        "tina.zhang@intel.com" <tina.zhang@intel.com>
References: <20190711135625.20684-1-eric.auger@redhat.com>
 <a35234a6-e386-fc8e-fcc4-5db4601b00d2@marvell.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <3741c034-08f1-9dbb-ab06-434f3a8bd782@redhat.com>
Date:   Wed, 20 Nov 2019 11:18:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a35234a6-e386-fc8e-fcc4-5db4601b00d2@marvell.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5HWBhLnLMeGUl4cuPBFxxQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On 11/20/19 9:15 AM, Tomasz Nowicki wrote:
> Hi Eric,
>=20
> On 11.07.2019 15:56, Eric Auger wrote:
>> This series brings the VFIO part of HW nested paging support
>> in the SMMUv3.
>>
>> The series depends on:
>> [PATCH v9 00/14] SMMUv3 Nested Stage Setup (IOMMU part)
>> (https://www.spinics.net/lists/kernel/msg3187714.html)
>>
>> 3 new IOCTLs are introduced that allow the userspace to
>> 1) pass the guest stage 1 configuration
>> 2) pass stage 1 MSI bindings
>> 3) invalidate stage 1 related caches
>>
>> They map onto the related new IOMMU API functions.
>>
>> We introduce the capability to register specific interrupt
>> indexes (see [1]). A new DMA_FAULT interrupt index allows to register
>> an eventfd to be signaled whenever a stage 1 related fault
>> is detected at physical level. Also a specific region allows
>> to expose the fault records to the user space.
>>
>> Best Regards
>>
>> Eric
>>
>> This series can be found at:
>> https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9
>=20
> I think you have already tested on ThunderX2, but as a formality, for=20
> the whole series:
>=20
> Tested-by: Tomasz Nowicki <tnowicki@marvell.com>
> qemu: https://github.com/eauger/qemu/tree/v4.1.0-rc0-2stage-rfcv5
> kernel: https://github.com/eauger/linux/tree/v5.3.0-rc0-2stage-v9 +=20
> Shameer's fix patch
>=20
> In my test I assigned Intel 82574L NIC and perform iperf tests.

Thank you for your testing efforts.
>=20
> Other folks from Marvell claimed this to be important feature so I asked=
=20
> them to review and speak up on mailing list.

That's nice to read that!  So it is time for me to rebase both the iommu
and vfio parts. I will submit something quickly. Then I would encourage
the review efforts to focus first on the iommu part.

Thanks

Eric
>=20
> Thanks,
> Tomasz
>=20

