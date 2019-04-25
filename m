Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC88C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8943217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbfDYHkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:40:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbfDYHkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:40:37 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2D2130882A5;
        Thu, 25 Apr 2019 07:40:36 +0000 (UTC)
Received: from [10.36.116.17] (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FDF01001DDE;
        Thu, 25 Apr 2019 07:40:33 +0000 (UTC)
Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1556062279-64135-10-git-send-email-jacob.jun.pan@linux.intel.com>
 <143adac1-d58b-dde6-593b-74ea71da73c8@redhat.com>
 <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c847182b-6e5c-5344-a162-29e273a489fb@redhat.com>
Date:   Thu, 25 Apr 2019 09:40:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439E840F5@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 25 Apr 2019 07:40:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On 4/25/19 9:12 AM, Liu, Yi L wrote:
> Hi Eric,
> 
>> From: Auger Eric [mailto:eric.auger@redhat.com]
>> Sent: Thursday, April 25, 2019 1:28 AM
>> To: Jacob Pan <jacob.jun.pan@linux.intel.com>; iommu@lists.linux-foundation.org;
>> Subject: Re: [PATCH v2 09/19] iommu/vt-d: Enlightened PASID allocation
>>
>> Hi Jacob,
>>
>> On 4/24/19 1:31 AM, Jacob Pan wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>
>>> If Intel IOMMU runs in caching mode, a.k.a. virtual IOMMU, the IOMMU
>>> driver should rely on the emulation software to allocate and free
>>> PASID IDs.
>> Do we make the decision depending on the CM or depending on the VCCAP_REG?
>>
>> VCCAP_REG description says:
>>
>> If Set, software must use Virtual Command Register interface to allocate and free
>> PASIDs.
> 
> The answer is it depends on the ECAP.VCS and then the PASID allocation bit in
> VCCAP_REG. But VCS bit implies the iommu is a software implementation
> (vIOMMU) of vt-d architecture. Pls refer to the descriptions of "Virtual
> Command Support" in vt-d 3.0 spec.
> 
> "Hardware implementations of this architecture report a value of 0
> in this field. Software implementations (emulation) of this
> architecture may report VCS=1."

OK I understand. But strictly speaking a vIOMMU may not implement CM.
But that's nitpicking ;-)

Thanks

Eric
> 
> Thanks,
> Yi Liu
> 
