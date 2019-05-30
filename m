Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3A5C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8591F2534A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 19:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eopZwE0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE3T5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 15:57:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34504 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfE3T5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 15:57:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id e19so6544037wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8rg6/1s22IasR8MpGP1L9RT9i2KZBo0tX8JqXh8qlGQ=;
        b=eopZwE0yythzbMbJqacLiOxH//35NmzjHLLVpu9vPdc/ZxMPWQLRpgfpoXXR0ZUlpi
         a10GeO9RXzf9IXhAFNyz3QgQ5yKW5SqTZs7fGJss2Chjiz1uLvUW4/uLXd/pf7+1CVv2
         nzHG2LwgfoBj43dNR+JcRSUoB6h6M/PUBJm5+APilc4HYFvpYiPHmc421pRZRDPyQM1a
         L/j1lHBZbgeIBuqNvOVyQ4rebZO/QZL2RUzYft1drJXcub2MxvtmgT8MoBmu/q8SLSki
         jRdJ4ZBJx+Cx1QXU/B5PlYPn85/W3XBlO2aEGQUcH9NWC0GIDxN2M++YF/6GawByemi0
         WGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8rg6/1s22IasR8MpGP1L9RT9i2KZBo0tX8JqXh8qlGQ=;
        b=BndHidntYQ6zd9Q5fkfRcoNR8Y+ZGF5re7lCo9ZroTOCKL7LbSlXikf9PIz22HXhEV
         emkOtRKq4HEUVyWq74UwzYVi0GUDCDEUN06UzHlVPXJolVKXSobPFsFFDY/Gb0uKyfp4
         7UcWbnNVaI7anMVRVRPVT1d9V1OkGvZgTC4nGUb4FrqDXPAYc9AdJV9jeSzBsfUqKRAC
         /T+ovxI/Echl6OtcVOBLJmsXLAax6lTneKB4BYKiBCjshzmbrU+D/ZjlE12Cy9iopSyl
         RW3ax4QV66StCZruw5/z4lbA2xjHYsornwJlyXwquUuYnguICtaFFiDWknXmvBMzGGn+
         vf2g==
X-Gm-Message-State: APjAAAWwvlozIs3LV7GHlkthtpcpfG2+KpSzeFRUTbHbtvwe5V56aMlO
        N7ZPGmxt+SoWN7TASVqKU5KR0rU=
X-Google-Smtp-Source: APXvYqx0UwAbLY0LgMyHPk+nbu3kenTTnNr+QOo1aASwdnd5xxEWB5YCCf/BOuRGb+GGribu/qxcOA==
X-Received: by 2002:a1c:4083:: with SMTP id n125mr3178377wma.54.1559246247835;
        Thu, 30 May 2019 12:57:27 -0700 (PDT)
Received: from avx2 ([46.53.254.27])
        by smtp.gmail.com with ESMTPSA id l18sm8143753wrh.54.2019.05.30.12.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 12:57:27 -0700 (PDT)
Date:   Thu, 30 May 2019 22:57:25 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] add typeof_member() macro
Message-ID: <20190530195724.GA2870@avx2>
References: <20190529190720.GA5703@avx2>
 <a32bb1376821422fa3c647c01f3f1a95@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a32bb1376821422fa3c647c01f3f1a95@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 11:37:42AM +0000, David Laight wrote:
> From: Alexey Dobriyan

> > +#define typeof_member(T, m)	typeof(((T*)0)->m)
> 
> Should probably be 't' (not 'T') and upper case ?

T comes from C++ where they uppercase types in template arguments.
It makes sense as types stand out sligthly around lowercase identifiers.

> Hmmm.... the #define is longer that what it expands to ...

It hides cast of 0 which is implementation detail :^)

Proper syntax would be

	typeof(struct foo::bar)

but one can only dream.
