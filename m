Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E176C3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114A8217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 00:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="tAi6KJc1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394396AbfITAVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 20:21:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36772 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbfITAVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 20:21:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so5444303qkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YTp5B1qD8E9aflcOxXO4o+LEcSQkbFxZ9MJfYS1B/aY=;
        b=tAi6KJc1ByzYT5nMutazH/kLr1utqSsJFknFvHpj54XCTbUT2K4+0UOf5BbZe7lzdx
         h3t+Xz5lVwr9REvW3R7lKKS+FiULp0arjEPvn03l9VEgBxPHuSNlxieDuQgxBu6VgRpR
         2dwZy6GgWFfQlp47xAywud/3/l3MuMAOJAkl/x4VI3te+AP3LLeCvjyecJ9dsIZN3cfd
         Up9dmNYCbP+TjBSD9UU7Tnf/3yBuqHdaFVQOAb9igELNb7BKGO7rq/JDrIu+oO3oycNR
         6/+qWVkpNdO6YFupeqXgHoDnhbIHbGlKwz7OptlNrluWVc+HyGcc07VeupgsMGehnq98
         z2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YTp5B1qD8E9aflcOxXO4o+LEcSQkbFxZ9MJfYS1B/aY=;
        b=HvXpB7XV/5YaylnkshZtqCplo3p4yPwzNB30f9gsDvdnr/75O8yq0RivA4am8xVSVR
         ZpLODjnEU0jZHaRuWAsWRMF7xKo8MneQfgyECeGKe77HoY6Y0SE9TQoLbO5z6fBJcBuJ
         d151ESTL6cijmeojVqIOQF6RKieo6xTDIPYtUntvUcvnTQEZgs7Jei5P24ARupnJ4x3o
         7sOFzpdaPNuJCvCua03sqTXi28JaMYi7CdYgc/xzWI2xuh68s/AWXYW5gylZyrtm9oYq
         GFWJH+dFU2cCrIWwfZHWh3sTpF3lDlI0aHhJBFSPnmeLg4ZDTlBxWE5/Ay9u2iO0XHOk
         9m+w==
X-Gm-Message-State: APjAAAXsZvzXgR+CSOhCc/6kzz9DrEigq4xPFaXLNqJnMNSZAZIXoJ7+
        R6KnxRyrpkUar922HLDNvEG1YQ==
X-Google-Smtp-Source: APXvYqzoVPYrXP2tRPahgitnuE7bPJdek/u+2/XsD7AKfKbgjvGvtGUxVRqbqsjBylkdRiti0acXDg==
X-Received: by 2002:a37:591:: with SMTP id 139mr590821qkf.162.1568938900968;
        Thu, 19 Sep 2019 17:21:40 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id c16sm198104qkg.131.2019.09.19.17.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 17:21:40 -0700 (PDT)
Date:   Thu, 19 Sep 2019 17:21:36 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Shannon Nelson <snelson@pensando.io>,
        Pensando Drivers <drivers@pensando.io>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ionic: Remove unnecessary ternary operator in
 ionic_debugfs_add_ident
Message-ID: <20190919172136.01f0e016@cakuba.netronome.com>
In-Reply-To: <20190917232616.125261-1-natechancellor@gmail.com>
References: <20190917232616.125261-1-natechancellor@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019 16:26:16 -0700, Nathan Chancellor wrote:
> clang warns:
> 
> ../drivers/net/ethernet/pensando/ionic/ionic_debugfs.c:60:37: warning:
> expression result unused [-Wunused-value]
>                             ionic, &identity_fops) ? 0 : -EOPNOTSUPP;
>                                                          ^~~~~~~~~~~
> 1 warning generated.
> 
> The return value of debugfs_create_file does not need to be checked [1]
> and the function returns void so get rid of the ternary operator, it is
> unnecessary.
> 
> [1]: https://lore.kernel.org/linux-mm/20150815160730.GB25186@kroah.com/
> 
> Fixes: fbfb8031533c ("ionic: Add hardware init and device commands")
> Link: https://github.com/ClangBuiltLinux/linux/issues/658
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied, thank you!
