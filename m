Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD595C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2FA21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="CCYeqD0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfCTTAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:00:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53883 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfCTTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:00:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so328022wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ktddu76WvPbH/e8wAG7UqSfwslqPcY4HSdFqx+VFTkc=;
        b=CCYeqD0S+iTcgZE45mxeAPvWF/Ok/KAYKsoB9rrSXQawpo0fBd8UOJ/MUYJicGxrfJ
         t+zp29pYhJNEswtNIvOj9MYKN+uKxWE1O6AfVECcDmRCw5Co/6wClZuadCCp0+tIFEaw
         oGuJz51mUPKJ3+cwTV5xz0qNWjbE/vVXagmApSR1Jzk2xTjnhbKLfifkjeNDTLVdGpY/
         QWswkQfLk1pg7ygp6w9c3GlFIvlaF5lHELq8nxUhJZKoU6Z1+h8vndhbcG3HgFk6tKe4
         H89/losBcFKTVlW9PKMgL5tCKfsp7+NjBby+g5LOEZhysIzaFq0KQeB74J2UDmhj0RMU
         jFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ktddu76WvPbH/e8wAG7UqSfwslqPcY4HSdFqx+VFTkc=;
        b=L3FaBROAbyXUlLnMlZts3OjcXrKtGVVrBBlY/6M6NZlPnifLVgttTrSzDPKKA/qjwZ
         o4Nc7MbHXSHsJ/Y9bBQyvRKJNhnzg9QKds+RazySN4AthFM7RS1p9BiwTkh0gXy4c8BY
         DAMbkXqnDnMkDhA9T1//HeYBvOPGWScy7FFSv6Kh+vpQWdObs0uq5GkGPWHe7JYzwDu0
         0s092UYZ5qF9zeMjq/+pXVkFcvcmIJlfDLhUijnE62h9FxvKm0kgjGYWbLqNeWIGKR1o
         LxqVjqYvplK12y0dPA07XAqbLlZCaFNWZWWgmWyPjNh2+BC3ww1yD5PKQPJPQXQn41X+
         NdEg==
X-Gm-Message-State: APjAAAUqxDVZCqg+YArLUd+MxfzmjIks0xmTafYiu/222mA/7Yt5vp49
        8eKjlMivOHjzEFVlDSzX4xpqug==
X-Google-Smtp-Source: APXvYqzM7Sa4kAtDERQfjedrwWTwL45BwWDXIJfXMHSQ/ahCbP8nuHeXgEv7Wm996SCNIXTXnWG6kA==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr9160511wmc.107.1553108436068;
        Wed, 20 Mar 2019 12:00:36 -0700 (PDT)
Received: from [172.20.1.106] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id o127sm4851367wmo.20.2019.03.20.12.00.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:00:35 -0700 (PDT)
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190320173332.18105-1-alban@kinvolk.io>
 <20190320173332.18105-3-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH bpf-next v1 3/7] tools: bpftool: create map of maps
Message-ID: <d856c20f-662b-60ac-996e-8148337a50e9@netronome.com>
Date:   Wed, 20 Mar 2019 19:00:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320173332.18105-3-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alban, thanks for those patches!

2019-03-20 18:33 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
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
> 
> ---
> 
> Previous version of this patch was sent while bpf-next was closed.
> https://marc.info/?l=linux-kernel&m=155180393501258&w=2
> 
> Since then, the following changes were done:
> - error management when calling map_parse_fd (review from Jakub)
> - fix documentation and bash completion (review from Quentin)
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst |  9 ++-
>  tools/bpf/bpftool/bash-completion/bpftool     |  9 +++
>  tools/bpf/bpftool/map.c                       | 75 +++++++++++++++++--
>  3 files changed, 83 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5c984ffc9f01..b685641bfd74 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -23,7 +23,7 @@ MAP COMMANDS
>  
>  |	**bpftool** **map { show | list }**   [*MAP*]
>  |	**bpftool** **map create**     *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE* \
> -|		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*]
> +|		**entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*] [**innermap** MAP]
>  |	**bpftool** **map dump**       *MAP*
>  |	**bpftool** **map update**     *MAP* [**key** *DATA*] [**value** *VALUE*] [*UPDATE_FLAGS*]
>  |	**bpftool** **map lookup**     *MAP* [**key** *DATA*]
> @@ -60,10 +60,15 @@ DESCRIPTION
>  		  Output will start with map ID followed by map type and
>  		  zero or more named attributes (depending on kernel version).
>  
> -	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*]
> +	**bpftool map create** *FILE* **type** *TYPE* **key** *KEY_SIZE* **value** *VALUE_SIZE*  **entries** *MAX_ENTRIES* **name** *NAME* [**flags** *FLAGS*] [**dev** *NAME*] [**innermap** MAP]
>  		  Create a new map with given parameters and pin it to *bpffs*
>  		  as *FILE*.
>  
> +		  To create a map of type **array_of_maps** or
> +		  **hash_of_maps**, the additional parameter **innermap** needs
> +		  to reference an existing map with the type and size of the
> +		  maps in the values.
> +
>  	**bpftool map dump**    *MAP*
>  		  Dump all entries in a given *MAP*.
>  
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index b803827d01e8..9e37de8bb227 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -461,6 +461,14 @@ _bpftool()
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
>                          *)
>                              _bpftool_once_attr 'type'
>                              _bpftool_once_attr 'key'
> @@ -469,6 +477,7 @@ _bpftool()
>                              _bpftool_once_attr 'name'
>                              _bpftool_once_attr 'flags'
>                              _bpftool_once_attr 'dev'
> +                            _bpftool_once_attr 'innermap'
>                              return 0
>                              ;;
>                      esac
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 18f9bc3aed4f..a576f2a019be 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -1100,6 +1100,7 @@ static int do_create(int argc, char **argv)
>  	struct bpf_create_map_attr attr = { NULL, };
>  	const char *pinfile;
>  	int err, fd;
> +	int inner_map_fd = -1;

