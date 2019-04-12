Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88027C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F58921872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfDLKTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51600 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfDLKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:19:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8A344F74B7;
        Fri, 12 Apr 2019 10:19:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A0E119C65;
        Fri, 12 Apr 2019 10:19:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190411.140203.1367510571263899902.davem@davemloft.net>
References: <20190411.140203.1367510571263899902.davem@davemloft.net> <20190409125912.11600-1-colin.king@canonical.com>
To:     David Miller <davem@davemloft.net>
Cc:     dhowells@redhat.com, colin.king@canonical.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dns: remove redundant zero length namelen check
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17755.1555064391.1@warthog.procyon.org.uk>
Date:   Fri, 12 Apr 2019 11:19:51 +0100
Message-ID: <17756.1555064391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 12 Apr 2019 10:19:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:

> > The zero namelen check is redundant as it has already been checked
> > for zero at the start of the function.  Remove the redundant check.
> > 
> > Addresses-Coverity: ("Logically Dead Code")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Applied to net-next.
> 
> However it does look like two sets of semantics were considered.
> In one case rejecting a zero namelen and in another having it
> mean whatever the strings length is modulo the max of 256.

It probably makes sense to merge the:

	if (namelen < 3 || namelen > 255)
		return -EINVAL;

check into the earlier:

	if (!name || namelen == 0)
		return -EINVAL;

check too.

David
