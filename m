Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6729C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB50A213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B5LNUENa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="d00eRd8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbfDFTGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 15:06:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFTGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 15:06:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 60CA36079C; Sat,  6 Apr 2019 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577608;
        bh=mtVERRMRXHZTuyi1ugtO4a1Mz95n6PAZeQCvJIUgZKI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=B5LNUENaCwin5oK/HNpM4SX5gezXqacNTThUXzpvEr/jTQPahtwGZqN+b7X4cnV8f
         M2D6TDNmQydX4xhBrWJPswD6lQYO7cDqXEd9yQBz9HXr6+b/6N3jKfU3ANqSWrt4e+
         KA1pc66KN5/UWpZjI1Gj2a9BEF6alvUtqj2XxYg8=
Received: from [10.79.171.6] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 599276049C;
        Sat,  6 Apr 2019 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554577607;
        bh=mtVERRMRXHZTuyi1ugtO4a1Mz95n6PAZeQCvJIUgZKI=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=d00eRd8qdwJoQ7FU90Q6yhZjr8OzlJHydgx0HLMoU3v19ykzHc3ATTOYQf5X9+/BO
         CgVothd7rOxndjHR1huKWoxTaxpXrMF7F74zvGSB5OmVKAaN8wAfSYv6tvZY5PT56E
         JcS0QOrOnUPDuP4M0b9T4uHbimbdYOv5cQSKeSqA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 599276049C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] f2fs: data: fix warning Using plain integer as NULL
 pointer
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20190406105936.GA30585@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <22201e87-47ed-d660-ca15-33567daab355@codeaurora.org>
Date:   Sun, 7 Apr 2019 00:36:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190406105936.GA30585@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2019 4:29 PM, Hariprasad Kelam wrote:
> changed passing function argument "0 to NULL" to fix below sparse
> warning
>
> fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   fs/f2fs/data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 97279441..15a2381 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
>   
>   void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
>   {
> -	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
> +	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
>   }
>   
>   void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
