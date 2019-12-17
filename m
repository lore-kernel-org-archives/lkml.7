Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25597C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB58320733
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p2BA0wU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfLQSJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:09:24 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41285 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbfLQSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:09:24 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so9151576ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 10:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0QP0bNN7yAk9S0VSL+bDYhT11IE+1HUbY9Rj0py1yCE=;
        b=p2BA0wU8M/ya6yrzSkxIH8TVd9h1XiBbINW+Huy2NFmyXElYd9Ia1D/NubOVDh1Kdv
         MQzNQ1pcGc/s/T/a7H34WnfNU2OrpHngWKY5K9JDXNLtRN4CAUShGQaEV7HcucxfZULJ
         /Xl+9X8Ms4lkoXXdnCQzfeJ8egxbdxgGEdSjWeOoLpK1eGfIYcpqvSMmjgbmn8Jxo5o3
         HaHSNhhqNux4rLEzbvbyR4vk24bgbdRH9nKQzCyc4DNMp1bQ6q/k0x54f18ToB0NBDEz
         WawJBKQIfVG9/FX+P/7OGGqeqPIBXEJ7vjTeup8usTBfs4khn6gdldLVwQPQaQ7vYtLs
         qpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QP0bNN7yAk9S0VSL+bDYhT11IE+1HUbY9Rj0py1yCE=;
        b=ZG2nSeLymTbsr8j46si87Ct7FlNrcmcgrGsu80ilhfDwSMjckNtIX6DWXIQ/XHALB6
         dRbEmSgJW8QfwqPmLFjtz/J+TJyDWpPHiVgSUyXO7YTcKNa7T7fmnSgPoQbST1UEozPu
         RDK+gx5hzbyf1cgLPhL3wCz+9GekiDnL/43J8IXUhEyGRr5WT3kA/zkg7BRMGANUmh0h
         OWOsXKhCGI7dpQ5tqO0n9LZKkG+13Xd6D0M0QYnPtFw93qiox7Pbo/6BcIJiZK/1R7iy
         B0jgHiX71OA1/anL4NSPTRhT2blrJsq/1P4xUo/PkYHEHE2M+L/KerDVBOOTW41LSdLe
         GCtQ==
X-Gm-Message-State: APjAAAUL538A8Tyy4PZWeRUaHh0jeSS90BQ1Fc1/4A1HsdHydxjSFKPi
        MXdEN39sPgcGKS8HswIT+TSun8Eg0/yrSA==
X-Google-Smtp-Source: APXvYqzygSEbeuLKhJwgREmiPZE43+M37DDkao0wUrn9tOxKO0Bs/tSa8+mexekGEomP2+Y30lr4fg==
X-Received: by 2002:a92:d3c6:: with SMTP id c6mr18655191ilh.228.1576606163657;
        Tue, 17 Dec 2019 10:09:23 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g62sm2809294ile.39.2019.12.17.10.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:09:23 -0800 (PST)
Subject: Re: [PATCH for-5.5] io_uring: make HARDLINK imply LINK
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1576605351.git.asml.silence@gmail.com>
 <4d08ae851e48c030b726e00def4451466475b7e9.1576605351.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <30c12b37-997c-6625-50a1-1ed0e8bad2f9@kernel.dk>
Date:   Tue, 17 Dec 2019 11:09:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4d08ae851e48c030b726e00def4451466475b7e9.1576605351.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/19 10:57 AM, Pavel Begunkov wrote:
> The rules are as follows, if IOSQE_IO_HARDLINK is specified, then it's a
> link and there is no need in IOSQE_IO_LINK, though it could be there.
> Add proper check.

Applied, thanks.

-- 
Jens Axboe

