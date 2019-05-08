Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DC6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CC821530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 23:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pC9WFVDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfEHXGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 19:06:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53454 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfEHXGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 19:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hQZD7KxlOTP7+vnGKWKCqYXK/isFooIL1sZyygnqlN4=; b=pC9WFVDVjyzdcNOFj4cM2zFYfi
        os5FltodzYudEuL3rWkXDUKvUf33y78xa7aN9QMjFdkn8wZ14k2IAf0R8IPsgK0X2ooKkDqqa84Ol
        bulKSOl+D7cQGbROt6FP3/sSxtYGEx4bW88+i5x1ySD1u6/ho2jUdPW6Lq+XVJ8IR+VW9376H2NfI
        15bmEM6Otyj19lEjTv05+g4iyy0vu/jmIfXD2R99Is269iinVdXRVRL25mvjOv1sQUzHicnhJd0lq
        sDKQPBm3D/THEkZtakMx3I8CiXeTRqk88dUJVzoqi1+bAhFYSd1kz9RkhXEW4wX9nRkjh3LyH3jfR
        nMDr5hKA==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOVeB-0001jR-8m; Wed, 08 May 2019 23:06:47 +0000
Date:   Wed, 8 May 2019 16:06:46 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] platform/x86: acer-wmi: Mark expected switch
 fall-throughs
Message-ID: <20190508230645.GB32286@wrath>
References: <20190508164934.GA20064@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508164934.GA20064@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 11:49:34AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/platform/x86/acer-wmi.c: In function ‘set_u32’:
> drivers/platform/x86/acer-wmi.c:1378:33: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (cap == ACER_CAP_WIRELESS ||
>                                  ^
> drivers/platform/x86/acer-wmi.c:1386:3: note: here
>    case ACER_WMID:
>    ^~~~
> drivers/platform/x86/acer-wmi.c:1393:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     else if (wmi_has_guid(WMID_GUID2))
>             ^
> drivers/platform/x86/acer-wmi.c:1395:3: note: here
>    default:
>    ^~~~~~~
> drivers/platform/x86/acer-wmi.c: In function ‘get_u32’:
> drivers/platform/x86/acer-wmi.c:1340:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (cap == ACER_CAP_MAILLED) {
>       ^
> drivers/platform/x86/acer-wmi.c:1344:2: note: here
>   case ACER_WMID:
>   ^~~~
> drivers/platform/x86/acer-wmi.c: In function ‘WMID_get_u32’:
> drivers/platform/x86/acer-wmi.c:1013:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (quirks->mailled == 1) {
>       ^
> drivers/platform/x86/acer-wmi.c:1018:2: note: here
>   default:
>   ^~~~~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index fcfeadd1301f..bd87f9037f95 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1015,6 +1015,7 @@ static acpi_status WMID_get_u32(u32 *value, u32 cap)
>  			*value = tmp & 0x1;
>  			return 0;
>  		}
> +		/* fall through */
>  	default:
>  		return AE_ERROR;
>  	}
> @@ -1341,6 +1342,7 @@ static acpi_status get_u32(u32 *value, u32 cap)
>  			status = AMW0_get_u32(value, cap);
>  			break;
>  		}
> +		/* fall through */

This doesn't strike me as obviously the right thing to do here. If the interface
type is AMW0_V2, why is it the right thing to do to use WMID_get_u32 if the cap
isn't ACER_CAP_MAILLED?

>  	case ACER_WMID:
>  		status = WMID_get_u32(value, cap);
>  		break;
> @@ -1383,6 +1385,7 @@ static acpi_status set_u32(u32 value, u32 cap)
>  
>  				return AMW0_set_u32(value, cap);
>  			}
> +			/* fall through */

Similarly here.

Are we documenting intended behavior, or covering up a bug.

>  		case ACER_WMID:
>  			return WMID_set_u32(value, cap);

-- 
Darren Hart
VMware Open Source Technology Center
