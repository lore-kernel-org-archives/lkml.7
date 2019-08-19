Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53B7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3EB20651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMMAgHS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfHSO2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:28:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfHSO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:28:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so1046709pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :user-agent:message-id:content-transfer-encoding;
        bh=g1/UhsGpab2huoNPYfjYR7z5xJe4sBwu+dlYxZJw49k=;
        b=jMMAgHS3zoiaNzMEUcmUgjr6gPEABAgsBi6k0p2sQa8P8pHKcQPRrru8ITglJxQ/0X
         zsy/uqPEE8EGDNTSZiugXTzmq1iu2hHO/tCotMqhdESeN1GjUmmq463qCh88MPL0CEVb
         zz36GZCHPW+fhZivXCxUZCmpmsgJfPX4cXT24UtQ2cTwcIBJFySECSx6Z5gaw7D51Eym
         wdu4ZJmpO8t/K1A5F0b/ZqNmsiK88RSUibuOj6D3beExU2y78Bx5wSzd/yww/7HTES4C
         ByXVWplr1NiberP0x8tGeOljLU3aAT7oBhrzuZqQ0OAGw1pyq841e4AMIgazCkv/ikQZ
         u4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:user-agent:message-id:content-transfer-encoding;
        bh=g1/UhsGpab2huoNPYfjYR7z5xJe4sBwu+dlYxZJw49k=;
        b=taES7oEbbfl2W8dl7bRD5EYEhqIlI8lmZuElc49seG4Xneymck4UUjHykNrvJZulE1
         WDi9o0wZ4P8bOYubhhszOBEHjY9XppRz7kSOBjB5WPQn251jpITiuCIdfOkZtqy/ruLR
         zWOwcURR9a0B27ZZOX+VCsDM3Hrb2dndiWSkFPRVm+E5+tjM/OLO48h56096a0qZUgqj
         o6DgVhbXXaiwzbC5HR7k/B0e9ZFj7R878A7yzujFFXlAX/xOe9ySJo1c339o/e13UP4v
         xYoVT0qbzm6E0ppBwRMxW9R371hcMsgN9mQEtb0volcZGP2x45z0h83TVAFWp9kPF/3M
         3Pbg==
X-Gm-Message-State: APjAAAXFfXaIR1ykAg0A40zbGBChZDtLJ4Lt4rcfT2VFkYUJW6ns3GxJ
        AJUjNhf13RFN9BSnan5pwY5lONiuHMw=
X-Google-Smtp-Source: APXvYqyEjr4b6B13UJoHIE8vvVUqnED+Xe2pkMgDtpPBfdCtsyNSFc3mykM+gLpwYyHA6dXGhvbWGg==
X-Received: by 2002:a17:902:ba14:: with SMTP id j20mr13915360pls.84.1566224930295;
        Mon, 19 Aug 2019 07:28:50 -0700 (PDT)
Received: from localhost (193-116-95-121.tpgi.com.au. [193.116.95.121])
        by smtp.gmail.com with ESMTPSA id k3sm27704498pfg.23.2019.08.19.07.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:28:49 -0700 (PDT)
Date:   Tue, 20 Aug 2019 00:28:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v10 6/7] powerpc/mce: Handle UE event for memcpy_mcsafe
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Santosh Sivaraj <santosh@fossix.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190815003941.18655-1-santosh@fossix.org>
        <20190815003941.18655-7-santosh@fossix.org>
In-Reply-To: <20190815003941.18655-7-santosh@fossix.org>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1566224688.g0ntl10a9q.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Santosh Sivaraj's on August 15, 2019 10:39 am:
> From: Balbir Singh <bsingharora@gmail.com>
>=20
> If we take a UE on one of the instructions with a fixup entry, set nip
> to continue execution at the fixup entry. Stop processing the event
> further or print it.

The previous patch added these fixup entries and now you handle them
here. Which in theory seems to break bisecting. The patches should
either be merged, or this one moved ahead in the series.

