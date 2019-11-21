Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D07C2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 13:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXSFAR9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKUN5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:57:23 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44904 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:57:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id m16so3041027qki.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 05:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcDsqTOBKJBpNZHgzn8Kjdfvr2wcc/d2yQmIGtE36pw=;
        b=gXSFAR9dEon5gm3tKVOYPqeVsyb2IY+wuHLQgZgwLfNMp7bjV51CEMTNByn6SLi7NE
         vXJF9Rahp4i89nTuHT4KLjj3y6EIAvY0WrWiTD3jghJHQ/CsJ81j91gP1or5mq4fIE87
         StbUduRDmMGmKeQMzEt9I2QRZlbxOWgS9vVoiqTjz6kv/NE5EHS3RBePUymkWxE74D7W
         d4N6Zk4WMnNRHkrmLFI9l1pa6wR4S7tD4uMVBnKxQQRIPU3scdb9U3RuW+z1PS/HHslP
         Qpz6suvJD8uCf6rHmYz2quWAjUzGywVJQTY3u0AmfC4YgSVRWJ78LMn+AiPFIz4UGRFZ
         CkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcDsqTOBKJBpNZHgzn8Kjdfvr2wcc/d2yQmIGtE36pw=;
        b=SY6402yuO9vzDjtsCqajRwi7wsfH1w2rdSYLei6y87pxRgNotkp0H3E5RiT06BiKT/
         K+2/ZtEzTQaPcIW0z5dkorr5WoVibIE9WMEpOvNwn4CoUXzybIFRCyDk9VERrEd2I1W8
         wRosWbYmU4xtTFexY0TG4xc4TKEymUIjT4CtocJarXZ3iKXAgP5iW7yB7YBLZKNhy2SG
         yHusI8EMniK6BYD+IYogTXdD7VaIKfY0ZBU3I1mVW+1yrfsF4B+OcwCRG3MgFTqaqIdE
         GukAxzt30jaL9Ug68yoY+dSoyAb8sC410GnN9rZ3xBC4URfpXA4zY9ZDiWRYO1pnhxy2
         kZ7A==
X-Gm-Message-State: APjAAAXyEHh6YqNtztNrbWXBeWO6k7pah+DPI4eXD8keB4LMJIf5hy1q
        nnkTFAMyYkSnASbuI7zrIu4=
X-Google-Smtp-Source: APXvYqyoE7xo4eLglSmSZJVq/6dVlEIeoTLnfcvtWOeRZ3c+rp/vw0l/WAVB2tr6UWxZxf823HvLHA==
X-Received: by 2002:a37:5603:: with SMTP id k3mr8052484qkb.346.1574344641660;
        Thu, 21 Nov 2019 05:57:21 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id l31sm131911qta.29.2019.11.21.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 05:57:20 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A227040D3E; Thu, 21 Nov 2019 10:57:17 -0300 (-03)
Date:   Thu, 21 Nov 2019 10:57:17 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] perf tools: Add kernel AUX area sampling
 definitions
Message-ID: <20191121135717.GA5078@kernel.org>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
 <20191115124225.5247-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115124225.5247-2-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 15, 2019 at 02:42:11PM +0200, Adrian Hunter escreveu:
> Add kernel AUX area sampling definitions, which brings perf_event.h into
> line with the kernel version.
> 
> New sample type PERF_SAMPLE_AUX requests a sample of the AUX area buffer.
> New perf_event_attr member 'aux_sample_size' specifies the desired size of
> the sample.

I squashed the first two patches in this series and added this note:

Committer notes:

I squashed the first two patches in this series to avoid breaking
automatic bisection, i.e. after applying only the original first patch
in this series we would have:

  # perf test -v parsing
  26: Sample parsing                                        :
  --- start ---
  test child forked, pid 17018
  sample format has changed, some new PERF_SAMPLE_ bit was introduced - test needs updating
  test child finished with -1
  ---- end ----
  Sample parsing: FAILED!
  #

With the two paches combined:

  # perf test parsing
  26: Sample parsing                                        : Ok
  #

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/include/uapi/linux/perf_event.h     | 10 ++++++++--
>  tools/perf/tests/attr/base-record         |  2 +-
>  tools/perf/tests/attr/base-stat           |  2 +-
>  tools/perf/util/perf_event_attr_fprintf.c |  1 +
>  tools/perf/util/session.c                 |  1 +
>  5 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index bb7b271397a6..377d794d3105 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -141,8 +141,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_TRANSACTION			= 1U << 17,
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
> +	PERF_SAMPLE_AUX				= 1U << 20,
>  
> -	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -300,6 +301,7 @@ enum perf_event_read_format {
>  					/* add: sample_stack_user */
>  #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
>  #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
> +#define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
>  
>  /*
>   * Hardware event_id to monitor via a performance monitoring event:
> @@ -424,7 +426,9 @@ struct perf_event_attr {
>  	 */
>  	__u32	aux_watermark;
>  	__u16	sample_max_stack;
> -	__u16	__reserved_2;	/* align to __u64 */
> +	__u16	__reserved_2;
> +	__u32	aux_sample_size;
> +	__u32	__reserved_3;
>  };
>  
>  /*
> @@ -864,6 +868,8 @@ enum perf_event_type {
>  	 *	{ u64			abi; # enum perf_sample_regs_abi
>  	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
> +	 *	{ u64			size;
> +	 *	  char			data[size]; } && PERF_SAMPLE_AUX
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
> index efd0157b9d22..645009c08b3c 100644
> --- a/tools/perf/tests/attr/base-record
> +++ b/tools/perf/tests/attr/base-record
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0|1
> -size=112
> +size=120
>  config=0
>  sample_period=*
>  sample_type=263
> diff --git a/tools/perf/tests/attr/base-stat b/tools/perf/tests/attr/base-stat
> index 4d0c2e42b64e..b0f42c34882e 100644
> --- a/tools/perf/tests/attr/base-stat
> +++ b/tools/perf/tests/attr/base-stat
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0
> -size=112
> +size=120
>  config=0
>  sample_period=0
>  sample_type=65536
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index d4ad3f04923a..06add607e72d 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -143,6 +143,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(sample_regs_intr, p_hex);
>  	PRINT_ATTRf(aux_watermark, p_unsigned);
>  	PRINT_ATTRf(sample_max_stack, p_unsigned);
> +	PRINT_ATTRf(aux_sample_size, p_unsigned);
>  
>  	return ret;
>  }
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index f07b8ecb91bc..eb7ffd5524dc 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -752,6 +752,7 @@ do { 						\
>  	bswap_field_32(sample_stack_user);
>  	bswap_field_32(aux_watermark);
>  	bswap_field_16(sample_max_stack);
> +	bswap_field_32(aux_sample_size);
>  
>  	/*
>  	 * After read_format are bitfields. Check read_format because
> -- 
> 2.17.1

-- 

- Arnaldo
