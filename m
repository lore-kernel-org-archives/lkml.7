Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06846C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05B8218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 21:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="eK9f+c9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfCTVCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 17:02:12 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35353 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfCTVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 17:02:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id z13so15062689qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=V/B29pHr7YufZf/HG3/02zkKcDsRjwO5vHtTKZ4nqiA=;
        b=eK9f+c9iRH0F9pujt6loV3fJYobzQp04/+lbPrtA8R+tJrvamIUHrI1grx5oU0e10s
         /2TIhFds+Pf4VxKv7ON+4n3DX7hFnscMFT7qs/K/PooIbw5vf49nHbfFI7cHg1ThWpNx
         fjKJXOXv4PZsPN1fqJQsXvjiRD07yy7+O92W+8HDOCZHIA838uZ+AwEOA1DORS0ne4LI
         DWsIusb6FlMXukZ2jRLIDuImUg8Y0K6emwph/IelA+sgWwbx1isReWTDk2sd0hSi6/f9
         04UVBjoS+rEq7iz3sSJmv3F15tGz/qpx893oxkSrMxA19WshsP6l4e5ZjqnGHjpFM3kv
         fQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=V/B29pHr7YufZf/HG3/02zkKcDsRjwO5vHtTKZ4nqiA=;
        b=V+f00IGy2IsZzeQwvBieFt10fK+BOxXf7TkMcDvadqALaG8BoY9LcheTdbgtdk1wzU
         lGUpJgSoLCqL8BFuISHUUKBYXtEuCR7wCfPsdubmtDbH3l7In/2kXRPuQz5rX8v7bIcq
         f8w0ZOvof+JUk4qmuB5bcSo2GPOiB8lhWx82nJlv/o98NxBs69ZKI+/OVerqdrv1oxWQ
         kDAhHqPU1izPlOrttasJX5M0xiTLjZRv4krZcWOZwPxFxW/IIWYpBpr1zRddoafZnKgx
         i0i8mXi5qHP4c19IHq5FB2H2+HrDb/RFvjGSRg/QvANBqRazU9UhSDGJkH6ukUXTTHdG
         1xxA==
X-Gm-Message-State: APjAAAX+Y/vBpfzbcgnlDr0euCclmEGM+7j3wmQoj8VEfjDXI/Q4CszI
        ewWZyQLVMafzVPjqwse3vnN6lQ==
X-Google-Smtp-Source: APXvYqxlHLUc7myCefoFOa1LaNLXdIPxbvKXL2lIUi7sIPuoq2p7shTPaO4LBEOJUFDigTic0RWg8w==
X-Received: by 2002:a37:bce:: with SMTP id 197mr8745860qkl.46.1553115730575;
        Wed, 20 Mar 2019 14:02:10 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 1sm1624665qtb.80.2019.03.20.14.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 14:02:10 -0700 (PDT)
Date:   Wed, 20 Mar 2019 14:02:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alban@kinvolk.io, iago@kinvolk.io
Subject: Re: [PATCH bpf-next v1 2/7] tools: bpftool: fix error message on
 invalid argument count
Message-ID: <20190320140205.54f87bb9@cakuba.netronome.com>
In-Reply-To: <20190320173332.18105-2-alban@kinvolk.io>
References: <20190320173332.18105-1-alban@kinvolk.io>
        <20190320173332.18105-2-alban@kinvolk.io>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2019 18:33:27 +0100, Alban Crequy wrote:
