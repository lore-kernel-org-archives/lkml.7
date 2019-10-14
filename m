Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E84ECE58E
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF077206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YJQ3hBah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfJNTzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:55:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37738 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfJNTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:55:37 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so40656855iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LaNvdM3Y+Nw3RPtMWnQ04czEbDLgyS6QZf5OCO/8gV0=;
        b=YJQ3hBahej4pFygAujA3K8OBfhAJjvxDnaz63qJGGNmVtDIQE8Zv86CSI3jqtOzJqh
         oxpy4lCvn3y2JqeSr9KInv2+gAjnrBg6DCNd3lzJTNpft1gCzuuXsEptPm5CzT2gIWEu
         jzdOkr16K9/eKdM/aD5an4ADdWze5L2nxAhb09igiKUjFNuOToUDht4owHv5IQpkHB0r
         PfHrMD229Kra2aSuJfIcC7GXx3fgHBISsGi5g4+Q8Pn8DiUxzfKC2QTHgP05XOGh19Z0
         jk6M/G91enAzrK21qHP2om02q/FbWw1T3iMOb4JvXqhu4Ts0zl5thKzXhYBnh+oC/Byy
         BEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LaNvdM3Y+Nw3RPtMWnQ04czEbDLgyS6QZf5OCO/8gV0=;
        b=R8ZVHY/rW5uHj+5rOUpn3vLX6VDxOevjYhRahn/oHa+icGaA2KIUaVqhboJeIAKEan
         /gomd2wOQNkK+yUeIiPh9jNgimMuyqysSJ+sMTnI+5eN5ak9k0Fj93DzxYrm6IwwUWJQ
         WrZv1m1m9xglV7ZA3tf3guwB9E31VofYRWg2S86/zvn0JMlGAZ9GQ7+mY2dpeFv8+19q
         v7+Y2czOV4mwrERe0PWXgdIMKI25ue0dNWnk2oBmEa66mDGe1MCtPfveTbkfB/576OPx
         IVw6ilxlSGuHreFmUEHcF2oaKwUKmpOh4nplayGdrvJMdK7rz3q+RKm+3Uu6CHNgueM/
         WYXQ==
X-Gm-Message-State: APjAAAUUWjPUM2XXOleMtUu3COH+5lBCFVTzg8mnhyUTJ6d6lbz8c9n3
        MOEd9RUSsGEi6CW5v6eSjoifRcnFd9AFOg==
X-Google-Smtp-Source: APXvYqyXVrhJoNgzIF1tvzUcbIMMAp/kG7NHlHTwH+XJPxrJqUADoMHGCM66RfqiI1KD4CTsMeo1vg==
X-Received: by 2002:a92:7702:: with SMTP id s2mr2260931ilc.248.1571082935767;
        Mon, 14 Oct 2019 12:55:35 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y5sm14904809iol.75.2019.10.14.12.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2019 12:55:34 -0700 (PDT)
Subject: Re: [PATCH block/for-linus] blkcg: Fix ->pd_alloc_fn() being called
 with the wrong blkcg on policy activation
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, newella@fb.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20191014185027.GH18794@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ee958749-62af-2393-d1e5-5bc4fc3eb146@kernel.dk>
Date:   Mon, 14 Oct 2019 13:55:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014185027.GH18794@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/19 12:50 PM, Tejun Heo wrote:
> cf09a8ee19ad ("blkcg: pass @q and @blkcg into
> blkcg_pol_alloc_pd_fn()") added @blkcg to ->pd_alloc_fn(); however,
> blkcg_activate_policy() ends up using pd's allocated for the root
> blkcg for all preallocations, so ->pd_init_fn() for non-root blkcgs
> can be passed in pd's which are allocated for the root blkcg.
> 
> For blk-iocost, this means that ->pd_init_fn() can write beyond the
> end of the allocated object as it determines the length of the flex
> array at the end based on the blkcg's nesting level.

Applied, thanks.

-- 
Jens Axboe

