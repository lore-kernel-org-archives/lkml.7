Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C73C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D51B2147A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561700387;
	bh=6aZeyquE37yylW+f6DBNbaMYSjXvL7vQzuyLohuFmT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=EeqRXuGwAJjXvMuMIfW3OmOOUjmlt/sz6imUXYF6g5Ztqcsiu5mPy71ekpkYYbZH/
	 nR4BY/ihum+G+Da+dzWYp6sML32z3o/aCejPoGBgyWh7DtHx1g/d5LMzmcy7bsvj1m
	 LFLnrj01Vl7r/AEDKtXg5Zdp0UDGt1YDjQpmEQTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfF1Fjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfF1Fjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:39:45 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D29F42133F;
        Fri, 28 Jun 2019 05:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561700384;
        bh=6aZeyquE37yylW+f6DBNbaMYSjXvL7vQzuyLohuFmT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VANttZFySgX0Q9/V5gt6b69RzBWlwwOpGTqaYaU4PknmJW8L431qvIgF6jXBLDyo/
         JF3zEO6FbvZHndI/MJMncjWH0dhaGixbaGFkcwjzNo12zQ2l/L3YBcParOziwW7ynC
         CvtMUR6eaBTK/C4JDRF8jpCKy61wAVX+8MWDM+vM=
Date:   Fri, 28 Jun 2019 14:39:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing: Simplify assignment parsing for hist
 triggers
Message-Id: <20190628143940.23b8f53f0ef754e9c6a5b947@kernel.org>
In-Reply-To: <17ac912dcec67c85e371b47dd2f55ae7c082b5f6.1561647046.git.zanussi@kernel.org>
References: <cover.1561647046.git.zanussi@kernel.org>
        <17ac912dcec67c85e371b47dd2f55ae7c082b5f6.1561647046.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jun 2019 10:35:16 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> In the process of adding better error messages for sorting, I realized
> that strsep was being used incorrectly and some of the error paths I
> was expecting to be hit weren't and just fell through to the common
> invalid key error case.

Would you mean this includes a bugfix too?

> 
> It also became obvious that for keyword assignments, it wasn't
> necessary to save the full assignment and reparse it later, and having
> a common empty-assignment check would also make more sense in terms of
> error processing.
> 
> Change the code to fix these problems and simplify it for new error
> message changes in a subsequent patch.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

Anyway looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace_events_hist.c | 70 ++++++++++++++++------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index ca6b0dff60c5..964d032f51c6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1985,12 +1985,6 @@ static int parse_map_size(char *str)
>  	unsigned long size, map_bits;
>  	int ret;
>  
> -	strsep(&str, "=");
> -	if (!str) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	ret = kstrtoul(str, 0, &size);
>  	if (ret)
>  		goto out;
> @@ -2050,25 +2044,25 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  static int parse_assignment(struct trace_array *tr,
>  			    char *str, struct hist_trigger_attrs *attrs)
>  {
> -	int ret = 0;
> +	int len, ret = 0;
>  
> -	if ((str_has_prefix(str, "key=")) ||
> -	    (str_has_prefix(str, "keys="))) {
> -		attrs->keys_str = kstrdup(str, GFP_KERNEL);
> +	if ((len = str_has_prefix(str, "key=")) ||
> +	    (len = str_has_prefix(str, "keys="))) {
> +		attrs->keys_str = kstrdup(str + len, GFP_KERNEL);
>  		if (!attrs->keys_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if ((str_has_prefix(str, "val=")) ||
> -		   (str_has_prefix(str, "vals=")) ||
> -		   (str_has_prefix(str, "values="))) {
> -		attrs->vals_str = kstrdup(str, GFP_KERNEL);
> +	} else if ((len = str_has_prefix(str, "val=")) ||
> +		   (len = str_has_prefix(str, "vals=")) ||
> +		   (len = str_has_prefix(str, "values="))) {
> +		attrs->vals_str = kstrdup(str + len, GFP_KERNEL);
>  		if (!attrs->vals_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (str_has_prefix(str, "sort=")) {
> -		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
> +	} else if ((len = str_has_prefix(str, "sort="))) {
> +		attrs->sort_key_str = kstrdup(str + len, GFP_KERNEL);
>  		if (!attrs->sort_key_str) {
>  			ret = -ENOMEM;
>  			goto out;
> @@ -2079,12 +2073,8 @@ static int parse_assignment(struct trace_array *tr,
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (str_has_prefix(str, "clock=")) {
> -		strsep(&str, "=");
> -		if (!str) {
> -			ret = -EINVAL;
> -			goto out;
> -		}
> +	} else if ((len = str_has_prefix(str, "clock="))) {
> +		str += len;
>  
>  		str = strstrip(str);
>  		attrs->clock = kstrdup(str, GFP_KERNEL);
> @@ -2092,8 +2082,8 @@ static int parse_assignment(struct trace_array *tr,
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (str_has_prefix(str, "size=")) {
> -		int map_bits = parse_map_size(str);
> +	} else if ((len = str_has_prefix(str, "size="))) {
> +		int map_bits = parse_map_size(str + len);
>  
>  		if (map_bits < 0) {
>  			ret = map_bits;
> @@ -2133,8 +2123,14 @@ parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
>  
>  	while (trigger_str) {
>  		char *str = strsep(&trigger_str, ":");
> +		char *rhs;
>  
> -		if (strchr(str, '=')) {
> +		rhs = strchr(str, '=');
> +		if (rhs) {
> +			if (!strlen(++rhs)) {
> +				ret = -EINVAL;
> +				goto free;
> +			}
>  			ret = parse_assignment(tr, str, attrs);
>  			if (ret)
>  				goto free;
> @@ -4459,10 +4455,6 @@ static int create_val_fields(struct hist_trigger_data *hist_data,
>  	if (!fields_str)
>  		goto out;
>  
> -	strsep(&fields_str, "=");
> -	if (!fields_str)
> -		goto out;
> -
>  	for (i = 0, j = 1; i < TRACING_MAP_VALS_MAX &&
>  		     j < TRACING_MAP_VALS_MAX; i++) {
>  		field_str = strsep(&fields_str, ",");
> @@ -4557,10 +4549,6 @@ static int create_key_fields(struct hist_trigger_data *hist_data,
>  	if (!fields_str)
>  		goto out;
>  
> -	strsep(&fields_str, "=");
> -	if (!fields_str)
> -		goto out;
> -
>  	for (i = n_vals; i < n_vals + TRACING_MAP_KEYS_MAX; i++) {
>  		field_str = strsep(&fields_str, ",");
>  		if (!field_str)
> @@ -4718,12 +4706,6 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  	if (!fields_str)
>  		goto out;
>  
> -	strsep(&fields_str, "=");
> -	if (!fields_str) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	for (i = 0; i < TRACING_MAP_SORT_KEYS_MAX; i++) {
>  		struct hist_field *hist_field;
>  		char *field_str, *field_name;
> @@ -4732,9 +4714,11 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  		sort_key = &hist_data->sort_keys[i];
>  
>  		field_str = strsep(&fields_str, ",");
> -		if (!field_str) {
> -			if (i == 0)
> -				ret = -EINVAL;
> +		if (!field_str)
> +			break;
> +
> +		if (!*field_str) {
> +			ret = -EINVAL;
>  			break;
>  		}
>  
> @@ -4744,7 +4728,7 @@ static int create_sort_keys(struct hist_trigger_data *hist_data)
>  		}
>  
>  		field_name = strsep(&field_str, ".");
> -		if (!field_name) {
> +		if (!field_name || !*field_name) {
>  			ret = -EINVAL;
>  			break;
>  		}
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
