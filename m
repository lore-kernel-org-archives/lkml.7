Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B5C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B715220835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 21:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574802289;
	bh=4BT53fP2gHc7gGfzPjV4f8Jug4qA+UqXlwvkeZU5Fv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OaxhDMQOQZ9qkllYDjSKcsfatEVR1liylyN/nIWv8RtAGybpFoJaMn8igHyohL7MU
	 N9Rrd67MQYtdPjxbUgl/xFh2bVbQyxuzicKNXF9Tu19vkrHtO4rNvKojLIU6QX4IQj
	 mF1D2NJyf9kZcCicygp831ITsU7xbPhtECa3u0b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfKZVEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:04:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53521 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKZVEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 16:04:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so4754015wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 13:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ufrm0CTU3ZzlwhLP0MhQM3iCgGvz24IecULGzksBi4g=;
        b=jYZdkJu7pPRkh3o2TjZdZHaUPTGRt17SpOD6CbyS7jiP44BCLfXijiqxwFtgXSayKO
         fM+KOrypLIDLKD+hbynlzqJLhuUz+9mfLMyNgOwn9WVpxtllv0Vyq0Rp2PhFMGiS2mkN
         1AwXAegoWufy0q5LwS3HVyBs0lNXTQ071gmAm+iBNpqbmiqoE9PXnpwkK8w68lakHGsX
         e7ZAsqi25Iimo/RtGszjfKVZ+b86vLpz1lnQeZNGLSucR4TxZZyOzNbBLArwfts2oPBt
         GPHDbWrtawMr4mAAjpl6UzhS1u3gJ052QgAY9WCneMpBcu99/if5mB5UiDPguhXsgk6W
         ETKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ufrm0CTU3ZzlwhLP0MhQM3iCgGvz24IecULGzksBi4g=;
        b=dNrZOXGSs0d365NouHTbt/VDQhjNRTcuOWySctv1Vc/Ql5J/ESe29cxp1dmoKpLVBE
         7zOGHIeSte3uIm+J7UiHt3mvHc1Ak4Js2rtJbvbJ1FsgGOfoT7BM6hse//xxg2K0uu55
         jcbyhEpCrcCvI8bpZpcsDdawxkStYTaqhlMS2+tg5lJ5fEJykn1OZ1XDBqIKBVWp8xUl
         hcvtVoavTrGTc6zTgYGCmedtD9CsI06Dphxly+c/q40Xv/nG2SbcymMgWX540FWhsdN8
         DQwcu7xewzrE5/FW0xGDhHkTzacloOG+dZRX9LxZJhIjEQYaJeWIzU/Td30Cg9nBluLo
         +Esw==
X-Gm-Message-State: APjAAAXzsnQ7T0opXCSfHT+uVu7QboHnQ+Cti+YB18k0fEIcg9dg/6ok
        EIJjZh++WKKqPeJCPAilLjo=
X-Google-Smtp-Source: APXvYqwhYyLI7I256MnlqeuAKJqVMhpmFDphxZnOGg5BunYSQhKYNMg0o6MO7CTkZw+MaXhFvkHKCg==
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr961751wmb.176.1574802286202;
        Tue, 26 Nov 2019 13:04:46 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e16sm16331307wrj.80.2019.11.26.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 13:04:45 -0800 (PST)
Date:   Tue, 26 Nov 2019 22:04:43 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [GIT PULL] x86/urgent fix for v5.5
Message-ID: <20191126210443.GA114386@gmail.com>
References: <20191125161626.GA956@gmail.com>
 <20191125192456.GA46001@gmail.com>
 <20191126094554.GA3017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191126094554.GA3017@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > Forgot to list the conflicts that may arise if you merge this after the 
> > other x86 bits.
> > 
> > Firstly the symbol bits would conflict here:
> > 
> >             arch/x86/entry/entry_32.S
> >             arch/x86/kernel/head_32.S
> >             arch/x86/xen/xen-asm_32.S
> 
> Note that these conflicts will arise once you merge x86-asm-for-linus, 
> with an additional semantic conflict in arch/x86/crypto/blake2s-core.S, 
> see my merge conflict mail to that pull request.
> 
> > There's also a conflict in arch/x86/include/asm/pgtable_32_types.h.
> 
> This asm/pgtable_32_types.h conflict will be the only conflict you'll see 
> when you merge x86-iopl-for-linus:
> 
>   <<<<<<< HEAD
>   #define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 39)
>   =======
>   #define CPU_ENTRY_AREA_PAGES    (NR_CPUS * 41)
>   >>>>>>> e3cb0c7102f04c83bf1a7cb1d052e92749310b46
> 
> And the correct resolution is to pick the '41' side.

I missed one other semantic conflict that can result in build failures on 
certain stripped down x86 32-bit configs, for example 32-bit 
"allnoconfig" where CONFIG_X86_IOPL_IOPERM gets turned off.

Here's a (tested) fix for that:

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 0bcd7762727dd8ba9b9b6f828e5a4cbd5da4f725 x86/iopl: Make 'struct tss_struct' constant size again

 Thanks,

	Ingo

------------------>
Ingo Molnar (1):
      x86/iopl: Make 'struct tss_struct' constant size again


 arch/x86/include/asm/processor.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index b4e29d8b9e5a..e51afbb0cbfb 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -411,9 +411,7 @@ struct tss_struct {
 	 */
 	struct x86_hw_tss	x86_tss;
 
-#ifdef CONFIG_X86_IOPL_IOPERM
 	struct x86_io_bitmap	io_bitmap;
-#endif
 } __aligned(PAGE_SIZE);
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct tss_struct, cpu_tss_rw);
