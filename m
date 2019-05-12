Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05908C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09F52133D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 06:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfELG5B convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 02:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfELG5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 02:57:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E30C5945B;
        Sun, 12 May 2019 06:57:01 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-61.rdu2.redhat.com [10.10.120.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C69485C26A;
        Sun, 12 May 2019 06:56:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <eb1862ebb97f41dcdf85abbea43a22d51ec94c9c.camel@perches.com>
References: <eb1862ebb97f41dcdf85abbea43a22d51ec94c9c.camel@perches.com> <20190511123603.3265-1-colin.king@canonical.com>
To:     Joe Perches <joe@perches.com>
Cc:     dhowells@redhat.com, Colin King <colin.king@canonical.com>,
        linux-afs@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] afs: remove redundant assignment to variable ret
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26839.1557644218.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Sun, 12 May 2019 07:56:58 +0100
Message-ID: <26840.1557644218@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 12 May 2019 06:57:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> wrote:

> @@ -71,11 +71,9 @@ static int afs_xattr_get_acl(const struct xattr_handler *handler,
>  	if (ret == 0) {
>  		ret = acl->size;
>  		if (size > 0) {
> -			ret = -ERANGE;
>  			if (acl->size > size)
>  				return -ERANGE;
>  			memcpy(buffer, acl->data, acl->size);
> -			ret = acl->size;
>  		}
>  		kfree(acl);
>  	}

This is also the wrong solution.  See my reply to Colin.

David
