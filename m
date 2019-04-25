Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F2AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129BE218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556185846;
	bh=1IkGVSlGFDld6FbcEHIT1SiASIMoYQkeETs+lvzeViU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zwAfF66m6m6BwQ2V+YmNh9MFSq+fQWXdfyQRiutNEBj33bYHWroRSSfW9HyvbSEDQ
	 5gxPbdDbe9RElNHMqjtWlCu/GDvrenMQ2g7UpsInzcgnJ/bj+57HgTpI2rEdR3ac8N
	 yvoUNRZXRhAeAj7Jd4SrgjIveGbpGtw6GFLqQMtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfDYJuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:50:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51564 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbfDYJuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:50:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so8415392wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 02:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRURGkNNf2oM8zyBsCgVmv0B2tylYvvIGuKb+CaX1Yo=;
        b=cNn8Hr/RTFc8nnA1dcl3N4dyUfXumDRAvttnl1GXNjF1B5zvh7yBHOxxFTdm+zN8Rl
         ycPvI64sMIhgxe1zbiPgqisQTOCwUEKWx4EcMcYIolvpmvsaGcHexWA8FXNA5Jdsvly5
         1Y0Q7MNP5OxLyLyuhEt8rhQF/6mkJ46uQY2kbMih8yHTmKBNMKS0qHoeXnLNRQkiqzir
         z++huLATxoWgPhEtv2WAiIgftav+LCndTuZeygQNW94n5cEEDVEMjSPfADWhqOFERZv3
         ojsO9hAu+rJYnHBlYy3A7fNpWbUzCRN3neXkyR3fDIeaIpRb9gY15zMoDcDfACFOqXyX
         u5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRURGkNNf2oM8zyBsCgVmv0B2tylYvvIGuKb+CaX1Yo=;
        b=gOxNrW22Q64kARmSOpxMp4JS53ZQs3xnQXidcxN0p7VA2zgYVLdWiPsYXXS+r92TF9
         tb3iUaJnZyIZXN5TbGToqi+gKs8v6JpzpksIAZ9Fzm/SmqDV8x+WaCvGf0N9v1Nxh6ug
         CLOvlsegHSB0RYbknV2q29dAflIJQICZZONBjCo4YGB1K+w8r2dMqUtl2hiDPEhGN2S5
         MQ81n7hOddC1sJlmvsak/Iuu4lF0N3UYX0+4Rc1/vLD7xkFHdmqtVFIfeEnSdR383Se4
         NzdJM1pL+Y5WEgGjbvwgL1UTbh6AiwXMok9CPGByr5eUUrubL+79cjrvAoEGFe/0CsGb
         RU7A==
X-Gm-Message-State: APjAAAUdUb50tMGpq3KqM2tYPdAI9RWLNGFM4Hvx8Awb+mazn2f7wWUQ
        Xxj8Vl7izmz3mzU36tkOrpY=
X-Google-Smtp-Source: APXvYqyl8ixo/hRmfGqlSnoCSP453r0hCb4185iNiqNIhSTNo7y0rmXJkJRhxrTRRQJn++ybDPivTQ==
X-Received: by 2002:a7b:c14c:: with SMTP id z12mr2797644wmi.138.1556185842281;
        Thu, 25 Apr 2019 02:50:42 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p9sm751536wma.31.2019.04.25.02.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 02:50:41 -0700 (PDT)
Date:   Thu, 25 Apr 2019 11:50:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: x86/paravirt: Detect over-sized patching bugs in
 paravirt_patch_call()
Message-ID: <20190425095039.GC115378@gmail.com>
References: <20190424134115.091452807@linutronix.de>
 <20190424134223.690835713@linutronix.de>
 <20190425065209.GA89582@gmail.com>
 <alpine.DEB.2.21.1904250921010.1762@nanos.tec.linutronix.de>
 <20190425081012.GA115378@gmail.com>
 <20190425091717.GA72229@gmail.com>
 <20190425092131.GL4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425092131.GL4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 25, 2019 at 11:17:17AM +0200, Ingo Molnar wrote:
> > It basically means that we silently won't do any patching and the kernel 
> > will crash later on in mysterious ways, because paravirt patching is 
> > usually relied on.
> 
> That's OK. The compiler emits an indirect CALL/JMP to the pv_ops
> structure contents. That _should_ stay valid and function correctly at
> all times.

It might result in a correctly executing kernel in terms of code 
generation, but it doesn't result in a viable kernel: some of the places 
rely on the patching going through and don't know what to do when it 
doesn't and misbehave or crash in interesting ways.

Guess how I know this. ;-)

> Not patching should at the very least cause a WARN with RETPOLINE 
> kernels though, we hard rely on the patching actually working and 
> writing at least a direct call.

We hard rely in other places too.

How about just BUG_ON()-ing in paravirt_patch_call() as well? It's not 
like these are *supposed* to fail, and if they do we want to know it, 
even if the outcome might be more benign in some cases?

I.e. how about the patch below? This not only makes it more apparent when 
patching fails, it also makes the kernel smaller and removes an #ifdef 
ugly.

I tried it with a richly paravirt-enabled kernel and no patching bugs 
were detected.

Thanks,

	Ingo

Signed-off-by: Ingo Molnar <mingo@kernel.org>

---
 arch/x86/kernel/paravirt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7f9121f2fdac..544d386ded45 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -73,21 +73,21 @@ struct branch {
 static unsigned paravirt_patch_call(void *insnbuf, const void *target,
 				    unsigned long addr, unsigned len)
 {
+	const int call_len = 5;
 	struct branch *b = insnbuf;
-	unsigned long delta = (unsigned long)target - (addr+5);
+	unsigned long delta = (unsigned long)target - (addr+call_len);
 
-	if (len < 5) {
-#ifdef CONFIG_RETPOLINE
-		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
-#endif
-		return len;	/* call too long for patch site */
+	if (len < call_len) {
+		pr_warn("paravirt: Failed to patch indirect CALL at %ps\n", (void *)addr);
+		/* Kernel might not be viable if patching fails, bail out: */
+		BUG_ON(1);
 	}
 
 	b->opcode = 0xe8; /* call */
 	b->delta = delta;
-	BUILD_BUG_ON(sizeof(*b) != 5);
+	BUILD_BUG_ON(sizeof(*b) != call_len);
 
-	return 5;
+	return call_len;
 }
 
 #ifdef CONFIG_PARAVIRT_XXL
