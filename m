Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93232C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D28F2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 08:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfD2Ipz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 04:45:55 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33320 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbfD2Ipz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 04:45:55 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2451035|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.145498-0.00694801-0.847554;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.ERaVMaQ_1556527548;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.ERaVMaQ_1556527548)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 29 Apr 2019 16:45:49 +0800
Date:   Mon, 29 Apr 2019 16:45:00 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org, guoren@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] riscv: Add support for libdw
Message-ID: <20190429084441.GC22718@vmh-VirtualBox>
References: <99f15d5c74727c31bf8d08b6cf948754e3e09943.1554961908.git.han_mao@c-sky.com>
 <mhng-a74d03ae-cfb4-4e42-8950-f90816975291@palmer-si-x1e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-a74d03ae-cfb4-4e42-8950-f90816975291@palmer-si-x1e>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:11:04PM -0700, Palmer Dabbelt wrote:
> On Thu, 11 Apr 2019 00:53:50 PDT (-0700), han_mao@c-sky.com wrote:
> >This patch add support for DWARF register mappings and libdw registers
> >initialization, which is used by perf callchain analyzing when
> >--call-graph=dwarf is given.
> 
> Is there any way to make this the only backtracer?  It's the only one that's
> likely to be useful on RISC-V without recompiling everything with
> -fno-omit-frame-pointer, which has a major performance hit.
>

Frame pointer is the default record mode in record_callchain_opt.
Some generic modification seems required to change this, default to
use dwarf if riscv and show corresponding message in --help.

Thanks,
Mao Han 