I'm still not entirely happy with the ignore_event thing, but that's
probably more a symptom of the convoluted way machine check handling
and reporting is structured. For now it's probably fine.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>=20
> Co-developed-by: Reza Arbab <arbab@linux.ibm.com>
> Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mce.h  |  4 +++-
>  arch/powerpc/kernel/mce.c       | 16 ++++++++++++++++
>  arch/powerpc/kernel/mce_power.c | 15 +++++++++++++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mc=
e.h
> index f3a6036b6bc0..e1931c8c2743 100644
> --- a/arch/powerpc/include/asm/mce.h
> +++ b/arch/powerpc/include/asm/mce.h
> @@ -122,7 +122,8 @@ struct machine_check_event {
>  			enum MCE_UeErrorType ue_error_type:8;
>  			u8		effective_address_provided;
>  			u8		physical_address_provided;
> -			u8		reserved_1[5];
> +			u8		ignore_event;
> +			u8		reserved_1[4];
>  			u64		effective_address;
>  			u64		physical_address;
>  			u8		reserved_2[8];
> @@ -193,6 +194,7 @@ struct mce_error_info {
>  	enum MCE_Initiator	initiator:8;
>  	enum MCE_ErrorClass	error_class:8;
>  	bool			sync_error;
> +	bool			ignore_event;
>  };
> =20
>  #define MAX_MC_EVT	100
> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
> index a3b122a685a5..ec4b3e1087be 100644
> --- a/arch/powerpc/kernel/mce.c
> +++ b/arch/powerpc/kernel/mce.c
> @@ -149,6 +149,7 @@ void save_mce_event(struct pt_regs *regs, long handle=
d,
>  		if (phys_addr !=3D ULONG_MAX) {
>  			mce->u.ue_error.physical_address_provided =3D true;
>  			mce->u.ue_error.physical_address =3D phys_addr;
> +			mce->u.ue_error.ignore_event =3D mce_err->ignore_event;
>  			machine_check_ue_event(mce);
>  		}
>  	}
> @@ -266,8 +267,17 @@ static void machine_process_ue_event(struct work_str=
uct *work)
>  		/*
>  		 * This should probably queued elsewhere, but
>  		 * oh! well
> +		 *
> +		 * Don't report this machine check because the caller has a
> +		 * asked us to ignore the event, it has a fixup handler which
> +		 * will do the appropriate error handling and reporting.
>  		 */
>  		if (evt->error_type =3D=3D MCE_ERROR_TYPE_UE) {
> +			if (evt->u.ue_error.ignore_event) {
> +				__this_cpu_dec(mce_ue_count);
> +				continue;
> +			}
> +
>  			if (evt->u.ue_error.physical_address_provided) {
>  				unsigned long pfn;
> =20
> @@ -301,6 +311,12 @@ static void machine_check_process_queued_event(struc=
t irq_work *work)
>  	while (__this_cpu_read(mce_queue_count) > 0) {
>  		index =3D __this_cpu_read(mce_queue_count) - 1;
>  		evt =3D this_cpu_ptr(&mce_event_queue[index]);
> +
> +		if (evt->error_type =3D=3D MCE_ERROR_TYPE_UE &&
> +		    evt->u.ue_error.ignore_event) {
> +			__this_cpu_dec(mce_queue_count);
> +			continue;
> +		}
>  		machine_check_print_event_info(evt, false, false);
>  		__this_cpu_dec(mce_queue_count);
>  	}
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_po=
wer.c
> index e74816f045f8..1dd87f6f5186 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -11,6 +11,7 @@
> =20
>  #include <linux/types.h>
>  #include <linux/ptrace.h>
> +#include <linux/extable.h>
>  #include <asm/mmu.h>
>  #include <asm/mce.h>
>  #include <asm/machdep.h>
> @@ -18,6 +19,7 @@
>  #include <asm/pte-walk.h>
>  #include <asm/sstep.h>
>  #include <asm/exception-64s.h>
> +#include <asm/extable.h>
> =20
>  /*
>   * Convert an address related to an mm to a physical address.
> @@ -559,9 +561,18 @@ static int mce_handle_derror(struct pt_regs *regs,
>  	return 0;
>  }
> =20
> -static long mce_handle_ue_error(struct pt_regs *regs)
> +static long mce_handle_ue_error(struct pt_regs *regs,
> +				struct mce_error_info *mce_err)
>  {
>  	long handled =3D 0;
> +	const struct exception_table_entry *entry;
> +
> +	entry =3D search_kernel_exception_table(regs->nip);
> +	if (entry) {
> +		mce_err->ignore_event =3D true;
> +		regs->nip =3D extable_fixup(entry);
> +		return 1;
> +	}
> =20
>  	/*
>  	 * On specific SCOM read via MMIO we may get a machine check
> @@ -594,7 +605,7 @@ static long mce_handle_error(struct pt_regs *regs,
>  				&phys_addr);
> =20
>  	if (!handled && mce_err.error_type =3D=3D MCE_ERROR_TYPE_UE)
> -		handled =3D mce_handle_ue_error(regs);
> +		handled =3D mce_handle_ue_error(regs, &mce_err);
> =20
>  	save_mce_event(regs, handled, &mce_err, regs->nip, addr, phys_addr);
> =20
> --=20
> 2.21.0
>=20
>=20
=
