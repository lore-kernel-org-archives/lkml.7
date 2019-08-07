Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B47C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D8A21BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glORLVbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfHGMfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:35:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40553 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfHGMfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:35:34 -0400
Received: by mail-ot1-f65.google.com with SMTP id l15so46305408oth.7;
        Wed, 07 Aug 2019 05:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JZuZZafG9InRZg3sJah2SsLACCwnR/QLsffrqIQ7qL0=;
        b=glORLVbYNymQGAs3xP0KTC+NCDkOT1lxa/Tg/4OpDl26lLqhmoSdG5rG9V3OEQyxNa
         yXFnPuNy6AWAL46d+3oqCPuOBdI1amlFJG9rC5FJqOPneFt+kpvM5h7aHqkjGXeh4WDu
         9dDatCOn8xre84uStfHjyPOuxaDyPHkauwGc27TwGbdXuH5LXG9hlfxv/5NCGfMLNtIX
         cUIJj3BIVzo0goNUabxInYbqPN/ryf7PYKVD//RNAGKHHwZJDEDxc50yxUg3SfXYFM2t
         FlcA6x5rx9AY1sXvW958b3lAN39XIQVACJ0K+kA1njsgVCDXYscYZDx5agcpILlW+WY2
         T30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JZuZZafG9InRZg3sJah2SsLACCwnR/QLsffrqIQ7qL0=;
        b=OKSqIM3PNGPW5wympclP+S+e3FhH4kLTrXOomKomWokMuqOaKHEQkRqEMcfqZwXnfI
         4WQQiR/yE/U3ry6JoZGXw0modh6gyc48GNblHdznsI/16ppx6BkGfcNRJ5arQHfzMqjp
         dfzcZuicAP5Y2EgP4x1DhTFhuz8Vkz/EWkKwF+HU4v3+ksbKqayDfwJbLpz41RGXZybX
         JeyvRusSOn57GrQURquxd3xpgZhrQg3VylzcgUOe9M9IW2/UZiPC2ltc2Yjn/J/LO9MV
         Ra+GT9rZvpuKO9LSRtiWzvZOhjlGHxJuZPTjNiWh/oZOPJphuJvdxOfg33/PtuP1cGHd
         TH/Q==
X-Gm-Message-State: APjAAAWXJ9GeORiAXOchugKT1ICGt3F/krPRc+NeEyZ1/DZRsNJeDYcG
        Dj8IOyVKHQzGg9DDn4Wudt/StqhR
X-Google-Smtp-Source: APXvYqwP1RK8Zqg9ji5PjaAzKucKfNeMU+zgSW+ITvubMhN8EPG91EFKUnjM4+9DDCkInCzknGuqoQ==
X-Received: by 2002:a05:6830:11d4:: with SMTP id v20mr7171768otq.121.1565181333422;
        Wed, 07 Aug 2019 05:35:33 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([205.204.117.7])
        by smtp.gmail.com with ESMTPSA id m21sm28662136otl.70.2019.08.07.05.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 05:35:32 -0700 (PDT)
Subject: Re: [PATCH][ocfs2-next] ocfs2: ensure ret is set to zero before
 returning
To:     Colin King <colin.king@canonical.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190807121929.28918-1-colin.king@canonical.com>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <fb3d7441-93ea-b619-52fc-00da950c9201@gmail.com>
Date:   Wed, 7 Aug 2019 20:35:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190807121929.28918-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/8/7 20:19, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> A previous commit introduced a regression where variable ret was
> originally being set from the return from a call to function
> dlm_create_debugfs_subroot and this set was removed. Currently
> ret is now uninitialized if no alloction errors are found which
> may end up with a bogus check on ret < 0 on the 'leave:' return
> path.  Fix this by setting ret to zero on a successful execution
> path.

Good catch.
Or shall we just initialize 'ret' at first?

> 
> Addresses-Coverity: ("Uninitialzed scalar variable")

Typo here. 

Thanks,
Joseph

> Fixes: cba322160ef0 ("ocfs2: further debugfs cleanups")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ocfs2/dlm/dlmdomain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
> index 5c4218d66dd2..ee6f459f9770 100644
> --- a/fs/ocfs2/dlm/dlmdomain.c
> +++ b/fs/ocfs2/dlm/dlmdomain.c
> @@ -2052,6 +2052,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(const char *domain,
>  	mlog(0, "context init: refcount %u\n",
>  		  kref_read(&dlm->dlm_refs));
>  
> +	ret = 0;
>  leave:
>  	if (ret < 0 && dlm) {
>  		if (dlm->master_hash)
> 
