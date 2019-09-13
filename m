Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5741CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D23C21479
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCdFJVPR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730663AbfIMQrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:47:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44814 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfIMQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:47:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id k1so13481326pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O2GrZSCWrGyTvU5B/RJG4lzDoBeHKSl0cnXPuD6j5Ww=;
        b=dCdFJVPRnuKvPqm7/HrWrh/QdrJEjpQdMC+Ed9rsYxbh1kRzr6HsOSKreT8+Ty7Kyd
         RyfTnUmDPzP9+l8/sY24MhB8uUdQW+O50kVmcIlkQhKQd6YDTBVOfuLGLM1sAdXfBukL
         hprMlbZn+Ao+TkhwaL76RvOuZ9BCK5vQYU4wb8kwWOJf6Z+e8WbvxZpCM/pSd7HkyrOf
         H1TTfCsP23M4iEG3lWUn1MTUVVzhEOb14M2i2J4E4p7AbEQRZ68jvm/updzs84fynH1d
         mlrKxPx+2/aABifiY35WaMi8roQQwNp1/wVZFOXhy+31c5AXlJN0v13H6nlDPVLDvQa3
         +Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O2GrZSCWrGyTvU5B/RJG4lzDoBeHKSl0cnXPuD6j5Ww=;
        b=sYVJ5j+EgN/lgicLJzz043UE9s4Fzf6Dxbgi0Md1eSzQVSLeZ7G1hb4n3ZLmZXjNPb
         S9Q0mkXIXloGPlBldzsdyXPBUZ3Zq8q3BkdgJuM+ZhzzaSRbtJ52NgYFMkS4v7aJJP6U
         Xp3UIsANlWeGribGG8RLybIkJCAw2krVVF4gkSQivAimyqMNYZtqhxWEB3g//xgvPJeN
         5lMGQiIudRPFLYLHI8cFH9nFqTyH6H+MrWJa7whVoclI+bSEkMLOwtQf0q0ICjBDuf7P
         TJYBEwuTsclty/oexVLflplc2FYyJL+x3Jd3IQUwRrki0QltSZbDIVj0DRneJtZ46fk6
         5yRQ==
X-Gm-Message-State: APjAAAVpzd6c1ccnuuzF21VKagfBt/VygY1Cig2DOtjg+W/sQHDBYNQY
        wVFaTRGhnq/2EXIV+Oc9N0PFzA==
X-Google-Smtp-Source: APXvYqzCT2ZHq1pz5aqPi5tYLzQFiM+ozl2W/CkKQWfKF1qwLfAt7FbJn2Pxm8l9A/GMmyWGXxj2gQ==
X-Received: by 2002:a17:902:581:: with SMTP id f1mr49614453plf.246.1568393261984;
        Fri, 13 Sep 2019 09:47:41 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id j126sm25738962pfb.186.2019.09.13.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 09:47:41 -0700 (PDT)
Date:   Fri, 13 Sep 2019 09:47:36 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-i2c@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au, robh+dt@kernel.org,
        mark.rutland@arm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] i2c: Aspeed: Add AST2600 compatible
Message-ID: <20190913164736.GA52781@google.com>
References: <1568392510-866-1-git-send-email-eajames@linux.ibm.com>
 <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568392510-866-2-git-send-email-eajames@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 11:35:09AM -0500, Eddie James wrote:
> The driver default behavior works with the AST2600. We need a new
> compatible though to make sure the driver doesn't enable AST2400 or
> AST2500 behavior.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
