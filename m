Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC38C606C7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73806216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntTORaKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbfGHTJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:09:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40056 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731340AbfGHTJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:09:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so634633wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 12:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=l+7u9g4YDBV0qSmQ+PNq9QxlNzB07gtt7XvLALkjfds=;
        b=ntTORaKLJG/d8XA448AE1+EpfPqMxzbrGlBi8lJLzrIW6Nw98seS7mTbk1/TimIZL7
         QmTRbcq+jHhUV57ext+KUxTl+Tsb4rm+4TZsgmC8fegHHREqd62ASkozX6RbyifS0m3K
         rXP3t5Pmt0lxx+nuXPTsHASW+Se0CqOyrROEfvm29546/BKlBH1C44IsDtfPaO6koLe6
         kqoY8/ddoyN49cVKTv+pef+E4SOTBza7boq8nwT8RFnG7gaJbE6U5H9Z1621HfMl8jU/
         fxMiPaoOOMqpFBoJx5WuSfAaCbaQreTuLynDEbkx+koRyE59r7LcHoiK/1PrBGEyDvJE
         N4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=l+7u9g4YDBV0qSmQ+PNq9QxlNzB07gtt7XvLALkjfds=;
        b=ZM7bFA5akZIuxBIcHSwCPhCmcjat0Ixr8EQktz/j3jpIF0KHJDYDBd2wFrd5JwzRyg
         sWDYjVlWXR9sd7qR8aZ8RdnWVPtmBDWcgwszn6i7b78FhGU4PJle5eMXaEjPO+8KlTVj
         BBOt7ApQOGwQOKmaMb1EGQQN/srSbTzTtJLQE4ZqKdoaTiJKTBcEAWm3X+I+m/QXXaT9
         Je1/8iamYYd69atxPsaRRv+tm+gBhG3M0R9XiA/JFUKf4a//XUGIlAIjsB0QpjOaz5Hd
         RAS9DGTzZyPreZHhjtEIRyVA2pdCKlQiI+nuCu8O1uxxqpTJwW/To/4lmBtqX4uxDJmE
         w7Gw==
X-Gm-Message-State: APjAAAWcLzD3WG8UKjJPkr6tTTQNZ86L0LyR6LK7LvXJkyvWeIO9Mz++
        ZHV/xOC4pg4AY0HNm+KtLlI6BTc=
X-Google-Smtp-Source: APXvYqxygdOhpHLx5tzXF/3yWMoK0F/y9xyRu5iDwky2a0KP1f5yVHS7RUpBgCDBQs3i6zgtzAhOFg==
X-Received: by 2002:a1c:a584:: with SMTP id o126mr18402512wme.147.1562612972910;
        Mon, 08 Jul 2019 12:09:32 -0700 (PDT)
Received: from avx2 ([46.53.249.188])
        by smtp.gmail.com with ESMTPSA id t1sm21098764wra.74.2019.07.08.12.09.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 12:09:32 -0700 (PDT)
Date:   Mon, 8 Jul 2019 22:09:30 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     thgarnie@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 06/11] x86/CPU: Adapt assembly for PIE support
Message-ID: <20190708190930.GA16215@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Garnier wrote:
> -		"pushq $1f\n\t"
> +		"movabsq $1f, %q0\n\t"
> +		"pushq %q0\n\t"
>  		"iretq\n\t"
>  		UNWIND_HINT_RESTORE
>  		"1:"

Fake PIE. True PIE looks like this:

ffffffff81022d70 <do_sync_core>:
ffffffff81022d70:       8c d0                   mov    eax,ss
ffffffff81022d72:       50                      push   rax
ffffffff81022d73:       54                      push   rsp
ffffffff81022d74:       48 83 04 24 08          add    QWORD PTR [rsp],0x8
ffffffff81022d79:       9c                      pushf
ffffffff81022d7a:       8c c8                   mov    eax,cs
ffffffff81022d7c:       50                      push   rax
ffffffff81022d7d:  ===> 48 8d 05 03 00 00 00    lea    rax,[rip+0x3]        # ffffffff81022d87 <do_sync_core+0x17>
ffffffff81022d84:       50                      push   rax
ffffffff81022d85:       48 cf                   iretq
ffffffff81022d87:       c3                      ret

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -710,7 +710,8 @@ static inline void sync_core(void)
 		"pushfq\n\t"
 		"mov %%cs, %0\n\t"
 		"pushq %q0\n\t"
-		"pushq $1f\n\t"
+		"leaq 1f(%%rip), %q0\n\t"
+		"pushq %q0\n\t"
 		"iretq\n\t"
 		UNWIND_HINT_RESTORE
 		"1:"
