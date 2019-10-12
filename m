Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CCC4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 23:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6948E206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 23:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570922010;
	bh=+wHs2Y/Qg5mogbSpED8FXiNC/fGFHyhQ+Ml3FmkKkSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HD32SQhnMfviVPly/m9w7glaezizfirmowX4Rt6ZEvC/+75AdYSc51LscpBxV7tzs
	 ywr4Cdl47BreEDpEIm2UnQqwpoBMwgP7hLq0AC62zT8U0jWRCzv3jxFLfjFWoq7zcm
	 jAL59FBs6dAEBsAxYB/SfOx9ZrPdi4cEZFsOZZb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfJLXND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 19:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfJLXNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 19:13:02 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167A02089F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570921982;
        bh=+wHs2Y/Qg5mogbSpED8FXiNC/fGFHyhQ+Ml3FmkKkSo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WwC2Zd/EElIEXkBTdXusEwwsN4TJ4e5D5MZxTtfywIxcnPXQrwGl5L6KJELMbxZCM
         S2pRWM8koBpwKPoErCqpDh/JoZER3vtzcv1N90m4xpbH+WN/fw1KTsMGpT5lRl4XwD
         HHBuNFJU67xnwaOi7vgnJujwYccyolwUM8aW4WPE=
Received: by mail-wr1-f48.google.com with SMTP id j11so15578621wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2019 16:13:02 -0700 (PDT)
X-Gm-Message-State: APjAAAWHHOOyjjvsTTJKTXy2MJwMKsbGPFqxzHd1U3PY3U8Rxk1/ql/I
        Wq+eAlkYZn7lQeIc/Zqv9nTQ/2AfvBFLMnNbqXJ+cw==
X-Google-Smtp-Source: APXvYqw7HEa5GYoH47kjNp12sTWsxaiCKc6Zk/2lzuijVQxR+tnPNkLDBsht+XtGjda/KjufIv6NxSXSW8gqONbWoYA=
X-Received: by 2002:adf:f9cf:: with SMTP id w15mr20086297wrr.61.1570921980646;
 Sat, 12 Oct 2019 16:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-7-dancol@google.com>
In-Reply-To: <20191012191602.45649-7-dancol@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 12 Oct 2019 16:12:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWF61dmSpMEYvqa2FHWL8Zj6GJtevFTfymV20CCjiqRcg@mail.gmail.com>
Message-ID: <CALCETrWF61dmSpMEYvqa2FHWL8Zj6GJtevFTfymV20CCjiqRcg@mail.gmail.com>
Subject: Re: [PATCH 6/7] Allow users to require UFFD_SECURE
To:     Daniel Colascione <dancol@google.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lokeshgidra@google.com,
        Nick Kralevich <nnk@google.com>, nosh@google.com,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2019 at 12:16 PM Daniel Colascione <dancol@google.com> wrote:
>
> This change adds 2 as an allowable value for
> unprivileged_userfaultfd. (Previously, this sysctl could be either 0
> or 1.) When unprivileged_userfaultfd is 2, users with CAP_SYS_PTRACE
> may create userfaultfd with or without UFFD_SECURE, but users without
> CAP_SYS_PTRACE must pass UFFD_SECURE to userfaultfd in order for the
> system call to succeed, effectively forcing them to opt into
> additional security checks.

This patch can go away entirely if you make UFFD_SECURE automatic.
