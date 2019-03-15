Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E9CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FC921872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfCOLY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:24:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbfCOLY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:24:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 774EEAF26;
        Fri, 15 Mar 2019 11:24:27 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>,
        "Yan\, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        ceph-devel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libceph: Avoid a NULL pointer dereference
References: <20190314211724.21306-1-pakki001@umn.edu>
Date:   Fri, 15 Mar 2019 11:24:26 +0000
In-Reply-To: <20190314211724.21306-1-pakki001@umn.edu> (Aditya Pakki's message
        of "Thu, 14 Mar 2019 16:17:24 -0500")
Message-ID: <87ef78bct1.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aditya Pakki <pakki001@umn.edu> writes:

> kmalloc allocates memory for dest->name and attempts to call
> memcpy without a check for failure. This patch avoids such a scenario.

Since kmalloc is being invoked with the __GFP_NOFAIL flag, it will never
fail.  Thus, there's no point in checking for NULL in this case.

Cheers,
-- 
Luis


>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  net/ceph/osdmap.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 48a31dc9161c..c76a7c7e6a77 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1901,6 +1901,8 @@ void ceph_oid_copy(struct ceph_object_id *dest,
>  	} else {
>  		dest->name = dest->inline_name;
>  	}
> +	if (!dest->name)
> +		return;
>  	memcpy(dest->name, src->name, src->name_len + 1);
>  	dest->name_len = src->name_len;
>  }
