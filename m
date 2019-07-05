Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A884C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44491218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="lv30PSIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfGEIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:24:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33139 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfGEIYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:24:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so5792228lfe.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2019 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9FLSzJ96T/u9vNlRMaRjTA0JNSLf0kIkghtMhBwyp9U=;
        b=lv30PSIq9pW5vgIcjCH4iIU4BZBPHLBgKjqfgeFMmewbZ2luPi2ZZ19NeiI30AvKsF
         tI0xsp6C49tdZhDUj2L284wYugBfJsBUboRnL48ny5bmEVYxpc4v2I7UoXydXnzWep5Z
         rctEB73EmbXa+4nsEDuOETE7Tmr/cRNUZ/22BQ1rIQw76EHFBQu/jFS8IdgQHqTXSD6R
         9UV1/cxwJ9uRyni/jSVXqsLrs0ntF7hgVj8Q26cDf/I/eIKOX4g2xk8hwNJMFNS9DU5T
         TcH0IoT/YuXxrZSHn8xXRK8Oj3vUJta32gJsHlN41ylY6hvgF14UrlzQJydlDE3KEZQN
         9iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9FLSzJ96T/u9vNlRMaRjTA0JNSLf0kIkghtMhBwyp9U=;
        b=BvG+rxNs7L3MzrlqtIC649AOJ1+tR0spVidUJLq8pt8I5Ug+mPLtMl/wKS+q6XLW9J
         co9eK8AyDIK/gSnn50wxR/pPduY152rB1j2ATLxy8qUyoIp4k4KEg+v4Jjdr6ivfakVV
         Jg+27YuN4GrUlzDqfJER6vSUuYu9bf8y438gc/vRO12e6h8J6bEOG4RDMsN8JiPB41ii
         0hhyeaXB21MocR3MpnPOM91WTNiLRGMvfB7wHFnfMKGr0MQFN9Qsibf8li764jxQVxPC
         tZrN+myWvUsWwg3HzPTyIKc0ivZhbN4Eww+ez3iE280pOdXlmI2YcnnE1VNA8b0Xezhz
         lEug==
X-Gm-Message-State: APjAAAXZJtfgp/8/fLTP63H0/7GonWQ4F0U8ws2AjhKrgOiSrZBIv6Y2
        NXik5SQ8IRmDJLzxGhXcZpff4x8pwBizUA==
X-Google-Smtp-Source: APXvYqxQhgzeDSHDGmuSiLnwG+1ig4OZXNqprv4IyRpQeKXZebY0s3QjP/9/qJmA0GStJqJYfa/89A==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr1382863lfl.9.1562315093495;
        Fri, 05 Jul 2019 01:24:53 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4432:513d:ecce:ffd3:f4fa:ae62? ([2a00:1fa0:4432:513d:ecce:ffd3:f4fa:ae62])
        by smtp.gmail.com with ESMTPSA id m28sm1624828ljb.68.2019.07.05.01.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 01:24:52 -0700 (PDT)
Subject: Re: [PATCH][next] ubifs: remove redundant assignment to pointer fname
To:     Colin King <colin.king@canonical.com>,
        Richard Weinberger <richard@nod.at>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704222803.4328-1-colin.king@canonical.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b5e7709b-3494-d415-b36c-b19939a15fb5@cogentembedded.com>
Date:   Fri, 5 Jul 2019 11:24:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190704222803.4328-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 05.07.2019 1:28, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer fname rc is being assigned with a value that is never

    rc?

> read because the function returns after the assignment. The assignment
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   fs/ubifs/debug.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index 92fe5c5ed78a..95da71e13fc8 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -2817,7 +2817,6 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
>   		     c->vi.ubi_num, c->vi.vol_id);
>   	if (n == UBIFS_DFS_DIR_LEN) {
>   		/* The array size is too small */
> -		fname = UBIFS_DFS_DIR_NAME;
>   		return;
>   	}
>   

MBR, Sergei

