Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F78C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D074206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 22:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733235AbfHOWrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 18:47:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:58997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfHOWrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 18:47:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 15:47:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,389,1559545200"; 
   d="scan'208";a="352372678"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2019 15:47:08 -0700
Date:   Thu, 15 Aug 2019 15:50:51 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 16/19] iommu/vt-d: Misc macro clean up for SVM
Message-ID: <20190815155051.0212b5e6@jacob-builder>
In-Reply-To: <CAHp75VdD4SpA3oR8KBr6WihLkBgaaUn6f7tFdO7H-2n-hbun_Q@mail.gmail.com>
References: <1565900005-62508-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1565900005-62508-17-git-send-email-jacob.jun.pan@linux.intel.com>
        <CAHp75VdD4SpA3oR8KBr6WihLkBgaaUn6f7tFdO7H-2n-hbun_Q@mail.gmail.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 00:17:44 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 15, 2019 at 11:52 PM Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> >
> > Use combined macros for_each_svm_dev() to simplify SVM device
> > iteration and error checking.
> >
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >  drivers/iommu/intel-svm.c | 85
> > +++++++++++++++++++++++------------------------ 1 file changed, 41
> > insertions(+), 44 deletions(-)
> >
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 5a688a5..ea6f2e2 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -218,6 +218,10 @@ static const struct mmu_notifier_ops
> > intel_mmuops = { static DEFINE_MUTEX(pasid_mutex);
> >  static LIST_HEAD(global_svm_list);
> >
> > +#define for_each_svm_dev(svm, dev)                     \
> > +       list_for_each_entry(sdev, &svm->devs, list)     \  
> 
> > +       if (dev == sdev->dev)                           \  
> 
> This should be
>   if (dev != sdev->dev) {} else
> and no trailing \ is neeeded.
> 
> The rationale of above form to avoid
> for_each_foo() {
> } else {
>   ...WTF?!..
> }
> 
I understand, but until we have the else {} case we don't have anything
to avoid. The current code only has a simple positive logic.

> > +
> >  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops) {
> >         struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > @@ -263,15 +267,13 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ goto out;
> >                         }
> >
> > -                       list_for_each_entry(sdev, &svm->devs, list)
> > {
> > -                               if (dev == sdev->dev) {
> > -                                       if (sdev->ops != ops) {
> > -                                               ret = -EBUSY;
> > -                                               goto out;
> > -                                       }
> > -                                       sdev->users++;
> > -                                       goto success;
> > +                       for_each_svm_dev(svm, dev) {
> > +                               if (sdev->ops != ops) {
> > +                                       ret = -EBUSY;
> > +                                       goto out;
> >                                 }
> > +                               sdev->users++;
> > +                               goto success;
> >                         }
> >
> >                         break;
> > @@ -408,48 +410,43 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) goto out;
> >
> >         svm = ioasid_find(NULL, pasid, NULL);
> > -       if (IS_ERR(svm)) {
> > +       if (IS_ERR_OR_NULL(svm)) {
> >                 ret = PTR_ERR(svm);
> >                 goto out;
> >         }
> >
> > -       if (!svm)
> > -               goto out;
> > +       for_each_svm_dev(svm, dev) {
> > +               ret = 0;
> > +               sdev->users--;
> > +               if (!sdev->users) {
> > +                       list_del_rcu(&sdev->list);
> > +                       /* Flush the PASID cache and IOTLB for this
> > device.
> > +                        * Note that we do depend on the hardware
> > *not* using
> > +                        * the PASID any more. Just as we depend on
> > other
> > +                        * devices never using PASIDs that they
> > have no right
> > +                        * to use. We have a *shared* PASID table,
> > because it's
> > +                        * large and has to be physically
> > contiguous. So it's
> > +                        * hard to be as defensive as we might
> > like. */
> > +                       intel_pasid_tear_down_entry(iommu, dev,
> > svm->pasid);
> > +                       intel_flush_svm_range_dev(svm, sdev, 0, -1,
> > 0, !svm->mm);
> > +                       kfree_rcu(sdev, rcu);
> > +
> > +                       if (list_empty(&svm->devs)) {
> > +                               ioasid_free(svm->pasid);
> > +                               if (svm->mm)
> > +
> > mmu_notifier_unregister(&svm->notifier, svm->mm);
> >
> > -       list_for_each_entry(sdev, &svm->devs, list) {
> > -               if (dev == sdev->dev) {
> > -                       ret = 0;
> > -                       sdev->users--;
> > -                       if (!sdev->users) {
> > -                               list_del_rcu(&sdev->list);
> > -                               /* Flush the PASID cache and IOTLB
> > for this device.
> > -                                * Note that we do depend on the
> > hardware *not* using
> > -                                * the PASID any more. Just as we
> > depend on other
> > -                                * devices never using PASIDs that
> > they have no right
> > -                                * to use. We have a *shared* PASID
> > table, because it's
> > -                                * large and has to be physically
> > contiguous. So it's
> > -                                * hard to be as defensive as we
> > might like. */
> > -                               intel_pasid_tear_down_entry(iommu,
> > dev, svm->pasid);
> > -                               intel_flush_svm_range_dev(svm,
> > sdev, 0, -1, 0, !svm->mm);
> > -                               kfree_rcu(sdev, rcu);
> > -
> > -                               if (list_empty(&svm->devs)) {
> > -                                       ioasid_free(svm->pasid);
> > -                                       if (svm->mm)
> > -
> > mmu_notifier_unregister(&svm->notifier, svm->mm); -
> > -                                       list_del(&svm->list);
> > -
> > -                                       /* We mandate that no page
> > faults may be outstanding
> > -                                        * for the PASID when
> > intel_svm_unbind_mm() is called.
> > -                                        * If that is not obeyed,
> > subtle errors will happen.
> > -                                        * Let's make them less
> > subtle... */
> > -                                       memset(svm, 0x6b,
> > sizeof(*svm));
> > -                                       kfree(svm);
> > -                               }
> > +                               list_del(&svm->list);
> > +
> > +                               /* We mandate that no page faults
> > may be outstanding
> > +                                * for the PASID when
> > intel_svm_unbind_mm() is called.
> > +                                * If that is not obeyed, subtle
> > errors will happen.
> > +                                * Let's make them less subtle... */
> > +                               memset(svm, 0x6b, sizeof(*svm));
> > +                               kfree(svm);
> >                         }
> > -                       break;
> >                 }
> > +               break;
> >         }
> >   out:
> >         mutex_unlock(&pasid_mutex);
> > @@ -585,7 +582,7 @@ static irqreturn_t prq_event_thread(int irq,
> > void *d)
> >                          * to unbind the mm while any page faults
> > are outstanding.
> >                          * So we only need RCU to protect the
> > internal idr code. */ rcu_read_unlock();
> > -                       if (IS_ERR(svm) || !svm) {
> > +                       if (IS_ERR_OR_NULL(svm)) {
> >                                 pr_err("%s: Page request for
> > invalid PASID %d: %08llx %08llx\n", iommu->name, req->pasid,
> > ((unsigned long long *)req)[0], ((unsigned long long *)req)[1]);
> > --
> > 2.7.4
> >  
> 
> 

[Jacob Pan]
