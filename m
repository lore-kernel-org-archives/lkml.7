Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFECC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8237C2230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXG0GcG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfKSICi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 03:02:38 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30837 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbfKSICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 03:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574150556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eBN81lYF0LKZpaUGdEsCbpSGEXMtk1khkxIllPt2w8Y=;
        b=CXG0GcG14K1saLiov8YgE3OTwT9Mi+O0ZkqZd/CalANBvYRE+k0wsF358CCprk8hS3oceL
        vEXCgX5T/p5BF42zc4VRfZBOBjwgym0/TUQ1IOhTTZI3Go52Uo91i706OKsCo1yddXGDF+
        LVazsoEFNgPpsJU6jO2B0ehL9ko4hc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-PCDJ56K3N6aUmxqVHjKpDA-1; Tue, 19 Nov 2019 03:02:33 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63678805DE0;
        Tue, 19 Nov 2019 08:02:30 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E64C56404A;
        Tue, 19 Nov 2019 08:02:27 +0000 (UTC)
Subject: Re: [PATCH v2 02/10] iommu/vt-d: Fix CPU and IOMMU SVM feature
 matching checks
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <1574106153-45867-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574106153-45867-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <26d1e79b-3a16-0a8f-895e-e2c41c8d3b28@redhat.com>
 <20191118134719.6835981b@jacob-builder>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <3634dee5-3f9f-4618-951e-8bb5e4988223@redhat.com>
