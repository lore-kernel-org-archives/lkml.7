Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A526C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03BD20663
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 04:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CD8VxCTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfC3EF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 00:05:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44139 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfC3EF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 00:05:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so1905425pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 21:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=FjEvGJEPFn8oXL1HhH1RTdos5pVV7O6gPJ+nxkGEee4=;
        b=CD8VxCTLX0oVfkAwjRaT5ggpC4ttURLUQhJmTzab1JzejecOSUsANTRoql7Fef25tA
         ZCHPS39rzpL6VF5AlyAuiduZOTR1myCZu8CYXr72d4WA5FJdbTdVI6j+ezEiAUX8H2zW
         K+fIZLIQoU6UdhYvR3yxOZqxlE7nyRdrJyVcmiQTFlnEEAUAJduE7IeyNDpiUNvOryCJ
         gHE+w+B7JzJBXw+fVbBlVYQhv80mAZhMD+hi8HNIPhLQLGF2mxY62R6vVj2ayAB/6wJl
         K9HDTwwVrJ6RMZWweJjZlXD1TIr0vb6nB5DeUQScjZSzSpbxR4ElJPdOOI0sqEd7YVKJ
         a2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=FjEvGJEPFn8oXL1HhH1RTdos5pVV7O6gPJ+nxkGEee4=;
        b=KS385pfzdWOMtJwPumfmKwoqYY3VW1KoDQU0uuxxDjwsWZe1K0mphVUqnj2XeumS6Z
         GvKAyhPDYexsxeS6OpkMqAuJQav77QoU0XK43vKcZzf9FSAOZdfoEeU1NhlX21IyjeHo
         0EIzT7hQuWkBwF7CEKsynevxwsVt0D87skp+/fTWV7+Zk5UpRogYhjeB1AqkUx1jqHUo
         X2cshIiHhbXoSWxN6MRZ3pLDTrVi100yG0xfRBclzKh10LGfKP4Pg4zp9P41hzXsb0Nc
         w9hqheFfoFNthSy94QWlKzR2szr9y80/Ubglkw64KoWiEvonrQ88z5yMvnW+sHspMaue
         i1Bg==
X-Gm-Message-State: APjAAAVc+AdLdKSc8ksLcGmnMg+sbG5B+m2vt0YmSz8pwhssjx12pNit
        mhcqg5qty4Oh9nD54NqD8YcdQoInYIfsaa77
X-Google-Smtp-Source: APXvYqw60JK5gh+MUx+YPzLAwPQQ45wjNt68g9zDP2EEPDbhzLQeXeN6QuTxlAbm7EOPmDUn/3SUmA==
X-Received: by 2002:a17:902:900a:: with SMTP id a10mr53629171plp.183.1553918728573;
        Fri, 29 Mar 2019 21:05:28 -0700 (PDT)
Received: from localhost ([64.62.193.194])
        by smtp.gmail.com with ESMTPSA id e4sm1082958pgd.32.2019.03.29.21.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 21:05:27 -0700 (PDT)
Date:   Fri, 29 Mar 2019 21:05:27 -0700 (PDT)
X-Google-Original-Date: Fri, 29 Mar 2019 20:45:23 PDT (-0700)
Subject:     Re: [RFC][PATCH 0/4 v2] sycalls: Remove args i and n from syscall_get_arguments()
In-Reply-To: <20190329134045.3fb2e69f@gandalf.local.home>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        akpm@linux-foundation.org, luto@amacapital.net,
        roland@hack.frob.com, oleg@redhat.com, linux-arch@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, gustavo@embeddedor.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux@dominikbrodowski.net, luto@kernel.org, keescook@chromium.org,
        ebiederm@xmission.com, ldv@altlinux.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2019 10:40:45 PDT (-0700), rostedt@goodmis.org wrote:
> On Fri, 29 Mar 2019 10:24:58 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> The whole series looks fine to me.
>
> Great! I may just send a pull request to you, after some fixes (see
> below).
>
>>
>> I still suspect that we should just remove the syscall_set_arguments()
>> thing entirely, but even without that, the cleanup of the calling
>> convention is at least an improvement.
>
> I'll keep it around for now, but this should go as a warning to Dmitry,
> to get something using it soon, or they may be dropped.
>
> Also, Dmitry found a few bugs with the current
> syscall_set/get_arguments() on some of the archs (riscv and csky). Which
> I'll add at the front of this series and update my changes to keep the
> same logic.

Thanks.  I'm happy to have you take the RISC-V fix through your tree.

>
> Then I'll post a non RFC version.
>
> -- Steve
