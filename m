Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC595C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED09218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 12:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dq5Q7N9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfCWMPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 08:15:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfCWMPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 08:15:45 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C48F41EC0982;
        Sat, 23 Mar 2019 13:15:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553343343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbTlQlq9ax0tFhHa1D8ky4Rnsvy7ZAQ3H63inArW7cE=;
        b=Dq5Q7N9Tvp0dayr26hzk3tLFeCB+kZ/BizaZr3//PMomMH/mOM9/BGNJtOZDeuvKqBPI/o
        sORSGy/GMaC092VaFBStFuaEnTIFvZnxn8UI3tAqy242VTvUuYsPFoV7BeJfHMkdDU3fSP
        XzI9hxH+J+mM452ukpr4zy3r1V7K+Dc=
Date:   Sat, 23 Mar 2019 13:15:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Message-ID: <20190323121546.GA17541@zn.tnic>
References: <20190228153558.127292-1-Yazen.Ghannam@amd.com>
 <20190228153558.127292-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190228153558.127292-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 03:36:10PM +0000, Ghannam, Yazen wrote:
> diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
> index de8dbb0b42b5..40e63cea2d81 100644
> --- a/drivers/edac/amd64_edac.h
> +++ b/drivers/edac/amd64_edac.h
> @@ -274,7 +274,11 @@
>  
>  #define UMC_SDP_INIT			BIT(31)
>  
> -#define NUM_UMCS			2
> +/*
> + * Number of Unified Memory Controllers
> + * Set during driver init based on family/model.
> + */
> +static u8 num_umcs;

Please don't do silly things like that:

In file included from drivers/edac/amd64_edac_inj.c:2:0:
drivers/edac/amd64_edac.h:279:11: warning: ‘num_umcs’ defined but not used [-Wunused-variable]
 static u8 num_umcs;
           ^~~~~~~~

I fixed it up now.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
