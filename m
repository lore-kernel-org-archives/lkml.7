Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A3FC2D0D0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 19:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799A220643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 19:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="f8OM+3XU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLXTgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 14:36:10 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36414 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfLXTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 14:36:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so15692354lfe.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Dec 2019 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Lme9Wyno1ygBZWQLeRNkRIxRgffFulfZDQ48FUsXuA=;
        b=f8OM+3XUqBeZKY+6zorTFgHHqvIbDxTbgy9NEbgemnUwj1/f9jJuj4G92IIfVYfVCg
         PbD8Qf2tvK/0gYEd4gaEH+WlMRL6lmknPlrPmZFtyeW8/5fMHGNBQxULMgwnDWq8xi+x
         Ixr8QzlWetXxmYXcK7ym0mhdwdc/1L8gmBpd97Iz7JiQQGe0rsAG4GzIHApC6bDLJanx
         Wb2MLrG2UX2Y4zwRypJJcnRB4/MxynyaphlnGYzpDefzcDeponubc/MHz2x1Yx8x862s
         5TcmBh+UqQ+MFP8nr5s5y85KTg5EyN3JwUscG390aqu5h83yri7LtXXsnW66Z5wrtpkf
         3D9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Lme9Wyno1ygBZWQLeRNkRIxRgffFulfZDQ48FUsXuA=;
        b=a5ZD9tsvLQ7GJM9DTm7A2XHUOcpsDqUepoQ08PaVRTwnrtQwmTMjLGT7jCR1G7JNbA
         dtdMvneySy47YNW/7vJQozlk0DrJq0vhcAieH9g20x/9M5RqZ293UdvaiolTXBRqsTHj
         iAb0f0czwzf5sBJag7TQ7Ar1k34frto9VGBN5Fc6RuZDZeMlHrzrBkiyn9Ex6yfjYbou
         J8H90CO26OJujwhTxH5LWICVs/gQ938CGFNE0uh7HKVTRUc1V8oEkamcOqRSKvKuzYya
         7VWKibDBoRtm3LMIcepFRNu2F9D7egkUkXJskeAZUTVUM1JC1HRRGbIgNvM6wbjynJCG
         2WRA==
X-Gm-Message-State: APjAAAW6phuPJQy7a4Aknk4Qa1icXrXX8+Z5MbxbfV4dL3V80SPMsd85
        zn4elA3OezzMQx+QXNu4MxV28WEyBnabNTX2bh7r
X-Google-Smtp-Source: APXvYqyyd41paNWd67q+SotBLtkizccVMdu3Hz4Ze4VEpxhr+L2hhXbp6W/Ter6cuc+8yBX4JmRQ+64Igvaadkob3xQ=
X-Received: by 2002:a19:ae04:: with SMTP id f4mr20932323lfc.64.1577216167638;
 Tue, 24 Dec 2019 11:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20191224124552.10452-1-yuehaibing@huawei.com>
In-Reply-To: <20191224124552.10452-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Dec 2019 14:35:56 -0500
Message-ID: <CAHC9VhQ17u_44L+oKVBu6ThatY4TmYa_hTL8JjGsmV=sxJ_FOg@mail.gmail.com>
Subject: Re: [PATCH -next] selinux: remove set but not used variable 'sidtab'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, omosnace@redhat.com,
        rgb@redhat.com, keescook@chromium.org, casey@schaufler-ca.com,
        jeffv@google.com, kent.overstreet@gmail.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 7:46 AM YueHaibing <yuehaibing@huawei.com> wrote:
> security/selinux/ss/services.c: In function security_port_sid:
> security/selinux/ss/services.c:2346:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
> security/selinux/ss/services.c: In function security_ib_endport_sid:
> security/selinux/ss/services.c:2435:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
> security/selinux/ss/services.c: In function security_netif_sid:
> security/selinux/ss/services.c:2480:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
> security/selinux/ss/services.c: In function security_fs_use:
> security/selinux/ss/services.c:2831:17: warning: variable sidtab set but not used [-Wunused-but-set-variable]
>
> Since commit 66f8e2f03c02 ("selinux: sidtab reverse lookup hash table")
> 'sidtab' is not used any more, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  security/selinux/ss/services.c | 8 --------
>  1 file changed, 8 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
