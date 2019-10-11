Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396A1ECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3CC214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfJKLRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:17:41 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:55832 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfJKLRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:17:40 -0400
Received: by mail-io1-f72.google.com with SMTP id r13so14181968ioj.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=J6IpSUQHDWERoX2AnvSyjcwg1RqT2lsBVSYteeT19hs=;
        b=jFQo/nDDSzESA/ySx4zEg2/GfvhbcjcVVuy21gZcCaDIOf9cRF3hDL3BaO5PYomEzs
         IkcTekKebxZLbd9KKp5iF9zxdhDBfEB4qrwDRzUK/zVgg9Yq3A9GAPYRxhNGiD2eV/V2
         Fzol0e2tFWaPt3CKWZzoh0cauQCuYMdjSKJ4+ulwKBz/nH9WzKnpj/cFj/3SQEu/FcPA
         +dw9uOipUpWK913D9ee4z6tsbnUdXNEO7yAxbyg9alDts7LXokzWXfAXuWYIJNNHMV1v
         PK+udQKsLfW5qvwMwcchpLS+7Kqiy+ZnB2hJ/qMfPl7AAAP+WWW2kxue/Y6eMjUrTYVy
         hkMw==
X-Gm-Message-State: APjAAAWCT5X1pfY86QKefmqO3w0zbRAQsehs7+LwdHVB3I7mbdNWhSDO
        BUgPiF4kzSWakr8eMJfMtOCPbygPtpywqUK9cQx4iD3zDY/8
X-Google-Smtp-Source: APXvYqwES4qEmYyyt71giBG7PfCAe90So4U07Z87aibJC0DoxHzB5GwTlQlGmazSj6Tp5sPaljHQBMN0gA1g6YKo8aclPUOJRcvY
MIME-Version: 1.0
X-Received: by 2002:a6b:5814:: with SMTP id m20mr16543044iob.242.1570792657772;
 Fri, 11 Oct 2019 04:17:37 -0700 (PDT)
Date:   Fri, 11 Oct 2019 04:17:37 -0700
In-Reply-To: <20191011111732.GA25982@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061e8090594a0aa4c@google.com>
Subject: Re: Re: KMSAN: uninit-value in alauda_check_media
From:   syzbot <syzbot+e7d46eb426883fb97efd@syzkaller.appspotmail.com>
To:     Jas K <jaskaransingh7654321@gmail.com>
Cc:     gregkh@linuxfoundation.org, jaskaransingh7654321@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, usb-storage@lists.one-eyed-alien.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi, just taking a crack at this. Hope you guys don't mind.

> #syz test: https://github.com/google/kasan.git 1e76a3e5

KMSAN bugs can only be tested on https://github.com/google/kmsan.git tree
because KMSAN tool is not upstreamed yet.
See https://goo.gl/tpsmEJ#kmsan-bugs for details.


> diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
> index ddab2cd3d2e7..bb309b9ad65b 100644
> --- a/drivers/usb/storage/alauda.c
> +++ b/drivers/usb/storage/alauda.c
> @@ -452,7 +452,7 @@ static int alauda_init_media(struct us_data *us)
>   static int alauda_check_media(struct us_data *us)
>   {
>   	struct alauda_info *info = (struct alauda_info *) us->extra;
> -	unsigned char status[2];
> +	unsigned char *status = us->iobuf;
>   	int rc;

>   	rc = alauda_get_media_status(us, status);
