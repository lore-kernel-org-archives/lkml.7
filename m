Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391C9C282DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19ABD20879
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfEVPIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729583AbfEVPIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:08:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ABBB2B00B;
        Wed, 22 May 2019 15:08:50 +0000 (UTC)
Date:   Wed, 22 May 2019 17:08:48 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (smsc47m1) fix outside array bounds warnings
Message-ID: <20190522170848.198ccea6@endymion>
In-Reply-To: <20190521044456.26431-1-yamada.masahiro@socionext.com>
References: <20190521044456.26431-1-yamada.masahiro@socionext.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Tue, 21 May 2019 13:44:56 +0900, Masahiro Yamada wrote:
> Kbuild test robot reports outside array bounds warnings:
> 
>   CC [M]  drivers/hwmon/smsc47m1.o
> drivers/hwmon/smsc47m1.c: In function 'fan_div_store':
> drivers/hwmon/smsc47m1.c:370:49: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>   tmp = 192 - (old_div * (192 - data->fan_preload[nr])
>                                 ~~~~~~~~~~~~~~~~~^~~~
> drivers/hwmon/smsc47m1.c:372:19: warning: array subscript [0, 2] is outside array bounds of 'u8[3]' {aka 'unsigned char[3]'} [-Warray-bounds]
>   data->fan_preload[nr] = clamp_val(tmp, 0, 191);
>   ~~~~~~~~~~~~~~~~~^~~~
> drivers/hwmon/smsc47m1.c:373:53: warning: array subscript [0, 2] is outside array bounds of 'const u8[3]' {aka 'const unsigned char[3]'} [-Warray-bounds]
>   smsc47m1_write_value(data, SMSC47M1_REG_FAN_PRELOAD[nr],
>                              ~~~~~~~~~~~~~~~~~~~~~~~~^~~~

These messages are pretty confusing. Subscript [0, 2] would refer to a
bi-dimensional array, while these are 1-dimension arrays. If [0, 2]
means something else, I still don't get it, because both indexes 0 and
2 are perfectly within bounds of a 3-element array. So what do these
messages mean exactly? Looks like a bogus checker to me.

> The index field in the SENSOR_DEVICE_ATTR_R* defines is 0, 1, or 2.
> However, the compiler never knows the fact that the default in the
> switch statement is unreachable.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/hwmon/smsc47m1.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
> index 5f92eab24c62..e00102e05666 100644
> --- a/drivers/hwmon/smsc47m1.c
> +++ b/drivers/hwmon/smsc47m1.c
> @@ -364,6 +364,10 @@ static ssize_t fan_div_store(struct device *dev,
>  		tmp |= data->fan_div[2] << 4;
>  		smsc47m1_write_value(data, SMSC47M2_REG_FANDIV3, tmp);
>  		break;
> +	default:
> +		WARN_ON(1);
> +		mutex_unlock(&data->update_lock);
> +		return -EINVAL;
>  	}

So basically the code is fine, the checker (which checker, BTW?)
incorrectly thinks it isn't, and you propose to add dead code to make
the checker happy?

I disagree with this approach. Ideally the checker must be improved to
understand that the code is correct. If that's not possible, we should
be allowed to annotate the code to skip that specific check on these
specific lines, because it has been inspected by a knowledgeable human
and confirmed to be correct.

And if that it still not "possible", then the least intrusive fix would
be to make one of the valid cases the default. But adding new code
which will never be executed, but must still be compiled and stored,
no, thank you. Another code checker could legitimately complain about
that actually.

IMHO if code checkers return false positives then they are not helping
us and should not be used in the first place.

-- 
Jean Delvare
SUSE L3 Support
