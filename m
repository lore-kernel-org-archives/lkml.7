Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37CBC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79718218A4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562304643;
	bh=ZXJGmtTtDCu80dq8Kr3bcpm8nifiAu8++BtQM5F+1TA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OR6IRhyAQxsZL4lBZvpENV64G4CDmvJku45xY3TAF8Sxso6OIkfOUBwKgv3cBGdK3
	 3NnIf7d1QTh9cPP0mebigF0DOB+gple1q9y5luVjzd3RXRrsvuCtJ/kWY7FP4SEV74
	 8ZFt3gTITUi9Y7p4RHNJgDOS/phb6FSuTH0ltOHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfGEFam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:30:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbfGEFam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:30:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772F621850;
        Fri,  5 Jul 2019 05:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562304641;
        bh=ZXJGmtTtDCu80dq8Kr3bcpm8nifiAu8++BtQM5F+1TA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNoPX7tEHWq8ZJ1jqSHPWaWgCjZpSL4p/wMZ2SNNsjkBsFu+x/SAnE8nPrlqhT1Bf
         qqML5npx752bSGT7jE/1QEwiZVpD7jHVrHax6ZHPL0D3CL1YfrfwjyDdiRYm61MiCH
         EQxtwhyCWbchz0rpjnEjrek5Mbs28vP1LSbpsGyc=
Date:   Fri, 5 Jul 2019 07:30:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
Cc:     mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [Linux-kernel-mentee, PATCH] media:
 dvb_frontend.h: Fix shifting signed 32-bit value problem
Message-ID: <20190705053037.GC8621@kroah.com>
References: <20190704170422.GA25633@luke-XPS-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704170422.GA25633@luke-XPS-13>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 10:04:22AM -0700, Luke Nowakowski-Krijger wrote:
> Fix DVBFE_ALGO_RECOVERY and DVBFE_ALGO_SEARCH_ERROR to use U cast which
> fixes undefined behavior error by certain compilers. 
> 
> Signed-off-by: Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>
> ---
>  include/media/dvb_frontend.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/media/dvb_frontend.h b/include/media/dvb_frontend.h
> index f05cd7b94a2c..472fe5871d94 100644
> --- a/include/media/dvb_frontend.h
> +++ b/include/media/dvb_frontend.h
> @@ -144,7 +144,7 @@ enum dvbfe_algo {
>  	DVBFE_ALGO_HW			= (1 <<  0),
>  	DVBFE_ALGO_SW			= (1 <<  1),
>  	DVBFE_ALGO_CUSTOM		= (1 <<  2),
> -	DVBFE_ALGO_RECOVERY		= (1 << 31)
> +	DVBFE_ALGO_RECOVERY		= (1U << 31)

BIT() is better for stuff like this.

thanks,

greg k-h
