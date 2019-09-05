Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9D3C3A5AB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D84A22CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbfIEJXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733279AbfIEJXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:23:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A0291190C034;
        Thu,  5 Sep 2019 09:23:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC0485D712;
        Thu,  5 Sep 2019 09:23:19 +0000 (UTC)
Date:   Thu, 5 Sep 2019 10:23:17 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] KVM: inject data abort if instruction cannot be
 decoded
Message-ID: <20190905092317.GB14512@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190904180736.29009-1-xypron.glpk@gmx.de>
 <20190905092039.GG32415@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905092039.GG32415@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Thu, 05 Sep 2019 09:23:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 10:20:39AM +0100, Stefan Hajnoczi wrote:
> On Wed, Sep 04, 2019 at 08:07:36PM +0200, Heinrich Schuchardt wrote:
> > If an application tries to access memory that is not mapped, an error
> > ENOSYS, "load/store instruction decoding not implemented" may occur.
> > QEMU will hang with a register dump.
> > 
> > Instead create a data abort that can be handled gracefully by the
> > application running in the virtual environment.
> > 
> > Now the virtual machine can react to the event in the most appropriate
> > way - by recovering, by writing an informative log, or by rebooting.
> > 
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >  virt/kvm/arm/mmio.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/mmio.c b/virt/kvm/arm/mmio.c
> > index a8a6a0c883f1..0cbed7d6a0f4 100644
> > --- a/virt/kvm/arm/mmio.c
> > +++ b/virt/kvm/arm/mmio.c
> > @@ -161,8 +161,8 @@ int io_mem_abort(struct kvm_vcpu *vcpu, struct kvm_run *run,
> >  		if (ret)
> >  			return ret;
> >  	} else {
> > -		kvm_err("load/store instruction decoding not implemented\n");
> > -		return -ENOSYS;
> > +		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
> > +		return 1;
> 
> I see this more as a temporary debugging hack than something to merge.
> 
> It sounds like in your case the guest environment provided good
> debugging information and you preferred it over debugging this from the
> host side.  That's fine, but allowing the guest to continue running in
> the general case makes it much harder to track down the root cause of a
> problem because many guest CPU instructions may be executed after the
> original problem occurs.  Other guest software may fail silently in
> weird ways.  IMO it's best to fail early.

The current error message is quite limited in its usefulness - mostly
you have to be able to google the message and hope to hit a previous
report which explains the problem, or find someone on IRC who remembers
the problem, etc.

Could we put a text doc in the kernel tree explaining the problem in
enough detail that people can identify their next steps to resolve it,
and then make this error message tell people to read that text doc.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
