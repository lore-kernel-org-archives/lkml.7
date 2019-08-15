Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0BC3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0592089E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAjHWRtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfHOVR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:17:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43522 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730169AbfHOVR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:17:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so1832076pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euAnvJlLHwVUNWqq2xyGqSRGjCXD2Duyc9/+lj5jrdM=;
        b=YAjHWRtW3eRnYmQ932JYs9q3eRzTpat4T4ge8uPo+kqBuB27goMgfeDi36qWlmLDb7
         9m4B9SXumWgoAtKsKvrLuaw6osBlWEgP2+FZI54AlvdB8kHCxIDeHYYrg3LOKPW+He+2
         KzsobapzVAFEJs56O3gwSQNWJxo+ehjouFAJuIprBzu1P1lN554GjIhFVLupIHVDUnC1
         3cqWj26wPFyzB9n9FHOXUQ3OOlQK+h1ZAjutsMo+TCjgMqvRVJVvGhVTGygYiWv/q8RZ
         LrHIp7N8L3W0tn4MAXihdzVFR+3fggRzBW1XCbmSCbwMhIABBUmLOwTDMAxRvlDIm+Li
         aLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euAnvJlLHwVUNWqq2xyGqSRGjCXD2Duyc9/+lj5jrdM=;
        b=AzZgMsUhA68p9+6mE6n0tpvb5u1dWW1Tmxyo6AjvbgR4TMEzVC39LbGrBrijO7a8uJ
         EAEvCK0daIc+qU/0mQ2WrbBEljsfbdoxkgO0q3OGuTRt4u0qL7A9yD6TaA/IrCls/+Oc
         wCRp7IuAQI3wfHoMPUIzFasLSZ6hAauf5/YpO+kFu82jUw5e5RopjMO7kl/Qp+tOgspD
         P1OLvGANaZPxAVqPrqEb6yuPssGKgzqOeNDOhtzgGV0uLfgZj+OJk5RLN2+Cp5WccsMB
         KHy10XZfeJEn28T071l+IurP2dOGewoXNXcdopZAXyZmqjxKdz0kzohmFAX43MAOzGhb
         ja+g==
X-Gm-Message-State: APjAAAVA6oR+jNX/S4JbnPomR89B5TnKgknpfKdIXZ1pp1RnftITrotR
        5WfrjsLzKVlBLdFpIRpa2t3cFUu4NYKaaHv1wjk=
X-Google-Smtp-Source: APXvYqxJJtdZgSXLEanOrlC8xqY0wjMqhsc/vj6RWI1cNg/RS0kRPQ0q2Lww/wl133yUbf0iQai3U9kADReUf0LJIDc=
X-Received: by 2002:a17:90a:a114:: with SMTP id s20mr4052992pjp.20.1565903876841;
 Thu, 15 Aug 2019 14:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com> <1565900005-62508-17-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1565900005-62508-17-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 16 Aug 2019 00:17:44 +0300
