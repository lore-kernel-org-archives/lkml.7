Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E96BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 016BE217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FW93TT0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfGOPSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:18:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36984 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfGOPSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:18:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so16000468qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cRpKFS+Fyt9LbiY0I1uGPCo3RsVwfYk0idM+vjumZjA=;
        b=FW93TT0uUkqJYlM64Rb3ivtPki+Y5zRRrdRBX35zervukDmNb89nBvc7LW6gyAM5I8
         LF91waCKAMrkT7MHNDv4dyhXEAIzhtV2fiYleJDyh4/ZP59skJTCchgrsRKqQATMOR23
         T8iW+SuvnqRn5a9h8B+9qGsl9GQY7aOCRIo98ipoTGIXMlbWXJv4ezLJIgRcwuyYnDWn
         lkiCB1EHTipRT4X2X83R2Bnbkg9toh3hq4aSBNP7C1ndCR+mc1jtJ4nKx8O2adZJ5pck
         pQcTgmyx5vdb3xuz/L2adPEpGkvazvqJQqWKtlm1Fo994mHz4b3c7b66VF9hWs849x1U
         B8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cRpKFS+Fyt9LbiY0I1uGPCo3RsVwfYk0idM+vjumZjA=;
        b=DkyI8ba3dLPZqTFjfaQ8oMkWzI1azqPMsC4GAd680sOC0tYdS1H4ap1YDUHuKskCpz
         bWB+VpPb2PAt6LhgC0xGwkjQ4bUpUMJoogsyoQaoXhkzASPD+GFk1V0OqS0MseWXqWQ8
         A7eAG081Ee+i9l8gKtYdyP/kWEgnC6pMdceaSdfPB2C4WdusYtH/1jusKsLfmXI4rkV6
         NDL09LC5Fln+I/ZzK8Xi2oLmu4MwCmXTXe9KYzA4MZkR1gwA5gyk/3YAI+KQ3wTY4h5E
         TmSt6t6NNdvCtpkCrac7ZgadQXvirctRvS5AJ0y0AyJTKPe3MbYLxXZefnWIIWziP5hO
         4sbw==
X-Gm-Message-State: APjAAAUCmoccDzsM22cXEckHtAJvCB7Ba8n6qdQh5kMdBk9XwD9IETHf
        yB4TjfqQ0qsxcCvXgUGFP/bVmA==
X-Google-Smtp-Source: APXvYqx6aw9F3hMC/lqfvZiuDSagGEHvd4jwPaC9u4/DDmcJvnugFN8K3ynyJgUCEy2eCj6WksZC6g==
X-Received: by 2002:ac8:7651:: with SMTP id i17mr17268712qtr.245.1563203884002;
        Mon, 15 Jul 2019 08:18:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d141sm7800449qke.3.2019.07.15.08.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jul 2019 08:18:03 -0700 (PDT)
Message-ID: <1563203882.4610.1.camel@lca.pw>
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 15 Jul 2019 11:18:02 -0400
In-Reply-To: <F89E7123-C21C-41AA-8084-1DB4C832D7BD@gmail.com>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
         <20190715131732.GX29483@dhcp22.suse.cz>
         <F89E7123-C21C-41AA-8084-1DB4C832D7BD@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-15 at 10:01 -0500, Catalin Marinas wrote:
> On 15 Jul 2019, at 08:17, Michal Hocko <mhocko@kernel.org> wrote:
> > On Sat 13-07-19 04:49:04, Yang Shi wrote:
> > > When running ltp's oom test with kmemleak enabled, the below warning was
> > > triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
> > > passed in:
> > 
> > kmemleak is broken and this is a long term issue. I thought that
> > Catalin had something to address this.
> 
> What needs to be done in the short term is revert commit
> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0. Longer term the solution is to embed
> kmemleak metadata into the slab so that we don’t have the situation where the
> primary slab allocation success but the kmemleak metadata fails. 
> 
> I’m on holiday for one more week with just a phone to reply from but feel free
> to revert the above commit. I’ll follow up with a better solution. 

Well, the reverting will only make the situation worst for the kmemleak under
memory pressure. In the meantime, if someone wants to push for the mempool
solution with tunable pool sizes along with the reverting, that could be an
improvement.

https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.com/
