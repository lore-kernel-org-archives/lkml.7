Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F304B206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfH0IqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfH0IqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B0BB7FDFA;
        Tue, 27 Aug 2019 08:46:20 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92A41600D1;
        Tue, 27 Aug 2019 08:46:11 +0000 (UTC)
Date:   Tue, 27 Aug 2019 10:46:09 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        kvm@vger.kernel.org, kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 04/19] virtio: Implement get_shm_region for PCI
 transport
Message-ID: <20190827104609.234a536b.cohuck@redhat.com>
In-Reply-To: <20190827103457.35927d9d.cohuck@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
        <20190821175720.25901-5-vgoyal@redhat.com>
        <20190827103457.35927d9d.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 27 Aug 2019 08:46:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2019 10:34:57 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 21 Aug 2019 13:57:05 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:

> > +static bool vp_get_shm_region(struct virtio_device *vdev,
> > +			      struct virtio_shm_region *region, u8 id)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);  
> 
> This whole function looks like it is indented incorrectly.

Hmpf, it looks like my mail client is squashing tabs, so the
indentation looks off here, but is probably fine :) It's the function
above that seems to have a mix of spaces and tabs.

> 
> > +	struct pci_dev *pci_dev = vp_dev->pci_dev;
> > +	u8 bar;
> > +	u64 offset, len;
> > +	phys_addr_t phys_addr;
> > +	size_t bar_len;
> > +	char *bar_name;
> > +	int ret;
