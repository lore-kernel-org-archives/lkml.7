Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F83C20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCHR5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:57:15 -0500
Received: from trent.utfs.org ([94.185.90.103]:42110 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfCHR5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:57:15 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 16B316427B;
        Fri,  8 Mar 2019 18:57:13 +0100 (CET)
Date:   Fri, 8 Mar 2019 09:57:13 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <17155.1552056554@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.999.1903080954040.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org> <10106.1551892803@warthog.procyon.org.uk> <17155.1552056554@warthog.procyon.org.uk>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2019, David Howells wrote:
> > $ mount | grep nfs4
> > nfs:/usr/local/src on /usr/local/src type nfs4 (ro,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys,clientaddr=192.168.56.139,local_lock=none,addr=192.168.0.115)
> > 
> > ...so FS-Cache ("fsc") isn't even used here.
> 
> Interesting.  Can you do:
> 
> 	cat /proc/fs/nfsfs/volumes

That seems to confirm the mount options, fsc is disabled:

# cat /proc/fs/nfsfs/volumes
NV SERVER   PORT DEV          FSID                              FSC
v4 c0a80073  801 0:46         1cfd45bf1921474d:a795870ea80f5ff7 no

> See the attached for a patch that helps with certain kinds of collision,
> though I can't see that it should help with what you're seeing since the
> RELINQUISHED flag isn't set on the old cookie (fl=222, but 0x10 isn't in
> there).  You can monitor the number of waits by looking in
> /proc/fs/fscache/stats for the:
> 
> 	Acquire: n=289166 nul=0 noc=0 ok=286331 nbf=2 oom=0 wrq=23748

Ah, the wrq= field gets only introduced by this patch. OK, I'll see if I 
can build a test kernel with that and will report back.

Thanks for looking in to this,
Christian.
-- 
BOFH excuse #290:

The CPU has shifted, and become decentralized.
