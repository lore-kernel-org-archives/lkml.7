Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED73C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AD82133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfELSKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:10:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfELSKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8212D81F19;
        Sun, 12 May 2019 18:10:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7808860BCD;
        Sun, 12 May 2019 18:10:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5CD844B0.5060206@bfs.de>
References: <5CD844B0.5060206@bfs.de> <155764714099.24080.1233326575922058381.stgit@warthog.procyon.org.uk> <155764714872.24080.15171754166782593095.stgit@warthog.procyon.org.uk>
To:     wharms@bfs.de
Cc:     dhowells@redhat.com, colin.king@canonical.com, joe@perches.com,
        jaltman@auristor.com, linux-afs@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] afs: Fix afs_xattr_get_yfs() to not try freeing an error value
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31807.1557684645.1@warthog.procyon.org.uk>
Date:   Sun, 12 May 2019 19:10:45 +0100
Message-ID: <31808.1557684645@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 12 May 2019 18:10:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

walter harms <wharms@bfs.de> wrote:

> > +	ret = dsize;
> > +	if (size > 0) {
> > +		if (dsize > size) {
> > +			ret = -ERANGE;
> > +			goto error_key;
> >  		}
> > +		memcpy(buffer, data, dsize);
> >  	}
> >  
> 
> i am confused: if size is <= 0 then the error is in dsize ?

See this bit, before that hunk:

> +	if (ret < 0)
> +		goto error_key;

David
