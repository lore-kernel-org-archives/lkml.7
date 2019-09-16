Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB4C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FC020678
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568650159;
	bh=+xqkrfZQUYv9qQoMb9obJG1dhK0csNItrLmKUr0mTFw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=pwsqOJs+ZQPPyyqZ9X7lIc/Gns1wOLBsIjlcqPWDS4YhsANafEQo0fkQCLXOAE2wW
	 Ib6n9Z4WSPfeNsnZ5S+jqz2JvtvCbLRPOg+sHgVMouQxPoy86eGs1M9n+yhGsO6P8F
	 KC721xt1SgebQ8kT3jdNxXOWX6bXE09iP1Kwaa5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389646AbfIPQJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbfIPQJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 12:09:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF8A20678;
        Mon, 16 Sep 2019 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568650154;
        bh=+xqkrfZQUYv9qQoMb9obJG1dhK0csNItrLmKUr0mTFw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T4iNa/s9FMok1H5jFLps3Lu/MV9sWu+L0TZy4TtBXTdYj51qGTdJco13jsaLolcIi
         IHxYVz9zMU0Z6zeewTbSnvDwMqcfOqsPdqAv+A5Vl26BNEt9fq5UPEE1HP5U1Nsxg4
         sPk86446cbpBh1MMdlbhF/1AyLIxBP0y50aayusQ=
Subject: Re: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190916150337.18049-1-marcelo.cerri@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <212adcf8-566e-e06d-529f-f0ac18bd6a35@kernel.org>
Date:   Mon, 16 Sep 2019 10:09:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916150337.18049-1-marcelo.cerri@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/19 9:03 AM, Marcelo Henrique Cerri wrote:
> Use INT_MAX instead of AF_MAX, since libc might have a smaller value
> of AF_MAX than the kernel, what causes the test to fail.
> 
> Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> ---
>   tools/testing/selftests/net/socket.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
> index afca1ead677f..10e75ba90124 100644
> --- a/tools/testing/selftests/net/socket.c
> +++ b/tools/testing/selftests/net/socket.c
> @@ -6,6 +6,7 @@
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <netinet/in.h>
> +#include <limits.h>
>   
>   struct socket_testcase {
>   	int	domain;
> @@ -24,7 +25,10 @@ struct socket_testcase {
>   };
>   
>   static struct socket_testcase tests[] = {
> -	{ AF_MAX,  0,           0,           -EAFNOSUPPORT,    0 },
> +	/* libc might have a smaller value of AF_MAX than the kernel
> +	 * actually supports, so use INT_MAX instead.
> +	 */
> +	{ INT_MAX, 0,           0,           -EAFNOSUPPORT,    0  },
>   	{ AF_INET, SOCK_STREAM, IPPROTO_TCP, 0,                1  },
>   	{ AF_INET, SOCK_DGRAM,  IPPROTO_TCP, -EPROTONOSUPPORT, 1  },
>   	{ AF_INET, SOCK_DGRAM,  IPPROTO_UDP, 0,                1  },
> 

What failure are you seeing? It sounds arbitrary to use INT_MAX
instead of AF_MAX. I think it is important to understand the
failure first.

Please note that AF_MAX is widely used in the kernel.

thanks,
-- Shuah
