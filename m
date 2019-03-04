Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4883FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1511F20657
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jjjozfw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfCDP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:27:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCDP1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kZQuhXmk8qRb0qhXSfsRFvygnvQmGOk//z4N4EZvYrU=; b=jjjozfw6nonSqAWJWm6pqjYvI
        WxZ4tkFZWMK6eaFfNhB7Xaxur/ON3qvs73Z0hc/hK0W4j6/8SoQHT/9GiB1fgC41RWfYxO16q+P5K
        CWsf2w2R4xstB7gR+LgHNZ5aSqM6Z5I2LLuqXd/aaPLtFVE5UckJTnIVohuqmdDtgszmLa15JxIGX
        5icQTEy3yp2+GGdW4IwBv10v4VH+DCir7TJ2cTsnsYbOYmg50uiaSfDxAC7zRPijCI/DUpuHjKXCr
        jvxZnobNL3MmeMeHnFoZfANQStM88RtiiQH3HUqXy7y5LubSp7NmT84akp7wO9rsQj3Zs/AG/Q5wc
        AiXbUNXdw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0pVD-0005qo-0T; Mon, 04 Mar 2019 15:27:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9BA3B20288BAA; Mon,  4 Mar 2019 16:27:36 +0100 (CET)
Date:   Mon, 4 Mar 2019 16:27:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 02/17] drivers/net/b44: Align pwol_mask to unsigned
 long for better performance
Message-ID: <20190304152736.GN32494@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-3-git-send-email-fenghua.yu@intel.com>
 <20190304100022.GA32477@hirez.programming.kicks-ass.net>
 <20190304144526.GB230561@romley-ivt3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304144526.GB230561@romley-ivt3.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 06:45:26AM -0800, Fenghua Yu wrote:

> Sure. I will change the patch to your code. And add
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> to this patch?

Sure..
