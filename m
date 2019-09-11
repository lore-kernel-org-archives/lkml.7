Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4463C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F512082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568205199;
	bh=eN1N5vPP2BYE5r+wilFLEutQv6wNUw7Z0cM/4TJqqQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hawn7Wywsn6S5W6OLI9Qp9zFWJ5r05XGmLl49ct6pXsfi/9ABXDNf3JPoAJQL6QOW
	 /FiEuHfGWSzNL6J1mGPPbYVlPS7fhbc6yacB01+IrbCwWBthKkKHs7cWyiJyeSmWK8
	 cD1glsWWebXXfp0kjn7XIFU47i0cLhc+9r5GMtXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfIKMdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:33:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:40740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726198AbfIKMdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:33:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A71A0AC3E;
        Wed, 11 Sep 2019 12:33:16 +0000 (UTC)
Date:   Wed, 11 Sep 2019 14:33:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911123316.GX4023@dhcp22.suse.cz>
References: <20190911120908.28410-1-mst@redhat.com>
 <20190911121628.GT4023@dhcp22.suse.cz>
 <20190911082236-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911082236-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-09-19 08:25:03, Michael S. Tsirkin wrote:
> On Wed, Sep 11, 2019 at 02:16:28PM +0200, Michal Hocko wrote:
> > On Wed 11-09-19 08:10:00, Michael S. Tsirkin wrote:
> > > iovec addresses coming from vhost are assumed to be
> > > pre-validated, but in fact can be speculated to a value
> > > out of range.
> > > 
> > > Userspace address are later validated with array_index_nospec so we can
> > > be sure kernel info does not leak through these addresses, but vhost
> > > must also not leak userspace info outside the allowed memory table to
> > > guests.
> > > 
> > > Following the defence in depth principle, make sure
> > > the address is not validated out of node range.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Tested-by: Jason Wang <jasowang@redhat.com>
> > 
> > no need to mark fo stable? Other spectre fixes tend to be backported
> > even when the security implications are not really clear. The risk
> > should be low and better to be covered in case.
> 
> This is not really a fix - more a defence in depth thing,
> quite similar to e.g.  commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
> x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
> in scope.
>
> That one doesn't seem to be tagged for stable. Was it queued
> there in practice?

not marked for stable but it went in. At least to 4.4.

-- 
Michal Hocko
SUSE Labs
