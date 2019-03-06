Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F22920684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 00:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfCFAYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 19:24:12 -0500
Received: from trent.utfs.org ([94.185.90.103]:55096 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfCFAYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 19:24:12 -0500
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id D1AFE63138;
        Wed,  6 Mar 2019 01:24:09 +0100 (CET)
Date:   Tue, 5 Mar 2019 16:24:09 -0800 (PST)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-kernel@vger.kernel.org
cc:     David Howells <dhowells@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve Dickson <steved@redhat.com>
Subject: FS-Cache: Duplicate cookie detected
Message-ID: <alpine.DEB.2.21.999.1903051616350.4505@trent.utfs.org>
User-Agent: Alpine 2.21.999 (DEB 277 2018-05-20)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ever since ec0328e46d6e ("fscache: Maintain a catalogue of allocated 
cookies") was commited, people are seeing[0] those "Duplicate cookie 
detected" messages in syslog, see below. NFS and CIFS mounts appear to 
continue to work, but these messsages are new and I too am wondering if 
this is something to worry about.

They _are_ logged with pr_err in fs/fscache/cookie.c, but maybe this needs 
to be changed to a different loglevel?

Thanks,
Christian.

 FS-Cache: Duplicate cookie detected
 FS-Cache: O-cookie c=000000009da9dbf0 [p=000000001593f904 fl=222 nc=0 na=1]
 FS-Cache: O-cookie d=00000000287febd9 n=00000000980c9e8a
 FS-Cache: O-key=[8] '020001bdc0a80064'
 FS-Cache: N-cookie c=00000000bfe3f869 [p=000000001593f904 fl=2 nc=0 na=1]
 FS-Cache: N-cookie d=00000000287febd9 n=00000000e153f178
 FS-Cache: N-key=[8] '020001bdc0a80064'


[0] https://bugzilla.kernel.org/show_bug.cgi?id=200145
-- 
BOFH excuse #318:

Your EMAIL is now being delivered by the USPS.
