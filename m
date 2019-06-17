Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C2C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3982E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfFQJgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:36:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfFQJgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:36:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96A65AF30;
        Mon, 17 Jun 2019 09:36:14 +0000 (UTC)
Subject: Re: [RFC PATCH 11/16] xen/grant-table: make grant-table xenhost aware
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-12-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <71d3131a-cd14-6bf6-391a-6e4b0533fb23@suse.com>
Date:   Mon, 17 Jun 2019 11:36:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-12-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Largely mechanical changes: the exported grant table symbols now take
> xenhost_t * as a parameter. Also, move the grant table global state
> inside xenhost_t.
> 
> If there's more than one xenhost, then initialize both.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   arch/x86/xen/grant-table.c |  71 +++--
>   drivers/xen/grant-table.c  | 611 +++++++++++++++++++++----------------
>   include/xen/grant_table.h  |  72 ++---
>   include/xen/xenhost.h      |  11 +
>   4 files changed, 443 insertions(+), 322 deletions(-)
> 
> diff --git a/include/xen/xenhost.h b/include/xen/xenhost.h
> index 9e08627a9e3e..acee0c7872b6 100644
> --- a/include/xen/xenhost.h
> +++ b/include/xen/xenhost.h
> @@ -129,6 +129,17 @@ typedef struct {
>   		const struct evtchn_ops *evtchn_ops;
>   		int **evtchn_to_irq;
>   	};
> +
> +	/* grant table private state */
> +	struct {
> +		/* private to drivers/xen/grant-table.c */
> +		void *gnttab_private;
> +
> +		/* x86/xen/grant-table.c */
> +		void *gnttab_shared_vm_area;
> +		void *gnttab_status_vm_area;
> +		void *auto_xlat_grant_frames;

Please use proper types here instead of void *. This avoids lots of
casts. It is okay to just add anonymous struct definitions and keep the
real struct layout local to grant table code.


Juergen
