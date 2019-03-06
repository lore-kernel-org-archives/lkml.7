Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119B6C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33C820684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 17:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfCFRUJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 12:20:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfCFRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 12:20:08 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EBD780F79;
        Wed,  6 Mar 2019 17:20:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-148.rdu2.redhat.com [10.10.121.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1D3B25D786;
        Wed,  6 Mar 2019 17:20:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <22096.1551878195@warthog.procyon.org.uk>
References: <22096.1551878195@warthog.procyon.org.uk> <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org>
To:     Christian Kujau <lists@nerdbynature.de>
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: Re: FS-Cache: Duplicate cookie detected
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10105.1551892803.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 06 Mar 2019 17:20:03 +0000
Message-ID: <10106.1551892803@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 06 Mar 2019 17:20:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> >  FS-Cache: Duplicate cookie detected
> >  FS-Cache: O-cookie c=000000009da9dbf0 [p=000000001593f904 fl=222 nc=0 na=1]
> >  FS-Cache: O-cookie d=00000000287febd9 n=00000000980c9e8a
> >  FS-Cache: O-key=[8] '020001bdc0a80064'
> >  FS-Cache: N-cookie c=00000000bfe3f869 [p=000000001593f904 fl=2 nc=0 na=1]
> >  FS-Cache: N-cookie d=00000000287febd9 n=00000000e153f178
> >  FS-Cache: N-key=[8] '020001bdc0a80064'
> 
> I've just spotted something that all these things have in common.  The old
> cookie has FSCACHE_COOKIE_RELINQUISHING set in the flags (fl=222).  I don't
> have a wait for this situation in fscache - which I should.

I take it back - 0x200 is FSCACHE_COOKIE_ACQUIRED. :-/

I can reproduce a slightly different problem by setting off ~6000 parallel
processes, each reading its own individual directory of files.

I also see reports like this:

   FS-Cache: Duplicate cookie detected
   FS-Cache: O-cookie c=00000000db33ad59 [p=000000004bc53500 fl=218 nc=0 na=0]
   FS-Cache: O-cookie d=          (null) n=          (null)
   FS-Cache: O-cookie o=000000006cf6db4f
   FS-Cache: O-key=[16] '0100010101000000e51fc6000323ae02'
   FS-Cache: N-cookie c=00000000791c49d0 [p=000000004bc53500 fl=2 nc=0 na=1]
   FS-Cache: N-cookie d=00000000e220fe14 n=00000000d4484489
   FS-Cache: N-key=[16] '0100010101000000e51fc6000323ae02'

with no cookie def or netfs data and flags ACQUIRED, RELINQUISHED and
INVALIDATING - which I can insert a wait for.

David