> From: Alban Crequy <alban@kinvolk.io>
> 
> Symptoms:
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar type hash key 8 value 8 entries
> Error: '8' needs at least 2 arguments, 1 found
> 
> After this patch:
> $ sudo bpftool map create /sys/fs/bpf/dir/foobar type hash key 8 value 8 entries
> Error: can't parse max entries: missing argument
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  tools/bpf/bpftool/common.c |  5 +++++
>  tools/bpf/bpftool/main.h   | 11 +++++++----
>  tools/bpf/bpftool/map.c    | 15 ++++++++++++---
>  tools/bpf/bpftool/prog.c   |  2 --
>  4 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index f7261fad45c1..e560cd8f66bc 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -627,6 +627,11 @@ int parse_u32_arg(int *argc, char ***argv, __u32 *val, const char *what)
>  		return -1;
>  	}
>  
> +	if (*argc == 0) {
> +		p_err("can't parse %s: missing argument", what);
> +		return -1;
> +	}
> 
>  	*val = strtoul(**argv, &endptr, 0);
>  	if (*endptr) {
>  		p_err("can't parse %s as %s", **argv, what);
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index d7dd84d3c660..7fc2973446d0 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -22,14 +22,17 @@
>  #define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
>  #define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
>  #define GET_ARG()	({ argc--; *argv++; })
> -#define REQ_ARGS(cnt)							\
> +
> +#define REQ_ARGS(cnt)	REQ_ARGS_GENERIC(cnt, argc, argv)
> +#define REQ_ARGSP(cnt)	REQ_ARGS_GENERIC(cnt, *argc, *argv)
> +#define REQ_ARGS_GENERIC(cnt, ARGC, ARGV)				\
>  	({								\
>  		int _cnt = (cnt);					\
>  		bool _res;						\
>  									\
> -		if (argc < _cnt) {					\
> -			p_err("'%s' needs at least %d arguments, %d found", \
> -			      argv[-1], _cnt, argc);			\
> +		if ((ARGC) < _cnt) {					\
> +			p_err("'%s' needs at least %d arguments, %d found",	\
> +			      (ARGV)[-1], _cnt, (ARGC));			\
>  			_res = false;					\
>  		} else {						\
>  			_res = true;					\
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 994a7e0d16fb..18f9bc3aed4f 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -98,6 +98,9 @@ int map_parse_fd(int *argc, char ***argv)
>  		char *endptr;
>  
>  		NEXT_ARGP();
> +		if (!REQ_ARGSP(1)) {
> +			return -1;
> +		}
>  
>  		id = strtoul(**argv, &endptr, 0);
>  		if (*endptr) {
> @@ -114,6 +117,9 @@ int map_parse_fd(int *argc, char ***argv)
>  		char *path;
>  
>  		NEXT_ARGP();
> +		if (!REQ_ARGSP(1)) {
> +			return -1;
> +		}
>  
>  		path = **argv;
>  		NEXT_ARGP();
> @@ -1100,11 +1106,10 @@ static int do_create(int argc, char **argv)
>  	pinfile = GET_ARG();
>  
>  	while (argc) {
> -		if (!REQ_ARGS(2))
> -			return -1;

Seems like it'd be better to make a version of REQ_ARGS() which
uses the next arg in the error message (if it exists) rather than
pushing all the checks out?

I think the format of the parsing loop is quite canonical here, with
all arguments being in the <keyword> <value> form, therefore I think
it's worthwhile improving the REQ_ARGS(2) check.

>  		if (is_prefix(*argv, "type")) {
>  			NEXT_ARG();
> +			if (!REQ_ARGS(1))
> +				return -1;
>  
>  			if (attr.map_type) {
>  				p_err("map type already specified");
> @@ -1119,6 +1124,8 @@ static int do_create(int argc, char **argv)
>  			NEXT_ARG();
>  		} else if (is_prefix(*argv, "name")) {
>  			NEXT_ARG();
> +			if (!REQ_ARGS(1))
> +				return -1;
>  			attr.name = GET_ARG();
>  		} else if (is_prefix(*argv, "key")) {
>  			if (parse_u32_arg(&argc, &argv, &attr.key_size,
> @@ -1138,6 +1145,8 @@ static int do_create(int argc, char **argv)
>  				return -1;
>  		} else if (is_prefix(*argv, "dev")) {
>  			NEXT_ARG();
> +			if (!REQ_ARGS(1))
> +				return -1;
>  
>  			if (attr.map_ifindex) {
>  				p_err("offload device already specified");
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 8ef80d65a474..e0875ef5e444 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -836,8 +836,6 @@ static int parse_attach_detach_args(int argc, char **argv, int *progfd,
>  	}
>  
>  	NEXT_ARG();
> -	if (!REQ_ARGS(2))
> -		return -EINVAL;
>  
>  	*mapfd = map_parse_fd(&argc, &argv);
>  	if (*mapfd < 0)

