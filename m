Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD4C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC54E206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHV/oYBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFEMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 08:53:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39943 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfFEMxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 08:53:16 -0400
Received: by mail-qk1-f193.google.com with SMTP id c70so5009518qkg.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 05:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FEJlwRzOSRN+nlu5X4lPOwpsvJ7oWUXOjTXr6yHewVs=;
        b=KHV/oYBHp2bFpw53YVfhzl3g1kG2WmIzXRZmzI671MGDFgyIhzTfBLeny6QRd70/Wb
         Q49SrLx5bOYcq2UmvSigcBYt6+enapqr/jp80PXY1p/Iw73+1AbeG1WQ34FQWF5AsKvJ
         AGGL7LlhdFnNbX5jRS+pEU1gQVS2U/7ZugcNin0lr/k5mnUgkNYskil9lWeShlZeX+V+
         honvGgrYzMXAKP8nxyImXTxWXcu+MauFLuTdLk0+IvFYUuBNrCPlCzWx2DLr8HfTORMF
         /M+4nzHB/xT/FWPQ7B5nsF7aqSjSoRXrMBxptfHgcxSyXz6vDTdeHNz8mkC5VxT1c0BQ
         xsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FEJlwRzOSRN+nlu5X4lPOwpsvJ7oWUXOjTXr6yHewVs=;
        b=kQLbNV7aa5iswVMBnlF4KPG9sPc1MOzisz10L7MQcUMLDMqy0rOMuoYZWfGj++YWop
         FEqUBVLo4oed7m0CwpHNxH5w+xj89/gYtcdOvJhkxcx3KI8sZNJNsH6zLG5yCPpVsr+n
         wRALmlPwcKa/FF0M28l3c0+d4ZNGxsulXcl+7nvE6ArHt1IuBhX6cj6eDBgahamsXa5e
         x7r++jNixIBtss+S30+eLpMfuj56WFmXYdXT9Nc4COk9nqAs/49jpmlo9xBUlLWWr+0D
         gntDzmDNcuxNe4UHJGEsiJqBznBX6PwFRX1oTSBJwoL6r6ppvJzaFzYYwZSSr49sDJZj
         OXzw==
X-Gm-Message-State: APjAAAXCEYD0QR6Hr7nlIhst5exHq4npUHaoJnJkJmgqXgOkogysziYX
        b/npJSk7My1xmAwDiHH2v3c=
X-Google-Smtp-Source: APXvYqxpOHxbmXPU3eVITd9pgKb9Z6rBwqCROpIc51RhnW7VWDuMfcmxuBM3TI73Byjp3o64Xi3W3g==
X-Received: by 2002:ae9:ea05:: with SMTP id f5mr13508285qkg.275.1559739195257;
        Wed, 05 Jun 2019 05:53:15 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id q29sm1693245qkq.77.2019.06.05.05.53.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 05:53:14 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D172C41149; Wed,  5 Jun 2019 09:53:11 -0300 (-03)
Date:   Wed, 5 Jun 2019 09:53:11 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ben Gainey <ben.gainey@arm.com>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCHv2] perf jvmti: Fix gcc string overflow warning
Message-ID: <20190605125311.GE20408@kernel.org>
References: <20190531080307.22628-1-jolsa@kernel.org>
 <20190531120530.GB17152@kernel.org>
 <20190531131321.GB1281@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190531131321.GB1281@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 31, 2019 at 03:13:21PM +0200, Jiri Olsa escreveu:
> On Fri, May 31, 2019 at 09:05:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > I think for these needs flipping that 'n' into a 'l' is good enough.
 
> ok, I forgot there's strlcpy.. v2 attached

Thanks, applied v2.

- Arnaldo
 
> ---
> We are getting fake gcc warning when we compile with gcc9 (9.1.1):
> 
>      CC       jvmti/libjvmti.o
>    In file included from /usr/include/string.h:494,
>                     from jvmti/libjvmti.c:5:
>    In function ‘strncpy’,
>        inlined from ‘copy_class_filename.constprop’ at jvmti/libjvmti.c:166:3:
>    /usr/include/bits/string_fortified.h:106:10: error: ‘__builtin_strncpy’ specified bound depends on the length of the source argument [-Werror=stringop-overflow=]
>      106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__dest));
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    jvmti/libjvmti.c: In function ‘copy_class_filename.constprop’:
>    jvmti/libjvmti.c:165:26: note: length computed here
>      165 |   size_t file_name_len = strlen(file_name);
>          |                          ^~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> As per Arnaldo's suggestion using strlcpy, which does
> the same thing and keeps gcc silent.
> 
> Cc: Ben Gainey <ben.gainey@arm.com>
> Cc: Stephane Eranian <eranian@google.com>
> Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Link: http://lkml.kernel.org/n/tip-sve3b63c550wr907e6ui6gx5@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/jvmti/libjvmti.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index aea7b1fe85aa..c441a34cb1c0 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/compiler.h>
> +#include <linux/string.h>
>  #include <sys/types.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -162,8 +163,7 @@ copy_class_filename(const char * class_sign, const char * file_name, char * resu
>  		result[i] = '\0';
>  	} else {
>  		/* fallback case */
> -		size_t file_name_len = strlen(file_name);
> -		strncpy(result, file_name, file_name_len < max_length ? file_name_len : max_length);
> +		strlcpy(result, file_name, max_length);
>  	}
>  }
>  
> -- 
> 2.21.0

-- 

- Arnaldo
