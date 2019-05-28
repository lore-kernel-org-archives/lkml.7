Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5714BC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3488F20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfE1TCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfE1TCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92379821EF;
        Tue, 28 May 2019 19:02:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3152C1001DD8;
        Tue, 28 May 2019 19:02:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com>
References: <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] Smack: Restore the smackfsdef mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10709.1559070135.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 20:02:15 +0100
Message-ID: <10710.1559070135@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 28 May 2019 19:02:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> James, this is a repair for a regression introduced in 5.1.
> It should be pulled for 5.2 and added to 5.1.
> 
> The following changes since commit 619ae03e922b65a1a5d4269ceae1e9e13a058d6b:
> 
>   Smack: Fix kbuild reported build error (2019-04-30 14:13:32 -0700)
> 
> are available in the git repository at:
> 
>   https://github.com/cschaufler/next-smack.git smack-for-5.2-b
> 
> for you to fetch changes up to a5765ce797070d046dc53ccceeb0ed304cb918eb:
> 
>   Smack: Restore the smackfsdef mount option (2019-05-28 10:22:04 -0700)

Can you hold this for the moment, please?

Note that there appears to be another problem by inspection of the code.  I
think that smack_sb_eat_lsm_opts() strips the "smack" prefix off of the
options, whereas smack_fs_context_parse_param() does not.

This means that there's no need to do this:

	 static const struct fs_parameter_spec smack_param_specs[] = {
	+	fsparam_string("fsdef",		Opt_fsdefault),
		fsparam_string("fsdefault",	Opt_fsdefault),
		fsparam_string("fsfloor",	Opt_fsfloor),
		fsparam_string("fshat",		Opt_fshat),

but that all the option names in that table *do* need prefixing with "smack".

The way you enter the LSM is going to depend on whether
generic_parse_monolithic() is called.  You're only going to enter this way if
mount(2) is the syscall of entry and the filesystem doesn't override the
->parse_monolithic() option (none in the upstream kernel).

David
