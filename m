Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32887C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CCA206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kmqvI8DN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbfDQMYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:24:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45921 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731932AbfDQMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:24:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id y6so22204947ljd.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jkkH9h6g3c5wZ0xmnDDnbdL1hwDiFSrGr2hnQTsYsOE=;
        b=kmqvI8DN5pjdhnDJvYlgyLSffHdeJGtnQ05iN249+35u3wRAI8G4jojJqTJAr94Hb9
         YS/OxPBFkUOHUhtYR3XvRRjn6grWVGT/7PXrtOJWkuTS//Py7zshkUX3t0bsx8ytobDh
         XgSm/JwcNCBkbRG55QSMgCLVawWIZ0eRd4Rm25W2WL7WzRt40xe537RKTkofm0SSdhvK
         YnbGbIr43zSsAiv8MFZbFTJw/SdrooQr3YzPm1C38IAspvQL6kXvipZG+ZCj+8vLg2iQ
         ySgLz5AKmTUsKrRdwrEOFMPqMQebpEShcchh2HxJWgfDsI3opg7fnhTg1tO64gxLege3
         xNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jkkH9h6g3c5wZ0xmnDDnbdL1hwDiFSrGr2hnQTsYsOE=;
        b=Vumm12KVxGj2+TRGwopIYIKumZidNe12apI7RKHbdFnUSKb1esXOjSXuV+XmehR+w/
         q2Mt0Ex9DVGo9acut78NqRCPqQ8ULabUGCWC+oIDyCKeK3+VFOgRInL3kXzn3CqjExP7
         AVv5EXGlfjuhfMUhB0l91IQ/o32l/wqEFw9+gdHu7RlnXKLBSb0/KJS3HpXJpLmtrtCs
         +WHQxI0ysL3N2nwLkrDY0ApDFa0JR76BeWjRJCXm0SnOUxd1bKV03ChH7zft2v3qM7nW
         YVRMzqtPzytr4SE1a49iaJX9KLTBfMdeUWaR4JCIaGc4g/e+IAdoO32byU7yOeZWNAjz
         7EOA==
X-Gm-Message-State: APjAAAVp+HHD4UllHSwXYiBfZgDKKpJJ1UtdJYuFn7hgsTdE64HblR7d
        t+cGOs1/YSSNEKvIkkMaI2OlrkIa7ugmN9G3Q2eg
X-Google-Smtp-Source: APXvYqyEUivNAJXAg0ImGGrf+euiMQnGxepBH/O57TXXh/nVk/mw53BA50+rz1iQAWcVIJIgSBanf0fsC/108vuk9y8=
X-Received: by 2002:a2e:9ec3:: with SMTP id h3mr25925196ljk.131.1555503858038;
 Wed, 17 Apr 2019 05:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190417092600.161770-1-maowenan@huawei.com>
In-Reply-To: <20190417092600.161770-1-maowenan@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Apr 2019 08:24:06 -0400
Message-ID: <CAHC9VhR+KqRNy740g-_Q1kajG2gFYah0nH0tgAxjVYk-NxtmmA@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix potential memory leak in selinux_socket_bind()
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 5:15 AM Mao Wenan <maowenan@huawei.com> wrote:
>
> There might be memory leak if avc_has_perm() is failed after calling
> sel_netport_sid() or sel_netnode_sid(), port and node list must be deleted
> and freed firstly before it goto out.
> call trace:
> __sys_bind
>  security_socket_bind
>   selinux_socket_bind
>    sel_netport_sid
>    sel_netnode_sid
>
> Fixes: 3e11217263("SELinux: Add network port SID cache")
> Fixes: 88b7d370bb("selinux: fix address family in bind() and connect() to match address/port")
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  security/selinux/hooks.c           | 15 +++++++++++----
>  security/selinux/include/netnode.h |  1 +
>  security/selinux/include/netport.h |  1 +
>  security/selinux/netnode.c         | 38 ++++++++++++++++++++++++++++++++++++++
>  security/selinux/netport.c         | 27 +++++++++++++++++++++++++++
>  5 files changed, 78 insertions(+), 4 deletions(-)

These are object label caches and as such it really isn't necessary,
or desirable, to remove entries.  Regardless of if the access is
allowed or not, the system is attempting to access these objects, and
likely to do so again, so having the object labels "hot" in the cache
is a performance win.

-- 
paul moore
www.paul-moore.com
