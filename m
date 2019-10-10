Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D72C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F268E20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570696736;
	bh=kHF1T18V0B85FjA/sMNpJQV9yXiVVxa+g33YQBJI1fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QkxWP1s78mdWXfsPrXKquIwy4X8ymw65DBbl8FGOr9Tf/JVg3rdlaeCSjGfd2d7kn
	 RIUg1AXvUHTYhNpcLnhwftxpDy07CQOVw0JV2Y/cXhl6/qTARvqgSITW2wwwAizDqI
	 Qr/izKVH5bmPVp2rmzsaIx9HSCdh3ziRek9hd4y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbfJJIiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:38:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbfJJIiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:38:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C2E1218AC;
        Thu, 10 Oct 2019 08:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570696732;
        bh=kHF1T18V0B85FjA/sMNpJQV9yXiVVxa+g33YQBJI1fE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzVNn/RQ3o1UEtnxTUpH1XlM3iZ9FLCm8fUzGM7G8+naVW8QwPF40KHu9h6SE0a0b
         28Dn8531LL1B4+gt2K+VKdYS16CeS4JbJeuPtTZYGZZspiAXplSHKxl3V9kCcaK5fw
         /5S7yUUcvm2fq1hRJ3ethpw7KH+6vU6C8RUo0jK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.3 004/148] s390/topology: avoid firing events before kobjs are created
Date:   Thu, 10 Oct 2019 10:34:25 +0200
Message-Id: <20191010083610.526706630@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191010083609.660878383@linuxfoundation.org>
References: <20191010083609.660878383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

commit f3122a79a1b0a113d3aea748e0ec26f2cb2889de upstream.

arch_update_cpu_topology is first called from:
kernel_init_freeable->sched_init_smp->sched_init_domains

even before cpus has been registered in:
kernel_init_freeable->do_one_initcall->s390_smp_init

Do not trigger kobject_uevent change events until cpu devices are
actually created. Fixes the following kasan findings:

BUG: KASAN: global-out-of-bounds in kobject_uevent_env+0xb40/0xee0
Read of size 8 at addr 0000000000000020 by task swapper/0/1

BUG: KASAN: global-out-of-bounds in kobject_uevent_env+0xb36/0xee0
Read of size 8 at addr 0000000000000018 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Tainted: G    B
Hardware name: IBM 3906 M04 704 (LPAR)
Call Trace:
([<0000000143c6db7e>] show_stack+0x14e/0x1a8)
 [<0000000145956498>] dump_stack+0x1d0/0x218
 [<000000014429fb4c>] print_address_description+0x64/0x380
 [<000000014429f630>] __kasan_report+0x138/0x168
 [<0000000145960b96>] kobject_uevent_env+0xb36/0xee0
 [<0000000143c7c47c>] arch_update_cpu_topology+0x104/0x108
 [<0000000143df9e22>] sched_init_domains+0x62/0xe8
 [<000000014644c94a>] sched_init_smp+0x3a/0xc0
 [<0000000146433a20>] kernel_init_freeable+0x558/0x958
 [<000000014599002a>] kernel_init+0x22/0x160
 [<00000001459a71d4>] ret_from_fork+0x28/0x30
 [<00000001459a71dc>] kernel_thread_starter+0x0/0x10

Cc: stable@vger.kernel.org
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/topology.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -311,7 +311,8 @@ int arch_update_cpu_topology(void)
 	on_each_cpu(__arch_update_dedicated_flag, NULL, 0);
 	for_each_online_cpu(cpu) {
 		dev = get_cpu_device(cpu);
-		kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+		if (dev)
+			kobject_uevent(&dev->kobj, KOBJ_CHANGE);
 	}
 	return rc;
 }


