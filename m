Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1EC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BAA2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 06:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bSq+njuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfH2Gqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 02:46:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfH2Gqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 02:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XqP6KMHBCPelPBAfqvIaQqLm65eVmqW9YvWHKrHsia8=; b=bSq+njuLMh/IWrVBbvVdjZxB1
        1GcwUvx/GvMQouDj9rqBcbio1YAApe59HHPJlVQrjMEmEG53zV1kim0pX7me3YGSHHRmlK6XoC7os
        eLRbmH7iorT3BER7+Ijz9ltiG3nN38RlQ3emvE8lJDMYfRiKxkM6irbaaD6aTYoFOCA3zCz9O57aJ
        mt+KYeCu0Gpx6P3HlMoQAiKQKw2IBvTtWMfy6xRZZINxNsMwFAgRNBDljwJS1KcZqDtUCEomYt4/r
        GbJcz0Snih0atw5tAY7aH+dv5EcaDRcMP/tqpxjLlawyiEfPJSlD1P4b9H+felGrTqxZqYlej6w0N
        b4Vm0zGPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3ECO-0001xf-6i; Thu, 29 Aug 2019 06:46:24 +0000
Date:   Wed, 28 Aug 2019 23:46:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Nicolai Stange <nstange@suse.de>,
        Allison Randal <allison@lohutok.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joel Stanley <joel@jms.id.au>,
        Firoz Khan <firoz.khan@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20190829064624.GA28508@infradead.org>
References: <cover.1567007242.git.msuchanek@suse.de>
 <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ad51b41aebf65b3f3fcb9922f0f00b47932725d.1567007242.git.msuchanek@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 06:43:50PM +0200, Michal Suchanek wrote:
> +ifdef CONFIG_COMPAT
> +obj-y				+= sys_ppc32.o ptrace32.o signal_32.o
> +endif

This should be:

obj-$(CONFIG_COMPAT)		+= sys_ppc32.o ptrace32.o signal_32.o

>  /* This value is used to mark exception frames on the stack. */
>  exception_marker:
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 60436432399f..73d0f53ffc1a 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -277,7 +277,7 @@ static void do_signal(struct task_struct *tsk)
>  
>  	rseq_signal_deliver(&ksig, tsk->thread.regs);
>  
> -	if (is32) {
> +	if ((IS_ENABLED(CONFIG_PPC32) || IS_ENABLED(CONFIG_COMPAT)) && is32) {

I think we should fix the is_32bit_task definitions instead so that
callers don't need this mess.  I'd suggest something like:

#ifdef CONFIG_COMPAT
#define is_32bit_task()		test_thread_flag(TIF_32BIT)
#else
#define is_32bit_task()		IS_ENABLED(CONFIG_PPC32)
#endif
