Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A2C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3DC20700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLPHiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:38:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:48282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfLPHiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:38:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 056F9B033;
        Mon, 16 Dec 2019 07:38:20 +0000 (UTC)
Subject: Re: [PATCH] xen/grant-table: remove unnecessary BUG_ON on
 gnttab_interface
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20191215201321.7439-1-pakki001@umn.edu>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <0b2714b7-36d4-f281-5287-d6889791098f@suse.com>
Date:   Mon, 16 Dec 2019 08:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191215201321.7439-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.19 21:13, Aditya Pakki wrote:
> grow_gnttab_list() checks for NULL on gnttab_interface immediately
> after gnttab_expand() check. The patch removes the redundant assertion
> and replaces the BUG_ON call with recovery code.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/xen/grant-table.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
> index 49b381e104ef..f59694c352be 100644
> --- a/drivers/xen/grant-table.c
> +++ b/drivers/xen/grant-table.c
> @@ -664,7 +664,6 @@ static int grow_gnttab_list(unsigned int more_frames)
>   	unsigned int nr_glist_frames, new_nr_glist_frames;
>   	unsigned int grefs_per_frame;
>   
> -	BUG_ON(gnttab_interface == NULL);
>   	grefs_per_frame = gnttab_interface->grefs_per_grant_frame;
>   
>   	new_nr_grant_frames = nr_grant_frames + more_frames;
> @@ -1388,7 +1387,9 @@ static int gnttab_expand(unsigned int req_entries)
>   	int rc;
>   	unsigned int cur, extra;
>   
> -	BUG_ON(gnttab_interface == NULL);
> +	if (!gnttab_interface)
> +		return -EINVAL;
> +
>   	cur = nr_grant_frames;
>   	extra = ((req_entries + gnttab_interface->grefs_per_grant_frame - 1) /
>   		 gnttab_interface->grefs_per_grant_frame);
> @@ -1423,7 +1424,9 @@ int gnttab_init(void)
>   	/* Determine the maximum number of frames required for the
>   	 * grant reference free list on the current hypervisor.
>   	 */
> -	BUG_ON(gnttab_interface == NULL);
> +	if (!gnttab_interface)
> +		return -EINVAL;
> +

I'd just remove the BUG_ON().

gnttab_request_version() called some lines up always sets
gnttab_interface.

The BUG_ON() in nr_status_frames() can be removed, too. It is either
called by v2 specific functions (for those to be reached
gnttab_interface must be set) or by gnttab_init() (reasoning see
above).


Juergen
