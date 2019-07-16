Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C72C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6E72173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 20:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="UjsZ8CYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbfGPUOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 16:14:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33791 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388710AbfGPUON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 16:14:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so9651115pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=C/FZ0QAiMuLjEEngrepG7om6baxWenb4p2KWkDb57tg=;
        b=UjsZ8CYSaCmcEO+pgITQ9jydF8lFuGT7jIwJ0de2f+3jOXSfwQ2wCSNrG/jwHW0hDl
         Tjq41ee5F88S0ndqE8Cj/5mE8krz1XkOWzDBfUr4L02KADczcLjYJl7NJ+ttUaGUl+2z
         fMmZsTblTPGssZrRh/yqqkkzfnAswOBwgzJ31eiXJtQuOI+p6bJxWOpojsghFl0KMkqT
         0HBZJk9kaJsW5sHevFrU8v/YN+ph3m1OeGZxlqJCrU/SI7jnOzPdo2Z2qGPqk47U/Fmi
         7x0pMUMaYG07vAkRuyU7MKI9/J/x4lgPxvzBJz777O+NqfFYwG/zDSFzjrysykl27rZY
         P+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=C/FZ0QAiMuLjEEngrepG7om6baxWenb4p2KWkDb57tg=;
        b=SQ9MYVEgmk26DL3ygU5W/K4ym+3LY5beEKIbGxOotDrDTR0wn4BgO/7uEIn8wKA3sT
         ccTWdKTfsinFa5W4L6thc1gieaQwAna6d5+48+avE9q/0HrKmiDzXnYV0bvkSVr97BRt
         JmErQ/Ggrh4lpF3bO7AfoV4O+kaPkXZ3Yyg9DvxJ0IoTxoe+YfQP0KOolPrqJDK/bLSc
         4naczkNsHbM6Ot+5F8cT7b59AnnXPBA301J+ArxIQLisPhiW1SGPUmcWwNuA5r47YYwZ
         sJeJm0Kvd8Y/3iCi8WskQACgSjnoQDN1nySQRkTPcavKdHKlwVbw6z45qRW2WIw6q7oH
         aXWw==
X-Gm-Message-State: APjAAAX0qPBSTak/nAzcMeOap1Ywow/8f1ecNQnMA3RU5jYtvmujLyMK
        EroBINkbqPCRRauaZ82+2/MCyB4DqJA=
X-Google-Smtp-Source: APXvYqyjsJYv4MYeFqIYNMUgkBQlp+ni2ByOUQ81x8KvvHCp9j4wKlKACilqvsB/yevGexUnZ2cm2w==
X-Received: by 2002:a63:2a96:: with SMTP id q144mr24520269pgq.116.1563308052582;
        Tue, 16 Jul 2019 13:14:12 -0700 (PDT)
Received: from [25.171.20.61] ([172.58.27.255])
        by smtp.gmail.com with ESMTPSA id g66sm21989546pfb.44.2019.07.16.13.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 13:14:11 -0700 (PDT)
Date:   Tue, 16 Jul 2019 22:14:04 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <156330601781.24987.14382168743362213732.pr-tracker-bot@kernel.org>
References: <20190715151509.3151-1-christian@brauner.io> <156330601781.24987.14382168743362213732.pr-tracker-bot@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] pidfd and clone3 fixes
To:     pr-tracker-bot@kernel.org
CC:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ldv@altlinux.org
From:   Christian Brauner <christian@brauner.io>
Message-ID: <4E676721-FB86-4C28-84EF-318868F97241@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 16, 2019 9:40:17 PM GMT+02:00, pr-tracker-bot@kernel=2Eorg wrote:
>The pull request you sent on Mon, 15 Jul 2019 17:15:09 +0200:
>
>> git@gitolite=2Ekernel=2Eorg:pub/scm/linux/kernel/git/brauner/linux
>tags/for-linus-20190715
>
>has been merged into torvalds/linux=2Egit:
>https://git=2Ekernel=2Eorg/torvalds/c/3c69914b4c7b0b72ff0275c14743778057e=
e8a6e
>
>Thank you!

Btw, I also wanted to have a set of dedicated reviewers
for files this whole API touched
in maintainers=2E
Especially fork, exit, and pid since we don't have any right now=2E
Essentially, to ensure that we have a set
of eyes that need to be cc'ed on core changes=2E
I tried to get Oleg on board with me but he's pretty busy=2E
It's something I still think would be good=2E
But maybe it's not needed=2E

Christian
