Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4623C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C0420661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfCFR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:56:19 -0500
Received: from trent.utfs.org ([94.185.90.103]:58898 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfCFR4T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:56:19 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 514AF63883;
        Wed,  6 Mar 2019 18:56:17 +0100 (CET)
Date:   Wed, 6 Mar 2019 09:56:17 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <10106.1551892803@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org>
References: <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019, David Howells wrote:
> I can reproduce a slightly different problem by setting off ~6000 parallel
> processes, each reading its own individual directory of files.

Ususually I only see it shortly after mount, and only once, but I too can 
reproduce it with NFStest ([0], and there's a Fedora package too) via 
"nfstest_cache --server $SERVER --client `hostname`", which then produces 
a couple of these messages:

FS-Cache: Duplicate cookie detected
FS-Cache: O-cookie c=000000002fcc866b [p=00000000c10c6e18 fl=222 nc=0 na=1]
FS-Cache: O-cookie d=00000000d5ed73bb n=00000000076c9150
FS-Cache: O-key=[10] '040002000801c0a80073'
FS-Cache: N-cookie c=00000000e8d5dcd4 [p=00000000c10c6e18 fl=2 nc=0 na=1]
FS-Cache: N-cookie d=00000000d5ed73bb n=00000000a54e9705
FS-Cache: N-key=[10] '040002000801c0a80073'


...and the O-key does indeed seem to resemble the server address, 
somewhat:

 >>> s = "040002000801c0a80073";
 >>> bytes = ["".join(x) for x in zip(*[iter(s)]*2)]; bytes = [int(x, 16) for x in bytes]; print ".".join(str(x) for x in reversed(bytes))
 115.0.168.192.1.8.0.2.0.4
 ^^^^^^^^^^^^^

Mount options on that client are:

$ mount | grep nfs4
nfs:/usr/local/src on /usr/local/src type nfs4 (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.56.139,local_lock=none,addr=192.168.0.115)

...so FS-Cache ("fsc") isn't even used here. The server in that scenario 
is a current Fedora 29 installation.

HTH,
Christian.

[0] http://wiki.linux-nfs.org/wiki/index.php/NFStest

> 
> I also see reports like this:
> 
>    FS-Cache: Duplicate cookie detected
>    FS-Cache: O-cookie c=00000000db33ad59 [p=000000004bc53500 fl=218 nc=0 na=0]
>    FS-Cache: O-cookie d=          (null) n=          (null)
>    FS-Cache: O-cookie o=000000006cf6db4f
>    FS-Cache: O-key=[16] '0100010101000000e51fc6000323ae02'
>    FS-Cache: N-cookie c=00000000791c49d0 [p=000000004bc53500 fl=2 nc=0 na=1]
>    FS-Cache: N-cookie d=00000000e220fe14 n=00000000d4484489
>    FS-Cache: N-key=[16] '0100010101000000e51fc6000323ae02'
> 
> with no cookie def or netfs data and flags ACQUIRED, RELINQUISHED and
> INVALIDATING - which I can insert a wait for.
> 
> David

-- 
BOFH excuse #420:

Feature was not beta tested
