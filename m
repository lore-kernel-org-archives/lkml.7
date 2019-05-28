Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACB7C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502892070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfE1LES convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:04:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:50240 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1LER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:04:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVZts-0002tB-VI; Tue, 28 May 2019 13:04:13 +0200
Date:   Tue, 28 May 2019 13:04:12 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yury Norov <ynorov@marvell.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: LZ4 decompressor broken on ARM due to missing strchrnul() string
 traverse in cpumask_parse"
Message-ID: <20190528110412.gg66fl67yahtwb6i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

|  CC      arch/arm/boot/compressed/decompress.o
|In file included from include/linux/mm_types_task.h:14,
|                 from include/linux/mm_types.h:5,
|                 from include/linux/mmzone.h:21,
|                 from include/linux/gfp.h:6,
|                 from include/linux/umh.h:4,
|                 from include/linux/kmod.h:22,
|                 from include/linux/module.h:13,
|                 from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
|                 from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:13,
|                 from arch/arm/boot/compressed/decompress.c:55:
|include/linux/cpumask.h: In function ‘cpumask_parse’:
|include/linux/cpumask.h:636:21: error: implicit declaration of function ‘strchrnul’; did you mean ‘strchr’? [-Werror=implicit-function-declaration]
|  unsigned int len = strchrnul(buf, '\n') - buf;
|                     ^~~~~~~~~
|                     strchr
|include/linux/cpumask.h:636:42: error: invalid operands to binary - (have ‘int’ and ‘const char *’)
|  unsigned int len = strchrnul(buf, '\n') - buf;
|                     ~~~~~~~~~~~~~~~~~~~~ ^
|cc1: some warnings being treated as errors

3713a4e1fdb8da86f96a3e770b08e278d97529b4 is the first bad commit
commit 3713a4e1fdb8da86f96a3e770b08e278d97529b4
Author: Yury Norov <ynorov@marvell.com>
Date:   Tue May 14 15:44:46 2019 -0700

    include/linux/cpumask.h: fix double string traverse in cpumask_parse

    cpumask_parse() finds first occurrence of either or strchr() and
    strlen().  We can do it better with a single call of strchrnul().

    [akpm@linux-foundation.org: remove unneeded cast]
    Link: http://lkml.kernel.org/r/20190409204208.12190-1-ynorov@marvell.com
    Signed-off-by: Yury Norov <ynorov@marvell.com>
    Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 f20d8a9ec1755b3981520ecf015248f6a0d9f116 db67caf64f99a9be808cd73e413c106c5aee15b7 M      include

This commit is v5.2-rc1~62^2~49.
How do we deal with this one?

Sebastian
