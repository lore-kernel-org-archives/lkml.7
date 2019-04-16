Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86289C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBC120872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbfDPPeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:34:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51466 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfDPPeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:34:22 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C6B678665D;
        Tue, 16 Apr 2019 15:34:15 +0000 (UTC)
Received: from x2.localnet (ovpn-120-96.rdu2.redhat.com [10.10.120.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2000919C7D;
        Tue, 16 Apr 2019 15:34:09 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>, Shuah Khan <shuah@kernel.org>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [RFC PATCH v1 1/5] fs: Add support for an O_MAYEXEC flag on sys_open()
Date:   Tue, 16 Apr 2019 11:34:07 -0400
Message-ID: <2361288.r9sZr2NHLB@x2>
Organization: Red Hat
In-Reply-To: <87wojuxj8s.fsf@oldenburg2.str.redhat.com>
References: <20181212081712.32347-1-mic@digikod.net> <3452959.b6JmBh7Lnt@x2> <87wojuxj8s.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 16 Apr 2019 15:34:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 16, 2019 7:49:39 AM EDT Florian Weimer wrote:
> * Steve Grubb:
> > This flag that is being proposed means that you would have to patch all
> > interpreters to use it. If you are sure that upstreams will accept that,
> > why not just change the policy to interpreters shouldn't execute
> > anything unless the execute bit is set? That is simpler and doesn't need
> > a kernel change. And setting the execute bit is an auditable event.
> 
> I think we need something like O_MAYEXEC so that security policies can
> be enforced and noexec mounts can be detected.

Application whitelisting can already today stop unknown software without 
needing O_MAYEXEC.

> I don't think it's a good idea to do this in userspace, especially the
> latter.

The problem is that passing O_MAYEXEC is opt-in. You can use ptrace/seccomp/
bpf/LD_PRELOAD/LD_AUDIT to remove that bit from an otherwise normal program. 
This does not require privs to do so.

But let's consider that this comes to pass and every interpreter is updated 
and IMA can see the O_MAYEXEC flag. Attackers now simply pivot to running 
programs via stdin. It never touches disk and therefore nothing enforces 
security policy. This already is among the most common ways that malware runs 
today to evade detection.

-Steve


