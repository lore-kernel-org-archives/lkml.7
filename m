Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AF4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAA620850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="VAnn82FZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfCTTBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:01:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35579 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCTTBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:01:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so321896wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zcRCVq3B+iwwZzRJrXnuwilWuPQVL4V6o04ieqitPfQ=;
        b=VAnn82FZaA+TzmputmzDuvnrv9DkO+e3kVqRf/9CsVPjSsK7w1oOCIiKvWBqX2nXAM
         pPN0l4GN5Hqz/sudxKvFQg2z6ep7u6o5s5N20rNC2zn1gXVQ6zlt8tLpfEIqLpo8ljky
         2g8DFTjYa/IcBIm3L0XGUaV/jn+QEOBCj0Tu3yC9t7hP9inYbT+ZGgtKl+VRM+iDcJOc
         BIQrCJVB46y8knCG+lhZIODTXV1sv87iChZ0n6kcLxKKmS0NMBi8OSUZBF/MPh5lpFIq
         L0KV2kInrD+emk6DSe6yBJAucoKfBz42nSRLEJSkCI72hXvV8mvjxI68f5K0wZ9MTow/
         ci/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zcRCVq3B+iwwZzRJrXnuwilWuPQVL4V6o04ieqitPfQ=;
        b=DDbxq8JZDaRqEm0elZHPWD60kj3mto9+wgk3ee5JNEjxRSJYO2Px1Sxanhds8Ndxb2
         7VA6X16aCG+tlBiqhHigjYsuBm11nA0evk303rp4myCPp9i4cgDMQAxbI1gIHCiV/7tj
         I4MPadYtuMCKIRB6cD6c5p+IrtZCeMBNWhhxcqCX/WW1U5nXSgpdsjqjIgb5VnuQhHv7
         DBwTSAR5OIkRrULv7ViiK8ZwkxfaHjaPY7tAzHqNTTMnFMz5oQH8knbSNJ2jXQHfcmxW
         6FuNzMVTEeasY6Y3NfMai6aBjdnpG2bBK58V3IW3TDVcOkdcdfBZTaor2TZTGoFJJw0q
         JBHQ==
X-Gm-Message-State: APjAAAXsLqph2TX6UkuSHhvBBQIPnsRqdQBdS/MY0prKbdy0SuvgwLlN
        VuCDrcvQa5br2FdbczFz/EFLKQ==
X-Google-Smtp-Source: APXvYqzS5ga6x8HSaHitv63vGSSRGgTpCEJB73C3HaCJrQXrEQIWWjmzSTsUWcpD18/D5JWHAFsjjA==
X-Received: by 2002:a1c:4d:: with SMTP id 74mr9029583wma.129.1553108462606;
        Wed, 20 Mar 2019 12:01:02 -0700 (PDT)
