Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56428C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141520820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIpSBZz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbfIWPg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 11:36:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35327 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbfIWPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:36:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id 205so9361975pfw.2;
        Mon, 23 Sep 2019 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ijALtNMVDCbRngnlUemEOMqxh/pmlAYjBmJTRLvXFqE=;
        b=DIpSBZz7HEpByiy/fNz+JyvxDoOOZ09A1dZh+X8HnqtM5NW+KIAJsZQmVDgSOuMb51
         fvaPBwl7+oOS2zuhPyNx2n9sJAlkYZ4uzrWBhgHdJr819RN1sqFlY1Z8Q+foyPZwjpld
         tGomb12TZLB/14W77hjoI/d/+HRTYEWUnDRyIZSvfvXAt8H7LXJgCqfqE/ggQLVu2BWa
         skwtb/LGV3PeMt/HfCAG78fsKI0rFSzldjNsCb2AO8odTztYE4nm1kYM1VGzMvRXJWeZ
         ahHYP/K8Gt1JAQLHv4GJkiaf6LIH6iSvR4y5bhwNkYZSTWUzRj0UkZrtAgeMnB3Kq8Xq
         ZjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijALtNMVDCbRngnlUemEOMqxh/pmlAYjBmJTRLvXFqE=;
        b=grlbC6rwY5ALT8FU0p1I1Bav5RNSTsVTjpfkk8VWU0ioz18b4Zpv1aYgM7ECQQT+/r
         BChv7LESWJBJYKWKAvoqw9HXBzVfkkaZ9F2m9OTPo7PTQYY1RSYeMWKeTmpZFtF0kbma
         J6EloPY+a5Y2wz2wT09nyHlT7hudQUnrs92Mh+ktoculXl7i9Y6GHsTYStg51h8DMmmz
         y57PP+a3UxkgfQIRIq+czZ/QpkUOYZ+rSmoVeJowxS7avkYW3Pg6W5xUteFKgkMjlrsR
         qg3B0wXGHRKfq5nZbEjqSkXw3IRTKsrMxfQJSMyIC25fBfiKYWJ+ZzoWv4JxVXVH+R8o
         wCtw==
X-Gm-Message-State: APjAAAXxaw/UWx/6M+fJhIubR9A/fZ6t/k/YFNO2+QYmmfr9oVx8Ynse
        7dZz9/nMH04h+w2qP5+jLATzoipuN6Q=
X-Google-Smtp-Source: APXvYqxKErLEPgwToF1xjIjSrEMsm45EEQIHxCIhG0rhsc/BFBsX8V6p0M59fQ9mrKhJjz5R5wCksw==
X-Received: by 2002:a65:4785:: with SMTP id e5mr498575pgs.407.1569253016423;
        Mon, 23 Sep 2019 08:36:56 -0700 (PDT)
Received: from [10.230.28.130] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b5sm17838111pfp.38.2019.09.23.08.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 08:36:55 -0700 (PDT)
Subject: Re: [GIT PULL] MIPS changes
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
References: <20190921231022.kawfomtmka737arq@pburton-laptop>
 <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ac8e3a45-5efe-0e60-3ee0-1a5dbcfa8fc2@gmail.com>
Date:   Mon, 23 Sep 2019 08:36:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjmJbF3p9vZTW2nbeD4LkG-JZV+uqv8BnxzojJ5SZsLjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/2019 11:35 AM, Linus Torvalds wrote:
> On Sat, Sep 21, 2019 at 4:10 PM Paul Burton <paul.burton@mips.com> wrote:
>>
>> Here are the main MIPS changes for v5.4; please pull.
> 
> Hmm. I pulled and because initial tests didn't show any issues, I
> already pushed out.
> 
> But some unrelated further testing then shows that this:
> 
>> Florian Fainelli (2):
>>       firmware: bcm47xx_nvram: Correct size_t printf format
>>       firmware: bcm47xx_nvram: Allow COMPILE_TEST
> 
> causes problems, and commit feb4eb060c3a ("firmware: bcm47xx_nvram:
> Correct size_t printf format") is buggy:
> 
>   drivers/firmware/broadcom/bcm47xx_nvram.c: In function ‘nvram_init’:
>   drivers/firmware/broadcom/bcm47xx_nvram.c:151: warning: format ‘%zu’
> expects argument of type ‘size_t’, but argument 2 has type ‘u32’ {aka
> ‘unsigned int’} [-Wformat=]
> 
> and the change to use %zu was completely wrong.
> 
> It prints out 'header.len', which is an u32, not nvram_len which is a size_t.
> 
> Tssk tssk.
> 
> I've fixed it in my tree, but this should have shown up in linux-next,
> or in MIPS testing. The process clearly failed.

Thanks for fixing that. The process worked, there was an email sent by
the kbuild robot but I saw it only now somehow and failed to address it
in time before Paul sent out the pull request.
-- 
Florian
