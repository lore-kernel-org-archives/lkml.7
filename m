Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0BCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58AAA214B2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="lSOCFHyV";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="blcGG18h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfKDRDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:03:08 -0500
Received: from smtp118.ord1d.emailsrvr.com ([184.106.54.118]:36596 "EHLO
        smtp118.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbfKDRDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1572886986;
        bh=SJS/ittzgAH8BlGqcQ8TbkYpepfiiLoeVfFqeIS8430=;
        h=Subject:To:From:Date:From;
        b=lSOCFHyVtAeGxGgsfdwN3OXRioUUfK9ced6m1o9WRgKUOJhHYTTDo0w4ZKOjxfbtd
         NrovYV19+Y/qcbWh1Hije4nU3yMY8ZJp4aqdXUyU0q1WyZ4syNsAk6zCQPp1dV0uWv
         rS9vbqEROMFLMag9wJPmxIMI1BBHhPUcbUXu84bo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1572886986;
        bh=SJS/ittzgAH8BlGqcQ8TbkYpepfiiLoeVfFqeIS8430=;
        h=Subject:To:From:Date:From;
        b=blcGG18hc9sNzm6nF7m1Q5GAVQwpvZ8AWKKBn3b8Zjwg+xhK8t5HB4ENZtqI1xhi7
         E/MIKF7dE9Up0f6KO4aqeiVhuQKF9wUAD1oylcBCwLH2HtECNMu0LxLEDjuxrFP+8L
         2jAEN9PfXpt02C3WcyFcCkvbSHt/sGdQ3Jgb/lKE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 985A320362;
        Mon,  4 Nov 2019 12:03:05 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 04 Nov 2019 12:03:06 -0500
Subject: Re: [PATCH v2] staging: comedi: rewrite macro function with GNU
 extension typeof
To:     Jules Irenge <jbi.octave@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hsweeten@visionengravers.com
References: <20191104163331.68173-1-jbi.octave@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <84a2d50f-a1ac-bdc5-989c-b0294e9dea22@mev.co.uk>
Date:   Mon, 4 Nov 2019 17:03:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104163331.68173-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/2019 16:33, Jules Irenge wrote:
> Rewrite macro function with the GNU extension typeof
> to remove a possible side-effects of MACRO argument reuse "x".
>   - Problem could rise if arguments have different types
> and different use though.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
> v1 - had no full commit log message, with changes not intended to be in the patch
> v2 - remove some changes not intended to be in this driver
>       include note of a potential problem
>   drivers/staging/comedi/comedi.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> index 09a940066c0e..a57691a2e8d8 100644
> --- a/drivers/staging/comedi/comedi.h
> +++ b/drivers/staging/comedi/comedi.h
> @@ -1103,8 +1103,10 @@ enum ni_common_signal_names {
>   
>   /* *** END GLOBALLY-NAMED NI TERMINALS/SIGNALS *** */
>   
> -#define NI_USUAL_PFI_SELECT(x)	(((x) < 10) ? (0x1 + (x)) : (0xb + (x)))
> -#define NI_USUAL_RTSI_SELECT(x)	(((x) < 7) ? (0xb + (x)) : 0x1b)
> +#define NI_USUAL_PFI_SELECT(x)\
> +	({typeof(x) x_ = (x); (x_ < 10) ? (0x1 + x_) : (0xb + x_); })
> +#define NI_USUAL_RTSI_SELECT(x)\
> +	({typeof(x) x_ = (x); (x_ < 7) ? (0xb + x_) : 0x1b; })
>   
>   /*
>    * mode bits for NI general-purpose counters, set with
> 

I wasn't sure about this the first time around due to the use of GNU 
extensions in uapi header files, but I see there are a few, rare 
instances of this GNU extension elsewhere in other uapi headers (mainly 
in netfilter stuff), so I guess it's OK.  However, it  does mean that 
user code that uses these macros will no longer compile unless GNU 
extensions are enabled.

Does anyone know any "best practices" regarding use of GNU extensions in 
user header files under Linux?

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
