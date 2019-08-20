Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99CCC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8510E22CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 07:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfHTHPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:15:05 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33888 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 03:15:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46CMW84G2Cz1rJh4;
        Tue, 20 Aug 2019 09:15:00 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46CMW83CNvz1qqkJ;
        Tue, 20 Aug 2019 09:15:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id hgek4RhEvX4I; Tue, 20 Aug 2019 09:14:59 +0200 (CEST)
X-Auth-Info: cfJnge3W34ep21vK8LNYWSq+oBbl20n/Lm1XsjLjpAA2A+eyEau2plN2hZlALXyM
Received: from hawking (charybdis-ext.suse.de [195.135.221.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 20 Aug 2019 09:14:59 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     "hch\@infradead.org" <hch@infradead.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org,
        Allison Randal <allison@lohutok.net>
Subject: Re: [v2 PATCH] RISC-V: Optimize tlb flush path.
References: <20190820004735.18518-1-atish.patra@wdc.com>
        <20190820030641.GA24946@infradead.org>
X-Yow:  I think my CAREER is RUINED!!
Date:   Tue, 20 Aug 2019 09:14:58 +0200
In-Reply-To: <20190820030641.GA24946@infradead.org> (hch@infradead.org's
        message of "Mon, 19 Aug 2019 20:06:41 -0700")
Message-ID: <mvmo90kl34d.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 19 2019, "hch@infradead.org" <hch@infradead.org> wrote:

> This looks a little odd to m and assumes we never pass a size smaller
> than PAGE_SIZE.  Whule that is probably true, why not something like:
>
> 	if (size < PAGE_SIZE && size != -1)

ITYM size <= PAGE_SIZE.  And since size is unsigned it cannot be == -1
at the same time.

> 		local_flush_tlb_page(start);
> 	else
> 		local_flush_tlb_all();
>
> ?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
