Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD25AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A90218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NwjvcSsP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfDYMMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:12:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36572 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfDYMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:12:31 -0400
Received: by mail-ed1-f66.google.com with SMTP id u57so18968853edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=epM1g0ajaGKZNZKxoMBDM4nsEuiSGxkC9wWYA+FG7b8=;
        b=NwjvcSsPH28PGnbwcWzZ0EgaKX5eO0jT7lKQuk9eoxHRXSFX2u6JtkQ2h6FSJKzQ8N
         JfObvsGKHUSLBsrZ2EAMQjevvjY6CE5mWoBu75PL0Cah8UNbibwfznsdSaBr3aqTSLHB
         1qbQEkKe4bixVnte4ASBc2Va1viSPtxBdoaLw2cOHH28JznUYuVQmShmQhRWs5bZUwBN
         mDcE9SHLFszoMtMz4JK+97jLzwBH0iCnq6UqRFa55Iix1iFTLcijgyxW18L1fKpySiIy
         rNlljhn0/0NvgpdAFU9mKRYAQltexrEb1zhkntKFQKlgqMtczKNlpEcTqYLeYT/QyAu5
         TuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=epM1g0ajaGKZNZKxoMBDM4nsEuiSGxkC9wWYA+FG7b8=;
        b=Y0c3kRqklYd2nqyR22v0V/IhQsca7aFp5CMXfyjy3Z1Kt1X4GieLwavxshx43yYxJr
         drCmjjwDrbqbYJcMVC9UxMx/KhD8YM40dfbduwAG9mkAtW+77NxARKPYMbLRvTN8O78g
         3lfanFXStcElrMwQuS9NyWqiani5rHEkoWzfPODCjy/r7H+37TVRT2IumbgMT7bo/UQX
         UdGlOgnJndSWKSDT3QY/Y4xxlHlxrUcSpV6MAHqBbATmHgh9Y8hLutTET/B339UePD6G
         gUFC9Pbh1N9HSLhEOzy1kdTnE1Yzjr75NrzNbMIiFE/ZZCeJ9pkODkpg38WwwufpUmfA
         WY1Q==
X-Gm-Message-State: APjAAAXESIt9Sqc/HyBTJT6W6z7q1hXHvu6eIkM+IqRi1CTURQHlt+AT
        aEJdrlrLlAJm8COv72Y83gO6lrLMBgUeTdQCDqbTk/m1
X-Google-Smtp-Source: APXvYqxHXqs6a6hGx35DBb5CbfP5fDbbNV4wO9dgwxKEmnLvx6BaWelrKYT2s+m/puJYSQQPJyFGU3sHaejaUUzXcSo=
X-Received: by 2002:a50:94b3:: with SMTP id s48mr5179118eda.61.1556194350079;
 Thu, 25 Apr 2019 05:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190423204154.3085-1-pasha.tatashin@soleen.com>
 <20190425093200.GM3584@localhost.localdomain> <20190425094115.GN3584@localhost.localdomain>
In-Reply-To: <20190425094115.GN3584@localhost.localdomain>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 25 Apr 2019 08:12:19 -0400
Message-ID: <CA+CK2bD7crdQB3oJ97ATkYzGK3Bw_tA9zijoAgrLB9UeWO=1Gg@mail.gmail.com>
Subject: Re: [PATCH] kexec: quiet down kexec reboot
To:     Baoquan He <bhe@redhat.com>
Cc:     Sasha Levin <sashal@kernel.org>, kexec@lists.infradead.org,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>, ebiederm@xmission.com,
        dyoung@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > And kexec doesn't print many messages. When 'kexec -e' is executed,
> > much critical work need be done in 1st kernel, and also in 2nd kernel
> > till printed messages are seen. Sometime it could hang there without a
> > notice, because we need shutdown all devices before it. Keeping it can
> > at least tell which stage it is?
> >
> > No strong objection, just we may need enable it manually if silent
> > hang is met. Anyone has different opinion?
>
> Please ignore this mail, I must be dizzy. pr_notice looks good to me.
>

Thank you for looking at this.

Pasha
