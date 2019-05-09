Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC4FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454D920578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkBo2kat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfEISzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:55:45 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40329 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfEISzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:43 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so2699857ywe.7;
        Thu, 09 May 2019 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JFPFXVDH7pJ9CJTfoL2qJ+K7zcKHZ5roJuaHINr0fU=;
        b=VkBo2kat9T4exVnlUA1bHK14ozicDJbZ7bEF/zNTVnMg+kDzu1jvmAWAkbD0Hyr+kr
         dxeWekWbRiXvQtRC+ezW0VrSfDxmTqS5rVLLXtgQWs6YYHfDjrGOw0ORNZCkfyho8D/0
         203ElUp4T/6HItf2fiinS4NkeaOj59/tYEbBnIxv3DOablRikKYSKZ9AMNFo1AwK0TYd
         5PpgWFvp2hu9+eTd9mO7KKHMNKi1iyp5lnTTyv0b/Ig5nrVmCdnKM2NF0hJgQWFdMrGo
         cd20NCP8uCgeAlj3PCgBGmHSovzlODFAkM/zwIcAHqiCyKNpBrq6hcLQJDf0fFSmu2Xj
         pIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JFPFXVDH7pJ9CJTfoL2qJ+K7zcKHZ5roJuaHINr0fU=;
        b=KBYgJ+GCkAyVtQ29NDt4VSVZfiJbwf0RKrs9RQfaMLFot/S3riS1blQt1A+dDCnep9
         X9N9N5VHEqgBTnIeV3eW9sM0wF7pYkPI41i5lJh8fy8C2SoJPm4GDwtuzgr8lQpuNxuL
         o39i5HZRLIuJH0IjgRKtpw0FAApNJkZ1KKa9j8Zj/0czkrG+NCtiv9XvKIoBQLqbNDkI
         pC9dw8uE5eldey/LzFZD0Ld6cpqDHKcyPF4kgnMf8JutyZjrsHuIHKNcbOinqdkeeuvL
         7lpGnhUpLt95y2hT5X3hCw6wYSJkiSdoLjqMuqOIQ8rgxKxY6lgXVo+jjcWL1Igv7xTK
         0ozg==
X-Gm-Message-State: APjAAAW2lHJShkn0Nk0X75pt2lFWjwjrLUQbbzNa4BDwcCqgOk0JEeoI
        dgk9qu0QwYuGh0akw2lOalkRbA9wmU2mGFP3PR4=
X-Google-Smtp-Source: APXvYqwNlGdkGWUPsJYGt/hFZGUABwbuzytLt/hWzpG1HIsldhR/35nTAj17XxIPutZ/+XfqJ0/Q/fsLJeS8d5kh4Jk=
X-Received: by 2002:a0d:d7d0:: with SMTP id z199mr3300615ywd.468.1557428143045;
 Thu, 09 May 2019 11:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190509181301.719249738@linuxfoundation.org> <20190509181305.327667203@linuxfoundation.org>
In-Reply-To: <20190509181305.327667203@linuxfoundation.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 9 May 2019 11:55:31 -0700
Message-ID: <CAMo8Bf+TZ_ptRjDVuKLZ2M6Bjo83ckuvj=6hCpiZ2ufJrnu80A@mail.gmail.com>
Subject: Re: [PATCH 4.19 32/66] xtensa: fix initialization of pt_regs::syscall
 in start_thread
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 9, 2019 at 11:48 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ Upstream commit 2663147dc7465cb29040a05cc4286fdd839978b5 ]
>
> New pt_regs should indicate that there's no syscall, not that there's
> syscall #0. While at it wrap macro body in do/while and parenthesize
> macro arguments.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/xtensa/include/asm/processor.h | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

This patch should not be taken to any of the stable trees, except maybe
5.0.y, because NO_SYSCALL was introduced to arch/xtensa in 5.0.

This patch doesn't have any cc:stable tags, I'm curious why was it chosen
for stable and what can I do to prevent that in the future?

-- 
Thanks.
-- Max
