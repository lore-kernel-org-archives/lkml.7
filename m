Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729C5C10F05
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F70218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCUAuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:50:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbfCUAuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C629D309265F;
        Thu, 21 Mar 2019 00:50:17 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2213060BE2;
        Thu, 21 Mar 2019 00:50:10 +0000 (UTC)
Date:   Wed, 20 Mar 2019 20:50:08 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, zohar@linux.ibm.com,
        mjg59@google.com
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record
 to syscall event
Message-ID: <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
 <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 21 Mar 2019 00:50:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-20 19:48, Paul Moore wrote:
> On Sat, Mar 16, 2019 at 8:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
> > verified xattrs"), the call to audit_log_start() is missing a context to
> > link it to an audit event. Since this event is in user context, add
> > the process' syscall context to the record.
> >
> > In addition, the orphaned keyword "locked" appears in the record.
> > Normalize this by changing it to "xattr=(locked)".
> >
> > Please see the github issue
> > https://github.com/linux-audit/audit-kernel/issues/109
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  security/integrity/evm/evm_secfs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> > index 015aea8fdf1e..4171d174e9da 100644
> > --- a/security/integrity/evm/evm_secfs.c
> > +++ b/security/integrity/evm/evm_secfs.c
> > @@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> >         if (count > XATTR_NAME_MAX)
> >                 return -E2BIG;
> >
> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
> > +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> > +                            AUDIT_INTEGRITY_EVM_XATTR);
> 
> This part is fine.
> 
> >         if (!ab)
> >                 return -ENOMEM;
> >
> > @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> >                 inode_lock(inode);
> >                 err = simple_setattr(evm_xattrs, &newattrs);
> >                 inode_unlock(inode);
> > -               audit_log_format(ab, "locked");
> > +               audit_log_format(ab, "xattr=(locked)");
> 
> Two things come to mind:
> 
> * While we can clearly trust the string above, should we be logging
> the xattr field value as an untrusted string so it is consistent with
> how we record other xattr names?

That would be a question for Steve.

> * I'm not sure you can ever have parens in a xattr (I would hope not),
> but if we are going to use the xattr field, perhaps we should simply
> stick with the name as provided (".") so we don't ever run afoul of
> xattr names?  I'm curious to hear what the IMA/EVM folks think of
> this.

The legal xaddr names start with XATTR_SECURITY_PREFIX which is
"security." so there is no danger of collision with legal names, but I
suppose someone could try to use "(locked)" as a name which would look
identical but fail with a different res= number.  I think I prefer your
idea of printing the given value verbatim.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
