Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AB7C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6B620850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yyt/nvWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfCTTBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:01:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46830 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfCTTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:01:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id o1so3971708wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XBhIq3aqso0G04zXT+QC3Zu+3j3tuTRQXg8+qUd02lI=;
        b=yyt/nvWtHxXqRjMpiHjiXnMPMpBiiGIwJ+u+Gu99sbWTeYKDBVkAzRfHvd52nhYfpu
         otp5K/A3JVCs319iTobudv91ns2JZ/APRwrQgYHogWT3HAV4AsP1d6gDuU3QDm9+Xqzo
         U7JKwL5NeK+m9QEAAsEWgRE1Ujrx0YCN+5p17hwCyAVhBtjK6pR6eeiz92lBr9+Uscki
         7/frSDdX5wCqGw7gC3delyMgcDQ/SLXjwIc7y814P8/laViIIOjE4HTR8l8pFy0uz4k6
         DwzlmJITVYuXsg5EHebAL1QJovf5x6Ib0MnwVe8muLtO/ubq0vHBWKXkEAd+clJW4+gf
         Jfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XBhIq3aqso0G04zXT+QC3Zu+3j3tuTRQXg8+qUd02lI=;
        b=FsHS0/Yqx4zgAAuvkBHyOr/i+ZW8v9ADCdbJm9G5zFroVZmVEeiIeuSLDSjO/lpuS1
         2T55ll0H6Y71I4lUwletWKhPbjzZPlO8vm3erKdq/W6fZOOB7Hea9mztugRUlzEM6qgU
         +S190QbslqQNwcggPKpFbKSX7VwsgPVzHQnCsYVmCB7B/x8Kqt9WcUA5/HkPnqPD23N1
         h81Sgk/W5aMXNZdeilP/G88hYacLldpazaOAPni01G2FKvvq3n18i75CluYJ/tSa0fuV
         T8xXzJDomY90hlWVYaHHzrVEyAAgJh+YKZMDqed7dOXVJXIu7yged5lC5ACRybBntW3Y
         nHdA==
X-Gm-Message-State: APjAAAVUcZWvXvr+k/4+AvuxFA58aFNMEwo5zXUPDMLC9ADyxnV3xoOc
        1U8qwXJeSaZAALpeKO5i8Lli9QWCfGw=
X-Google-Smtp-Source: APXvYqw0zQAEMUgKOWMwAMiZHIEnO0Vh7OMwmXi1bh5My5/jAToW3ykUMDLLunZRU81L/E5HaaEKnw==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr22377557wrj.325.1553108475257;
        Wed, 20 Mar 2019 12:01:15 -0700 (PDT)
Received: from [172.20.1.106] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id j3sm9094551wrg.54.2019.03.20.12.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:01:14 -0700 (PDT)
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190320173332.18105-1-alban@kinvolk.io>
 <20190320173332.18105-6-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH bpf-next v1 6/7] tools: bpftool: fix bpffs mount when
 pinning subdirectories
