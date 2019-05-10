Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F41CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED9E920850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 20:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1b9PSNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfEJUfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 16:35:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37343 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfEJUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 16:35:09 -0400
Received: by mail-it1-f195.google.com with SMTP id l7so11317724ite.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hL++2fQtVcBcemd3HMY6tCiADu4XC0og1WjDAbLOUQM=;
        b=E1b9PSNPBbhgMZMTVNXTGlJqb6S/p+8s+/bVnewxr9ELVRjAaaOPHPYdTrzxApIozC
         3t4jfPjPMnx4jeJ+hM2N8+85nlc0z1lyKDDzz43TVzU2SxMfyufYM9mIqgUufcbSYmbn
         7iJIKtvM6VssLd/K1frs/EFopOK1/Ne2lKs1S91PkYwsfOc2PMxdKUxpCkUGBOJNukId
         VWAln6lgv1bTkpNN/jLzUq7b0krgG+86+WmXJ2St7u7I6cDfSNppya2YLhf6Aq/DydJV
         s2OQ6FsQMOQu9OJd+//B/EvYhUe3atds/biREjrf28hPsnvpyUUc1u4soVwv/vxFscD1
         h8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hL++2fQtVcBcemd3HMY6tCiADu4XC0og1WjDAbLOUQM=;
        b=liiefnbhPkoBaV67Ob4pQ8/361x9Pzwu19hkv54YlN+Vh/GbrVjkTAYMHocto5E1aA
         VlhYqzys0WTBO3qkk4lMKnyzI7zab4WEkcj/Mlwamf1VgtwU4AgdhRNBVD3DPQiuyIn2
         pbXz1QRAbiqCckyPRioa6SNxVobeHa9VKliGInkiL1b/MD6Q49oknkEbaoTMcH7T+FZa
         NoVXE9am+XcGANdEw9uAkiDZxZuLbQc5PxhhIFWK8bw9Wa26R02xNqfEDvshulG5qieW
         BBVLUNVmXVMyaLFRRlmXVDP+7BcZQomqXP6z0/9iXsZuWK4E2Zgft44sNyzxvBJ9fAMr
         qPcw==
X-Gm-Message-State: APjAAAVWai1J3Ih6KolOVRLpsGJWrHQacgz7kiIh1gaVPKO57tpz5jb8
        gJRlwFY4miv3I0h/9KF7TchkfYHW65IxlQ+sQGx1zA==
X-Google-Smtp-Source: APXvYqxlErmY8vWfOnLWWMSub/Y/z3/XiSVXzHpmCbXvbQ84l8sjIZ/uqt0ZuRjJvLGzx6VVhTRWg1bKtkBMBG15sNs=
X-Received: by 2002:a24:f946:: with SMTP id l67mr8837449ith.43.1557520508599;
 Fri, 10 May 2019 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190510193833.1051-1-bnvandana@gmail.com>
In-Reply-To: <20190510193833.1051-1-bnvandana@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 10 May 2019 22:34:57 +0200
Message-ID: <CAKXUXMzJCmSZqJ+VFxEOgf_HNgKfPfKS7OECw_RzSxVrDZpCGw@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] Staging: kpc2000: kpc_dma: resolve
 checkpath errors and warnings
To:     Vandana BN <bnvandana@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 9:39 PM Vandana BN <bnvandana@gmail.com> wrote:
>
> This patch resolves coding style errors and warnings reported by chechpatch
>

I did not look at the patch in detail, but you might want to also
consider to replace the CamlCase (function) names by names in
lower-case with underscores. That is the common style in the kernel.

Lukas
