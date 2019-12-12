Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C95C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899902173E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="fAJUxPKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfLLKqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:46:05 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39831 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbfLLKqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:46:04 -0500
Received: by mail-lf1-f66.google.com with SMTP id y1so1323029lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jvqQ2LSPQakFyO6vrj7XjHi+q/qAmMP0jyqzyEsZ6cY=;
        b=fAJUxPKa6DO3DxY2/J9PLqhfYlg/da8eDTz/vxL8gOoD6z21vggxxcj96lO60KKOo8
         p0koKVNcaIOdBdVMeu+QAuEIAUfdTrzi0LWNyykx9hQxI6BmIDydNHVZ9K+Hr9crQIWx
         1WIQiO4PvtcQhtih196GjeyVAvG28GxF0e+IAs1xreoZlIl5BdfEzXCGZe6VRQK/3y32
         c4UBiESyQ5Yfo/pvMuzcBCOOk+TRBprA0w8q9ywu+MEc/jbeYhb9A6rcn2gyplg1R/4M
         BLzvWfsPEG+qXB5Gw7IibuCyqUslGbXLtumbv9KvBuFi0Mznx1tC+CuaPMKxZ2a7UZm8
         hJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jvqQ2LSPQakFyO6vrj7XjHi+q/qAmMP0jyqzyEsZ6cY=;
        b=RQeVkk05wQkmDwrepvDo3s/OBmcJLUYxhHrpNRXzHCGsPhVy5LNCbWdoDYOCTpPo/e
         Xj87TPEnilz3wLbycKKXSAHUT36Cl4Vq35cc1d7N4T/uSx/nGt+rcgxRByq0AaM0spkS
         0Piq5nyvSkPCkimaIZ0Rq93j+cqzDZnXACOiA0qRRs2LT4l52ep7bbmY5Fx7lrxiCFp0
         L7eedN37faMSShYN9s6pgf40uC5fYrUm8px408B2YA6cTy9bHKdEEQIstpFPazYx2c82
         qXERQa92zPSKRHXvAVG8DhE/gtBH0H9NG24bATUPg5AYLHLQH176+fcnp/QdV5qsHDH9
         Ssgw==
X-Gm-Message-State: APjAAAVMkzv/MyJRoWBo3wrA0ItrwIX+EzPbxE8X1//pcfoF0fhfWBn6
        rOXy1Im3vpBBJMdK18wnzaWbebOGq5wYgw==
X-Google-Smtp-Source: APXvYqwP+hehehn1jHv/Es8YupV7UnCXZ6dmvNhY+VQdGf477L2UvXNh73dt+c8DyKqvqavUkp3eUA==
X-Received: by 2002:a19:f519:: with SMTP id j25mr5284968lfb.41.1576147562262;
        Thu, 12 Dec 2019 02:46:02 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:2a7:d365:c8bb:a230:5f6e:8263? ([2a00:1fa0:2a7:d365:c8bb:a230:5f6e:8263])
        by smtp.gmail.com with ESMTPSA id z7sm3048827lfa.81.2019.12.12.02.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 02:46:01 -0800 (PST)
Subject: Re: [PATCH v2 20/23] staging: qlge: Fix CHECK: usleep_range is
 preferred over udelay
To:     Scott Schafer <schaferjscott@gmail.com>, gregkh@linuxfoundation.org
Cc:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <cover.1576086080.git.schaferjscott@gmail.com>
 <a3f14b13d76102cd4e536152e09517a69ddbe9f9.1576086080.git.schaferjscott@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <337af773-a1da-0c04-6180-aa3597372522@cogentembedded.com>
Date:   Thu, 12 Dec 2019 13:45:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a3f14b13d76102cd4e536152e09517a69ddbe9f9.1576086080.git.schaferjscott@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11.12.2019 21:12, Scott Schafer wrote:

> chage udelay() to usleep_range()

    Change?

> Signed-off-by: Scott Schafer <schaferjscott@gmail.com>
> ---
>   drivers/staging/qlge/qlge_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/qlge/qlge_main.c b/drivers/staging/qlge/qlge_main.c
> index e18aa335c899..9427386e4a1e 100644
> --- a/drivers/staging/qlge/qlge_main.c
> +++ b/drivers/staging/qlge/qlge_main.c
> @@ -147,7 +147,7 @@ int ql_sem_spinlock(struct ql_adapter *qdev, u32 sem_mask)
>   	do {
>   		if (!ql_sem_trylock(qdev, sem_mask))
>   			return 0;
> -		udelay(100);
> +		usleep_range(100, 200);

    I hope you're not in atomic context...

>   	} while (--wait_count);
>   	return -ETIMEDOUT;
>   }

MBR, Sergei
