Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA6C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B0216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 12:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392526AbfHBM0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 08:26:53 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57911 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388599AbfHBM0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 08:26:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 460RHF4fMDz9sBF;
        Fri,  2 Aug 2019 22:26:49 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] pseries/hotplug-memory.c: Replace nested ifs by switch-case
In-Reply-To: <20190801225251.17864-1-leonardo@linux.ibm.com>
References: <20190801225251.17864-1-leonardo@linux.ibm.com>
Date:   Fri, 02 Aug 2019 22:26:48 +1000
Message-ID: <87sgqjkb1z.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Bras <leonardo@linux.ibm.com> writes:
> I noticed these nested ifs can be easily replaced by switch-cases,
> which can improve readability.
>
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  .../platforms/pseries/hotplug-memory.c        | 26 +++++++++++++------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Thanks, this looks sensible.

Please use "powerpc/" as the prefix on your patches, eg. in this case:

"powerpc/pseries/hotplug-memory.c: Replace nested ifs by switch-case"

I'll fix it up this time when I apply.

cheers

> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index 46d0d35b9ca4..8e700390f3d6 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -880,34 +880,44 @@ int dlpar_memory(struct pseries_hp_errorlog *hp_elog)
>  
>  	switch (hp_elog->action) {
>  	case PSERIES_HP_ELOG_ACTION_ADD:
> -		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
> +		switch (hp_elog->id_type) {
> +		case PSERIES_HP_ELOG_ID_DRC_COUNT:
>  			count = hp_elog->_drc_u.drc_count;
>  			rc = dlpar_memory_add_by_count(count);
> -		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
> +			break;
> +		case PSERIES_HP_ELOG_ID_DRC_INDEX:
>  			drc_index = hp_elog->_drc_u.drc_index;
>  			rc = dlpar_memory_add_by_index(drc_index);
> -		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
> +			break;
> +		case PSERIES_HP_ELOG_ID_DRC_IC:
>  			count = hp_elog->_drc_u.ic.count;
>  			drc_index = hp_elog->_drc_u.ic.index;
>  			rc = dlpar_memory_add_by_ic(count, drc_index);
> -		} else {
> +			break;
> +		default:
>  			rc = -EINVAL;
> +			break;
>  		}
>  
>  		break;
>  	case PSERIES_HP_ELOG_ACTION_REMOVE:
> -		if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_COUNT) {
> +		switch (hp_elog->id_type) {
> +		case PSERIES_HP_ELOG_ID_DRC_COUNT:
>  			count = hp_elog->_drc_u.drc_count;
>  			rc = dlpar_memory_remove_by_count(count);
> -		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_INDEX) {
> +			break;
> +		case PSERIES_HP_ELOG_ID_DRC_INDEX:
>  			drc_index = hp_elog->_drc_u.drc_index;
>  			rc = dlpar_memory_remove_by_index(drc_index);
> -		} else if (hp_elog->id_type == PSERIES_HP_ELOG_ID_DRC_IC) {
> +			break;
> +		case PSERIES_HP_ELOG_ID_DRC_IC:
>  			count = hp_elog->_drc_u.ic.count;
>  			drc_index = hp_elog->_drc_u.ic.index;
>  			rc = dlpar_memory_remove_by_ic(count, drc_index);
> -		} else {
> +			break;
> +		default:
>  			rc = -EINVAL;
> +			break;
>  		}
>  
>  		break;
> -- 
> 2.20.1
