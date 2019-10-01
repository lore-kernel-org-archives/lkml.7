Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CCECE588
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA2221855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MZM6C3tO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731822AbfJAHHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:07:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58614 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfJAHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:07:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=U+VBcJtf8B2Pl+iBalhNWw2Jq5hguTIVdcwKLqa/Fg8=; b=MZM6C3tO1ffvt2J0a6LR7mWlC
        B2VnygxSdHeDiWidvoyw1wkMx+8uK4y2dXJeOanFbjA8Qwyd5mAM76YBBayAPYrB1ejXnY5mY/PD5
        HXnbk3RKYES9ghzRr0ANEyk4Ws/Yjohs9bIEHWsQOElU6zB5qTj5ZPk58LZ3vEXPxq+vrcBrqZG2v
        6DSD0jYbmRV5OM7oH030xhAN/tz813PzG2KB0zdQnM79xahwqu5jqN2iAP0WdLDgfWjwfLdlQv222
        doVoMwJExAi7lXAUVNMkJcJBoCg382fkN+XCDzv3Se6KAEX83jolK8hRnntUkWHc9LXsk8R1iDBHv
        HbWaavrHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFCFn-0000wU-F0; Tue, 01 Oct 2019 07:07:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03B8E301B59;
        Tue,  1 Oct 2019 09:06:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4974926529A4F; Tue,  1 Oct 2019 09:07:20 +0200 (CEST)
Date:   Tue, 1 Oct 2019 09:07:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Zhang, Jun" <jun.zhang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "He, Bo" <bo.he@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/PAT: priority the PAT warn to error to highlight the
 developer
Message-ID: <20191001070720.GI4519@hirez.programming.kicks-ass.net>
References: <20190929072032.14195-1-jun.zhang@intel.com>
 <20190930120211.GE29694@zn.tnic>
 <88DC34334CA3444C85D647DBFA962C2735B662B6@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88DC34334CA3444C85D647DBFA962C2735B662B6@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 05:00:25AM +0000, Zhang, Jun wrote:
> Please see my comments.
> 

Please use a normal MUA that can quote text you're replying to. This is
unreadable garbage.
