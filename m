Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCC4C606B0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE31F20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfGJIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:46:59 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45802 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfGJIq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:46:59 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0A32472CCDD;
        Wed, 10 Jul 2019 11:46:57 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 00D8C7CCE3A; Wed, 10 Jul 2019 11:46:56 +0300 (MSK)
Date:   Wed, 10 Jul 2019 11:46:56 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Xi Ruoyao <xry111@mengyan1223.wang>
Cc:     Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        David Airlie <airlied@linux.ie>, Jessica Yu <jeyu@kernel.org>,
        kernel-hardening@lists.openwall.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: kernel oops loading i915 after "x86/asm: Pin sensitive CR4 bits"
 (873d50d58)
Message-ID: <20190710084656.GB5447@altlinux.org>
References: <e5baec48e5c362256a631a2d55fbc30251ab5e83.camel@mengyan1223.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5baec48e5c362256a631a2d55fbc30251ab5e83.camel@mengyan1223.wang>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 10, 2019 at 01:44:17PM +0800, Xi Ruoyao wrote:
> Hello,
> 
> When I try to build and run the latest mainline kernel, it Oops loading i915
> module:
> 
> BUG: unable to handle page fault for address: ffffffff9edc1598
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0003) - permissions violation
> PGD 1a20c067 P4D 1a20c067 PUD 1a20d063 PMD 8000000019e000e1 
> Oops: 0003 [#1] SMP PTI
> 
> The complete log is attached.
> 
> Bisection tells "x86/asm: Pin sensitive CR4 bits" (873d50d58) is the first "bad"
> commit.  I can revert it and also "x86/asm: Pin sensitive CR0 bits" (8dbec27a2)
> to make the kernel "seems to" work.
> 
> I'm not a kernel expert so I can't tell if there is a bug in Kees' patch, or his
> patch exploits a bug in i915 or module loader.

This seems to be a kernel bug introduced after v5.2, see
https://lore.kernel.org/lkml/CAHk-=wjh+h_-fd-gJz=wor42ZNmqq46QnB90jyfzqmKLsLFWOg@mail.gmail.com/


-- 
ldv
