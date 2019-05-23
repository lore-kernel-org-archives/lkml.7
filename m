Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413E0C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADC7206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 22:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="preTyOss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388593AbfEWWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 18:52:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37986 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387828AbfEWWwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 18:52:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so3887347pgl.5;
        Thu, 23 May 2019 15:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAZnY+0LFgj/iKqytMwo1QLvtcxOKw/oO9ryoDiYASE=;
        b=preTyOss4SNUd0H4OIaYn+isZig+YYtentrrBt6GxpkqTPRSjgKmj0RP17ZTM9wOGt
         nR/rlnjStv1YuxR2hGbF+x7D/cbl3Xbp6oyctgjejTqf9/tkL1TnNlpYvNQ9+WhyZtJi
         M0V3lmJ6XwEwgbiLfoHkldNdo+aTXhNxPoDDKexGp9JNp0PydIkffVym8+MiOMsr6hxC
         Zy6mEgNoKwpZlBYNLLK/0J75omgdzZbVgks51tjmSas6nZh+RVFhQo1FB4Ny+pM7gqOK
         wS4zKNOi0whK5pGLMy0Nm7TU5SMzDaNk+WsTMjOpIO2Mw9QaVhSTDKTVLsC7n4XnZfU5
         GuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAZnY+0LFgj/iKqytMwo1QLvtcxOKw/oO9ryoDiYASE=;
        b=o2PSH8uyQXquI21fcp/ACXFBPtklADLZSwQM8ds/5MqYT7p7QOBpC/9kRjVqhQ0GXs
         BivVzoqaco+QS++m035Qa14HCldM5tCuPa/6y2QLY6TeQNh4jn2ONeyhq9zhf/VwWkO6
         tLVvxLQ4UxW6pvy9nikvbQgejZvl1GAU9NELAa5V22pT/+bV6A8LRAuOBis0ZlgpI9sP
         Ff3dfd6lQO/3MVAWE15bxilMoPPyyNJpkR0bmqpUzkebIC6Z8sC20YMfJYyF2yRW1Wrh
         xIhwDo35gkA2Y3ay8g7mZD+Xnpr4bdmQg4jDZW1qMakAJ+ZCdYHNKI3Bm/e0UhNTZziz
         UYxQ==
X-Gm-Message-State: APjAAAVIjjYKc94D0hdLepOmbBoLQuhQiRtE+Q5rzL12VML7lPuPwLPg
        kw47+lxqyHqdoJeXJB+otpY=
X-Google-Smtp-Source: APXvYqwLsNzjcy0tLHdUwgmahCsGbFP1SOg2hB8cwA09vKDkk83oY55pXcTJ5cBo9k4OBgo67iE/+w==
X-Received: by 2002:a65:494a:: with SMTP id q10mr6717742pgs.201.1558651953823;
        Thu, 23 May 2019 15:52:33 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id h14sm366626pgj.8.2019.05.23.15.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 15:52:33 -0700 (PDT)
Date:   Thu, 23 May 2019 15:52:31 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabien Parent <fparent@baylibre.com>
Subject: Re: linux-next: build failure after merge of the input-current tree
Message-ID: <20190523225231.GD176265@dtor-ws>
References: <20190524082446.7d5bc21c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524082446.7d5bc21c@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 08:24:46AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the input-current tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/input/keyboard/mtk-pmic-keys.c:21:10: fatal error: linux/mfd/mt6392/registers.h: No such file or directory
>  #include <linux/mfd/mt6392/registers.h>
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>   78094276ca6a ("Input: mtk-pmic-keys - add support for MT6392")
> 
> I have reverted that commit for today.

Sorry about that, I dropped the patch from the tree.

Thanks.

-- 
Dmitry
