Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A63C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D99206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557139469;
	bh=Bszxc6bqbpOzzzsSnYjG/7jD+352okK7kbVrrpj0D4A=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=btyrm8fPcAdgDoTvSw+aV5Lp5W7A4T81aIFG3okgKKhwXLU+BNbJHVfdLkcOR1FGZ
	 mgDrEXHIHoa9vKTxKvuM5FivbdXQpexJA5OlNdI+qiIWb2pO1dpKfcXXnAhkXLwONS
	 tFg/cAN/Uk4YOpsSTMHY8AlE7YJ7Jy1On8hIS9Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEFKo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:44:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52762 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfEFKo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:44:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4022767wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F5AfuL7zt8o5dfccSY5UL2mBseC8RDufw18x0o3qLjs=;
        b=oP6y+jdZqwB+6b6OUcuCypGjhR2aQ3HoMcZdVin8BU3kJbb2r/nUD67rx2UetthaQM
         2hRKT2/GoNBracMj4x5GcuLLPaKP1bwGKoN7VqwEUAdL+V/NIwFXaPtUTgweww1oVlYb
         FffUJK9aD5YRoTy7hXptRgB7aFTCe1L98GpvEJd6N6dlgl1bjEd/yo8nhQ5kDv+lw85d
         whHnZfVtRWWgM6TnN9+N0xhLlCpHlJgfXZmSl7MLUIGweWlom4a2/dm2BkYm4IMhj6ZE
         c6VtFO91O+IwRegCvFlClXIc+Hm//83vEHNzE+AJouQzGMwFiciqLuefi30GqPdOYvFt
         mKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=F5AfuL7zt8o5dfccSY5UL2mBseC8RDufw18x0o3qLjs=;
        b=jG2aLhTCOc0P2+qPXWCMDK7i0UGd+0qowGP4Qew8IEGo/NR2I7jmL+eegiuf31yDey
         cbrmra5VTujkf0lRoKhG2QqdQjsHKRwoTAfYIKhO/qi8lrdgmSjFcMNZkWqhfPS13bzs
         Z5q87M1SgVvzy6RAQ8j8UXLvShD0Vr7s71rEz5EaX87bmdzdYTGjy8iaEaIay3VvgBSe
         uwAYfj4hg+/zf+ji7LU0zkFiSxWChfNUUYLlN0iOwt85CMMlXaLeX5Y+hW+a+GGfmcMe
         Qcy/n8ja61ZNykBzy8ZT/RFiqwMxN+NUuGUE3Spi8LbbSJvUMGLzfw2UEVPA6SrnWV/4
         ihnA==
X-Gm-Message-State: APjAAAWhuUTaNoEfeBzGQsdOeIHH8/s5vvH/btB0NwjQxuQOYDnJfUPR
        8WMx9Q0hPxVgEaDEeOLj3vk=
X-Google-Smtp-Source: APXvYqx8bl89kt1xjI79oen/lc2djya5kMF2JV/2BF/NqEbq5NP6kYIWd6Kdw3cdwsF/n78SCW7+YA==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr16505091wmh.40.1557139465751;
        Mon, 06 May 2019 03:44:25 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id b12sm17787071wrf.21.2019.05.06.03.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:44:25 -0700 (PDT)
Date:   Mon, 6 May 2019 12:44:23 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v5.2
Message-ID: <20190506104423.GA86522@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: 14e581c381b942ce5463a7e61326d8ce1c843be7 x86/kvm: Make steal_time visible

Smaller update for Hyper-V to support EOI assist, plus LTO fixes.

 Thanks,

	Ingo

------------------>
Andi Kleen (2):
      x86/hyperv: Make hv_vcpu_is_preempted() visible
      x86/kvm: Make steal_time visible

Vitaly Kuznetsov (1):
      x86/hyper-v: Implement EOI assist


 arch/x86/hyperv/hv_apic.c     | 5 +++++
 arch/x86/hyperv/hv_spinlock.c | 2 +-
 arch/x86/kernel/kvm.c         | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 8eb6fbee8e13..5c056b8aebef 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -86,6 +86,11 @@ static void hv_apic_write(u32 reg, u32 val)
 
 static void hv_apic_eoi_write(u32 reg, u32 val)
 {
+	struct hv_vp_assist_page *hvp = hv_vp_assist_page[smp_processor_id()];
+
+	if (hvp && (xchg(&hvp->apic_assist, 0) & 0x1))
+		return;
+
 	wrmsr(HV_X64_MSR_EOI, val, 0);
 }
 
diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
index a861b0456b1a..07f21a06392f 100644
--- a/arch/x86/hyperv/hv_spinlock.c
+++ b/arch/x86/hyperv/hv_spinlock.c
@@ -56,7 +56,7 @@ static void hv_qlock_wait(u8 *byte, u8 val)
 /*
  * Hyper-V does not support this so far.
  */
-bool hv_vcpu_is_preempted(int vcpu)
+__visible bool hv_vcpu_is_preempted(int vcpu)
 {
 	return false;
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5c93a65ee1e5..3f0cc828cc36 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -67,7 +67,7 @@ static int __init parse_no_stealacc(char *arg)
 early_param("no-steal-acc", parse_no_stealacc);
 
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
-static DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64);
+DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64) __visible;
 static int has_steal_clock = 0;
 
 /*
