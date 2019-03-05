Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE040C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBB220643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0rOiXqUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfCES14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:27:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46264 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfCES1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:27:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id i16so10556636wrs.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KKBb0F0mLsM0IaZh02AGpd5qe9JwtI+GVMPaoPv06Xc=;
        b=0rOiXqUYBH+bs2tZhjfpSbND9RKQKyFyLe8abxNRMgyQ/LC3vXONcdmmp+HO2ukwLI
         b6xLqIp3XKEXX+/Uh0TJ7pyB8dVByfW3P6E7h+hFXxkqRrLzbFveUZQA7V8Qa84XyDG7
         Ye+thvOFLTIJD/vQxsjJ+ptpcywMViXgw6KJcoUY0nuwYQXLO/0CGCnZ0TDprxWzHzx1
         Kt+e938l5nKRHscc5l8J1vjHi1yck9ur4Q1Dm2qR5CzJmUpf970ysnvt9IWoCeiAp2fP
         GrZO4LFr4+9MG+mBO14dZF+N8hgfQ2KZvHjtE3+ZUXa247Aw6YTMXKD5D5dOnCWWR1l7
         zxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=KKBb0F0mLsM0IaZh02AGpd5qe9JwtI+GVMPaoPv06Xc=;
        b=AlAyb9foq++tWe3/4/WL73VSYjALC9L521eoNPF5t9v76HyXDW3ZEv3bDViFM5RJWc
         iL9ooplelDmmTHaKwF4XDPPo70d5rMBmA61A1vx6GqYQ2IMs2iTt7F+4Qp7tJKbmFtJ1
         avDpWzBb0ee37Apd5ey+mzmJeAJGMQclVR9WgFo+U9Vx5KwOsWEHy3q0i4B3qCUf7pGf
         4JIYMez7oKbBeJVbUITBm6kKl8PVCbShfu1DK7UcspRphLFchMbhbyoKgMr7tGcQkYf0
         bRKRJqW2Cse4P7eAlIKpOKkT8Zh2O+FegJfHr14Hd9mOk5VeIhB4zvcrr9V1sc287flH
         vFJw==
X-Gm-Message-State: APjAAAUnsG2Zo8RsW60+RFNbvifUGdEHGoTbTQR7x55SByittHEsUJxV
        Q9gN+4BVVqVMUnRs5sc/jxIbAIBAow8=
X-Google-Smtp-Source: APXvYqz2Ko99ry6mpuwwO32qsQeSAB5OO0b/l/aADdedjG+f6dUC3F/xrlCzzSfB04GjMm2AuKQLhg==
X-Received: by 2002:a5d:5506:: with SMTP id b6mr157807wrv.33.1551810473028;
        Tue, 05 Mar 2019 10:27:53 -0800 (PST)
Received: from [172.20.1.107] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id c2sm12593834wrt.93.2019.03.05.10.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:27:52 -0800 (PST)
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190305163803.18915-1-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH bpf-next v1] tools/bpftool: create map of maps
Message-ID: <d46a2e1c-fdbc-b842-b951-53fa0897d73c@netronome.com>
Date:   Tue, 5 Mar 2019 18:27:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190305163803.18915-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-03-05 17:38 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
> From: Alban Crequy <alban@kinvolk.io>
> 
> Before this patch, there was no way to fill attr.inner_map_fd, necessary
> for array_of_maps or hash_of_maps.
> 
> This patch adds keyword 'innermap' to pass the innermap, either as an id
> or as a pinned map.
> 
> Example of commands:
> 
> $ sudo bpftool map create /sys/fs/bpf/innermap type hash \
>         key 8 value 8 entries 64 name innermap flags 1
> $ sudo bpftool map create /sys/fs/bpf/outermap type hash_of_maps \
>         innermap pinned /sys/fs/bpf/innermap key 64 value 4 \
>         entries 64 name myoutermap flags 1
> $ sudo bpftool map show pinned /sys/fs/bpf/outermap
> 47: hash_of_maps  name myoutermap  flags 0x1
> 	key 64B  value 4B  max_entries 64  memlock 12288B
> 
> Documentation and bash completion updated as well.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>

Thanks Alban!

> ---
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst |  2 +-
>  tools/bpf/bpftool/bash-completion/bpftool        | 13 +++++++++++++
>  tools/bpf/bpftool/map.c                          |  5 ++++-
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> index 9386bd6e0396..35902ab95cc5 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> @@ -25,7 +25,7 @@ PROG COMMANDS
>  |	**bpftool** **prog dump xlated** *PROG* [{**file** *FILE* | **opcodes** | **visual** | **linum**}]
>  |	**bpftool** **prog dump jited**  *PROG* [{**file** *FILE* | **opcodes** | **linum**}]
>  |	**bpftool** **prog pin** *PROG* *FILE*
> -|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*]
> +|	**bpftool** **prog { load | loadall }** *OBJ* *PATH* [**type** *TYPE*] [**map** {**idx** *IDX* | **name** *NAME*} *MAP*] [**dev** *NAME*] [**innermap** MAP]

This page is the documentation for "bpftool prog" commands. You want
"bpftool map" (tools/bpf/bpftool/Documentation/bpftool-map.rst) instead.

You also need to update the description line for the "bpftool map
create" command further down in the bpftool-map.rst page. And could you
please add a sentence to that description to explain what the argument
is for?

>  |	**bpftool** **prog attach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog detach** *PROG* *ATTACH_TYPE* [*MAP*]
>  |	**bpftool** **prog tracelog**
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index b803827d01e8..dcdc39510dc3 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -461,6 +461,18 @@ _bpftool()
>                              _sysfs_get_netdevs
>                              return 0
>                              ;;
> +                        innermap)
> +                            COMPREPLY+=( $( compgen -W "id pinned" -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        id)
> +                            _bpftool_get_map_ids
> +                            return 0
> +                            ;;
> +                        pinned)
> +                            _filedir
> +                            return 0
> +                            ;;

No need to add completion here for "pinned", it is handled already [0].

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/bpf/bpftool/bash-completion/bpftool?h=v5.0#n172

>                          *)
>                              _bpftool_once_attr 'type'
>                              _bpftool_once_attr 'key'
> @@ -469,6 +481,7 @@ _bpftool()
>                              _bpftool_once_attr 'name'
>                              _bpftool_once_attr 'flags'
>                              _bpftool_once_attr 'dev'
> +                            _bpftool_once_attr 'innermap'
>                              return 0
>                              ;;
>                      esac
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index e0c650d91784..7d8ce903a471 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1151,6 +1151,9 @@ static int do_create(int argc, char **argv)
>  				return -1;
>  			}
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "innermap")) {
> +			NEXT_ARG();
> +			attr.inner_map_fd = map_parse_fd(&argc, &argv);
>  		}
>  	}
>  
> @@ -1231,7 +1234,7 @@ static int do_help(int argc, char **argv)
>  		"Usage: %s %s { show | list }   [MAP]\n"
>  		"       %s %s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
>  		"                              entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
> -		"                              [dev NAME]\n"
> +		"                              [dev NAME] [innermap MAP]\n"
>  		"       %s %s dump       MAP\n"
>  		"       %s %s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
>  		"       %s %s lookup     MAP [key DATA]\n"
> 

