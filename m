Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE55FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAE62081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCIB6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:58:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:45619 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbfCIB6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:58:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 17:58:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,458,1544515200"; 
   d="scan'208";a="124395894"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2019 17:58:50 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Tom Murphy <tmurphy@arista.com>,
        Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
To:     James Sewart <jamessewart@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
 <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
 <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
Date:   Sat, 9 Mar 2019 09:53:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 3/9/19 12:57 AM, James Sewart wrote:
> Hey Lu,
> 
>> On 8 Mar 2019, at 03:09, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>>
>>>> Do you mind if I work on top of your patches for further cleanups and
>>>> sign off a v2 together with you?
>>> Sure, sounds good. I’ll fixup patch 3 and have a go at integrating
>>> iommu_prepare_isa into get_resv_regions. This should make the initial
>>> domain logic here quite concise.
>> Here attached three extra patches which I think should be added before
>> PATCH 3/4, and some further cleanup changes which you can merge with
>> PATCH 4/4.
>>
>> ----------------
>>
>> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
>> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>>
>> These two patches aim to add a generic method for vendor specific iommu
>> drivers to specify the type of the default domain for a device. Intel
>> iommu driver will register an ops for this since it already has its own
>> identity map adjudicator for a long time.
> This seems like a good idea, but as domain alloc is only called for the
> default domain on first device attached to a group, we may miss checking
> whether a device added later should have an identity domain. Should there
> be paths to downgrade a groups domain if one of the devices requires one?
> 

Good catch!

This is supposed to be handled in iommu_no_mapping(). But, obviously
current code sticks to lazy domain allocation. I'm not sure whether
there are any real such cases, but we should handle it in a clean way.
My idea is that we could downgrade to multiple domains per group (just
like what we have now) in this case and print a kernel message for this.

Or any other thoughts?

Best regards,
Lu Baolu
