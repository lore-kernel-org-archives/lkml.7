Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ABCC43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B796F2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556217130;
	bh=z+yQA0Bkw3i2gZWKQD9IiMLJ8Q7nYzQvxvTgRxnX9Pw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=13jz+a+xKXfFmvCTBDefajEhS9+LsPkgo/WUMYNRHjCygLp5HHRj6zPIkvVK+fnuZ
	 Gkeg/aBxuLmayDEGS0Rbao3QdKiwBvuqqjtAlzfaVbCYA+Hpe0nxDiB0ZIDJIm4Jiz
	 tqJpCXOZOdqp3xvWQGi/KG5IzbuNZlbpnvybvHio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbfDYScJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:32:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39446 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfDYScI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:32:08 -0400
Received: by mail-io1-f66.google.com with SMTP id c3so818997iok.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRiXf/0AYjA/HeJ3hn69dFn+gRAD63InC7f0LHnEv2A=;
        b=g/NW8K/Rl3bJgPwNV4/apOk+RAmb767Pp6QeYb0Ukvw9Olpg6qMdJPe6cfVWDLsSpI
         X9NAtA2t8Q0a248dGAosXHDucfXt3l+rdEgeR+GwnpmMufuynHzYlIB8C1DJ2qmMCVT+
         7g8Sl+2+ZVmayQmCH5+t2KUF0tI+8x+DGmRk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRiXf/0AYjA/HeJ3hn69dFn+gRAD63InC7f0LHnEv2A=;
        b=SAS8BezPoF9uovS2nlTDA3qISuoSOHW/wVEzNB5KKDbuJ0TNQT8OBpX3SE7aQ2kxCy
         IssFKsVXQCa3SkRJzszQCb74LPYhJOVmhMjpRnXG7QzhTh0r6kxXodOWXrO1jYRnSp3o
         OM0tzWXJ59vhoa8JH7sgdnZMR455Gf3RoEPksml735phPiJ7lAREWtNIoFEODD6lO81z
         cgHcc1X+SdZYQYKCZLjodrbx3kC16XnVWnAR03eyrqmrC/+2eR8Ffkx2ioZq6+7WVI6i
         yqncE09Gf4qL/K0akC/jPVPEdQF82SFoVJxcnvZ45iIECFB5WJvn8qUXJmv293LvtMOL
         GWMA==
X-Gm-Message-State: APjAAAUovJKuRu1NBUbAY/Fwvf5PROBxs2HRiJVpybmJL0YMCyUK2KyC
        KoXXvYKwR1u06jc3J28aQtdorJXHrn/FW98mRSRWkA==
X-Google-Smtp-Source: APXvYqwej6qE3E04G4TsNJlk8Q/dY+5xJeOGqPhanQxSpDI5vFBNey6YoTqGKCay6lTDFy39faHDhZtUVIFz3Pax2P4=
X-Received: by 2002:a05:6602:12:: with SMTP id b18mr13838300ioa.224.1556217128154;
 Thu, 25 Apr 2019 11:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190424001544.7188-1-prsriva02@gmail.com> <20190424001544.7188-2-prsriva02@gmail.com>
 <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com> <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
In-Reply-To: <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 11:31:57 -0700
Message-ID: <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
To:     prsriva <prsriva@linux.microsoft.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:19 AM prsriva <prsriva@linux.microsoft.com> wrote:
>
> I will fix the comments and send out the patchset with a cover letter.
> Thankyou for pointing this out.

Please trim the emails you reply to rather than quoting everything.

But the real reason I'm reacting to this email is because it was
marked as spam, because your SMTP setup is incorrect, and you don't go
through the proper MS SMTP server. As a result, you don't get the
proper DKIM signature for verification of the microsoft.com email
address, and sane email clients will mark your emails as spam.

Please fix.

                    Linus
