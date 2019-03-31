Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4EAC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7172146F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 09:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfCaJFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 05:05:35 -0400
Received: from trent.utfs.org ([94.185.90.103]:50074 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfCaJFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 05:05:32 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 5531D5FB40;
        Sun, 31 Mar 2019 11:05:28 +0200 (CEST)
Date:   Sun, 31 Mar 2019 02:05:28 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     David Howells <dhowells@redhat.com>
cc:     linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
In-Reply-To: <8939.1552374108@warthog.procyon.org.uk>
Message-ID: <alpine.DEB.2.21.999.1903310203520.21644@trent.utfs.org>
References: <alpine.DEB.2.21.999.1903112235120.21644@trent.utfs.org> <alpine.DEB.2.21.999.1903080954040.21644@trent.utfs.org> <alpine.DEB.2.21.999.1903060943320.1662@trent.utfs.org> <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org>
 <10106.1551892803@warthog.procyon.org.uk> <17155.1552056554@warthog.procyon.org.uk> <2827.1552315718@warthog.procyon.org.uk> <8939.1552374108@warthog.procyon.org.uk>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, 12 Mar 2019, David Howells wrote:
> > My /usr/local/src mount was mounted with vers=4.2 (default), while 
> > nfstest_cache was mounting its test-mount with vers=4.1! Apart from the 
> > different rsize/wsize values, the version number stood out. And indeed, 
> > when I mount my regular NFS mount /usr/local/src with vers=4.1, the 
> > "duplicate cookie" is no longer printed.
> 
> Yeah - NFS superblocks are differentiated by a whole host of parameters,
> including protocol version number, and caches aren't shared between
> superblocks because this introduces a tricky coherency problem.
> 
> The issue is that NFS superblocks to the same place do not currently manage
> coherency (inode attributes, data) between themselves, except via the server.
> 
> However, if "fsc" isn't given on the mount commandline, the superblock
> probably shouldn't get a server-level cookie if we can avoid it.

Just checking - are you waiting for new results from me, should I test 
something that I missed? Or are new patches in the works? :-D

Thanks,
Christian.
-- 
BOFH excuse #139:

UBNC (user brain not connected)
