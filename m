Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F58C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4970820674
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 20:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfHaUC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 16:02:57 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:55806 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfHaUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 16:02:56 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57E3B14BBC0EC;
        Sat, 31 Aug 2019 13:02:53 -0700 (PDT)
Date:   Sat, 31 Aug 2019 13:02:50 -0700 (PDT)
Message-Id: <20190831.130250.1236116087422472663.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
        bp@alien8.de, rth@twiddle.net, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, ysato@users.sourceforge.jp,
        dalias@libc.org, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, tglx@linutronix.de, cai@lca.pw,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        len.brown@intel.com, axboe@kernel.dk, dledford@redhat.com,
        jeffrey.t.kirsher@intel.com, linux-alpha@vger.kernel.org,
        nfont@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        mwb@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tbogendoerfer@suse.de,
        linux-mips@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH v2 7/9] sparc64: numa: check the node id consistently
 for sparc64
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0195eb73-99ae-fec2-3e11-2cb9e6677926@huawei.com>
References: <1567231103-13237-8-git-send-email-linyunsheng@huawei.com>
        <20190830.235337.570776316111294728.davem@davemloft.net>
        <0195eb73-99ae-fec2-3e11-2cb9e6677926@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 31 Aug 2019 13:02:54 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Sat, 31 Aug 2019 16:57:04 +0800

> Did you mean sparc64 system does not has ACPI, the device's node id will
> not specified by ACPI, so the ACPI is unrelated here?

Yes, sparc64 never has and never will have ACPI.

This is also true for several other platforms where you have made this
change.

The assumption of your entire patch set is that the semantics of the
NUMA node ID are somehow completely defined by ACPI semantics.  Which
is not true.
