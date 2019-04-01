Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C3FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A87206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfDAVeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:34:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:42590 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDAVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:34:09 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hB4Z7-0005Ex-2e; Mon, 01 Apr 2019 23:34:01 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hB4Z6-0004Wj-Sw; Mon, 01 Apr 2019 23:34:00 +0200
Subject: Re: [PATCH] bpf: do not start from first bucket if elem is not found
 on a htab
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
Cc:     =?UTF-8?Q?Maciej_=c5=bbenczykowski?= <maze@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20190331064129.31702-1-brianvv.kernel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <74e3024f-6fde-a04d-4000-89c6e61acc26@iogearbox.net>
Date:   Mon, 1 Apr 2019 23:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190331064129.31702-1-brianvv.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25406/Mon Apr  1 09:55:53 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/2019 08:41 AM, Brian Vazquez wrote:
> From: Brian Vazquez <brianvv@google.com>
> 
> When you want to traverse an entire map using BPF_MAP_GET_NEXT_KEY and
> key provided is not present due to a deletion you will start iterating the
> map from the beginning without noticing it. This patch changes the
> starting bucket in those situations to the bucket where key was
> suppossed to be.
> 
> Note that you can still get stuck in the same bucket but it is less
> likely than getting stuck in a loop restarting from the beginning of
> the entire map.
> 
> Signed-off-by: Brian Vazquez <brianvv@google.com>
> Signed-off-by: Maciej Żenczykowski <maze@google.com>

This breaks BPF selftest suite unfortunately:

# ./test_maps
test_maps: test_maps.c:114: test_hashmap: Assertion `bpf_map_get_next_key(fd, &key, &next_key) == 0 && (next_key == first_key)' failed.
Aborted

Some more background, situation is a bit tricky: pre 8fe45924387b ("bpf:
map_get_next_key to return first key on NULL") there was no reliable way
of getting to the start of a hash table, meaning it needed an 'invalid'
key to return the first element for starting traversal which commit fixed
by being able to pass in NULL. So some applications might still just rely
on e.g. key of zero bytes (if guaranteed to not be used otherwise) to do
just that. With this patch, we'd start out from anywhere in the hash table.

> ---
>  kernel/bpf/hashtab.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index fed15cf94dca6..eea046d269f51 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -611,11 +611,14 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  
>  	hash = htab_map_hash(key, key_size, htab->hashrnd);
>  
> -	head = select_bucket(htab, hash);
> +	/* keep track of current bucket */
> +	i = hash & (htab->n_buckets - 1);
> +	head = select_bucket(htab, i);
>  
>  	/* lookup the key */
>  	l = lookup_nulls_elem_raw(head, hash, key, key_size, htab->n_buckets);
>  
> +	/* this will start looking from bucket i */
>  	if (!l)
>  		goto find_first_elem;
>  
> @@ -630,7 +633,6 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
>  	}
>  
>  	/* no more elements in this hash list, go to the next bucket */
> -	i = hash & (htab->n_buckets - 1);
>  	i++;
>  
>  find_first_elem:
> 

