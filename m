Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FE22070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732345AbfCZRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfCZRnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:43:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A801A87629;
        Tue, 26 Mar 2019 17:43:02 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E869C600C8;
        Tue, 26 Mar 2019 17:42:55 +0000 (UTC)
Date:   Tue, 26 Mar 2019 13:42:52 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Steve Grubb <sgrubb@redhat.com>, Paul Moore <paul@paul-moore.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, omosnace@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, mjg59@google.com
Subject: Re: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record
 to syscall event
Message-ID: <20190326174252.irqrldtcy5bwho6k@madcap2.tricolour.ca>
References: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
 <CAHC9VhS61LTQMXiALRre+5_+wvwe6Wa9RN-WYNTjvz5LVsA5rw@mail.gmail.com>
 <20190321005008.wfz3bk7q262km5fz@madcap2.tricolour.ca>
 <2006016.NXIvICiRTL@x2>
 <1553614157.4115.17.camel@linux.ibm.com>
 <20190326161409.3wej7hcwnqalf4or@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190326161409.3wej7hcwnqalf4or@madcap2.tricolour.ca>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 26 Mar 2019 17:43:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-03-26 12:14, Richard Guy Briggs wrote:
> On 2019-03-26 11:29, Mimi Zohar wrote:
> > On Tue, 2019-03-26 at 11:22 -0400, Steve Grubb wrote:
> > 
> > > > > > --- a/security/integrity/evm/evm_secfs.c
> > > > > > +++ b/security/integrity/evm/evm_secfs.c
> > > > > > @@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file,
> > > > > > const char __user *buf,> > 
> > > > > >         if (count > XATTR_NAME_MAX)
> > > > > >         
> > > > > >                 return -E2BIG;
> > > > > > 
> > > > > > -       ab = audit_log_start(NULL, GFP_KERNEL,
> > > > > > AUDIT_INTEGRITY_EVM_XATTR);
> > > > > > +       ab = audit_log_start(audit_context(), GFP_KERNEL,
> > > > > > +                            AUDIT_INTEGRITY_EVM_XATTR);
> > > > > 
> > > > > This part is fine.
> > > > > 
> > > > > >         if (!ab)
> > > > > >         
> > > > > >                 return -ENOMEM;
> > > > > > 
> > > > > > @@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file,
> > > > > > const char __user *buf,> > 
> > > > > >                 inode_lock(inode);
> > > > > >                 err = simple_setattr(evm_xattrs, &newattrs);
> > > > > >                 inode_unlock(inode);
> > > > > > 
> > > > > > -               audit_log_format(ab, "locked");
> > > > > > +               audit_log_format(ab, "xattr=(locked)");
> > > > > 
> > > > > Two things come to mind:
> > > > > 
> > > > > * While we can clearly trust the string above, should we be logging
> > > > > the xattr field value as an untrusted string so it is consistent with
> > > > > how we record other xattr names?
> > > > 
> > > > That would be a question for Steve.
> > > 
> > > All fields with the same name must be represented the same way. If one 
> > > instance is untrusted, every instance of the same keyword must be untrusted.
> > 
> > Normal case:
> >        audit_log_format(ab, "xattr=");
> >        audit_log_untrustedstring(ab, xattr->name);
> > 
> > Ok, so the above audit_log_format() call should be replaced with
> >  audit_log_untrustedstring().
> 
> Ok, so I think we can agree on "audit_log_untrustedstring(ab,
> "xattr=.");" and simpler yet just print the contents regardless and not
> special case this print.  V2 coming...

Ok, what I typed above wasn't quite what I intended...  This is what I
meant:

	audit_log_format(ab, "xattr=");
	audit_log_untrustedstring(ab, ".");

But, I'll just move the normal case above the "." locking detection and
log all cases the same way.

> > Mimi
> 
> - RGB

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
