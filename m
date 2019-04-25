Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9502BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D9852084F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfDYJlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34606 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfDYJlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 238E03148077;
        Thu, 25 Apr 2019 09:41:22 +0000 (UTC)
Received: from localhost (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80157106A7AB;
        Thu, 25 Apr 2019 09:41:17 +0000 (UTC)
Date:   Thu, 25 Apr 2019 17:41:15 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     sashal@kernel.org, kexec@lists.infradead.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        dyoung@redhat.com
Subject: Re: [PATCH] kexec: quiet down kexec reboot
Message-ID: <20190425094115.GN3584@localhost.localdomain>
References: <20190423204154.3085-1-pasha.tatashin@soleen.com>
 <20190425093200.GM3584@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425093200.GM3584@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 25 Apr 2019 09:41:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/25/19 at 05:32pm, Baoquan He wrote:
> On 04/23/19 at 04:41pm, Pavel Tatashin wrote:
> > Here is a regular kexec command sequence and output:
> > =====
> > $ kexec --reuse-cmdline -i --load Image
> > $ kexec -e
> > [  161.342002] kexec_core: Starting new kernel
> > 
> > Welcome to Buildroot
> > buildroot login:
> > =====
> > 
> > Even when "quiet" kernel parameter is specified, "kexec_core: Starting
> > new kernel" is printed.
> 
> I personally don't like this change very much. 
> 
> kernel-parameters.txt tells that quiet disables most log messages, but
> not to disable log messages.
> 
> 	quiet           [KNL] Disable most log messages 
> 
> And kexec doesn't print many messages. When 'kexec -e' is executed,
> much critical work need be done in 1st kernel, and also in 2nd kernel
> till printed messages are seen. Sometime it could hang there without a
> notice, because we need shutdown all devices before it. Keeping it can
> at least tell which stage it is?
> 
> No strong objection, just we may need enable it manually if silent
> hang is met. Anyone has different opinion? 

Please ignore this mail, I must be dizzy. pr_notice looks good to me.

> > 
> > This message has  KERN_EMERG level, but there is no emergency, it is
> > a normal kexec operation, so quiet it down to appropriate KERN_NOTICE.
> > 
> > Machines that have slow console baud rate benefit from less output.
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/kexec_core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index d7140447be75..fe13e86984ec 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1171,7 +1171,7 @@ int kernel_kexec(void)
> >  		 * CPU hotplug again; so re-enable it here.
> >  		 */
> >  		cpu_hotplug_enable();
> > -		pr_emerg("Starting new kernel\n");
> > +		pr_notice("Starting new kernel\n");
> >  		machine_shutdown();
> >  	}
> >  
> > -- 
> > 2.21.0
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
