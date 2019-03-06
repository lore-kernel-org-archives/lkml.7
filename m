Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1161AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD73F20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 13:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfCFNQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 08:16:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbfCFNQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 08:16:37 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9A69356E4;
        Wed,  6 Mar 2019 13:16:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD5B36090C;
        Wed,  6 Mar 2019 13:16:35 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22095.1551878195.1@warthog.procyon.org.uk>
Date:   Wed, 06 Mar 2019 13:16:35 +0000
Message-ID: <22096.1551878195@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 06 Mar 2019 13:16:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Kujau <lists@nerdbynature.de> wrote:

>  FS-Cache: Duplicate cookie detected
>  FS-Cache: O-cookie c=000000009da9dbf0 [p=000000001593f904 fl=222 nc=0 na=1]
>  FS-Cache: O-cookie d=00000000287febd9 n=00000000980c9e8a
>  FS-Cache: O-key=[8] '020001bdc0a80064'
>  FS-Cache: N-cookie c=00000000bfe3f869 [p=000000001593f904 fl=2 nc=0 na=1]
>  FS-Cache: N-cookie d=00000000287febd9 n=00000000e153f178
>  FS-Cache: N-key=[8] '020001bdc0a80064'

I've just spotted something that all these things have in common.  The old
cookie has FSCACHE_COOKIE_RELINQUISHING set in the flags (fl=222).  I don't
have a wait for this situation in fscache - which I should.

Interestingly, '020001bdc0a80064' looks like is could be the key from the
server level, assuming this is from NFS:

	0200 01bdc0a8 0064

could be:

	AF_INET (LE), 1.189.192.168, 100 (BE)

David
