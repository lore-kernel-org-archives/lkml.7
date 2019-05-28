Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A0C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAEB20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfE1USy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:18:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40827 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbfE1USx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:18:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3A0ED9FFC5;
        Tue, 28 May 2019 20:18:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C803D60C47;
        Tue, 28 May 2019 20:18:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <6e061326-5feb-5471-c0c0-a364af5e82c3@schaufler-ca.com>
References: <6e061326-5feb-5471-c0c0-a364af5e82c3@schaufler-ca.com> <6889f4f9-4ae0-8a92-a2fc-04151ad8ed9f@schaufler-ca.com> <10710.1559070135@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PULL] Smack: Restore the smackfsdef mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15804.1559074726.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 21:18:46 +0100
Message-ID: <15805.1559074726@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 28 May 2019 20:18:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > 	 static const struct fs_parameter_spec smack_param_specs[] = {
> > 	+	fsparam_string("fsdef",		Opt_fsdefault),
> > 		fsparam_string("fsdefault",	Opt_fsdefault),
> > 		fsparam_string("fsfloor",	Opt_fsfloor),
> > 		fsparam_string("fshat",		Opt_fshat),
> >
> > but that all the option names in that table *do* need prefixing with
> > "smack".

Actually, you're right, we do need to add that *and* prefix it with "smack".

> I'm not sure I follow the logic, because "mount -o smackfsdefault=Pop"
> does what I would expect it to.

Yes, I'm sure it does - for the cases you're testing - but it's filesystem and
syscall dependent.  None of the filesystems currently ported to the mount API
upstream override ->parse_monolithic(), but that changes with nfs, shmem and
coda and will change with cifs too.

It also changes if you use fsconfig() to supply the options because that goes
through a different LSM hook (it uses fs_context_parse_param rather than
sb_eat_lsm_opts).

> > The way you enter the LSM is going to depend on whether
> > generic_parse_monolithic() is called.  You're only going to enter this way
> > if mount(2) is the syscall of entry and the filesystem doesn't override
> > the ->parse_monolithic() option (none in the upstream kernel).
> 
> So you're saying that the code works for the mount(2) case,
> but won't work for some other case? Are you planning a fix?
> Will that fix include restoration of smackfsdef?

I can do a fix, but testing it is a pain.

David
