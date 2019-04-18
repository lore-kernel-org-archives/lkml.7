Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9172DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5655B2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTDa9fm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfDRVf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:35:58 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37682 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbfDRVf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:35:57 -0400
Received: by mail-it1-f195.google.com with SMTP id u65so5604015itc.2;
        Thu, 18 Apr 2019 14:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JcQeKefnuv5DO4V/baWWP9bupE6bIYGFmFfZwag65u8=;
        b=qTDa9fm4JWztBxeTMtnbMOR+v2T1GPSxs32jxcg9ctHu/UqcwfkSDEbEG0feAVqP6K
         8qDN0uARVkPAntmDiYcmLVAFkueiwOEqTTytTFwY9vwWI/W0ReGNaHkbT69pXie4pOmK
         2nqPSXCU1/BQ3DKnCbDF50W36oK+xjXlxamYXm1YwGcgchJfuLWB85lo9kXJPT/6zMQb
         xPEnB8Bxex2hskUWs94pM4GQ54Pzubw5qDJL5hL9K9xONUvTjF/rZWV60xpbtGLc4ik2
         g7caCztlUWM0D1e8REBWLOZm/brb7TU0yG3tCDMv0BgBd6hte/5lsbP4cpfyPI647+8m
         r9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JcQeKefnuv5DO4V/baWWP9bupE6bIYGFmFfZwag65u8=;
        b=AaVTMVBf4fOOeXkIq83ns4syFhYkImY9MiTAGwWB90lpW3PlsH3Wlj64fDrxzMNnOA
         FKSMPbqDx/t2ZYXdPssItOCGd+BnZQBcl1bBhGvfv1KcsHuYEYJYQxvYZT37fs2pR18d
         6M7GQG4Ntcr6Aiynb0rYxkr1ZXrfOp3kLe5H/u74DEdxtCwbaRDTZaeaQ33toZIb24+I
         RDmCch/7gw0bs21GIXJk+rqNyQdioiF2Mnv98PuIpBk3YEURWDjOQkoLoDk30uf5geGK
         PYzoPuz8/LPHAXUYVNESUMZtOxYhz8N0riEuf61N5gAgFVxgJrupOnei8m78ebT5F0So
         RnvQ==
X-Gm-Message-State: APjAAAWtZneYFw2ptIJc/u0BzrKEExeac9K72S4SBIvTBcJqNDu5qULs
        qgKTSHLby0dCHynTj+w8gasyiUC8At/g+xJlhwrGBpQi
X-Google-Smtp-Source: APXvYqwIt5oSkxQpHqkyF2avHFEa19XSBumkQQeSmzOjR7T+auS/yl3Ghemt6N5qK1WtP+ERWrFcPYxMXehgOvVS7z4=
X-Received: by 2002:a24:1312:: with SMTP id 18mr128984itz.121.1555623355644;
 Thu, 18 Apr 2019 14:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190418155652.22181-1-alban@kinvolk.io> <20190418155652.22181-2-alban@kinvolk.io>
