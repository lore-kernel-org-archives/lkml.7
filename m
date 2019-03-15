Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EC2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6353218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCOSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:16:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725910AbfCOSQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:16:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2FIA6Ob079093
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:16:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r8gse15dm-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:16:07 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 15 Mar 2019 18:16:05 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Mar 2019 18:16:02 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2FIG0d629229120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Mar 2019 18:16:01 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D32EE4C040;
        Fri, 15 Mar 2019 18:16:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D9D94C058;
        Fri, 15 Mar 2019 18:16:00 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.177])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Mar 2019 18:16:00 +0000 (GMT)
Date:   Fri, 15 Mar 2019 19:15:57 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com, mimu@linux.ibm.com
Subject: Re: [PATCH v5 4/7] s390: ap: setup relation betwen KVM and mediated
 device
In-Reply-To: <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
References: <1552493104-30510-1-git-send-email-pmorel@linux.ibm.com>
        <1552493104-30510-5-git-send-email-pmorel@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031518-0020-0000-0000-00000323D24D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031518-0021-0000-0000-00002175DD38
Message-Id: <20190315191557.6c8d7668@oc2783563651>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-15_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903150125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 17:05:01 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When the mediated device is open we setup the relation with KVM unset it
> when the mediated device is released.
> 
> We ensure KVM is present on opening of the mediated device.
> 
> We ensure that KVM survives the mediated device, and establish a direct

survives? 

> link from KVM to the mediated device to simplify the relationship.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 80 ++++++++++++++++++++++-----------------
>  1 file changed, 46 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 0f8952c23..6b559ca 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -790,7 +790,6 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   * vfio_ap_mdev_set_kvm
>   *
>   * @matrix_mdev: a mediated matrix device
> - * @kvm: reference to KVM instance
>   *
>   * Verifies no other mediated matrix device has @kvm and sets a reference to
>   * it in @matrix_mdev->kvm.
> @@ -798,53 +797,39 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
>   * Return 0 if no other mediated matrix device has a reference to @kvm;
>   * otherwise, returns an -EPERM.
>   */
> -static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
> -				struct kvm *kvm)
> +static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev)
>  {
> -	struct ap_matrix_mdev *m;
> -
>  	mutex_lock(&matrix_dev->lock);
> +	if (matrix_mdev->kvm->arch.crypto.pqap_hook)
> +		goto err_unlock;
>  
> -	list_for_each_entry(m, &matrix_dev->mdev_list, node) {
> -		if ((m != matrix_mdev) && (m->kvm == kvm)) {
> -			mutex_unlock(&matrix_dev->lock);
> -			return -EPERM;
> -		}
> -	}
> +	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> +		goto err_unlock;
>  
> -	matrix_mdev->kvm = kvm;
> -	mutex_unlock(&matrix_dev->lock);
> +	matrix_mdev->kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
>  
> +	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> +				  matrix_mdev->matrix.aqm,
> +				  matrix_mdev->matrix.adm);
> +	kvm_get_kvm(matrix_mdev->kvm);
> +	mutex_unlock(&matrix_dev->lock);
>  	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&matrix_dev->lock);
> +	return -EPERM;
>  }
>  
>  static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
>  				       unsigned long action, void *data)
>  {
> -	int ret;
>  	struct ap_matrix_mdev *matrix_mdev;
>  
>  	if (action != VFIO_GROUP_NOTIFY_SET_KVM)
>  		return NOTIFY_OK;
>  
>  	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> -
> -	if (!data) {
> -		matrix_mdev->kvm = NULL;
> -		return NOTIFY_OK;
> -	}
> -
> -	ret = vfio_ap_mdev_set_kvm(matrix_mdev, data);
> -	if (ret)
> -		return NOTIFY_DONE;
> -
> -	/* If there is no CRYCB pointer, then we can't copy the masks */
> -	if (!matrix_mdev->kvm->arch.crypto.crycbd)
> -		return NOTIFY_DONE;
> -
> -	kvm_arch_crypto_set_masks(matrix_mdev->kvm, matrix_mdev->matrix.apm,
> -				  matrix_mdev->matrix.aqm,
> -				  matrix_mdev->matrix.adm);
> +	matrix_mdev->kvm = data;
>  
>  	return NOTIFY_OK;
>  }
> @@ -888,6 +873,12 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  	if (ret)
>  		goto err_group;
>  
> +	/* We do not support opening the mediated device without KVM */
> +	if (!matrix_mdev->kvm) {
> +		ret = -ENODEV;
> +		goto err_group;
> +	}
> +
>  	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
>  	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
>  
> @@ -896,8 +887,15 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  	if (ret)
>  		goto err_iommu;
>  
> +	ret = vfio_ap_mdev_set_kvm(matrix_mdev);

At this point the matrix_mdev->kvm ain't guaranteed to be valid IMHO. Or
am I wrong? If I'm right kvm_get_kvm(matrix_mdev->kvm) could be too late.

> +	if (ret)
> +		goto err_kvm;
> +
>  	return 0;
>  
> +err_kvm:
> +	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
> +				 &matrix_mdev->iommu_notifier);
>  err_iommu:
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>  				 &matrix_mdev->group_notifier);
> @@ -906,19 +904,33 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
>  	return ret;
>  }
>  
> -static void vfio_ap_mdev_release(struct mdev_device *mdev)
> +static int vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
>  {
> -	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +	struct kvm *kvm = matrix_mdev->kvm;
>  
>  	if (matrix_mdev->kvm)
>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);

This still conditional?

> -
> +	vfio_ap_mdev_reset_queues(matrix_mdev->mdev);

I guess your intention was to move vfio_ap_mdev_reset_queues()
here from vfio_ap_mdev_release(), but you still have a
vfio_ap_mdev_reset_queues() call in vfio_ap_mdev_release().

> +	matrix_mdev->kvm->arch.crypto.pqap_hook = NULL;
>  	matrix_mdev->kvm = NULL;
> +
> +	kvm_put_kvm(kvm);
> +	return 0;
> +}
> +
> +static void vfio_ap_mdev_release(struct mdev_device *mdev)
> +{
> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> +
> +	mutex_lock(&matrix_dev->lock);
> +
>  	vfio_ap_mdev_reset_queues(mdev);

Here.

Regards,
Halil

> +	vfio_ap_mdev_unset_kvm(matrix_mdev);
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
>  				 &matrix_mdev->iommu_notifier);
>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
>  				 &matrix_mdev->group_notifier);
> +	mutex_unlock(&matrix_dev->lock);
>  	module_put(THIS_MODULE);
>  }
>  