Date:   Tue, 19 Nov 2019 09:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191118134719.6835981b@jacob-builder>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PCDJ56K3N6aUmxqVHjKpDA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 11/18/19 10:47 PM, Jacob Pan wrote:
> On Mon, 18 Nov 2019 21:33:34 +0100
> Auger Eric <eric.auger@redhat.com> wrote:
>=20
>> Hi Jacob,
>>
>> On 11/18/19 8:42 PM, Jacob Pan wrote:
>>> The current code checks CPU and IOMMU feature set for SVM support
>>> but the result is never stored nor used. Therefore, SVM can still
>>> be used even when these checks failed. =20
>> "SVM can still be used even when these checks failed". What were the
>> consequences if it happened? Does it fix this cleanly now.
>>>
> The consequence is DMA cannot reach above 48-bit virtual address range
> when CPU does 5-level and IOMMU can only do 4-level. With is fix,
> svm_bind_mm will fail in the first place to prevent SVM use by DMA.
OK thank you for the clarification. Maybe this latter can be added in
the commit message
>=20
>>> This patch consolidates code for checking PASID, CPU vs. IOMMU
>>> paging mode compatibility, as well as provides specific error
>>> messages for each failed checks.>
>>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>  drivers/iommu/intel-iommu.c | 10 ++--------
>>>  drivers/iommu/intel-svm.c   | 40
>>> +++++++++++++++++++++++++++-------------
>>> include/linux/intel-iommu.h |  4 +++- 3 files changed, 32
>>> insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-iommu.c
>>> b/drivers/iommu/intel-iommu.c index 3f974919d3bd..d598168e410d
>>> 100644 --- a/drivers/iommu/intel-iommu.c
>>> +++ b/drivers/iommu/intel-iommu.c
>>> @@ -3289,10 +3289,7 @@ static int __init init_dmars(void)
>>> =20
>>>  =09=09if (!ecap_pass_through(iommu->ecap))
>>>  =09=09=09hw_pass_through =3D 0;
>>> -#ifdef CONFIG_INTEL_IOMMU_SVM
>>> -=09=09if (pasid_supported(iommu))
>>> -=09=09=09intel_svm_init(iommu);
>>> -#endif
>>> +=09=09intel_svm_check(iommu);
>>>  =09}
>>> =20
>>>  =09/*
>>> @@ -4471,10 +4468,7 @@ static int intel_iommu_add(struct
>>> dmar_drhd_unit *dmaru) if (ret)
>>>  =09=09goto out;
>>> =20
>>> -#ifdef CONFIG_INTEL_IOMMU_SVM
>>> -=09if (pasid_supported(iommu))
>>> -=09=09intel_svm_init(iommu);
>>> -#endif
>>> +=09intel_svm_check(iommu);
>>> =20
>>>  =09if (dmaru->ignored) {
>>>  =09=09/*
>>> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
>>> index 9b159132405d..716c543488f6 100644
>>> --- a/drivers/iommu/intel-svm.c
>>> +++ b/drivers/iommu/intel-svm.c
>>> @@ -23,19 +23,6 @@
>>> =20
>>>  static irqreturn_t prq_event_thread(int irq, void *d);
>>> =20
>>> -int intel_svm_init(struct intel_iommu *iommu)
>>> -{
>>> -=09if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
>>> -=09=09=09!cap_fl1gp_support(iommu->cap))
>>> -=09=09return -EINVAL;
>>> -
>>> -=09if (cpu_feature_enabled(X86_FEATURE_LA57) &&
>>> -=09=09=09!cap_5lp_support(iommu->cap))
>>> -=09=09return -EINVAL;
>>> -
>>> -=09return 0;
>>> -}
>>> -
>>>  #define PRQ_ORDER 0
>>> =20
>>>  int intel_svm_enable_prq(struct intel_iommu *iommu)
>>> @@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu
>>> *iommu) return 0;
>>>  }
>>> =20
>>> +static inline bool intel_svm_capable(struct intel_iommu *iommu)
>>> +{
>>> +=09return iommu->flags & VTD_FLAG_SVM_CAPABLE;
>>> +}
>>> +
>>> +void intel_svm_check(struct intel_iommu *iommu)
>>> +{
>>> +=09if (!pasid_supported(iommu))
>>> +=09=09return;
>>> +
>>> +=09if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
>>> +=09    !cap_fl1gp_support(iommu->cap)) {
>>> +=09=09pr_err("%s SVM disabled, incompatible 1GB page
>>> capability\n",
>>> +=09=09       iommu->name); =20
>> nit: is it really an error or just a warning?
> I think it is an error in that there is an illegal configuration. It is
> mostly for vIOMMU, we expect native HW should have these features
> matched.

OK

Thanks

Eric
>=20
>>> +=09=09return;
>>> +=09}
>>> +
>>> +=09if (cpu_feature_enabled(X86_FEATURE_LA57) &&
>>> +=09    !cap_5lp_support(iommu->cap)) {
>>> +=09=09pr_err("%s SVM disabled, incompatible paging
>>> mode\n",
>>> +=09=09       iommu->name);
>>> +=09=09return;
>>> +=09}
>>> +
>>> +=09iommu->flags |=3D VTD_FLAG_SVM_CAPABLE;
>>> +}
>>> +
>>>  static void intel_flush_svm_range_dev (struct intel_svm *svm,
>>> struct intel_svm_dev *sdev, unsigned long address, unsigned long
>>> pages, int ih) {
>>> diff --git a/include/linux/intel-iommu.h
>>> b/include/linux/intel-iommu.h index 63118991824c..7dcfa1c4a844
>>> 100644 --- a/include/linux/intel-iommu.h
>>> +++ b/include/linux/intel-iommu.h
>>> @@ -657,7 +657,7 @@ void iommu_flush_write_buffer(struct
>>> intel_iommu *iommu); int intel_iommu_enable_pasid(struct
>>> intel_iommu *iommu, struct device *dev);=20
>>>  #ifdef CONFIG_INTEL_IOMMU_SVM
>>> -int intel_svm_init(struct intel_iommu *iommu);
>>> +extern void intel_svm_check(struct intel_iommu *iommu);
>>>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>>>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>>> =20
>>> @@ -685,6 +685,8 @@ struct intel_svm {
>>>  };
>>> =20
>>>  extern struct intel_iommu *intel_svm_device_to_iommu(struct device
>>> *dev); +#else
>>> +static inline void intel_svm_check(struct intel_iommu *iommu) {}
>>>  #endif
>>> =20
>>>  #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
>>>  =20
>> Besides,
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
>> Thanks
>>
>> Eric
>>
>=20
> [Jacob Pan]
>=20