In-Reply-To: <20190418155652.22181-2-alban@kinvolk.io>
From:   Y Song <ys114321@gmail.com>
Date:   Thu, 18 Apr 2019 14:35:19 -0700
Message-ID: <CAH3MdRW3Ez5y6=oBnge9BT1e3OVpFNnbEe+12PNtsNvNeJUBAw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests: bpf: read netns from struct bpf_sock_ops
To:     Alban Crequy <alban.crequy@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?Q?Iago_L=C3=B3pez_Galeiras?= <iago@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 8:58 AM Alban Crequy <alban.crequy@gmail.com> wrote:
>
> From: Alban Crequy <alban@kinvolk.io>
>
> This shows how a sockops program could be restricted to a specific
> network namespace. The sockops program looks at the current netns via
> (struct bpf_sock_ops)->netns and checks if the value matches the
> configuration in the new BPF map "sock_netns".
>
> The test program ./test_sockmap accepts a new parameter "--netns"; the
> default value is the current netns found by stat() on /proc/self/ns/net,
> so the previous tests still pass:
>
> sudo ./test_sockmap
> ...
> Summary: 412 PASSED 0 FAILED
> ...
> Summary: 824 PASSED 0 FAILED
>
> I run my additional test in the following way:
>
> NETNS=$(readlink /proc/self/ns/net | sed 's/^net:\[\(.*\)\]$/\1/')
> CGR=/sys/fs/cgroup/unified/user.slice/user-1000.slice/session-5.scope/
> sudo ./test_sockmap --cgroup $CGR --netns $NETNS &
>
> cat /sys/kernel/debug/tracing/trace_pipe
>
> echo foo | nc -l 127.0.0.1 8080 &
> echo bar | nc 127.0.0.1 8080
>
> => the connection goes through the sockmap
>
> When testing with a wrong $NETNS, I get the trace_pipe log:
> > not binding connection on netns 4026531992
>
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
>
> ---
>
> Changes since v1:
> - tools/include/uapi/linux/bpf.h: update with netns_dev

Please have a separate patch for the uapi header sync
(tools/include/uapi/linux/bpf.h).

