Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C37C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50321582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 16:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfLQQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:17:59 -0500
Received: from ns.iliad.fr ([212.27.33.1]:40366 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729026AbfLQQRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 11:17:55 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 262012156E;
        Tue, 17 Dec 2019 17:17:54 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0DB302152D;
        Tue, 17 Dec 2019 17:17:54 +0100 (CET)
Subject: Re: [RFC PATCH v1] devres: align devres.data strictly only for
 devm_kmalloc()
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tejun Heo <tj@kernel.org>, Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Message-ID: <ae053dd1-c4e1-8489-3ab8-9f900de4eab4@free.fr>
Date:   Tue, 17 Dec 2019 17:17:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <74ae22cd-08c1-d846-3e1d-cbc38db87442@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Tue Dec 17 17:17:54 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/2019 16:30, Marc Gonzalez wrote:

> +#define DEVM_KMALLOC_PADDING_SIZE \
> +	(ARCH_KMALLOC_MINALIGN - sizeof(struct devres) % ARCH_KMALLOC_MINALIGN)

Doh!

#define DEVM_KMALLOC_PADDING_SIZE \
  ((ARCH_KMALLOC_MINALIGN - sizeof(struct devres)) % ARCH_KMALLOC_MINALIGN)
