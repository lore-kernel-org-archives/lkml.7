Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6F1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4782084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571782396;
	bh=bHp3SLo/oaTSXRWKHxzZG/j1GqQcaLZNg0xEAI6Ioq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xKrRHtlXENv67RK1CCNs6VmXWOKmMdgOHZnRdY+WVTvLVtFOUfxYeuahKD71/Vg4O
	 a81+MsVQQBSG8cJJU64+VgiRuTQu4CPbd5AC2cXkzN11Q7aKWiIz7BpKcojLekoZoD
	 5NaMozW2KUQ1llsiRZ96fWAi2zrwvq2mmBDXAVwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfJVWNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:13:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbfJVWNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:13:06 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42C52084B;
        Tue, 22 Oct 2019 22:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571782385;
        bh=bHp3SLo/oaTSXRWKHxzZG/j1GqQcaLZNg0xEAI6Ioq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asiQuavZl/Z9us2hPzXtalhx4Vbn9ncGxwhq5X7/hgZd+kMK5VS5nvoRf6/nap1o3
         JnBAf8UwVeydiV0K38EU3nAs3E9WGCEJNWlt6tBxPBEhfn64OHHSZHwponvjMaLZkC
         RQ8J70rZA0Zszu4b6V1bf44JSRjQtGi45NT5O27Y=
Date:   Tue, 22 Oct 2019 15:13:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     linfeilong <linfeilong@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts: fix memleak error in read_file
Message-Id: <20191022151305.c4af5c45ee7c605b4b12ae32@linux-foundation.org>
In-Reply-To: <bf5c73b4b8534189be0f0df81fe863f0@huawei.com>
References: <bf5c73b4b8534189be0f0df81fe863f0@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2019 11:47:59 +0000 linfeilong <linfeilong@huawei.com> wrote:

> An error is found by the static code analysis tool: "memleak"
> Fix this by add free before return.
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> ---
>  scripts/insert-sys-cert.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
> index 8902836..22d99a8 100644
> --- a/scripts/insert-sys-cert.c
> +++ b/scripts/insert-sys-cert.c
> @@ -250,6 +250,7 @@ static char *read_file(char *file_name, int *size)
>  	}
>  	if (read(fd, buf, *size) != *size) {
>  		perror("File read failed");
> +		free(buf);
>  		close(fd);
>  		return NULL;
>  	}

A few lines later we do

	return buf;

so the patch adds a use-after-free error.

We could do a free(cert) down in main() or we could just do nothing -
read_file() is only called a single time.