Received: from [172.20.1.106] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t2sm5487793wra.9.2019.03.20.12.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 12:01:01 -0700 (PDT)
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        alban@kinvolk.io, iago@kinvolk.io
References: <20190320173332.18105-1-alban@kinvolk.io>
 <20190320173332.18105-4-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 mQINBFnqRlsBEADfkCdH/bkkfjbglpUeGssNbYr/TD4aopXiDZ0dL2EwafFImsGOWmCIIva2
 MofTQHQ0tFbwY3Ir74exzU9X0aUqrtHirQHLkKeMwExgDxJYysYsZGfM5WfW7j8X4aVwYtfs
 AVRXxAOy6/bw1Mccq8ZMTYKhdCgS3BfC7qK+VYC4bhM2AOWxSQWlH5WKQaRbqGOVLyq8Jlxk
 2FGLThUsPRlXKz4nl+GabKCX6x3rioSuNoHoWdoPDKsRgYGbP9LKRRQy3ZeJha4x+apy8rAM
 jcGHppIrciyfH38+LdV1FVi6sCx8sRKX++ypQc3fa6O7d7mKLr6uy16xS9U7zauLu1FYLy2U
 N/F1c4F+bOlPMndxEzNc/XqMOM9JZu1XLluqbi2C6JWGy0IYfoyirddKpwzEtKIwiDBI08JJ
 Cv4jtTWKeX8pjTmstay0yWbe0sTINPh+iDw+ybMwgXhr4A/jZ1wcKmPCFOpb7U3JYC+ysD6m
 6+O/eOs21wVag/LnnMuOKHZa2oNsi6Zl0Cs6C7Vve87jtj+3xgeZ8NLvYyWrQhIHRu1tUeuf
 T8qdexDphTguMGJbA8iOrncHXjpxWhMWykIyN4TYrNwnyhqP9UgqRPLwJt5qB1FVfjfAlaPV
 sfsxuOEwvuIt19B/3pAP0nbevNymR3QpMPRl4m3zXCy+KPaSSQARAQABtC1RdWVudGluIE1v
 bm5ldCA8cXVlbnRpbi5tb25uZXRAbmV0cm9ub21lLmNvbT6JAj0EEwEIACcFAlnqRlsCGyMF
 CQlmAYAFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQNvcEyYwwfB7tChAAqFWG30+DG3Sx
 B7lfPaqs47oW98s5tTMprA+0QMqUX2lzHX7xWb5v8qCpuujdiII6RU0ZhwNKh/SMJ7rbYlxK
 qCOw54kMI+IU7UtWCej+Ps3LKyG54L5HkBpbdM8BLJJXZvnMqfNWx9tMISHkd/LwogvCMZrP
 TAFkPf286tZCIz0EtGY/v6YANpEXXrCzboWEiIccXRmbgBF4VK/frSveuS7OHKCu66VVbK7h
 kyTgBsbfyQi7R0Z6w6sgy+boe7E71DmCnBn57py5OocViHEXRgO/SR7uUK3lZZ5zy3+rWpX5
 nCCo0C1qZFxp65TWU6s8Xt0Jq+Fs7Kg/drI7b5/Z+TqJiZVrTfwTflqPRmiuJ8lPd+dvuflY
 JH0ftAWmN3sT7cTYH54+HBIo1vm5UDvKWatTNBmkwPh6d3cZGALZvwL6lo0KQHXZhCVdljdQ
 rwWdE25aCQkhKyaCFFuxr3moFR0KKLQxNykrVTJIRuBS8sCyxvWcZYB8tA5gQ/DqNKBdDrT8
 F9z2QvNE5LGhWDGddEU4nynm2bZXHYVs2uZfbdZpSY31cwVS/Arz13Dq+McMdeqC9J2wVcyL
 DJPLwAg18Dr5bwA8SXgILp0QcYWtdTVPl+0s82h+ckfYPOmkOLMgRmkbtqPhAD95vRD7wMnm
 ilTVmCi6+ND98YblbzL64YG5Ag0EWepGWwEQAM45/7CeXSDAnk5UMXPVqIxF8yCRzVe+UE0R
 QQsdNwBIVdpXvLxkVwmeu1I4aVvNt3Hp2eiZJjVndIzKtVEoyi5nMvgwMVs8ZKCgWuwYwBzU
 Vs9eKABnT0WilzH3gA5t9LuumekaZS7z8IfeBlZkGXEiaugnSAESkytBvHRRlQ8b1qnXha3g
 XtxyEqobKO2+dI0hq0CyUnGXT40Pe2woVPm50qD4HYZKzF5ltkl/PgRNHo4gfGq9D7dW2OlL
 5I9qp+zNYj1G1e/ytPWuFzYJVT30MvaKwaNdurBiLc9VlWXbp53R95elThbrhEfUqWbAZH7b
 ALWfAotD07AN1msGFCES7Zes2AfAHESI8UhVPfJcwLPlz/Rz7/K6zj5U6WvH6aj4OddQFvN/
 icvzlXna5HljDZ+kRkVtn+9zrTMEmgay8SDtWliyR8i7fvnHTLny5tRnE5lMNPRxO7wBwIWX
 TVCoBnnI62tnFdTDnZ6C3rOxVF6FxUJUAcn+cImb7Vs7M5uv8GufnXNUlsvsNS6kFTO8eOjh
 4fe5IYLzvX9uHeYkkjCNVeUH5NUsk4NGOhAeCS6gkLRA/3u507UqCPFvVXJYLSjifnr92irt
 0hXm89Ms5fyYeXppnO3l+UMKLkFUTu6T1BrDbZSiHXQoqrvU9b1mWF0CBM6aAYFGeDdIVe4x
 ABEBAAGJAiUEGAEIAA8FAlnqRlsCGwwFCQlmAYAACgkQNvcEyYwwfB4QwhAAqBTOgI9k8MoM
 gVA9SZj92vYet9gWOVa2Inj/HEjz37tztnywYVKRCRfCTG5VNRv1LOiCP1kIl/+crVHm8g78
 iYc5GgBKj9O9RvDm43NTDrH2uzz3n66SRJhXOHgcvaNE5ViOMABU+/pzlg34L/m4LA8SfwUG
 ducP39DPbF4J0OqpDmmAWNYyHh/aWf/hRBFkyM2VuizN9cOS641jrhTO/HlfTlYjIb4Ccu9Y
 S24xLj3kkhbFVnOUZh8celJ31T9GwCK69DXNwlDZdri4Bh0N8DtRfrhkHj9JRBAun5mdwF4m
 yLTMSs4Jwa7MaIwwb1h3d75Ws7oAmv7y0+RgZXbAk2XN32VM7emkKoPgOx6Q5o8giPRX8mpc
 PiYojrO4B4vaeKAmsmVer/Sb5y9EoD7+D7WygJu2bDrqOm7U7vOQybzZPBLqXYxl/F5vOobC
 5rQZgudR5bI8uQM0DpYb+Pwk3bMEUZQ4t497aq2vyMLRi483eqT0eG1QBE4O8dFNYdK5XUIz
 oHhplrRgXwPBSOkMMlLKu+FJsmYVFeLAJ81sfmFuTTliRb3Fl2Q27cEr7kNKlsz/t6vLSEN2
 j8x+tWD8x53SEOSn94g2AyJA9Txh2xBhWGuZ9CpBuXjtPrnRSd8xdrw36AL53goTt/NiLHUd
 RHhSHGnKaQ6MfrTge5Q0h5A=
