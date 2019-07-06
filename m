Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C510C0650E
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4D20836
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 17:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWzW0LYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfGFRc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 13:32:57 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41146 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfGFRc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 13:32:56 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so6379074ioj.8;
        Sat, 06 Jul 2019 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SEvZkE5vJAPhuJRsrqZsuhS+PD5Zgh6qAYTfG4/9RWg=;
        b=nWzW0LYp8W1LDGaS//1OA1RobxIc5VU0heFAxlgRyqaRrd+E2vAbJ4IWUqPpzxC2NP
         bKxbljkcUx7zP1VqQoZ//yBYx5ZTuHeYNIf4AayhBSngZ3bQdhLc/WHHnhKGTTJLvjS6
         93hrs6Cmz8+cxn3rWw4bx5pAEk8hwA/RlID/aaMy9V1EtaLHrJil1i9raoOLYqwLqkab
         UVl8m8aB3oFCRjd8RLByYm/s1DnzV+V9DBXfXeS8YRUtWDdyroDxYWReVoDcXVz7Tub9
         PRKECViw+UqsNKcfLdE9qKgy5flzI/E4UCiF1ey1IluSuOVuvdYTTkNK7mVigb7uFnfw
         mBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SEvZkE5vJAPhuJRsrqZsuhS+PD5Zgh6qAYTfG4/9RWg=;
        b=hurjETG1Wn3klWj2Y3zRUeVMFFOoU6D5TixAycHrBNypTCAgYkvb74rkszRJPsZDkS
         jbGY5iwxZNFArvqt6xTNhpsrQHAc9L4HLHrw8+WGygJ6JmDJ9ctTKSZ82Xj+/s2Wjdtd
         l2Iao5Slrg4OBkWZVHRAhjuwdXXMVUqenfMkze2c2k6ZAIxIGYh8UdXz8pQ8/7rS8thc
         LS7RG+oeKO/tZmJzPj6Z3geFVxuL+F/hcxwXzvZJp89obUKmNzqzPqvhuNE47w50k7Vf
         hJO1196VRs7WwuTpYRftfOvl761Z3j3ZiKsgZV6hRrq2/35ML0LoX3t4bb1M9o/a/fAa
         mU5g==
X-Gm-Message-State: APjAAAUtepsDvNoGFKmyERkIGxcxF7/TBVd3RA8TvG4CCwaOH5IHQ8kx
        /kbHhh5hBaSYYNAWIHJo6ax2Ro2Le9F2yobYfOs=
X-Google-Smtp-Source: APXvYqyZhsWPUJypEBlw3iOzCCnc0Z8Ysl6psPw4ayKhk+owN6/VPWptNgnm20i2NBMKtNRWNVS5yDY40eR5lXoOP6Y=
X-Received: by 2002:a5d:940b:: with SMTP id v11mr2834210ion.69.1562434375888;
 Sat, 06 Jul 2019 10:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com>
 <1562410493-8661-2-git-send-email-s.mesoraca16@gmail.com> <4d943e67-2e81-93fa-d3f9-e3877403b94d@infradead.org>
In-Reply-To: <4d943e67-2e81-93fa-d3f9-e3877403b94d@infradead.org>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sat, 6 Jul 2019 19:32:44 +0200
Message-ID: <CAJHCu1+hmA6cPH78KArA2PYwWcTy6US3Ja5XcNVy1bkamddjfQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/12] S.A.R.A.: add documentation
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi,
>
> Just a few typo fixes (inline).

Hi Randy,
thank you for your help!
I'll address these and the other fixes in the next version of the patchset.

Best,

Salvatore
