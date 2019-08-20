Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3532C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98AF22CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 11:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JCLb4S8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfHTLcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 07:32:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33882 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbfHTLcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 07:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ADPA2lmg+8u8Wej/uy5U5FOfipsvTMwf8Euyw2Wf2Io=; b=JCLb4S8NHw7j91f4Eb5VNQHayR
        tnnTZrbFw7tPPqSknmC15wSki+v6kSasQAxbHOMRYHDnunxCI8QMDLCUNI9bUt/esuaBw18NwyVO0
        PzOstYfX+mlm20WulNoGvFezEO9Zta+igUaCj8nDkDCWUVeo34FBSkBKP8+HBuzyEG+XoP+5gJ/aW
        Z9DFON3dIycqbI0/TldZI//RMu0OBFC3Tt4D7BYNUxsA5a3xChMYcb/nG7H/0iOs2su+wsgzWL+tn
        NYRfY6sKlBshJ7t67TjpOS/RRPTFlfiPkEvh7PzOccNZoNMno50P5TR+TFZHBZGtIDcLzyyk3Out8
        SJUi5V1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i02Mw-000240-Fg; Tue, 20 Aug 2019 11:32:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 375FF307456;
        Tue, 20 Aug 2019 13:31:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 609D520E58029; Tue, 20 Aug 2019 13:32:03 +0200 (CEST)
Date:   Tue, 20 Aug 2019 13:32:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190820113203.GM2332@hirez.programming.kicks-ass.net>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190818143316.4906-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 18, 2019 at 04:33:14PM +0200, Thomas Hellström (VMware) wrote:

> +#define VMWARE_HYPERCALL \
> +	ALTERNATIVE_2(".byte 0xed", \
> +		      ".byte 0x0f, 0x01, 0xc1", X86_FEATURE_VMW_VMCALL,	\
> +		      ".byte 0x0f, 0x01, 0xd9", X86_FEATURE_VMW_VMMCALL)

For sanity, could we either add comments, or macros for those
instrucions?

Something like:

#define INSN_INL	0xed
#define INSN_VMCALL	0x0f,0x01,0xc1
#define INSN_VMMCALL	0x0f,0x01,0xd9

#define VMWARE_HYPERCALL \
	ALTERNATIVE_2(_ASM_MK_NOP(INSN_INL),
		      _ASM_MK_NOP(INSN_VMCALL), X86_FEATURE_VMCALL,
		      _ASM_MK_NOP(INSN_VMMCALL), X86_FEATURE_VMMCALL)

With possibly a patch that does 's/_ASM_MK_NOP/_ASM_MK_INSN/' on
arch/x86/ for further sanity :-)
