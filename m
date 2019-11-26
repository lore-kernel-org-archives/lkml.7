Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DD4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4036E2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfKZKCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 05:02:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:51762 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727629AbfKZKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:02:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F9B7B38D;
        Tue, 26 Nov 2019 10:02:16 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] xen-pcifront: Align address of flags to size of
 unsigned long
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <1574710984-208305-1-git-send-email-fenghua.yu@intel.com>
 <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e236e8fe-3a81-e17a-2286-228bfde9919a@suse.com>
Date:   Tue, 26 Nov 2019 11:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1574710984-208305-3-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.19 20:43, Fenghua Yu wrote:
> The address of "flags" is passed to atomic bitops which require the
> address is aligned to size of unsigned long.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   include/xen/interface/io/pciif.h | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/xen/interface/io/pciif.h b/include/xen/interface/io/pciif.h
> index d9922ae36eb5..639d5fb484a3 100644
> --- a/include/xen/interface/io/pciif.h
> +++ b/include/xen/interface/io/pciif.h
> @@ -103,8 +103,11 @@ struct xen_pcie_aer_op {
>   	uint32_t devfn;
>   };
>   struct xen_pci_sharedinfo {
> -	/* flags - XEN_PCIF_* */
> -	uint32_t flags;
> +	/* flags - XEN_PCIF_*. Force alignment for atomic bit operations. */
> +	union {
> +		uint32_t	flags;
> +		unsigned long	flags_alignment;
> +	};
>   	struct xen_pci_op op;
>   	struct xen_pcie_aer_op aer_op;
>   };
> 

NAK.

This is an interface definition for communication between Xen dom0 and
guests via shared memory. It can't be changed.

BTW: you should Cc: the maintainers for the files you are modifying.


Juergen
