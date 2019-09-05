Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AC1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF48C2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfIENnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:43:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48991 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfIENnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:43:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F0B430603AD;
        Thu,  5 Sep 2019 13:43:10 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74F2A6017E;
        Thu,  5 Sep 2019 13:43:08 +0000 (UTC)
Date:   Thu, 5 Sep 2019 21:43:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] x86/boot: Add max_addr field in struct boot_params
Message-ID: <20190905134300.GB20805@MiWiFi-R3L-srv>
References: <20190830214707.1201-1-msys.mizuma@gmail.com>
 <20190830214707.1201-3-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830214707.1201-3-msys.mizuma@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Thu, 05 Sep 2019 13:43:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/19 at 05:47pm, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> Add max_addr field in struct boot_params. max_addr shows the
> maximum memory address to be reachable by memory hot-add.
> max_addr is set by parsing ACPI SRAT.
> 
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  Documentation/x86/zero-page.rst       | 4 ++++
>  arch/x86/include/uapi/asm/bootparam.h | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
> index f088f5881..cc3938d68 100644
> --- a/Documentation/x86/zero-page.rst
> +++ b/Documentation/x86/zero-page.rst
> @@ -19,6 +19,7 @@ Offset/Size	Proto	Name			Meaning
>  058/008		ALL	tboot_addr      	Physical address of tboot shared page
>  060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
>  						(struct ist_info)
> +078/010		ALL	max_addr		The possible maximum physical memory address [1]_
>  080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
>  090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
>  0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
> @@ -43,3 +44,6 @@ Offset/Size	Proto	Name			Meaning
>  						(array of struct e820_entry)
>  D00/1EC		ALL	eddbuf			EDD data (array of struct edd_info)
>  ===========	=====	=======================	=================================================
> +
> +.. [1] max_addr shows the maximum memory address to be reachable by memory
> +       hot-add. max_addr is set by parsing ACPI SRAT.
> diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
> index c895df548..6efad338b 100644
> --- a/arch/x86/include/uapi/asm/bootparam.h
> +++ b/arch/x86/include/uapi/asm/bootparam.h
> @@ -158,7 +158,7 @@ struct boot_params {
>  	__u64  tboot_addr;				/* 0x058 */
>  	struct ist_info ist_info;			/* 0x060 */
>  	__u64 acpi_rsdp_addr;				/* 0x070 */
> -	__u8  _pad3[8];					/* 0x078 */
> +	__u64 max_addr;					/* 0x078 */
>  	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
>  	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
>  	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
> -- 
> 2.18.1
> 