> - tools/testing/selftests/bpf/test_sockmap_kern.h: print debugs with
>   both netns_dev and netns_ino
> ---
>  tools/include/uapi/linux/bpf.h                |  2 +
>  tools/testing/selftests/bpf/test_sockmap.c    | 38 +++++++++++++++++--
>  .../testing/selftests/bpf/test_sockmap_kern.h | 22 +++++++++++
>  3 files changed, 59 insertions(+), 3 deletions(-)
>
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 704bb69514a2..eb56620a9d7a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3206,6 +3206,8 @@ struct bpf_sock_ops {
>         __u32 sk_txhash;
>         __u64 bytes_received;
>         __u64 bytes_acked;
> +       __u64 netns_dev;
> +       __u64 netns_ino;
>  };
>
>  /* Definitions for bpf_sock_ops_cb_flags */
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 3845144e2c91..5a1b9c96fca1 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -2,6 +2,7 @@
>  // Copyright (c) 2017-2018 Covalent IO, Inc. http://covalent.io
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <stdint.h>
>  #include <sys/socket.h>
>  #include <sys/ioctl.h>
>  #include <sys/select.h>
> @@ -21,6 +22,7 @@
>  #include <sys/resource.h>
>  #include <sys/types.h>
>  #include <sys/sendfile.h>
> +#include <sys/stat.h>
>
>  #include <linux/netlink.h>
>  #include <linux/socket.h>
> @@ -63,8 +65,8 @@ int s1, s2, c1, c2, p1, p2;
>  int test_cnt;
>  int passed;
>  int failed;
> -int map_fd[8];
> -struct bpf_map *maps[8];
> +int map_fd[9];
> +struct bpf_map *maps[9];
>  int prog_fd[11];
>
>  int txmsg_pass;
> @@ -84,6 +86,7 @@ int txmsg_ingress;
>  int txmsg_skb;
>  int ktls;
>  int peek_flag;
> +uint64_t netns_opt;
>
>  static const struct option long_options[] = {
>         {"help",        no_argument,            NULL, 'h' },
> @@ -111,6 +114,7 @@ static const struct option long_options[] = {
>         {"txmsg_skb", no_argument,              &txmsg_skb, 1 },
>         {"ktls", no_argument,                   &ktls, 1 },
>         {"peek", no_argument,                   &peek_flag, 1 },
> +       {"netns",       required_argument,      NULL, 'n'},
>         {0, 0, NULL, 0 }
>  };
>
> @@ -1585,6 +1589,7 @@ char *map_names[] = {
>         "sock_bytes",
>         "sock_redir_flags",
>         "sock_skb_opts",
> +       "sock_netns",
>  };
>
>  int prog_attach_type[] = {
> @@ -1619,6 +1624,8 @@ static int populate_progs(char *bpf_file)
>         struct bpf_object *obj;
>         int i = 0;
>         long err;
> +       struct stat netns_sb;
> +       uint64_t netns_ino;
>
>         obj = bpf_object__open(bpf_file);
>         err = libbpf_get_error(obj);
> @@ -1655,6 +1662,28 @@ static int populate_progs(char *bpf_file)
>                 }
>         }
>
> +       if (netns_opt == 0) {
> +               err = stat("/proc/self/ns/net", &netns_sb);
> +               if (err) {
> +                       fprintf(stderr,
> +                               "ERROR: cannot stat network namespace: %ld (%s)\n",
> +                               err, strerror(errno));
> +                       return -1;
> +               }
> +               netns_ino = netns_sb.st_ino;
> +       } else {
> +               netns_ino = netns_opt;
> +       }
> +       i = 1;
> +       err = bpf_map_update_elem(map_fd[8], &netns_ino, &i, BPF_ANY);
> +       if (err) {
> +               fprintf(stderr,
> +                       "ERROR: bpf_map_update_elem (netns):  %ld (%s)\n",
> +                       err, strerror(errno));
> +               return -1;
> +       }
> +
> +
>         return 0;
>  }
>
> @@ -1738,7 +1767,7 @@ int main(int argc, char **argv)
>         if (argc < 2)
>                 return test_suite(-1);
>
> -       while ((opt = getopt_long(argc, argv, ":dhvc:r:i:l:t:p:q:",
> +       while ((opt = getopt_long(argc, argv, ":dhvc:r:i:l:t:p:q:n:",
>                                   long_options, &longindex)) != -1) {
>                 switch (opt) {
>                 case 's':
> @@ -1805,6 +1834,9 @@ int main(int argc, char **argv)
>                                 return -1;
>                         }
>                         break;
> +               case 'n':
> +                       netns_opt = strtoull(optarg, NULL, 10);
> +                       break;
>                 case 0:
>                         break;
>                 case 'h':
> diff --git a/tools/testing/selftests/bpf/test_sockmap_kern.h b/tools/testing/selftests/bpf/test_sockmap_kern.h
> index e7639f66a941..317406dad6cf 100644
> --- a/tools/testing/selftests/bpf/test_sockmap_kern.h
> +++ b/tools/testing/selftests/bpf/test_sockmap_kern.h
> @@ -91,6 +91,13 @@ struct bpf_map_def SEC("maps") sock_skb_opts = {
>         .max_entries = 1
>  };
>
> +struct bpf_map_def SEC("maps") sock_netns = {
> +       .type = BPF_MAP_TYPE_HASH,
> +       .key_size = sizeof(__u64),
> +       .value_size = sizeof(int),
> +       .max_entries = 16
> +};
> +
>  SEC("sk_skb1")
>  int bpf_prog1(struct __sk_buff *skb)
>  {
> @@ -132,9 +139,24 @@ int bpf_sockmap(struct bpf_sock_ops *skops)
>  {
>         __u32 lport, rport;
>         int op, err = 0, index, key, ret;
> +       int i = 0;
> +       __u64 netns_dev, netns_ino;
> +       int *allowed;
>
>
>         op = (int) skops->op;
> +       netns_dev = skops->netns_dev;
> +       netns_ino = skops->netns_ino;
> +       bpf_printk("bpf_sockmap: netns_dev = %lu netns_ino = %lu\n",
> +                  netns_dev, netns_ino);
> +
> +       // Only allow sockmap connection on the configured network namespace
> +       allowed = bpf_map_lookup_elem(&sock_netns, &netns_ino);
> +       if (allowed == NULL || *allowed == 0) {
> +               bpf_printk("not binding connection on netns_ino %lu\n",
> +                          netns_ino);
> +               return 0;
> +       }
>
>         switch (op) {
>         case BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB:
> --
> 2.20.1
>
