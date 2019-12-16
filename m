Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB63C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C99206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576502907;
	bh=en62J9Sle+YYjeP96DqQn4yayB6lPx6YOVyC3LY1Kis=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=wqV9RYp5e8+NO050sYfSPnR00Ls/XjJO3mLWfDOyIyjiVGksO3LNwqcwjwk/ej79S
	 /Qc5vKlUP/XG7arF6M9iWEi7rGOiECLarz+7CDDlnlpjVQNva6z/IUckOzBDLGu6sA
	 W89dEB7/Fb4iGdUYc1ZcLoyxB/D/DDAUZ83GUkWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfLPN20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:28:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbfLPN20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:28:26 -0500
Received: from [192.168.0.114] (unknown [58.212.132.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3C0206CB;
        Mon, 16 Dec 2019 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576502905;
        bh=en62J9Sle+YYjeP96DqQn4yayB6lPx6YOVyC3LY1Kis=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=dbGzyJj4vH71sNkYyLTdAqtPy1ugCsqngU/6RSks1Og8gfuhSodwPMPwzEwhunxwl
         FIlvIXutM7Pca1Vn7QSzPyR3RrEXn4vBEOCBraj/GbxH2hjDROvOF6VqDVuFDoChqQ
         E4YdEa6hbIMxg6jYKvelWonDkjDPiL7aL4CVpALc=
Subject: Re: [RFC PATCH v5] f2fs: support data compression
To:     Markus Elfring <Markus.Elfring@web.de>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191216062806.112361-1-yuchao0@huawei.com>
 <0ab8c593-d043-cdf6-7805-f7bceba8e519@web.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
Message-ID: <0677a4fd-62a5-ad98-fd02-ae7d5a9cb501@kernel.org>
Date:   Mon, 16 Dec 2019 21:28:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <0ab8c593-d043-cdf6-7805-f7bceba8e519@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-16 19:51, Markus Elfring wrote:
> …
>> +++ b/fs/f2fs/f2fs.h
> …
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
>> +bool f2fs_is_compressed_page(struct page *page);
> …
>
> Can the following adjustment make sense?
>
> +bool f2fs_is_compressed_page(const struct page *page);
>
>
> Would you like to improve const-correctness at any more source code places?

I can't figure out a good reason to do that for f2fs internal functions...

Thanks,

>
> Regards,
> Markus
>
