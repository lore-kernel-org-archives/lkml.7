Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71707C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445B12414F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 20:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oH0bC4Ol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfE2UbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 16:31:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43144 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2UbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 16:31:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id l17so2647653wrm.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 13:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ttIdJb2/xAoFjaZO6dpOAHdFkGeYHu8nTf6vxbbMess=;
        b=oH0bC4Ol8n3DaC+f4ThJAywHSbj0SagL/oI/XOn9fjd41M18tGr8IYotUf8BP80F/c
         At9Ax8xRmnXNqw1XVfshHPbgWuxXa6VSB0Rp6Ep+Ltn4mPWnHbYKDzFkyOFC/WfU5eql
         /OeBIXHnjsm2EmkHhknePLOtzpQaDdGzeyXFMKcmayFkUWYKYnJl+cbCfDUkoit+50+k
         IxXgssLZHmVIqwFL4lBUnQhHTMCd9XwY4YjO41Pbmaj4UaXO4ElFZS8msW0Lgk99ymUj
         ijiunur9cX9bXeOAIYeKZl6ecIVcAN3RQpT4h0xKRrAKxM6h3gqWv7W8v+I6JZ/wsXPM
         64Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ttIdJb2/xAoFjaZO6dpOAHdFkGeYHu8nTf6vxbbMess=;
        b=aMbuuOBhpG5NXPPEtATgK5yeH6BIGEPRtxRtgNkPfkaAQgltjZffcYfKf+KXPIUA2N
         t2eu3oBhPsSVl28pFoPlw/NDDmebKF5wuDancbVPiLXWm7qfGA1FhKfbrCF6psEjedCY
         TfmMOgT6F6spbSqJa7sPjL3ZAYdjydV/TVyg8z9CBpnFtYDRAa1pnyB938MSbB6Q2NyF
         9QAuuz3aV63ALrxgb/OMorlN0Hbg6VbB6q74sTJkSp03BV4XIceJMxFvvtO6axt/5RWw
         a3RogO7hk4dIQhBUEoxAD217vocinrV/zXVxycDPeWsfE/3pk6pJ8jjP3G1g94ww7U08
         24Iw==
X-Gm-Message-State: APjAAAVLz7Id6I2kz3euMyi6yX7Ng+BeHHWZVxlnP8I017ZyAeU6fvqm
        RacXICGo+chyYdsLMt1OVlgookg=
X-Google-Smtp-Source: APXvYqzOeSzMQ/BPO54V2vMB3rBjuBAKXqH2CPGQM6d3YkqIfwqrs2mt9CyhmM84Jmbrc0PrB+SzmA==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr4972449wrr.324.1559161868869;
        Wed, 29 May 2019 13:31:08 -0700 (PDT)
Received: from avx2 ([46.53.251.224])
        by smtp.gmail.com with ESMTPSA id p13sm321108wmb.23.2019.05.29.13.31.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 13:31:08 -0700 (PDT)
Date:   Wed, 29 May 2019 23:31:06 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dianzhangchen0@gmail.com
Cc:     linux-kernel@vger.kernel.org, mhocko@kernel.org,
        willy@infradead.org
Subject: Re: [PATCH] mm/slab_common.c: fix possible spectre-v1 in
 kmalloc_slab()
Message-ID: <20190529203106.GA26268@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it makes more sense to sanitize size in size_index_elem(),
> don't you?

> -	return (bytes - 1) / 8;
> +	return array_index_nospec((bytes - 1) / 8, ARRAY_SIZE(size_index));

I think it should be fixed in poll.
Literally every small variable kmalloc call is going through this function.