Message-ID: <f247bd50-57aa-0320-e5de-a715a5f15491@netronome.com>
Date:   Wed, 20 Mar 2019 19:01:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320173332.18105-6-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-20 18:33 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
> From: Alban Crequy <alban@kinvolk.io>
> 
> When trying to pin at a path such as /sys/fs/bpf/subdir/mymap while the
> bpffs is mounted at the standard path and the "subdir" directory didn't
> exist, bpftool was failing and attempting to mount the bpffs on
> /sys/fs/bpf/subdir/. The mount obviously failed, since "subdir" didn't
> exist.
> 
> Commit 3fc27b71b894 ("tools: bpftool: try to mount bpffs if required for
> pinning objects") says:
> 
>     The code for mnt_bpffs() is a copy of function bpf_mnt_fs() from
>     iproute2 package (under lib/bpf.c, taken at commit 4b73d52f8a81), with
>     modifications regarding handling of error messages.
> 
> However, the function bpf_mnt_fs() from iproute2 only works when its
> parameter is the root of the bpffs (e.g. "/sys/fs/bfs").
For bpftool, the point was to be able to mount the bpffs at any mount
point the user wanted to use. So one way to fix that would be to simply
prevent the mount attempt if the directory does not exist. Another one
would be to attempt to create the directories (but I guess that sounds
more hazardous already). I'm not really sure we should restrict mounting
to the default /sys/fs/bpf. I understand the environment variable still
allows it, so why not, but I find it less straightforward. Maybe others
will have an opinion.

> 
> iproute2/tc actually only mounts at the standard path "/sys/fs/bfs" or
> at the path from the environment variable $TC_BPF_MNT. This patch
> implements a similar strategy but uses the environment variable name
> $BPFTOOL_BPF_MNT.
> 
> This patch still will not do the mkdir automatically. But at least,
> there will be no error message about the mount.
> 
> Fixes: 3fc27b71b894 ("tools: bpftool: try to mount bpffs if required for pinning objects")
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  tools/bpf/bpftool/common.c | 20 ++++++++++++++++----
>  tools/bpf/bpftool/main.h   |  6 ++++++
>  2 files changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index e560cd8f66bc..4783cbbe8037 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -168,6 +168,8 @@ int mount_bpffs_for_pin(const char *name)
>  	char *file;
>  	char *dir;
>  	int err = 0;
> +	const char *mnt_env = getenv(BPF_DIR_MNT_ENV);
> +	static const char *mnt;

Reverse-Christmas tree style for the declarations, please.

>  
>  	file = malloc(strlen(name) + 1);
>  	strcpy(file, name);
> @@ -183,13 +185,23 @@ int mount_bpffs_for_pin(const char *name)
>  		goto out_free;
>  	}
>  
> -	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
> +	mnt = mnt_env ? : BPF_DIR_MNT;
> +
> +	// Don't try to mount if wrong prefix: we don't want a leftover mount that is
> +	// not going to help.

Please stick to /* */-style comments.

> +	if (!is_prefix(mnt, dir)) {
> +		p_err("refuse to mount BPF file system (%s) to pin the object (%s): wrong directory",

Not all users know that bpftool attempts to mount the bpffs, I fear this
message might sound a bit obscure. Maybe something along
"<dir> is not in bpffs or under an expected mountpoint, cannot pin ..."?

> +		      mnt, name);
> +		err = -1;
> +		goto out_free;
> +	}
> +
> +	err = mnt_fs(mnt, "bpf", err_str, ERR_MAX_LEN);
>  	if (err) {
>  		err_str[ERR_MAX_LEN - 1] = '\0';
> -		p_err("can't mount BPF file system to pin the object (%s): %s",
> -		      name, err_str);
> +		p_err("can't mount BPF file system (%s) to pin the object (%s): %s",
> +		      mnt, name, err_str);
>  	}
> -

No need to remove the empty line?

>  out_free:
>  	free(file);
>  	return err;
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 7fc2973446d0..a2e28e600b72 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -18,6 +18,12 @@
>  
>  #define ptr_to_u64(ptr)	((__u64)(unsigned long)(ptr))
>  
> +/* If bpffs is not mounted, it can be automatically mounted at this location.
> + * The location can be changed with the environment variable $BPFTOOL_BPF_MNT.

Could you please document that in the manual pages? Otherwise very few
people will ever discover this variable. I don't think we have mentioned
anywhere that we try to mount the file system yet, but we could have it
in both bpftool-prog and bpftool-map I suppose.

> + */
> +#define BPF_DIR_MNT	"/sys/fs/bpf"
> +#define BPF_DIR_MNT_ENV	"BPFTOOL_BPF_MNT"

Could we rename those macros into BPFFS_MNT_* maybe?

> +
>  #define NEXT_ARG()	({ argc--; argv++; if (argc < 0) usage(); })
>  #define NEXT_ARGP()	({ (*argc)--; (*argv)++; if (*argc < 0) usage(); })
>  #define BAD_ARG()	({ p_err("what is '%s'?", *argv); -1; })
> 

