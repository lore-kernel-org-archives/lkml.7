Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E4EC48BD3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842EE206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 02:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfFYCv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 22:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbfFYCv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 22:51:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93E3159473;
        Tue, 25 Jun 2019 02:51:55 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-89.pek2.redhat.com [10.72.12.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 298936085B;
        Tue, 25 Jun 2019 02:51:51 +0000 (UTC)
Date:   Tue, 25 Jun 2019 10:51:48 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     James Morris <jmorris@namei.org>, Jiri Bohac <jbohac@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <20190625025148.GA4024@dhcp-128-65.nay.redhat.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
 <20190621064340.GB4528@localhost.localdomain>
 <CACdnJut=J1YTpM4s6g5XWCEs+=X0Jvf8otfMg+w=_oqSZmf01Q@mail.gmail.com>
 <20190624015206.GB2976@dhcp-128-65.nay.redhat.com>
 <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJusPtYLdg7ZPhBo=Y5EsBz6B+5M2zYscBrLcc89oNnPkdQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 25 Jun 2019 02:51:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/19 at 02:06pm, Matthew Garrett wrote:
> On Sun, Jun 23, 2019 at 6:52 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 06/21/19 at 01:18pm, Matthew Garrett wrote:
> > > I don't think so - we want it to be possible to load images if they
> > > have a valid signature.
> >
> > I know it works like this way because of the previous patch.  But from
> > the patch log "When KEXEC_SIG is not enabled, kernel should not load
> > images", it is simple to check it early for !IS_ENABLED(CONFIG_KEXEC_SIG) &&
> > kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)  instead of depending
> > on the late code to verify signature.  In that way, easier to
> > understand the logic, no?
> 
> But that combination doesn't enforce signature validation? We can't
> depend on !IS_ENABLED(CONFIG_KEXEC_SIG_FORCE) because then it'll
> enforce signature validation even if lockdown is disabled.

Ok, got your point. still something could be improved though, in the switch
chunk, the errno, reason and IS_ENABLED(CONFIG_KEXEC_SIG_FORCE) etc is
not necessary for this -EPERM case.

/* add some comment to describe the behavior */
if (ret && security_is_locked_down(LOCKDOWN_KEXEC)) {
	ret = -EPERM;
	goto out;
}

Thanks
Dave
