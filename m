Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE4BC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DF5206E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573680694;
	bh=xpiYEp+SikjI15PKP/7CLzXZ6mCQ39IEtDwFotwNxYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a3XZeH5but4dL2i3/fOVBc1ZRPFaAvrveMOF9barSRTqQOQv/vYvTPHUQHTtoydD+
	 bBCu6cyNTuBgwiLOyZUrzV9y6LJbHd9OhHBwUXExZ7mjgRyTiPbRVdaXaOAerZJKQg
	 zbvXMXCOzIwMA7JIXLbb7a8yAK/EOc9WMARpKHNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKMVbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:31:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33081 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMVbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:31:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so2541415pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpdKXpPcSiz6/JTbE9QNlxBQfmiP1mwEO8bUJ8zcJCg=;
        b=ugE7Om5TcoLoPYw9I10JV47y+NVwWvzrjR/ucKqlu9XrI+ZDuyQNsr5r2Eax2jtguG
         sKCSxtdn7v5eJ5VhFiDDMsWCI3ZqlQFehb1C3bj01BNBcPKbZkmYouS3+lfwZRAORcin
         uXzQsbygSwnYsHzz1Xz0BtvCOn8XPZj2hYB/adzBzfe0QvQDW3fInMVvEufKrk0BpMR6
         1Z9StsTtOFEFzp5GM5insWndT8nfjLGRex2q65yDxTFC93ZiFCLkklmSaeSPH/SB7MSN
         53IbtS4/t03g6MmyuG36/Ze5bqxvmrj6T8OROPm2zd2OuKZ+jJJZ2DgfqS8pBckFPw4O
         Rmmw==
X-Gm-Message-State: APjAAAXHxOKNPYv/y8A1EKlgyZoRQmqG9Psbz5Qnz4IiBzoQHuLPa9oY
        xoq4DtcEm2ysFyrJ8O0rSBM=
X-Google-Smtp-Source: APXvYqzh44+c2zz2ZHBa7sAGDdKClIkEYxIq7rFyH2wb3wUSXGytoH2lqXAKGiS6aq4ERLv3rNB1jQ==
X-Received: by 2002:a65:5c8b:: with SMTP id a11mr6220013pgt.60.1573680690533;
        Wed, 13 Nov 2019 13:31:30 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k13sm3520556pgl.69.2019.11.13.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:31:29 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 8F5BE403DC; Wed, 13 Nov 2019 21:31:28 +0000 (UTC)
Date:   Wed, 13 Nov 2019 21:31:28 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Tim Murray <timmurray@google.com>,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] firmware_class: make firmware caching configurable
Message-ID: <20191113213128.GZ11244@42.do-not-panic.com>
References: <20191113210124.59909-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113210124.59909-1-salyzyn@android.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 01:01:13PM -0800, Mark Salyzyn wrote:
> Because firmware caching generates uevent messages that are sent over
> a netlink socket, it can prevent suspend on many platforms.  It's
> also not always useful, so make it a configurable option.
> 
> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>

Looks good.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
