Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7410BC7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510DE208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 20:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390937AbfGRUkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:40:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRUkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 16:40:13 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hoDCF-0003Zz-3o; Thu, 18 Jul 2019 22:40:11 +0200
Date:   Thu, 18 Jul 2019 22:40:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Subject: x86 - clang / objtool status
Message-ID: <alpine.DEB.2.21.1907182223560.1785@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

after picking up Josh's objtool updates I gave clang a test ride again.

clan is built with https://github.com/ClangBuiltLinux/tc-build.git

That's using the llvm master branch. top commit is:

  0c99d19470b ("[OPENMP]Fix sharing of threadprivate variables with TLS support.")

I merged

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent

into the tip of Linus tree to pick up the latest objtool changes.

Here are the results for different configs:

1) defconfig

 objtool warnings:

  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x88: redundant UACCESS disable


2) debian distro config

 objtool warnings:

  drivers/gpu/drm/amd/amdgpu/atom.o: warning: objtool: atom_op_move() falls through to next function atom_op_and()
  drivers/infiniband/hw/hfi1/platform.o: warning: objtool: tune_serdes() falls through to next function apply_tx_lanes()
  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x86: redundant UACCESS disable
  drivers/gpu/drm/radeon/evergreen_cs.o: warning: objtool: evergreen_cs_parse() falls through to next function evergreen_dma_cs_parse()

 Build fails with:

  clang-10: error: unknown argument: '-mpreferred-stack-boundary=4'
  make[5]: *** [linux/scripts/Makefile.build:279: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o] Error 1


3) allmodconfig:

 objtool warnings:

  arch/x86/kernel/signal.o: warning: objtool: x32_setup_rt_frame()+0x255: call to memset() with UACCESS enabled
  arch/x86/kernel/signal.o: warning: objtool: __setup_rt_frame()+0x254: call to memset() with UACCESS enabled
  arch/x86/ia32/ia32_signal.o: warning: objtool: ia32_setup_rt_frame()+0x247: call to memset() with UACCESS enabled

  mm/kasan/common.o: warning: objtool: kasan_report()+0x52: call to __stack_chk_fail() with UACCESS enabled
  drivers/ata/sata_dwc_460ex.o: warning: objtool: sata_dwc_bmdma_start_by_tag()+0x3a0: can't find switch jump table

  lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch()+0x88: call to memset() with UACCESS enabled
  lib/ubsan.o: warning: objtool: ubsan_type_mismatch_common()+0x610: call to __stack_chk_fail() with UACCESS enabled
  lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1()+0x88: call to memset() with UACCESS enabled
  drivers/gpu/drm/i915/gem/i915_gem_execbuffer.o: warning: objtool: .altinstr_replacement+0x56: redundant UACCESS disable

 Build fails with:

  ERROR: "__compiletime_assert_2801" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
  ERROR: "__compiletime_assert_2446" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
  ERROR: "__compiletime_assert_2452" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!
  ERROR: "__compiletime_assert_2790" [drivers/net/wireless/intel/iwlwifi/iwlwifi.ko] undefined!

 This also emits a boatload of warnings like this:

  linux/fs/nfs/dir.c:451:34: warning: variable 'wq' is uninitialized when used within its own initialization
      [-Wuninitialized]
        DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
                                        ^~
  linux/include/linux/wait.h:74:63: note: expanded from macro 'DECLARE_WAIT_QUEUE_HEAD_ONSTACK'
        struct wait_queue_head name = __WAIT_QUEUE_HEAD_INIT_ONSTACK(name)
                               ~~~~                                  ^~~~
  linux/include/linux/wait.h:72:33: note: expanded from macro '__WAIT_QUEUE_HEAD_INIT_ONSTACK'
        ({ init_waitqueue_head(&name); name; })

Thanks,

	tglx
