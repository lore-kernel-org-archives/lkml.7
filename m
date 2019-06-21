Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C53C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050C52083B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFUNM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:12:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfFUNM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:12:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71A2F81123;
        Fri, 21 Jun 2019 13:12:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-57.rdu2.redhat.com [10.10.120.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F4191001B05;
        Fri, 21 Jun 2019 13:12:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20190621094757.zijugn6cfulmchnf@brauner.io>
References: <20190621094757.zijugn6cfulmchnf@brauner.io> <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk> <155905627927.1662.13276277442207649583.stgit@warthog.procyon.org.uk>
To:     Christian Brauner <christian@brauner.io>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mszeredi@redhat.com
Subject: Re: [PATCH 02/25] vfs: Allow fsinfo() to query what's in an fs_context [ver #13]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21651.1561122763.1@warthog.procyon.org.uk>
Date:   Fri, 21 Jun 2019 14:12:43 +0100
Message-ID: <21652.1561122763@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 21 Jun 2019 13:12:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> wrote:

> >  static int vfs_fsinfo_fd(unsigned int fd, struct fsinfo_kparams *params)
> >  {
> >  	struct fd f = fdget_raw(fd);
> 
> You're using fdget_raw() which means you want to allow O_PATH fds but
> below you're checking whether the f_ops correspond to
> fscontext_fops. If it's an O_PATH

It can't be.  The only way to get an fs_context fd is from fsopen() or
fspick() - neither of which allow O_PATH to be specified.

If you tried to go through /proc/pid/fd with open(O_PATH), I think you'd get
the symlink, not the target.

David
