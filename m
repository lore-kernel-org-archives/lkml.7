Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB49EC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B78218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfGYTyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:54:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:62331 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfGYTyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:54:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 12:54:22 -0700
X-IronPort-AV: E=Sophos;i="5.64,307,1559545200"; 
   d="scan'208";a="175354533"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 12:54:21 -0700
Message-ID: <0530d9d32a7316adee62e067cb0fb8048f97da84.camel@linux.intel.com>
Subject: Re: [PATCH v2 5/5] virtio-balloon: Add support for providing page
 hints to host
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        kvm@vger.kernel.org, david@redhat.com, mst@redhat.com,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com,
        konrad.wilk@oracle.com, lcapitulino@redhat.com,
        wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com,
        dan.j.williams@intel.com
Date:   Thu, 25 Jul 2019 12:54:21 -0700
In-Reply-To: <fc99b28d-2efd-cd05-59e4-99f35bd37cac@redhat.com>
References: <20190724165158.6685.87228.stgit@localhost.localdomain>
         <20190724170514.6685.17161.stgit@localhost.localdomain>
         <fc99b28d-2efd-cd05-59e4-99f35bd37cac@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-07-25 at 13:42 -0400, Nitesh Narayan Lal wrote:
> On 7/24/19 1:05 PM, Alexander Duyck wrote:
> > From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > 

<snip>

> > @@ -924,12 +956,24 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >  		if (err)
> >  			goto out_del_balloon_wq;
> >  	}
> > +
> > +	vb->ph_dev_info.react = virtballoon_page_hinting_react;
> > +	vb->ph_dev_info.capacity = VIRTIO_BALLOON_ARRAY_HINTS_MAX;
> > +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING)) {
> > +		err = page_hinting_startup(&vb->ph_dev_info);
> > +		if (err)
> > +			goto out_unregister_shrinker;
> > +	}
> Any reason why you have kept vb->ph_dev_info.react & vb->ph_dev_info.capacity
> initialization outside the feature check?

I just had them on the outside because it didn't really matter if I
initialized them or not if the feature was not present. So I just
defaulted to initializing them in all cases.

Since I will be updating capacity to be based on the size of the hinting
queue in the next patch set I will move capacity initialization inside of
the check.

