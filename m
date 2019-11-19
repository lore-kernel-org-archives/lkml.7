Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABFCC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FE6222EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IFSZpNzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKSIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:04:21 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49115 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfKSIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574150660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oip8BzctxYCGZPVW7Cfu80LxQBppTw5snSXechb1Hrs=;
        b=IFSZpNzUUVSu52kG9fCB8LyattwM/hNHUfxxHWruXoBAQkNBjJa/TCA4eyk7G4ija8+rQ2
        90hB9tclLUgcbmINX3N4GXDJuCWt/bmzxglRNWkgEy7Od9jhTWCMCPcVP0Qt9C7Us8e3OC
        awz8dxAIKxCxPfe7SFnGZ5OllmNFvd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-90Y80ZSfNmGJW1iF4g-Hpw-1; Tue, 19 Nov 2019 03:04:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1109B2EDD;
        Tue, 19 Nov 2019 08:04:14 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E39B75F765;
        Tue, 19 Nov 2019 08:04:11 +0000 (UTC)
Subject: Re: [PATCH v2 04/10] iommu/vt-d: Match CPU and IOMMU paging mode
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <601ca9c3-9f83-3d95-8d26-d4f46eee82ba@redhat.com>
 <20191118135238.49f5d957@jacob-builder>
 <ad3c3d58-dd1a-4b83-8b30-31e5be9e9c39@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <a6a6884e-7209-e906-905b-818858b97482@redhat.com>
Date:   Tue, 19 Nov 2019 09:04:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ad3c3d58-dd1a-4b83-8b30-31e5be9e9c39@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 90Y80ZSfNmGJW1iF4g-Hpw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu, Jacob,

On 11/19/19 4:06 AM, Lu Baolu wrote:
> Hi Eric and Jacob,
>=20
> On 11/19/19 5:52 AM, Jacob Pan wrote:
>> On Mon, 18 Nov 2019 21:55:03 +0100
>> Auger Eric <eric.auger@redhat.com> wrote:
>>
>>> Hi Jacob,
>>>
>>> On 11/18/19 8:42 PM, Jacob Pan wrote:
>>>> When setting up first level page tables for sharing with CPU, we
>>>> need to ensure IOMMU can support no less than the levels supported
>>>> by the CPU.
>>>> It is not adequate, as in the current code, to set up 5-level paging
>>>> in PASID entry First Level Paging Mode(FLPM) solely based on CPU.
>>>>
>>>> Fixes: 437f35e1cd4c8 ("iommu/vt-d: Add first level page table
>>>> interface")
>>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>> =C2=A0 drivers/iommu/intel-pasid.c | 12 ++++++++++--
>>>> =C2=A0 1 file changed, 10 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel-pasid.c
>>>> b/drivers/iommu/intel-pasid.c index 040a445be300..e7cb0b8a7332
>>>> 100644 --- a/drivers/iommu/intel-pasid.c
>>>> +++ b/drivers/iommu/intel-pasid.c
>>>> @@ -499,8 +499,16 @@ int intel_pasid_setup_first_level(struct
>>>> intel_iommu *iommu, }
>>>> =C2=A0 =C2=A0 #ifdef CONFIG_X86
>>>> -=C2=A0=C2=A0=C2=A0 if (cpu_feature_enabled(X86_FEATURE_LA57))
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pasid_set_flpm(pte, 1);
>>>> +=C2=A0=C2=A0=C2=A0 /* Both CPU and IOMMU paging mode need to match */
>>>> +=C2=A0=C2=A0=C2=A0 if (cpu_feature_enabled(X86_FEATURE_LA57)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cap_5lp_support(iommu-=
>cap)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
sid_set_flpm(pte, 1);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
_err("VT-d has no 5-level paging support
>>>> for CPU\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pa=
sid_clear_entry(pte);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -EINVAL;
>>> Can it happen? If I am not wrong intel_pasid_setup_first_level() only
>>> seems to be called from intel_svm_bind_mm which now checks the
>>> SVM_CAPABLE flag.
>>>
>> You are right, this check is not needed any more. I will drop the patch.
>>> Thanks
>=20
> I'd suggest to keep this. This helper is not only for svm, although
> currently svm is the only caller. For first level pasid setup, let's
> set an assumption that hardware should never report mismatching paging
> modes, this is helpful especially when running vIOMMU in VM guests.

OK. So maybe just add the rationale in the commit message?

Thanks

Eric
>=20
> Best regards,
> baolu
>=20

