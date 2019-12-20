Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141BCC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5BF206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 05:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MSLKMuHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTFfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 00:35:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:41564 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:35:01 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so4630957ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 21:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bJH9ngAKUt2zZBSAR+jdXkYppUB/dH1U+o3RlVCLv24=;
        b=MSLKMuHu9QZksGDMR6iUQ/crRkDEPYDqT4JZL7mzTHB6il8vBxzjQRibZnMfCeT2le
         mQida8F+9unRkoc1GnDv4mI9YgnWe4GyoeK7jjYVPdrZtNVSRl4AM8yGg+29WN1dGwug
         VTLCzs7L6SS5hPiivZvxr3YennyaDl2vj7jCX03XRxW5Loh1HeH/mGVl2dLvu0gSyhhu
         DpRPoS7E4pPCerJDnXIK+sTEnhPo4HYvBa9x3kXqYm65XfftWoxUyOFeUfOj73fZam6G
         /6MvRT0FkORkkE2gjxcJxGRZm0wdNDGFGf3rTGB97TetN1i9BDOJK79BjRuNDdLb5dzY
         Fz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bJH9ngAKUt2zZBSAR+jdXkYppUB/dH1U+o3RlVCLv24=;
        b=NPvafD2mVcoEogsHbphWKJ8ns6flOdl4iRbY6L9SwxR+fEOpNqEGM6CMRqMa2MPD3N
         e3NaTcedejbGVWtCU6/0X8cvKfFC4/L4SYFCsTZLwUGneJgPPf6jC4jAo8HVfDvn4VJh
         /FftXWkMueFuQSwLvOxXtBouHu/JktisnVp80iifmdLhdz61bGJi+lMDtAP76rcgHjfa
         XK4hDL71nOwLHhsRBzHJ2EfRRPavRB75qNjjfa3IZ6ul6Y4WkWDAxgrnnLcGPqpZZ2GG
         BGOnAjwquSBDQiNXT0frmFJq7QIHmDgEWTJ4lkzZfwgGXMSn4m05TJ5sN7gVrD35nfU5
         t31g==
X-Gm-Message-State: APjAAAUE4GAk14P0kgghzlEiK5lKHpdJlnvBWMh5I6vubdzP5Hn6MmoJ
        EnzhT36BG1TBMLrkFshs5j2eWw==
X-Google-Smtp-Source: APXvYqz3mkdhGZsgbEu11Mzt0Nz4pjnOdDnxa00QXAm4U97lfdYncbGpna1SDIs8u3ttfnE7oQWhUQ==
X-Received: by 2002:a6b:c8c8:: with SMTP id y191mr9069907iof.104.1576820100628;
        Thu, 19 Dec 2019 21:35:00 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h3sm3880783ilh.6.2019.12.19.21.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 21:35:00 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>
References: <20191220123614.5f11d2e3@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f6ff3aa5-e08b-8b25-454a-9aa51b8b5c37@kernel.dk>
Date:   Thu, 19 Dec 2019 22:34:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220123614.5f11d2e3@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/19/19 6:36 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/open.c
> 
> between commit:
> 
>   0a51692d49ec ("open: introduce openat2(2) syscall")
> 
> from the vfs tree and commit:
> 
>   252270311374 ("fs: make build_open_flags() available internally")
> 
> from the block tree.
> 
> I fixed it up (see at end, plus the merge fix patch below) and can
> carry the fix as necessary. This is now fixed as far as linux-next is
> concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.

Thanks Stephen, I may just pull in the vfs tree to avoid this conflict.

-- 
Jens Axboe