Message-ID: <CAHp75VdD4SpA3oR8KBr6WihLkBgaaUn6f7tFdO7H-2n-hbun_Q@mail.gmail.com>
Subject: Re: [PATCH v5 16/19] iommu/vt-d: Misc macro clean up for SVM
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 11:52 PM Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:
>
> Use combined macros for_each_svm_dev() to simplify SVM device iteration
> and error checking.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-svm.c | 85 +++++++++++++++++++++++------------------------
>  1 file changed, 41 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 5a688a5..ea6f2e2 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -218,6 +218,10 @@ static const struct mmu_notifier_ops intel_mmuops = {
>  static DEFINE_MUTEX(pasid_mutex);
>  static LIST_HEAD(global_svm_list);
>
> +#define for_each_svm_dev(svm, dev)                     \
> +       list_for_each_entry(sdev, &svm->devs, list)     \

> +       if (dev == sdev->dev)                           \

This should be
  if (dev != sdev->dev) {} else
and no trailing \ is neeeded.

The rationale of above form to avoid
for_each_foo() {
} else {
  ...WTF?!..
}

> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops *ops)
>  {
>         struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -263,15 +267,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>                                 goto out;
>                         }
>
> -                       list_for_each_entry(sdev, &svm->devs, list) {
> -                               if (dev == sdev->dev) {
> -                                       if (sdev->ops != ops) {
> -                                               ret = -EBUSY;
> -                                               goto out;
> -                                       }
> -                                       sdev->users++;
> -                                       goto success;
> +                       for_each_svm_dev(svm, dev) {
> +                               if (sdev->ops != ops) {
> +                                       ret = -EBUSY;
> +                                       goto out;
>                                 }
> +                               sdev->users++;
> +                               goto success;
>                         }
>
>                         break;
> @@ -408,48 +410,43 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>                 goto out;
>
>         svm = ioasid_find(NULL, pasid, NULL);
> -       if (IS_ERR(svm)) {
> +       if (IS_ERR_OR_NULL(svm)) {
>                 ret = PTR_ERR(svm);
>                 goto out;
>         }
>
> -       if (!svm)
> -               goto out;
> +       for_each_svm_dev(svm, dev) {
> +               ret = 0;
> +               sdev->users--;
> +               if (!sdev->users) {
> +                       list_del_rcu(&sdev->list);
> +                       /* Flush the PASID cache and IOTLB for this device.
> +                        * Note that we do depend on the hardware *not* using
> +                        * the PASID any more. Just as we depend on other
> +                        * devices never using PASIDs that they have no right
> +                        * to use. We have a *shared* PASID table, because it's
> +                        * large and has to be physically contiguous. So it's
> +                        * hard to be as defensive as we might like. */
> +                       intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> +                       intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> +                       kfree_rcu(sdev, rcu);
> +
> +                       if (list_empty(&svm->devs)) {
> +                               ioasid_free(svm->pasid);
> +                               if (svm->mm)
> +                                       mmu_notifier_unregister(&svm->notifier, svm->mm);
>
> -       list_for_each_entry(sdev, &svm->devs, list) {
> -               if (dev == sdev->dev) {
> -                       ret = 0;
> -                       sdev->users--;
> -                       if (!sdev->users) {
> -                               list_del_rcu(&sdev->list);
> -                               /* Flush the PASID cache and IOTLB for this device.
> -                                * Note that we do depend on the hardware *not* using
> -                                * the PASID any more. Just as we depend on other
> -                                * devices never using PASIDs that they have no right
> -                                * to use. We have a *shared* PASID table, because it's
> -                                * large and has to be physically contiguous. So it's
> -                                * hard to be as defensive as we might like. */
> -                               intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> -                               intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
> -                               kfree_rcu(sdev, rcu);
> -
> -                               if (list_empty(&svm->devs)) {
> -                                       ioasid_free(svm->pasid);
> -                                       if (svm->mm)
> -                                               mmu_notifier_unregister(&svm->notifier, svm->mm);
> -
> -                                       list_del(&svm->list);
> -
> -                                       /* We mandate that no page faults may be outstanding
> -                                        * for the PASID when intel_svm_unbind_mm() is called.
> -                                        * If that is not obeyed, subtle errors will happen.
> -                                        * Let's make them less subtle... */
> -                                       memset(svm, 0x6b, sizeof(*svm));
> -                                       kfree(svm);
> -                               }
> +                               list_del(&svm->list);
> +
> +                               /* We mandate that no page faults may be outstanding
> +                                * for the PASID when intel_svm_unbind_mm() is called.
> +                                * If that is not obeyed, subtle errors will happen.
> +                                * Let's make them less subtle... */
> +                               memset(svm, 0x6b, sizeof(*svm));
> +                               kfree(svm);
>                         }
> -                       break;
>                 }
> +               break;
>         }
>   out:
>         mutex_unlock(&pasid_mutex);
> @@ -585,7 +582,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>                          * to unbind the mm while any page faults are outstanding.
>                          * So we only need RCU to protect the internal idr code. */
>                         rcu_read_unlock();
> -                       if (IS_ERR(svm) || !svm) {
> +                       if (IS_ERR_OR_NULL(svm)) {
>                                 pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
>                                        iommu->name, req->pasid, ((unsigned long long *)req)[0],
>                                        ((unsigned long long *)req)[1]);
> --
> 2.7.4
>


-- 
With Best Regards,
Andy Shevchenko