Subject: Re: [PATCH bpf-next v1 4/7] tools: bpftool: implement map exec
 command
Message-ID: <391274e4-7634-a1ac-5969-02403abd77ac@netronome.com>
Date:   Wed, 20 Mar 2019 19:01:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320173332.18105-4-alban@kinvolk.io>
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
> The map exec commands allows to open an existing map and pass the file
> descriptor to a child process. This enables applications to use an
> existing BPF map even when they don't support bpffs.
> 
> Example of usage:
>     # bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99
>     anon_inode:bpf-map
> 
> Documentation and bash completion updated as well.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  .../bpf/bpftool/Documentation/bpftool-map.rst | 11 ++++
>  tools/bpf/bpftool/bash-completion/bpftool     | 22 +++++++-
>  tools/bpf/bpftool/map.c                       | 53 +++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index b685641bfd74..dfd8352fa453 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> @@ -30,6 +30,7 @@ MAP COMMANDS
>  |	**bpftool** **map getnext**    *MAP* [**key** *DATA*]
>  |	**bpftool** **map delete**     *MAP*  **key** *DATA*
>  |	**bpftool** **map pin**        *MAP*  *FILE*
> +|	**bpftool** **map exec**       *MAP*  **fd** *FD* **cmd** -- *CMD*
>  |	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
>  |	**bpftool** **map peek**       *MAP*
>  |	**bpftool** **map push**       *MAP* **value** *VALUE*
> @@ -101,6 +102,10 @@ DESCRIPTION
>  		  contain a dot character ('.'), which is reserved for future
>  		  extensions of *bpffs*.
>  
> +	**bpftool map exec**     *MAP*  **fd** *FD* **cmd** -- *CMD*
> +                  Load map and exec an external command, passing the file
> +                  descriptor.
> +

Please use tabs for indent.

Could you please add a line to explain that the process spawned get the
the link to the map in the file descriptor passed as *FD*? I'm being
pedantic, I know it's not that hard to understand with the examples,
just trying to make things as clear as possible for users reading the page.

I have nothing against the double dash in the examples or the commit
log, but putting it in the description in the command itself makes it
look like it is some kind of mandatory syntax. Would you consider
removing the occurrences above?

We don't really "exec" the map... Just thinking... Would another keyword
like "pass" or "passfd" be more relevant?

