Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197A0C072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6B620989
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 18:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfE1Syd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 14:54:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfE1Syd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 14:54:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B13EFF9E8B;
        Tue, 28 May 2019 18:54:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE6785D6A9;
        Tue, 28 May 2019 18:54:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <43e3de52-13d7-8089-11cf-a384662401aa@schaufler-ca.com>
References: <43e3de52-13d7-8089-11cf-a384662401aa@schaufler-ca.com> <9191ef31-a022-cdc4-9bed-ff225e4179bb@schaufler-ca.com> <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com> <11440.1559046181@warthog.procyon.org.uk> <9330.1559060541@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9985.1559069658.1@warthog.procyon.org.uk>
Date:   Tue, 28 May 2019 19:54:18 +0100
Message-ID: <9986.1559069658@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 28 May 2019 18:54:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> > Casey Schaufler <casey@schaufler-ca.com> wrote:
> >
> >>> Also, should all of these be prefixed with "smack"?  So:
> >>>
> >>>   	fsparam_string("smackfsdef",	Opt_fsdefault),
> >>>   	fsparam_string("smackfsfloor",	Opt_fsfloor),
> >>>   	fsparam_string("smackfshat",	Opt_fshat),	
> >> No. smack_fs_parameters takes care of that.
> > It does?  *Blink*.
> 
> Well, something does. I can't say that I 100% understand all
> of how the new mount code handles the mount options. Y'all made
> sweeping changes, and the code works the way it used to except
> for the awkward change from smackfsdef to smackfsdefault. It
> took no small amount of head scratching and experimentation to
> convince myself that the fix I proposed was correct.

Ah...  I suspect the issue is that smack_sb_eat_lsm_opts() strips the prefix
for an unconverted filesystem, but smack_fs_context_parse_param() doesn't
(which it shouldn't).

Can you try grabbing my mount-api-viro branch from:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git

and testing setting smack options on a tmpfs filesystem?

You might need to try modifying samples/vfs/test-fsmount.c to make it mount a
trmpfs filesystem through the new mount UAPI.

David
