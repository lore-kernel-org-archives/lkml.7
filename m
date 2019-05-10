Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD67C04AB5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F375217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 21:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpeS/e5y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfEJV2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 17:28:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41899 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfEJV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 17:28:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so6945380edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=OpeS/e5yAb8uvpLXYNqA6N1MI8D7JXLjmHyNft0qks+8R/zc45m3XbQH7ZLcDfretb
         NJx/g0yV7jox/sIORLwOrxO1a9CV1jZa4gZ98sX8gwy7R8ojzc6s0LmwQEN7UABbk8mb
         Fxhe8bCtYUg4ePrk9piZU6axZgBrTRfXt2Nca9QBNovg68zQtj8GUi/rd7SCaOGE7XQG
         maBuJVPgPv8M7/MFnTidvVHklN5G7hqvUjLYWauPMuQewufDa3+DR5c2bfu6JIzKNOi0
         rmTdxIt5cPg9YEIjCngJ1xtbJ4MWbtHDYD1wkUYVwYJKhe+0vPHojo8IZxOQPW4XrFjy
         V9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ULvb6m5Ct7N+U+Hk+TL0VPodYz5yvNtcE2Pdidu8130=;
        b=pHShoxzDhJ8OXX7XodRuEP6cxSVNQMahKI6ixSal9GsfdlfufdoXWokaztH5MDKlnr
         ic61Gm7zW+dAHqIyUybViqhZgSV2KhOg0PaKo2/VsImhyer8++7yCpvyuBmBGo1cIiSp
         NE4yOr5Cgfrdcfq9mZ9bcEre+2r9dbDJR8hFJ6Gh6875sax6WTtbhWCwJVkUveHDxxoU
         4KyTIdfO6H6J1HE4H4hepaPgJf7ySfypnIKCkff1tklE3LlvPNirC+IqDR+pGx6bJ7tI
         6EIQ2rF6RgZybEEkuwBQMDqYfIRDe5xpMnr9Nq1OHAFX+sp0ODesvDeO2hMQaN29Dhhz
         g0nw==
X-Gm-Message-State: APjAAAWyv//B72hRDir2a6lWSr4y67xzQGPr2SY6C/xm5JI5rmTo3KT6
        bLTaGo2yrys36hdOGQG1pGgU6g==
X-Google-Smtp-Source: APXvYqwB8IbdmimHYeSIRTDySy1Eup7HC96peg+2fx8bMgd82d1e5doTbK2hNZI5/C/ZsrOzqlCN9w==
X-Received: by 2002:a50:f5d0:: with SMTP id x16mr13446339edm.287.1557523718509;
        Fri, 10 May 2019 14:28:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id c6sm1742858edk.81.2019.05.10.14.28.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 14:28:37 -0700 (PDT)
Date:   Fri, 10 May 2019 23:28:31 +0200
From:   Jann Horn <jannh@google.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     viro@zeniv.linux.org.uk, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, initramfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.vnet.ibm.com,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com, hpa@zytor.com,
        arnd@arndb.de, rob@landley.net, james.w.mcmechan@gmail.com
Subject: Re: [PATCH v2 1/3] fs: add ksys_lsetxattr() wrapper
Message-ID: <20190510212831.GD253532@google.com>
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <20190509112420.15671-2-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509112420.15671-2-roberto.sassu@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:24:18PM +0200, Roberto Sassu wrote:
> Similarly to commit 03450e271a16 ("fs: add ksys_fchmod() and do_fchmodat()
> helpers and ksys_chmod() wrapper; remove in-kernel calls to syscall"), this
> patch introduces the ksys_lsetxattr() helper to avoid in-kernel calls to
> the sys_lsetxattr() syscall.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
[...]
> +int ksys_lsetxattr(const char __user *pathname,
> +		   const char __user *name, const void __user *value,
> +		   size_t size, int flags)
> +{
> +	return path_setxattr(pathname, name, value, size, flags, 0);
> +}

Instead of exposing ksys_lsetxattr(), wouldn't it be cleaner to use
kern_path() and vfs_setxattr(), or something like that? Otherwise you're
adding more code that has to cast between kernel and user pointers.
