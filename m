Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ADC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D161420823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551725823;
	bh=zBjw0IZkX72iUBmWRMc6YaCPGiD4Ye/EfblO8B5j+3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zowb6OeBcRex6V5Kn50s/zfYELpKkYumWrOEq0WG+V1PO08O/C6pmiHCqL7nG2D4D
	 ru/rehBsnL02fqrnuqRLX0+C8YAHM2LwXAWCdZ34TC3NQIidiuvK3DRpYy5mLJ+gdX
	 2IHhZg7TgoeGrCEk83L5OZn+aU1v6JEi8l1GSz9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCDS5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:57:02 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36202 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfCDS5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:57:02 -0500
Received: by mail-yw1-f67.google.com with SMTP id 189so4913038ywi.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 10:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G5rTsdLogr4Pn426CZ4doead2CWwStaw19gK8aVjylU=;
        b=fR0GtZF2HCBpwLCUQ5ziH441FbLKEBcsPs5/psGStH68FIEimmzfi4IAIgOH78Arsp
         OCGDyiw2HhnVJNdY2j8zSIrQi8FaO+o4o8dCijQmDDWQqV2I3StLWuFx0jmvgEy0TMqx
         axiFRmaycuUvjGQZKiuGh4Abz7cgH6t/HgDX8iDUPSyBREWu12Dvg5alw6yU8ZXircLF
         VnL9IbYd+tv3oRLtSRFC4WnOQOC56brOjcny7EPgMW+XuO4skO/YVdntgZ6GLhv3ui1h
         p7+YRQvoPpLVV+GnSvw4t9CZwcb0kVXPw9tJv5/uzdd7/5+7N8JHRZ2coZKNi9KDmQNV
         QSyA==
X-Gm-Message-State: APjAAAVRRh5Z8JiAzhNWStC+mDWAxO4ZT3Hv4RY9w9eFIvoAt1C4p587
        2rYL+K6grpJu92TAfLowMgE=
X-Google-Smtp-Source: APXvYqztRwnWv3pEawsYV9qGAllROIkrxq4e/0Xg9sZbcOXkL9oitOsG1/kCKgLP8oeAMJulyQT5bg==
X-Received: by 2002:a25:949:: with SMTP id u9mr15934919ybm.98.1551725821353;
        Mon, 04 Mar 2019 10:57:01 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::1:8d76])
        by smtp.gmail.com with ESMTPSA id d85sm3189818ywd.96.2019.03.04.10.56.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:57:00 -0800 (PST)
Date:   Mon, 4 Mar 2019 13:56:57 -0500
From:   "dennis@kernel.org" <dennis@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: Re: [PATCH 2/2] percpu: pcpu_next_md_free_region: inclusive check
 for PCPU_BITMAP_BLOCK_BITS
Message-ID: <20190304185657.GA17970@dennisz-mbp.dhcp.thefacebook.com>
References: <20190304104541.25745-1-peng.fan@nxp.com>
 <20190304104541.25745-2-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304104541.25745-2-peng.fan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Mon, Mar 04, 2019 at 10:33:55AM +0000, Peng Fan wrote:
> If the block [contig_hint_start, contig_hint_start + contig_hint)
> matches block->right_free area, need use "<=", not "<".
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>   Based on https://patchwork.kernel.org/cover/10832459/ applied linux-next
>   boot test on qemu aarch64
> 
>  mm/percpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 5ee90fc34ea3..0f91f1d883c6 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -390,7 +390,8 @@ static void pcpu_next_md_free_region(struct pcpu_chunk *chunk, int *bit_off,
>  		 */
>  		*bits = block->contig_hint;
>  		if (*bits && block->contig_hint_start >= block_off &&
> -		    *bits + block->contig_hint_start < PCPU_BITMAP_BLOCK_BITS) {
> +		    *bits + block->contig_hint_start <=
> +		    PCPU_BITMAP_BLOCK_BITS) {
>  			*bit_off = pcpu_block_off_to_off(i,
>  					block->contig_hint_start);
>  			return;
> -- 
> 2.16.4
> 

This is wrong. This iterator is for updating contig hints and not for
finding fit.

Have you tried reproducing and proving the issue you are seeing? In
general, making changes to percpu carries a lot of risk. I really only
want to be taking code that is provably solving a problem and not
supported by just code inspection. Boot testing for a change like this
is really not enough as we need to be sure changes like these are
correct.

Thanks,
Dennis
