Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E78C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41C720844
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NZu7XgmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfGHPJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:09:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfGHPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:09:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r7UwcFp7s/JselmOZws/SyZ0vs26xyAmDy6K8E/OEck=; b=NZu7XgmXduMWL7HuE6ocOe90f
        BMM3Il8oUtGCxdBtF2+rzdhGaMFvmDf2jl8ed5+3eNEhpR1tfvB8WgisJRaBdid9hPqLGTZKvBwl5
        udA8H/12Sks5lEojNuAQ/kSlq43katr9ZGYkMwgOULPzyq/YD9DyR8Ajv1sRXKKL3H3Oj5C0NdQ1d
        QPNZmRFEuGV79a6SBgZxuD/VsRvRCDm525CTAk4qOb0/z05HWnkxtSpO48/C6gdAex06Mj4r3QULN
        KDyH0ThG788ZfDohWaJsybGO/i85j0lYFLNE07SbzOcWPBT9yJw3na4LnyDzaDWzh/imksZWASbuy
        1rpx6evrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hkVGR-0001wF-GQ; Mon, 08 Jul 2019 15:09:11 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B233420976D8C; Mon,  8 Jul 2019 17:09:09 +0200 (CEST)
Date:   Mon, 8 Jul 2019 17:09:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 12/12] KVM/VMX/vPMU: support to report
 GLOBAL_STATUS_LBRS_FROZEN
Message-ID: <20190708150909.GP3402@hirez.programming.kicks-ass.net>
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com>
 <1562548999-37095-13-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562548999-37095-13-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:23:19AM +0800, Wei Wang wrote:
> This patch enables the LBR related features in Arch v4 in advance,
> though the current vPMU only has v2 support. Other arch v4 related
> support will be enabled later in another series.
> 
> Arch v4 supports streamlined Freeze_LBR_on_PMI. According to the SDM,
> the LBR_FRZ bit is set to global status when debugctl.freeze_lbr_on_pmi
> has been set and a PMI is generated. The CTR_FRZ bit is set when
> debugctl.freeze_perfmon_on_pmi is set and a PMI is generated.

(that's still a misnomer; it is: freeze_perfmon_on_overflow)

Why?

Who uses that v4 crud? It's broken. It looses events between overflow
and PMI.
