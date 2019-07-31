Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D362C32754
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE07C208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564582628;
	bh=8jdEF0UH5jaMsV1Zdp3Wv7KaJzAst2tDDCuDRenrLro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=obpCIilvREJXqhbaqHKIa3PzIhTVyxWTNtAF2LjMR4qYgIgfLpCNXrtRjq52tP4qO
	 /Cl1zXPchw9x9JWdEMFdHuz+bzGT37MvvuGP/98fkRRctkeWeR6a2PS4x3MYh0iLmI
	 P3jKD/6uLEDUAQAXRazE1L1lDiWtZp9fyoc2qetY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGaORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:17:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbfGaORG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:17:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23B6BAE5C;
        Wed, 31 Jul 2019 14:17:05 +0000 (UTC)
Date:   Wed, 31 Jul 2019 16:17:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] drivers/acpi/scan.c: Document why we don't need the
 device_hotplug_lock
Message-ID: <20190731141704.GW9330@dhcp22.suse.cz>
References: <20190731135306.31524-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731135306.31524-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 31-07-19 15:53:06, David Hildenbrand wrote:
> Let's document why the lock is not needed in acpi_scan_init(), right now
> this is not really obvious.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> @Andrew, can you drop "drivers/acpi/scan.c: acquire device_hotplug_lock in
> acpi_scan_init()" and add this patch instead? Thanks
> 
> ---
>  drivers/acpi/scan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 0e28270b0fd8..8444af6cd514 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2204,6 +2204,12 @@ int __init acpi_scan_init(void)
>  	acpi_gpe_apply_masked_gpes();
>  	acpi_update_all_gpes();
>  
> +	/*
> +	 * Although we call__add_memory() that is documented to require the
> +	 * device_hotplug_lock, it is not necessary here because this is an
> +	 * early code when userspace or any other code path cannot trigger
> +	 * hotplug/hotunplug operations.
> +	 */
>  	mutex_lock(&acpi_scan_lock);
>  	/*
>  	 * Enumerate devices in the ACPI namespace.
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
