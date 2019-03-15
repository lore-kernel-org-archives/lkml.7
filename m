Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6F2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFAB218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="ybDLdH3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfCOUIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:08:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34044 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfCOUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:08:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so7218897pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 13:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w/8BEsJtU/vPBtXWNnklc0y31OQ/+tImA8Olzr3Rnp4=;
        b=ybDLdH3e6cFnAzD6FNUG2hIfTsklO5+0A2fKyH5LhxFrSZyu7Csgycvb3ceERkEuT5
         /145vIgkDOSA3EKF9nNG3PoPp/LzERcUh8RWaiASn2f8k5zuivWtaTdSBe3CeiSsH577
         psUwxwlKmOgzXgvTAt+RKxnIiAfhXl/qOLszFKs4dBBu6IXChxZsl7axRhwj2DZLl17S
         q3BrNieqYAu8BsLAxguQ9sLM2GChbkqcjHPFuf+12hgVOeZrjJM7UPiyvmwW/NtTG4tC
         H5TD+vd1m/LXRB1cwGmkt/iyBBBc16kQy5NCHp7+fevfdVUvMTlXgekPzgWTCNK8PU5Z
         y6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w/8BEsJtU/vPBtXWNnklc0y31OQ/+tImA8Olzr3Rnp4=;
        b=CTqDLAtYWZye4ih/EqkqLcx0PQQnZWOQmoknY5zrrWHUhSG4B2ldLFmkAKnBD9rJo6
         Wopcyll+1fvG2aFvmzC9JXnah3aDA2rX+/RMvKc+Yv4aQsD9fwVVmNRoAi/Xs5yWkYM7
         Sp4+J2MsAjsE1FFrQJRS5KDgDc9nM7iPbvs4zjgnULLeLHT11wY1MQDeEu2DJe8Mr2Ed
         fbYeM5VKmi70lemhCWgKcufXmA+Wf1YyLrPSxNpb43RK+imYu0lXUncM8CujWgHMQdkU
         fXUGNG5VLABTLvPYTKH3lefnVl+HgaefMHvRAJgLMu+9J+XX6s6P3ZxCjdIcvDk1lzAm
         X6eQ==
X-Gm-Message-State: APjAAAVHosYLH5100NDIA1qwHFmNDm2F0on3wIALQfQCbwmYleAd0EN2
        Qgdtx3Pk+1vNsLTJh13gWGuefQ==
X-Google-Smtp-Source: APXvYqw3ersuww22smP4wtOi4H9cMMSRnG5LD3jdax/0JNgZtHHlG5M2oNapFw9IY1V4GykVK6neKA==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr6240373plp.80.1552680528905;
        Fri, 15 Mar 2019 13:08:48 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 13sm671544pfj.43.2019.03.15.13.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 13:08:48 -0700 (PDT)
Date:   Fri, 15 Mar 2019 13:08:47 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link it
 non-statically
Message-ID: <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net>
References: <20190315200414.32346-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315200414.32346-1-ivecera@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Ivan Vecera wrote:
> After some experiences I found that urandom_read does not need to be
> linked statically. When the 'read' syscall call is moved to separate
> non-inlined function then bpf_get_stackid() is able to find
> the executable in stack trace and extract its build_id from it.
But why? Do you have some problems with it being linked statically?

> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  tools/testing/selftests/bpf/Makefile       |  2 +-
>  tools/testing/selftests/bpf/urandom_read.c | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 2aed37ea61a4..c33900a8fec0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -69,7 +69,7 @@ TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>  all: $(TEST_CUSTOM_PROGS)
>  
>  $(OUTPUT)/urandom_read: $(OUTPUT)/%: %.c
> -	$(CC) -o $@ -static $< -Wl,--build-id
> +	$(CC) -o $@ $< -Wl,--build-id
>  
>  BPFOBJ := $(OUTPUT)/libbpf.a
>  
> diff --git a/tools/testing/selftests/bpf/urandom_read.c b/tools/testing/selftests/bpf/urandom_read.c
> index 9de8b7cb4e6d..db781052758d 100644
> --- a/tools/testing/selftests/bpf/urandom_read.c
> +++ b/tools/testing/selftests/bpf/urandom_read.c
> @@ -7,11 +7,19 @@
>  
>  #define BUF_SIZE 256
>  
> +static __attribute__((noinline))
> +void urandom_read(int fd, int count)
> +{
> +       char buf[BUF_SIZE];
> +       int i;
> +
> +       for (i = 0; i < count; ++i)
> +               read(fd, buf, BUF_SIZE);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	int fd = open("/dev/urandom", O_RDONLY);
> -	int i;
> -	char buf[BUF_SIZE];
>  	int count = 4;
>  
>  	if (fd < 0)
> @@ -20,8 +28,7 @@ int main(int argc, char *argv[])
>  	if (argc == 2)
>  		count = atoi(argv[1]);
>  
> -	for (i = 0; i < count; ++i)
> -		read(fd, buf, BUF_SIZE);
> +	urandom_read(fd, count);
>  
>  	close(fd);
>  	return 0;
> -- 
> 2.19.2
> 
