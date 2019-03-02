Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBA7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD4F206B6
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCBVMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 16:12:54 -0500
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:60233 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbfCBVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 16:12:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DEF3B180A885C;
        Sat,  2 Mar 2019 21:12:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fowl57_18ce2ed23631e
X-Filterd-Recvd-Size: 1879
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 Mar 2019 21:12:50 +0000 (UTC)
Message-ID: <cb87945edeeda2529b75e2169ff6f723daa732b2.camel@perches.com>
Subject: Re: [PATCH] x86: uv: Fix potential NULL pointer dereference of
 kmalloc_node
From:   Joe Perches <joe@perches.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nicolai Stange <nstange@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Andrew Banman <abanman@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 02 Mar 2019 13:12:49 -0800
In-Reply-To: <20190302210905.13032-1-pakki001@umn.edu>
References: <20190302210905.13032-1-pakki001@umn.edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-03-02 at 15:09 -0600, Aditya Pakki wrote:
> kmalloc_node might fail to allocate memory for thp field. This fix
> attempts to avoid a potential NULL pointer dereference.

right

> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
[]
> @@ -2011,6 +2011,9 @@ static void make_per_cpu_thp(struct bau_control *smaster)
>  	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
>  
>  	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
> +	if (!smaster->thp)
> +		return;
> +
>  	memset(smaster->thp, 0, hpsz);

Could use kzalloc_node as well


