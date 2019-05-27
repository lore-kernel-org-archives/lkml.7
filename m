Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349E1C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F121734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 07:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GY8m0hOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfE0Hi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 03:38:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35762 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfE0Hi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 03:38:56 -0400
Received: by mail-lf1-f67.google.com with SMTP id a25so1447468lfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 00:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OnF5vlOhiefqGSZXh+n1mosDCaj568K6lYr/Rle7pp0=;
        b=GY8m0hOWCVjaWJ4jZGrE65epBF6vNIz4YhB5bd4s3r+B4jyY19FANWvYo9UIujm4yq
         MOazijALm+pSFEPx/J7OliL/UFKNSPr04M9jkl0+Umm88Nu0/0XM/uct7nHQn9hq1Nhw
         TJCDnDRXA0Zk4BlEL495LXd42iBuv07b/cSeX7AsDCpmkaXEjpi08LsChMFLHG3oQdp3
         ApF3eRsNOlNfEtiOnHSyDP8GsvbLJR/0Uq1rmYGuvEx9yvj1BIf5Va3RgCq0tIEA9FnW
         VuePvLlFUpJ46LH0aCkqyD7x1wJ4eorHOgr3T+vTaAFgszCDvWlv2BI9GBfgIngG8D5q
         AXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OnF5vlOhiefqGSZXh+n1mosDCaj568K6lYr/Rle7pp0=;
        b=i7GBrf5IFWgxWyT2hogWvkeuzirV6/lbx73cix0NY5X9ZcVvNpHkFoZRTK1sd9dhm5
         cKj+6NU2xU91t8Twt/Dxh8199jwBAsGPMKyQdY7eKrfxDn1CREntQFTLuyRmeAS5CPaL
         UE4WXI2guc5EOyn3BbZ6R3ZwRplWQhUD6uQuBmRIIrGQpQk5AGQRuHDyt7UEiWzN4G3L
         6oowImQSk/AI+YuhljyyEkwfwBEXmcnb8fIli49JCivLQ0d7nBKpymoopYBUifr3ZjfK
         9zo4rFw/Dyqlz59EJJx9Pt5uZ3saRCcUYdn/paIuy7xXH70wt7ZdaR+QAlGu/eJRmYsF
         p7iQ==
X-Gm-Message-State: APjAAAUIEioVLSRQquV+dM2ZYBS1c4h2+dgH9sBdfA/2wxDDW6WgkquY
        Qi/InnTW5ZVIbmr2bNwQBvzqHxFy
X-Google-Smtp-Source: APXvYqyMW2+EDpvsHIQUPglafaUBwvOQtbxsCYfwSQ5na2dQ+Z+kmwvr2mLc1HxxvTFnCo+YbGLL2Q==
X-Received: by 2002:ac2:5a10:: with SMTP id q16mr369343lfn.49.1558942734140;
        Mon, 27 May 2019 00:38:54 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id h23sm2127908ljf.28.2019.05.27.00.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 00:38:53 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C4586460C2C; Mon, 27 May 2019 10:38:52 +0300 (MSK)
Date:   Mon, 27 May 2019 10:38:52 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Dianzhang Chen <dianzhangchen0@gmail.com>
Cc:     akpm@linux-foundation.org, kristina.martsenko@arm.com,
        ebiederm@xmission.com, j.neuschaefer@gmx.net, jannh@google.com,
        mortonm@chromium.org, yang.shi@linux.alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/sys.c: fix possible spectre-v1 in do_prlimit()
Message-ID: <20190527073852.GK11013@uranus>
References: <1558941788-969-1-git-send-email-dianzhangchen0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1558941788-969-1-git-send-email-dianzhangchen0@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 03:23:08PM +0800, Dianzhang Chen wrote:
> The `resource` in do_prlimit() is controlled by userspace via syscall: setrlimit(defined in kernel/sys.c), hence leading to a potential exploitation of the Spectre variant 1 vulnerability.
> The relevant code in do_prlimit() is as below：
> 
> if (resource >= RLIM_NLIMITS)
>         return -EINVAL;
> ...
> rlim = tsk->signal->rlim + resource;    // use resource as index
> ...
>             *old_rlim = *rlim;
> 
> Fix this by sanitizing resource before using it to index tsk->signal->rlim.
> 
> Signed-off-by: Dianzhang Chen <dianzhangchen0@gmail.com>
> ---
>  kernel/sys.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index bdbfe8d..7eba1ca 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -1532,6 +1532,8 @@ int do_prlimit(struct task_struct *tsk, unsigned int resource,
>  
>  	if (resource >= RLIM_NLIMITS)
>  		return -EINVAL;
> +
> +	resource = array_index_nospec(resource, RLIM_NLIMITS);
>  	if (new_rlim) {
>  		if (new_rlim->rlim_cur > new_rlim->rlim_max)
>  			return -EINVAL;

Could you please explain in details how array_index_nospec is different
from resource >= RLIM_NLIMITS? Since I don't get how it is related to
spectre issue.
