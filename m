Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79661C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFDA206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 21:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="TPR3K/r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:38:13 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:36452 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfKMViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 16:38:12 -0500
Received: by mail-qv1-f65.google.com with SMTP id cv8so1328104qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 13:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jdNYztEtxc8SfImaEzyFgaa9SQwFgVwrspdhS4uESk=;
        b=TPR3K/r6XvAteM0JaP1KBWpEhwecRZn365xgRo1ztlHHa9PEx2ccIhE0TiFliRhSjH
         KIQEYNuzL4kpccd5YK/E+EuSgRU/FHPNGINMda/SoLoCn31bprYoJ8rUYMUp/+sSmPyy
         IaYC7/Was/5vsDwGWDBCa01+/LDhIIBnrZfouRADWLT4xEq72wQcBF6RKtbzTPOsaMxL
         cY4FELOeE4rCvgZFGzox3YZbmNp+D8AGSPnOoZvMohgJcRSv9NIY5pn886ctjgaIC3Su
         XU8UGnWIty+CbanQSLN3Npb4xcYtxlidFhqspHOlg2BfCmM1Qt2JWHQiVqOc6q8dq3oO
         LIQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jdNYztEtxc8SfImaEzyFgaa9SQwFgVwrspdhS4uESk=;
        b=QlaiIvGm6Jg72uFGVrxT/2hSmQ1/F0uWJewTEbKNLPVCKBDlbHZ/BEvNxxnxkdyMj+
         SMe/KtxoF4iqEb2OOTUjKe2t0xx4hAy5/L9+t0OTuSvlKQSse50WAsj+1o5FejdW3Iox
         TB1vmqfAq57CfYE/rnddJGXESNIyCd8CCM0qCXtblAEol2svNCoMYUnIR2HdGTQum/ey
         f8aPM5sw/8K1ZasKAsT3p8j/6OQD4uq5nQui8Th+9FCRwU8kDuSn5Wb1OnJE3oN59O0g
         jHgPcEFDGWBvYXV7DS9nrimj97kbLgV5nXv0BA6/qn6SN26N0FHev4uUa9HJI/b+ZAO1
         3hLw==
X-Gm-Message-State: APjAAAUW35qoppYpZ5lW5mnqX9OqsOE2emMc8DYX1Q2XOwJgANckoMFx
        quqI7sLcQOumsFIPKVAc2fuFpPInS+lYWJK7lPC6Xg==
X-Google-Smtp-Source: APXvYqzBPtxmCxOGVmM3ecLjmVJEpWoL2fFkW94ZVkNcjD0QBsupbILPe/9QBBSkDQZNDqOl0hwctTXuQqReOk0/sII=
X-Received: by 2002:a0c:9637:: with SMTP id 52mr4897544qvx.174.1573681091430;
 Wed, 13 Nov 2019 13:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20191112223300.GA17891@debian> <20191113013026.GO8496@sasha-vm>
In-Reply-To: <20191113013026.GO8496@sasha-vm>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Thu, 14 Nov 2019 03:07:35 +0530
Message-ID: <CAG=yYwnJKcriaHcZFFrznxq1V9-ZcLzC-O=fAhQ6Skmn4eFPAg@mail.gmail.com>
Subject: Re: PROBLEM: objtool: __x64_sys_exit_group()+0x14: unreachable instruction
To:     Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com,
        christian@brauner.io, tj@kernel.org, peterz@infradead.org,
        prsood@codeaurora.org, avagin@gmail.com, aarcange@redhat.com,
        lkml <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        "Mr. Jeffrin Jose" <jeffrin@rajagiritech.edu.in>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 7:00 AM Sasha Levin <sashal@kernel.org> wrote:
> Could you bisect it please? I'm not seeing the warning here, and
> kernel/exit.c wasn't touched during the life of the 5.3 stable tree.


I tried  using related to  "git bisect"  and managed to  check based
on kernel revision related. The warning existed even on 5.3.5 and
may be even back . i think may be it  is a compiler issue which creates
the warning and not the kernel.


-- 
software engineer
rajagiri school of engineering and technology
