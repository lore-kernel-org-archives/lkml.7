Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3D0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98EC920848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfEPN4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:56:20 -0400
Received: from freki.datenkhaos.de ([81.7.17.101]:44322 "EHLO
        freki.datenkhaos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfEPN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:56:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by freki.datenkhaos.de (Postfix) with ESMTP id 15E7C1304DF0;
        Thu, 16 May 2019 15:56:17 +0200 (CEST)
Received: from freki.datenkhaos.de ([127.0.0.1])
        by localhost (freki.datenkhaos.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L3mHx5NWz_9W; Thu, 16 May 2019 15:56:15 +0200 (CEST)
Received: from probook (geri.datenkhaos.de [81.7.17.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by freki.datenkhaos.de (Postfix) with ESMTPSA;
        Thu, 16 May 2019 15:56:15 +0200 (CEST)
Date:   Thu, 16 May 2019 15:56:07 +0200
From:   Johannes Hirte <johannes.hirte@datenkhaos.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <20190516135606.GA25602@probook>
References: <20190423183827.GA4012@beast>
 <20190514120416.GA11736@probook>
 <201905140842.21066115C5@keescook>
 <20190514161051.GA21695@probook>
 <201905151151.D4EA0FF7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201905151151.D4EA0FF7@keescook>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019 Mai 15, Kees Cook wrote:
> On Tue, May 14, 2019 at 06:10:55PM +0200, Johannes Hirte wrote:
> > On 2019 Mai 14, Kees Cook wrote:
> > > On Tue, May 14, 2019 at 02:04:21PM +0200, Johannes Hirte wrote:
> > > > This breaks the build on my system:
> > > > 
> > > >   RELOCS  arch/x86/boot/compressed/vmlinux.relocs
> > > >   CC      arch/x86/boot/compressed/early_serial_console.o
> > > >   CC      arch/x86/boot/compressed/kaslr.o
> > > >   AS      arch/x86/boot/compressed/mem_encrypt.o
> > > >   CC      arch/x86/boot/compressed/kaslr_64.o
> > > > Invalid absolute R_X86_64_32S relocation: _etext
> > > > make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> > > > make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> > > > make[2]: *** Waiting for unfinished jobs....
> > > > make[1]: *** [arch/x86/boot/Makefile:112: arch/x86/boot/compressed/vmlinux] Error 2
> > > > make: *** [arch/x86/Makefile:283: bzImage] Error 2
> > > 
> > > Interesting! Can you send along your .config and compiler details?
> > 
> > Tested with gcc-8.3 and gcc-9.1, both the same result.
> > [...]
> > gcc version 8.3.0 (Gentoo 8.3.0-r1 p1.1)
> 
> Hm, I'm not able to reproduce this with any of the compilers I have
> access to. The most recent I have is:
> 
> gcc (Ubuntu 20180425-1ubuntu1) 9.0.0 20180425 (experimental) [trunk revision 259645]
> 
> Various stupid questions: did you wipe the whole bulid tree and start
> clean? 

No I didn't. And this fixed it now. After a distclean I'm unable to
reproduce it. So sorry for the noise.

-- 
Regards,
  Johannes