Nit: reverse-Christmas tree for declaring the variables.

>  
>  	if (!REQ_ARGS(7))
>  		return -1;
> @@ -1108,48 +1109,75 @@ static int do_create(int argc, char **argv)
>  	while (argc) {
>  		if (is_prefix(*argv, "type")) {
>  			NEXT_ARG();
> -			if (!REQ_ARGS(1))
> +			if (!REQ_ARGS(1)) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  
>  			if (attr.map_type) {
>  				p_err("map type already specified");
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
>  			}
>  
>  			attr.map_type = map_type_from_str(*argv);
>  			if ((int)attr.map_type < 0) {
>  				p_err("unrecognized map type: %s", *argv);
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
>  			}
>  			NEXT_ARG();
>  		} else if (is_prefix(*argv, "name")) {
>  			NEXT_ARG();
> -			if (!REQ_ARGS(1))
> +			if (!REQ_ARGS(1)) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  			attr.name = GET_ARG();
>  		} else if (is_prefix(*argv, "key")) {
>  			if (parse_u32_arg(&argc, &argv, &attr.key_size,
> -					  "key size"))
> +					  "key size")) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  		} else if (is_prefix(*argv, "value")) {
>  			if (parse_u32_arg(&argc, &argv, &attr.value_size,
> -					  "value size"))
> +					  "value size")) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  		} else if (is_prefix(*argv, "entries")) {
>  			if (parse_u32_arg(&argc, &argv, &attr.max_entries,
> -					  "max entries"))
> +					  "max entries")) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  		} else if (is_prefix(*argv, "flags")) {
>  			if (parse_u32_arg(&argc, &argv, &attr.map_flags,
> -					  "flags"))
> +					  "flags")) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  		} else if (is_prefix(*argv, "dev")) {
>  			NEXT_ARG();
> -			if (!REQ_ARGS(1))
> +			if (!REQ_ARGS(1)) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
> +			}
>  
>  			if (attr.map_ifindex) {
>  				p_err("offload device already specified");
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
>  			}
>  
> @@ -1157,28 +1185,59 @@ static int do_create(int argc, char **argv)
>  			if (!attr.map_ifindex) {
>  				p_err("unrecognized netdevice '%s': %s",
>  				      *argv, strerror(errno));
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
>  				return -1;
>  			}
>  			NEXT_ARG();
> +		} else if (is_prefix(*argv, "innermap")) {
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1)) {
> +				if (inner_map_fd != -1)
> +					close(inner_map_fd);
> +				return -1;
> +			}
> +
> +			if (inner_map_fd != -1) {
> +				close(inner_map_fd);
> +				p_err("innermap already specified");
> +				return -1;
> +			}
> +
> +			inner_map_fd = map_parse_fd(&argc, &argv);
> +			if (inner_map_fd < 0)
> +				return -1;
>  		} else {
>  			p_err("unknown arg %s", *argv);
> +			if (inner_map_fd != -1)
> +				close(inner_map_fd);
>  			return -1;
>  		}
>  	}
>  
>  	if (!attr.name) {
>  		p_err("map name not specified");
> +		if (inner_map_fd != -1)
> +			close(inner_map_fd);
>  		return -1;
>  	}
>  
>  	set_max_rlimit();
>  
> +	if (inner_map_fd != -1)
> +		attr.inner_map_fd = inner_map_fd;
> +
>  	fd = bpf_create_map_xattr(&attr);
>  	if (fd < 0) {
>  		p_err("map create failed: %s", strerror(errno));
> +		if (inner_map_fd != -1)
> +			close(inner_map_fd);
>  		return -1;

You might want to move all those

	if (inner_map_fd != -1)
		close(inner_map_fd);
	return -1;

at the end of the function under a label, and jump there with a goto for
the 15 or so occurrences of the pattern?

>  	}
>  
> +	if (inner_map_fd != -1)
> +		close(inner_map_fd);
> +
>  	err = do_pin_fd(fd, pinfile);
>  	close(fd);
>  	if (err)
> @@ -1243,7 +1302,7 @@ static int do_help(int argc, char **argv)
>  		"Usage: %s %s { show | list }   [MAP]\n"
>  		"       %s %s create     FILE type TYPE key KEY_SIZE value VALUE_SIZE \\\n"
>  		"                              entries MAX_ENTRIES name NAME [flags FLAGS] \\\n"
> -		"                              [dev NAME]\n"
> +		"                              [dev NAME] [innermap MAP]\n"
>  		"       %s %s dump       MAP\n"
>  		"       %s %s update     MAP [key DATA] [value VALUE] [UPDATE_FLAGS]\n"
>  		"       %s %s lookup     MAP [key DATA]\n"
> 

