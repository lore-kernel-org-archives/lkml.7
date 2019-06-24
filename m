Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D048C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610DA2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfFXByH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:54:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfFXByH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:54:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7D4A30832CE;
        Mon, 24 Jun 2019 01:54:06 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60D995D739;
        Mon, 24 Jun 2019 01:54:03 +0000 (UTC)
Date:   Mon, 24 Jun 2019 09:53:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Tiezhu Yang <kernelpatch@126.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com
Subject: Re: [PATCH v2] kexec: fix warnig of crash_zero_bytes in crash.c
Message-ID: <20190624015359.GC2976@dhcp-128-65.nay.redhat.com>
References: <43d6fe3a.18e.16b814a09ba.Coremail.kernelpatch@126.com>
 <20190624013520.GA2976@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624013520.GA2976@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 24 Jun 2019 01:54:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/19 at 09:35am, Dave Young wrote:
> On 06/23/19 at 06:24am, Tiezhu Yang wrote:
> > Fix the following sparse warning:
> > 
> > arch/x86/kernel/crash.c:59:15:
> > warning: symbol 'crash_zero_bytes' was not declared. Should it be static?
> > 
> > First, make crash_zero_bytes static. In addition, crash_zero_bytes
> > is used when CONFIG_KEXEC_FILE is set, so make it only available
> > under CONFIG_KEXEC_FILE. Otherwise, if CONFIG_KEXEC_FILE is not set,
> > the following warning will appear when make crash_zero_bytes static:
> > 
> > arch/x86/kernel/crash.c:59:22:
> > warning: ‘crash_zero_bytes’ defined but not used [-Wunused-variable]
> > 
> > Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
> > Signed-off-by: Tiezhu Yang <kernelpatch@126.com>
> > Cc: Vivek Goyal <vgoyal@redhat.com>
> > ---
> >  arch/x86/kernel/crash.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 576b2e1..f13480e 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -56,7 +56,9 @@ struct crash_memmap_data {
> >   */
> >  crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss = NULL;
> >  EXPORT_SYMBOL_GPL(crash_vmclear_loaded_vmcss);
> > -unsigned long crash_zero_bytes;
> > +#ifdef CONFIG_KEXEC_FILE
> > +static unsigned long crash_zero_bytes;
> > +#endif
> >  
> >  static inline void cpu_crash_vmclear_loaded_vmcss(void)
> >  {
> > -- 
> > 1.8.3.1
> 
> Acked-by: Dave Young <dyoung@redhat.com>

BTW, a soft reminder, for kexec patches, it would be better to cc kexec mail
list.

> 
> Thanks
> Dave
> 
