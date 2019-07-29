Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8747FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65071206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 12:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfG2MwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:52:05 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfG2MwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 08:52:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A553028A593
Subject: Re: [PATCH v2] platform/chrome: cros_ec_trace: update generating
 script
To:     Tzung-Bi Shih <tzungbi@google.com>, bleung@chromium.org,
        groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org, cychiang@google.com,
        dgreid@google.com
References: <20190723133322.243286-1-tzungbi@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bacac922-a15d-77c4-e549-cbf41100e4ef@collabora.com>
Date:   Mon, 29 Jul 2019 14:51:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723133322.243286-1-tzungbi@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tzung-Bi

On 23/7/19 15:33, Tzung-Bi Shih wrote:
> To remove ", \" from the last line.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
> ---
> Changes from v1:
> - simpler awk code
> 
>  drivers/platform/chrome/cros_ec_trace.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_trace.c b/drivers/platform/chrome/cros_ec_trace.c
> index 0a76412095a9..667460952dad 100644
> --- a/drivers/platform/chrome/cros_ec_trace.c
> +++ b/drivers/platform/chrome/cros_ec_trace.c
> @@ -6,7 +6,18 @@
>  #define TRACE_SYMBOL(a) {a, #a}
>  
>  // Generate the list using the following script:
> -// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' include/linux/mfd/cros_ec_commands.h
> +// sed -n 's/^#define \(EC_CMD_[[:alnum:]_]*\)\s.*/\tTRACE_SYMBOL(\1), \\/p' \

For some reason I accepted the patch using c++ style comments but I shouldn't,
while we are here could you update the patch and use c style comments instead,
thanks.

~ Enric

> +// include/linux/mfd/cros_ec_commands.h | awk '
> +// {
> +//   if (NR != 1)
> +//     print buf;
> +//   buf = $0;
> +// }
> +// END {
> +//   gsub(/, \\/, "", buf);
> +//   print buf;
> +// }
> +// '
>  #define EC_CMDS \
>  	TRACE_SYMBOL(EC_CMD_PROTO_VERSION), \
>  	TRACE_SYMBOL(EC_CMD_HELLO), \
> 
