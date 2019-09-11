Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F1EC5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E162085B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568219110;
	bh=p51cKNYssjsGmMVYnMjF9WdcHjn+O5GRnUBJEET3Mz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MAO26WNpe3n+XpBoXwK2rEcQ6sFdz0CneKvKkzsCVSyFzAhGfqr5IiLX26SpAb41s
	 5SAFPwkJj15yO88rAvf9ZfOnXMo9Zh9twLv8NOnAldbrw+tdTUnK1H+Rw/dpd8VI+G
	 wz+mQYN9x5s2stH5L1/QfSlW+v17WgFiAZ3ew2vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfIKQZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 12:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbfIKQZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:25:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5A902085B;
        Wed, 11 Sep 2019 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568219108;
        bh=p51cKNYssjsGmMVYnMjF9WdcHjn+O5GRnUBJEET3Mz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOtgRvNLApk4EIvptVK8jURuwGqdAAz+5Loinkha9ukkM1thBGc22ksV4WI3LbviW
         nCXtSdSU9J66ITrDQ5jYxxazBQCAkmRqKj8SCT4gYFhZKMdTC8zdbV+jLi9jVK6ESK
         C+L7kLIMTHAevfkjMd0jT5IgQOl1PNRNzSx5QErM=
Date:   Wed, 11 Sep 2019 17:25:04 +0100
From:   Will Deacon <will@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911162503.em2ytox2iq5wdp3z@willie-the-truck>
References: <20190911120908.28410-1-mst@redhat.com>
 <20190911095147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911095147-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 09:52:25AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 11, 2019 at 08:10:00AM -0400, Michael S. Tsirkin wrote:
> > iovec addresses coming from vhost are assumed to be
> > pre-validated, but in fact can be speculated to a value
> > out of range.
> > 
> > Userspace address are later validated with array_index_nospec so we can
> > be sure kernel info does not leak through these addresses, but vhost
> > must also not leak userspace info outside the allowed memory table to
> > guests.
> > 
> > Following the defence in depth principle, make sure
> > the address is not validated out of node range.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > Tested-by: Jason Wang <jasowang@redhat.com>
> > ---
> 
> Cc: security@kernel.org
> 
> Pls advise on whether you'd like me to merge this directly,
> Cc stable, or handle it in some other way.

I think you're fine taking it directly, with a cc stable and a Fixes: tag.

Cheers,

Will
