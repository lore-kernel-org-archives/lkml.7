Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABC7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228A82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733139AbfC0KKf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfC0KKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:10:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 750A13007C32;
        Wed, 27 Mar 2019 10:10:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22D1F62660;
        Wed, 27 Mar 2019 10:10:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAAM7YAnsYr0uQixmcv-=UDLWdmdJmbEN2D_zBcFQq2j-s+xtiw@mail.gmail.com>
References: <CAAM7YAnsYr0uQixmcv-=UDLWdmdJmbEN2D_zBcFQq2j-s+xtiw@mail.gmail.com> <155309339693.2324.9941108136967815885.stgit@warthog.procyon.org.uk> <155309340402.2324.7571102623113278534.stgit@warthog.procyon.org.uk>
To:     "Yan, Zheng" <ukernel@gmail.com>
Cc:     dhowells@redhat.com, ceph-devel <ceph-devel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] ceph: Convert to fs_context
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2234.1553681432.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 27 Mar 2019 10:10:32 +0000
Message-ID: <2235.1553681432@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 27 Mar 2019 10:10:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan, Zheng <ukernel@gmail.com> wrote:

> > -       if (fsopt->sb_flags != other->mount_options->sb_flags) {
> > +       if (fc->sb_flags != sb->s_flags) {

Fixed with:

@@ -945,7 +945,7 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 		dout("fsid doesn't match\n");
 		return 0;
 	}
-	if (fc->sb_flags != sb->s_flags) {
+	if (fc->sb_flags != (sb->s_flags & ~SB_BORN)) {
 		dout("flags differ\n");
 		return 0;
 	}

David
