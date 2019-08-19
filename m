Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1FDC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00AA20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="TbAdW3Hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfHSGZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:25:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38762 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfHSGZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:25:05 -0400
Received: from zn.tnic (p200300EC2F04B700DD16340F367BA899.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:dd16:340f:367b:a899])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D30E21EC0947;
        Mon, 19 Aug 2019 08:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566195903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1NGKnGyGKL3DbpygeMWEKaLo3/xWmVKOu0sYT8oGoE=;
        b=TbAdW3HxaT3DW+gjFEDeRVFSclyZHiIigxfCHIoGE4Dds5ZYuNgOUCwuNA/tG3ipe/GQi4
        QyfxCNWzPyjk+rV6Xw6K7hq8WHBQKYZnO/xyZUv15INavRBoNSuX97c3iRuiXOtnVmitjZ
        c2PV91DKI+vZr/Ej4yy8/OMluYvD+oI=
Date:   Mon, 19 Aug 2019 08:25:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190819062552.GC4841@zn.tnic>
References: <20190818143316.4906-1-thomas_os@shipmail.org>
 <20190818143316.4906-3-thomas_os@shipmail.org>
 <20190818201942.GC29353@zn.tnic>
 <b8875504-b112-ba5e-13d7-6abb51c01121@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8875504-b112-ba5e-13d7-6abb51c01121@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 12:28:05AM +0200, Thomas Hellström (VMware) wrote:
> Unfortunately we can't use it, because it's unconditionally set on AMD even
> if the VMware hypervisor
> doesn't support it (by version or by configuration).

AMD sets it because they don't support VMCALL. Nothing stops us from
making that conditional depending on what the hypervisor can/supports.
I'm thinking it would be even cleaner if we use those two flags:

X86_FEATURE_VMMCALL
X86_FEATURE_VMCALL

to denote hw support for either one or the other instruction and switch
accordingly. Just like KVM does.

In your case, the HV would set the preferred flag in
arch/x86/kernel/cpu/vmware.c - just like the others do in their
respective CPU init files - and the alternatives code would switch to it
when it runs.

Or is there more? :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
