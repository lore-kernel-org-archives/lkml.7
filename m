Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D392EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E6620656
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VcH1A54m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfH0Po2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:44:28 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33144 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfH0Po2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:44:28 -0400
Received: from zn.tnic (p200300EC2F0CD000D58CEF7064D904CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:d000:d58c:ef70:64d9:4cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A98E31EC06E5;
        Tue, 27 Aug 2019 17:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566920666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VHBR4nVac4hkcN25eNcINMCsBK8JU9h3vxB99dyirGI=;
        b=VcH1A54m6kJs1/No5Lu9Obxh+05iWmYgt7HIHUzgq5yivpuawF7Y+ULYNwUzDL/1G7j5Vl
        h05fl3yrd83hRgEl/hLOk5uYWhHXRiOP8k4vThzJScwOh1c4RVvFXVKOmxqmoTZTN3FUg2
        eJOqSSYYTMwyc712h39aGVIQ3zwNR1w=
Date:   Tue, 27 Aug 2019 17:44:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, Doug Covelli <dcovelli@vmware.com>
Subject: Re: [PATCH v2 2/4] x86/vmware: Add a header file for hypercall
 definitions
Message-ID: <20190827154422.GG29752@zn.tnic>
References: <20190823081316.28478-1-thomas_os@shipmail.org>
 <20190823081316.28478-3-thomas_os@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190823081316.28478-3-thomas_os@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 10:13:14AM +0200, Thomas Hellström (VMware) wrote:
> +/*
> + * The high bandwidth out call. The low word of edx is presumed to have the
> + * HB and OUT bits set.
> + */
> +#define VMWARE_HYPERCALL_HB_OUT						\
> +	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \

Hmm, that looks fishy:

This call in vmw_port_hb_out(), for example, gets converted to the asm
below (I've left in the asm touching only rDX).

# drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:160:              VMW_PORT_HB_OUT(
#NO_APP
        movzwl  0(%rbp), %edx   # channel_20(D)->channel_id, channel_20(D)->channel_id

	...

        sall    $16, %edx       #, tmp172
        orl     $3, %edx        #, tmp173

this is adding channel_id and flags:

                        VMWARE_HYPERVISOR_HB | (channel->channel_id << 16) |
                        VMWARE_HYPERVISOR_OUT,

the $3 being (VMWARE_HYPERVISOR_HB | VMWARE_HYPERVISOR_OUT).

        movslq  %edx, %rdx      # tmp173, tmp174

Here it is sign-extending it.

#APP
# 160 "drivers/gpu/drm/vmwgfx/vmwgfx_msg.c" 1
        push %rbp;mov %r8, %rbp;# ALT: oldinstr2        # bp
661:
        movw $0x5659, %dx; rep outsb

And now here you're overwriting the low word of %edx. And now it
contains:

0x[channel_id]5659

and the low word doesn't contain the 3, i.e., (VMWARE_HYPERVISOR_HB |
VMWARE_HYPERVISOR_OUT) anymore. And that's before you do the hypercall
so I'm guessing that cannot be right.

Or?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
