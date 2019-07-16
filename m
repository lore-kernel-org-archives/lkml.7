Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052FC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA31206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfGPK5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 06:57:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733037AbfGPK5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 06:57:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47441AF46;
        Tue, 16 Jul 2019 10:57:14 +0000 (UTC)
Subject: Re: [PATCH v7 4/5] x86/paravirt: Remove const mark from
 x86_hyper_xen_hvm variable
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     bp@alien8.de, sstabellini@kernel.org, tglx@linutronix.de,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com,
        mingo@redhat.com
References: <1562846532-32152-1-git-send-email-zhenzhong.duan@oracle.com>
 <1562846532-32152-5-git-send-email-zhenzhong.duan@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <2433589d-a2d2-6b51-cfbd-c1141014ab93@suse.com>
Date:   Tue, 16 Jul 2019 12:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1562846532-32152-5-git-send-email-zhenzhong.duan@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.19 14:02, Zhenzhong Duan wrote:
> .. as "nopv" support needs it to be changeable at boot up stage.
> 
> Checkpatch report warning, so move variable declarations from
> hypervisor.c to hypervisor.h
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> ---
>   arch/x86/include/asm/hypervisor.h | 8 ++++++++
>   arch/x86/kernel/cpu/hypervisor.c  | 8 --------
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hypervisor.h b/arch/x86/include/asm/hypervisor.h
> index f7b4c53..e41cbf2 100644
> --- a/arch/x86/include/asm/hypervisor.h
> +++ b/arch/x86/include/asm/hypervisor.h
> @@ -58,6 +58,14 @@ struct hypervisor_x86 {
>   	bool ignore_nopv;
>   };
>   
> +extern const struct hypervisor_x86 x86_hyper_vmware;
> +extern const struct hypervisor_x86 x86_hyper_ms_hyperv;
> +extern const struct hypervisor_x86 x86_hyper_xen_pv;
> +extern const struct hypervisor_x86 x86_hyper_kvm;
> +extern const struct hypervisor_x86 x86_hyper_jailhouse;
> +extern const struct hypervisor_x86 x86_hyper_acrn;
> +extern struct hypervisor_x86 x86_hyper_xen_hvm;

This should either stay const and be changed in patch 5, or you
should adapt its definition in arch/x86/xen/enlighten_hvm.c in
this patch.


Juergen
