Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B607FC74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E192086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562788302;
	bh=fRsmbqXRmmOj7ihKouMiZXZPTpW8rs55jarqdwOer9k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=gGyWHPaBEUNlAUBEE8OYNKXH5M56fl1hlk8Wj1hUyPgX32aEaJtY4KadZuXGjIFNN
	 9KhMw3nIJIwZqGQ1X3j/BI85+PM/itNPQN2Wmo1oWX5RN6OL+Ekv0LKgFDzk9uU+ob
	 fPEamSH2UuerEX9IR/plV0kOcn9nXCQaGIqFQczk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfGJTvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 15:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfGJTvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 15:51:40 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C531520645;
        Wed, 10 Jul 2019 19:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562788299;
        bh=fRsmbqXRmmOj7ihKouMiZXZPTpW8rs55jarqdwOer9k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OTCb6Rit4Lwn2mupiNYu/a7imwmAEDlOOPpAap1V892bVESqhY306mHggilDUuu/t
         +7ZK1YEqC0SIEDaG1jcmU9+wancaYFicMFDL3s0HpN+eZmyoDzf/CMmkIzBnRSg0ZJ
         8V0L85YnI0zOSaE8+DAmkHBAebv0tBOIksDDj8zU=
Message-ID: <1562788297.6330.7.camel@kernel.org>
Subject: Re: [PATCH] trace:add "gfp_t" support in synthetic_events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Zhengjun Xing <zhengjun.xing@linux.intel.com>, rostedt@goodmis.org,
        mingo@redhat.com, tom.zanussi@linux.intel.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 10 Jul 2019 14:51:37 -0500
In-Reply-To: <20190704025506.30199-1-zhengjun.xing@linux.intel.com>
References: <20190704025506.30199-1-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengjun,

On Thu, 2019-07-04 at 10:55 +0800, Zhengjun Xing wrote:
> Add "gfp_t" support in synthetic_events, then the "gfp_t" type
> parameter in some functions can be traced.
> 
> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index ca6b0dff60c5..0d3ab01b7cb5 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -752,6 +752,8 @@ static int synth_field_size(char *type)
>  		size = sizeof(unsigned long);
>  	else if (strcmp(type, "pid_t") == 0)
>  		size = sizeof(pid_t);
> +	else if (strcmp(type, "gfp_t") == 0)
> +		size = sizeof(gfp_t);
>  	else if (synth_field_is_string(type))
>  		size = synth_field_string_size(type);
>  
> @@ -792,6 +794,8 @@ static const char *synth_field_fmt(char *type)
>  		fmt = "%lu";
>  	else if (strcmp(type, "pid_t") == 0)
>  		fmt = "%d";
> +	else if (strcmp(type, "gfp_t") == 0)
> +		fmt = "%u";
>  	else if (synth_field_is_string(type))
>  		fmt = "%s";
>  

This will work, but I think it would be better to display as hex, and
also show the flags in human-readable form.

How about adding something like this on top of your patch?:


[PATCH] tracing: Add verbose gfp_flag printing to synthetic events

Add on top of 'trace:add "gfp_t" support in synthetic_events'.

Prints the gfp flags as hex in addition to the human-readable flag
string.  Example output:

  whoopsie-630 [000] ...1 78.969452: testevent: bar=b20 (GFP_ATOMIC|__GFP_ZERO)
    rcuc/0-11  [000] ...1 81.097555: testevent: bar=a20 (GFP_ATOMIC)
    rcuc/0-11  [000] ...1 81.583123: testevent: bar=a20 (GFP_ATOMIC)

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_hist.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0d3ab01..aeb4449 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -13,6 +13,10 @@
 #include <linux/rculist.h>
 #include <linux/tracefs.h>
 
+/* for gfp flag names */
+#include <linux/trace_events.h>
+#include <trace/events/mmflags.h>
+
 #include "tracing_map.h"
 #include "trace.h"
 #include "trace_dynevent.h"
@@ -795,7 +799,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
 	else if (strcmp(type, "gfp_t") == 0)
-		fmt = "%u";
+		fmt = "%x";
 	else if (synth_field_is_string(type))
 		fmt = "%s";
 
@@ -838,9 +842,20 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 					 i == se->n_fields - 1 ? "" : " ");
 			n_u64 += STR_VAR_LEN_MAX / sizeof(u64);
 		} else {
+			struct trace_print_flags __flags[] =
+				{ __def_gfpflag_names, { -1, NULL }};
+
 			trace_seq_printf(s, print_fmt, se->fields[i]->name,
 					 entry->fields[n_u64],
 					 i == se->n_fields - 1 ? "" : " ");
+
+			if (strcmp(se->fields[i]->type, "gfp_t") == 0) {
+				trace_seq_puts(s, " (");
+				trace_print_flags_seq(s, "|",
+						      entry->fields[n_u64],
+						      __flags);
+				trace_seq_putc(s, ')');
+			}
 			n_u64++;
 		}
 	}
-- 
2.7.4

