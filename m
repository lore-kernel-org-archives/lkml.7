Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06F6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A921A20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 17:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk1wssvB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfLBRNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 12:13:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43800 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbfLBRNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 12:13:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so183194plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64Rtkbp5lv2QBUlTxW71SlutJl/znQZhVAhGmRkDa5A=;
        b=Vk1wssvB/zZH8eG99umAlefNG1L3qcWJrGhvntSWhcfpVqIgNAxOidQi1rwq4EQIXn
         bN4vLm7U3VKPpBs9sda/OGs+oyh9PNagdmFLvXdLj/BS47NPntYenQZ5La3ndeMMvSdE
         skeX0zFDPEe2oYhEETSdTU90kbb3+PL8p4zstc5e0YlF0cKXQ92MxFz36GyVOGZ0X7/M
         K3MrdpOuSClJ+EaJxL7s+dztJNSPhojECu28cIb0F2l3WqnCnMDfk4C/Hj49DL952BEY
         BxZqmEm7yS/3E/w9YNyvwuwajKd5JfcTzCs/nbSRB1EuYZe1m8RWrwueCb+hlp03EFEM
         7wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64Rtkbp5lv2QBUlTxW71SlutJl/znQZhVAhGmRkDa5A=;
        b=NHOFSGDPVkNQ3ww+2Cz5fhsbsGjt7EjhU8hx57e2cn4tpZaUgGgdDe7HxEtfmea5tp
         +KYQfIj3rFm/XMRujrGMCEqFeZv7q8vtiKVfP1zVSB0YUhAFlEk6W2WgLQGUa7N2uI+t
         5SqDYo+8038uqTc1Ub4bAfx2gK4NNTCgAHOkjBf3uslUl7fdAFCHZizkqRsqGE1PJeXp
         96XL6ekXnCr1rDJBfwY2gXIZW58Aa0i3T1qRzCyG6qtkycIQw5+nVGNdb8bENLU6pEf6
         B+Cb+aKyZ9+S4jjAcPOUHbm4hdmeRnj4HcGIotndF5KbOO+qnKEnA6WNG7ipJdMxw9Tm
         VZTw==
X-Gm-Message-State: APjAAAUbwA5ZibSOGScOn/LMfrXA2sehg26Aay9DLs5BHDxQH9lVKVnl
        ucSf0OlqlZ8HmGfuu8yRNSz9P5ZSQL73+5W0pw6WEQ==
X-Google-Smtp-Source: APXvYqw2U7Pcn6yuncEv+9Hnh2ggnupoJ+IowA3xrDVuGtbGVVpYPNpOewznFvm7KtezB3JzP8UOxrp7rkAIVpmh7PQ=
X-Received: by 2002:a17:90a:ff02:: with SMTP id ce2mr16466pjb.117.1575306825934;
 Mon, 02 Dec 2019 09:13:45 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-2-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-2-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 09:13:37 -0800
Message-ID: <CAFd5g468=suYdH9No7f1qkr-oAvOFS3q4O1iW3ABs57fzsntdw@mail.gmail.com>
Subject: Re: [PATCH 1/6] docs/kunit/start: Use in-tree 'kunit_defconfig'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> The kunit doc suggests users to get the default `kunitconfig` from an
> external git tree.  However, the file is already located under the
> `arch/um/configs/` of the kernel tree.  Because the local file is easier
> to access and maintain, this commit updates the doc to use it.

I agree; this probably makes more sense.

> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
