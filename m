Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC1FC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8055F206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574079034;
	bh=ZyBDjFJ1ZiTLeQtvbqTVQDtIJNSyUKztg+ZXVh1EImw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A2PB1IsHxkaiB/kkTXSvHcOih2k738NqnWbFqUTISoe2OgnEwTU5W1RT7pO5E1Pld
	 iyl4isfhR6EgxnKgFg3yagyLEDl56xUnpe+Q1MN9VvvRhTwKnuK0LrSC6IQS2Y5iwd
	 MuNhy7j8MTIg582ioU4m7Wt63nYVuTeLOBtDt180=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfKRMKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:10:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40226 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfKRMKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:10:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so6368706wrw.7;
        Mon, 18 Nov 2019 04:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k6yV9Z8ApwY7EdsU9fwBTpDDY0oQNflKnyzJAyKrN9A=;
        b=XaULrSNBJxRDurJ2O9ji9cnAlbSQB6cMNkdn6z7AxTRV7SR5JdGgKHP3BDbDMLjl00
         SgPgYPo13Y5AtZE7R7cAK7WyRCKrXhSSZUS1EggXxWVKa2JH5taJxBWpvQaol2+keHH1
         gBT2gmSVSllbCM1n59ck3CQ3Y4eIFRNJG2gex/5C7OKX5LfOurcglwfUzyRaoExc6Zka
         g5QBeC3RqAdoKjx4ae0GKES+6a0IhO+kJgeXmQTbn/XEnXBk7L6STZwWo0i2RloMeQLo
         4/yb+w25QTBcViyIYLpD0CNnIIhGiILeI/N0piDUV4gSrAeDBuT9zV/sUFRkmplKAbb2
         ITAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=k6yV9Z8ApwY7EdsU9fwBTpDDY0oQNflKnyzJAyKrN9A=;
        b=aoIFeSSmCPHw/40LQt2Lw+HTmgTOlClH3Ps5e0dfzP53RE3akZAMjxLOyn/y6hByod
         D7M9QwdUB5/2r4b/bzFqSYNTINITcPECKysdMLu1jJOcKmBBSjnC6F8EVFRc4aGsr05a
         D9yeC4VAdjtmDakZbibsvGspjVszovRR575xRKGW5cLJJy4aJYpEX5UTH1tCzDLiRQZ7
         ekm7ZqREuXB6QOH78D9DmxSMduyZoNPt8MsFDXOs8PsnXXPkfLTomPDEFQNsb9D6DnF1
         TBHS6ITxhxk0KiZ+XurV58P0r+SA3jPqDYL8QJy2AcVrASabsebC8yp10prrjQUpLoJp
         YMpg==
X-Gm-Message-State: APjAAAXaf/5X/mSfNT2zsWP1tDAu80Jr3u9WTqDNYOuMNbWs+2y2zbig
        cP8YqbEQhuMyg+mZyGmveuvD+dzK
X-Google-Smtp-Source: APXvYqzBkW64CN2Vhg2q+4mLjGtfV06t9zPZmiRaIQhhO+G6RgqCAD9zfZaXFIGXvX8YVZl/bc/Dpg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr28768586wrr.88.1574079030657;
        Mon, 18 Nov 2019 04:10:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 17sm19136604wmg.19.2019.11.18.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 04:10:29 -0800 (PST)
Date:   Mon, 18 Nov 2019 13:10:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        x86-ml <x86@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [tip: x86/cleanups] x86: Fix typos in comments
Message-ID: <20191118121027.GA74767@gmail.com>
References: <20191118070012.27850-1-caoj.fnst@cn.fujitsu.com>
 <157406828172.12247.4218858363680758865.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157406828172.12247.4218858363680758865.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot2 for Cao jin <tip-bot2@linutronix.de> wrote:

> The following commit has been merged into the x86/cleanups branch of tip:
> 
> Commit-ID:     11a98f37a5c11fd3cec9c7a566dfa902bceb5bde
> Gitweb:        https://git.kernel.org/tip/11a98f37a5c11fd3cec9c7a566dfa902bceb5bde
> Author:        Cao jin <caoj.fnst@cn.fujitsu.com>
> AuthorDate:    Mon, 18 Nov 2019 15:00:12 +08:00
> Committer:     Borislav Petkov <bp@suse.de>
> CommitterDate: Mon, 18 Nov 2019 10:03:26 +01:00
> 
> x86: Fix typos in comments
> 
> BIOSen -> BIOSes; paing -> paging. Append to 640 its proper unit "Kb".
> encomapssing -> encompassing.
> 
>  [ bp: Merge into a single patch, fix one more typo, massage. ]
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Robert Richter <rrichter@marvell.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: x86-ml <x86@kernel.org>
> Link: https://lkml.kernel.org/r/20191118070012.27850-1-caoj.fnst@cn.fujitsu.com
> ---
>  arch/x86/kernel/setup.c | 6 +++---
>  arch/x86/mm/numa.c      | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 77ea96b..35b3f3a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -459,7 +459,7 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>   * due to mapping restrictions.
>   *
>   * On 64bit, kdump kernel need be restricted to be under 64TB, which is
> - * the upper limit of system RAM in 4-level paing mode. Since the kdump
> + * the upper limit of system RAM in 4-level paging mode. Since the kdump
>   * jumping could be from 5-level to 4-level, the jumping will fail if
>   * kernel is put above 64TB, and there's no way to detect the paging mode
>   * of the kernel which will be loaded for dumping during the 1st kernel

Beyond the typo, this whole paragraph is hard to read and inconsistent 
throughout.

How about something like this, on top? [ Feel free to backmerge, but can 
do a separate commit too - in which case I'll probably read the rest of 
the file too ;-) ]

Thanks,

	Ingo

 arch/x86/kernel/setup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d398afd206b8..e9fa944d4ed8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -468,15 +468,15 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 /*
  * Keep the crash kernel below this limit.
  *
- * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
  * due to mapping restrictions.
  *
- * On 64bit, kdump kernel need be restricted to be under 64TB, which is
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
  * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jumping could be from 5-level to 4-level, the jumping will fail if
- * kernel is put above 64TB, and there's no way to detect the paging mode
- * of the kernel which will be loaded for dumping during the 1st kernel
- * bootup.
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M