>  	**bpftool** **map event_pipe** *MAP* [**cpu** *N* **index** *M*]
>  		  Read events from a BPF_MAP_TYPE_PERF_EVENT_ARRAY map.
>  
> @@ -254,6 +259,12 @@ would be lost as soon as bpftool exits).
>    key: 00 00 00 00  value: 22 02 00 00
>    Found 1 element
>  
> +**# bpftool map exec pinned /sys/fs/bpf/foo fd 99 cmd -- readlink /proc/self/fd/99**
> +
> +::
> +
> +  anon_inode:bpf-map
> +
>  SEE ALSO
>  ========
>  	**bpf**\ (2),
> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
> index 9e37de8bb227..63cd53c4d3a7 100644
> --- a/tools/bpf/bpftool/bash-completion/bpftool
> +++ b/tools/bpf/bpftool/bash-completion/bpftool
> @@ -583,6 +583,26 @@ _bpftool()
>                      fi
>                      return 0
>                      ;;
> +                exec)
> +                    case $prev in
> +                        $command)
> +                            COMPREPLY=( $( compgen -W "$MAP_TYPE" -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        fd)
> +                            return 0
> +                            ;;
> +                        cmd)
> +                            COMPREPLY=( $(compgen -c -- "$cur" ) )
> +                            return 0
> +                            ;;
> +                        *)
> +                            _bpftool_once_attr 'fd'
> +                            _bpftool_once_attr 'cmd'
> +                            return 0
> +                            ;;
> +                    esac
> +                    ;;
>                  event_pipe)
>                      case $prev in
>                          $command)
> @@ -610,7 +630,7 @@ _bpftool()
>                      [[ $prev == $object ]] && \
>                          COMPREPLY=( $( compgen -W 'delete dump getnext help \
>                              lookup pin event_pipe show list update create \
> -                            peek push enqueue pop dequeue' -- \
> +                            peek push enqueue pop dequeue exec' -- \
>                              "$cur" ) )
>                      ;;
>              esac
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index a576f2a019be..768497364cee 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -883,6 +883,58 @@ static int do_update(int argc, char **argv)
>  	return err;
>  }
>  
> +static int do_exec(int argc, char **argv)
> +{
> +	struct bpf_map_info info = {};
> +	__u32 len = sizeof(info);
> +	int fd, ret;
> +	__u32 outfd = 0;

Reverse-Christmas tree.

> +
> +	if (argc < 2)
> +		usage();
> +
> +	fd = map_parse_fd_and_info(&argc, &argv, &info, &len);
> +	if (fd < 0)
> +		return -1;
> +
> +	while (argc) {
> +		if (is_prefix(*argv, "fd")) {
> +			if (parse_u32_arg(&argc, &argv, &outfd,
> +					  "out fd"))
> +				return -1;
> +		} else if (is_prefix(*argv, "cmd")){
> +			NEXT_ARG();
> +			if (!REQ_ARGS(1))
> +				return -1;
> +
> +			break;
> +		} else {
> +			p_err("unknown arg %s", *argv);
> +			return -1;
> +		}
> +	}
> +
> +	if (outfd == 0) {
> +		p_err("invalid fd");
> +		return -1;
> +	}
> +	if (*argv == NULL) {
> +		p_err("empty command");
> +		return -1;
> +	}
> +
> +

Spurious blank line.

> +	ret = dup2(fd, (int)outfd);
> +	if (ret == -1) {
> +		p_err("dup2 failed: %s", strerror(errno));
> +		return -1;
> +	}
> +
> +	execvp(argv[0], argv);
> +	p_err("execvp failed: %s", strerror(errno));
> +	return -1;
> +}
> +
>  static void print_key_value(struct bpf_map_info *info, void *key,
>  			    void *value)
>  {
> @@ -1355,6 +1407,7 @@ static const struct cmd cmds[] = {
>  	{ "enqueue",	do_update },
>  	{ "pop",	do_pop_dequeue },
>  	{ "dequeue",	do_pop_dequeue },
> +	{ "exec",	do_exec },
>  	{ 0 }
>  };
>  
> 

Please also add the new command in the interactive help (do_help()).

By the way, I like this new command a lot!
