Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7A0C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 841C920740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4+WwFj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfKYPLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 10:11:38 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33535 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728243AbfKYPLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:11:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574694697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B8aq+4dXm9sTBa7CCt2OVKoRFspOMELtHpVefAUQASU=;
        b=O4+WwFj8CwU1wbKab5XCNlWzrCmaBmp1VS6ffcB0ZSm0sCWemcOYskJxrUgGbI3gI/PsUx
        EjTXqYNjO+ynWUH6GiQDdknxHSqeaU56GB3UOePEz4e7enlnXQ55km5zXm3f5J9u5kAbe9
        pJpHqnrksSbdI3z65MQQ5ljQDWJNZVo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-hGsNKVxeMJSOLZs2H8k3aA-1; Mon, 25 Nov 2019 10:11:35 -0500
Received: by mail-qk1-f200.google.com with SMTP id o11so9776453qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 07:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SRvrk26Tw+YwS7iqlsr/BOs6fc+cs/57lcBe2woWPLA=;
        b=o1cOaEmnCBi9tmpo+ea0K7W/7NvGw7N4VmGyA/mUMZW+dPgc4fRzT9euXLYHDFbSjz
         iP9jawcenRDA24My1+eZQwzZfWO4BCch/lvPXX4flZlEkSqkQKBlp6kTvMcWDlPkYDH3
         A6QhA0eebpQTjFeNaS4aJ6fqflT6W3q010327be7cvGxEON/Vx5kMjy4geoDS9wZrLt0
         PayZMZGh4rFjr4aZfNJiR3faEozpVXxG6KLRag9BmkjJ1lWS5kifAKefHqN13zsYbe/A
         8OS+ZBYHu3K0EP1LfoTzpYDZHs8DB/enGXUxrrD43xNTq0uEJGfNGckNRHNu+qHr6ugn
         TdFw==
X-Gm-Message-State: APjAAAUjA5tamQiIJp3f4orxE3HrZXDYK5qUTlnch8ftOJ7FO9M9/wcM
        7928aDK3R+n6FefEJe7DrtJAM6nh2HynoeDxBG+z9PXT8PB7DN3gM/rM8S+8tKH6RGdPIltecPn
        zFU5+4hfv63UQCjhp/rLgPZjZXJZPcvmHGsD3BG8B
X-Received: by 2002:ac8:35ac:: with SMTP id k41mr10694191qtb.345.1574694694955;
        Mon, 25 Nov 2019 07:11:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwPbijPHkJf3lYg1Hh/+67Ez1Uid4YWzNyZ/Ykn4lB0wgAxoRj1JnbGOvXIYJUvTi4BNJ1NfDfylHT3OtPPqU=
X-Received: by 2002:ac8:35ac:: with SMTP id k41mr10694172qtb.345.1574694694776;
 Mon, 25 Nov 2019 07:11:34 -0800 (PST)
MIME-Version: 1.0
References: <CAO-hwJL_P92-PvyDO2gEPovAQ3vmoH4jpQd-9w5G2ug1UPjc7A@mail.gmail.com>
 <0000000000007c225e05982ab601@google.com>
In-Reply-To: <0000000000007c225e05982ab601@google.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Nov 2019 16:11:23 +0100
Message-ID: <CAO-hwJLO_yoBbROW6fHGc8QAXdPLXKroQd1EfVaEq=x6qyDy=A@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in lg4ff_set_autocenter_default
To:     syzbot <syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com>
Cc:     glider@google.com, Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
X-MC-Unique: hGsNKVxeMJSOLZs2H8k3aA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: HID: Fix assumption that devices have inputs

Looks like d9d4b1e46d9543a82c23f6df03f4ad697dab361b was the proper fix

Cheers,
Benjamin

On Mon, Nov 25, 2019 at 1:15 PM syzbot
<syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch and the reproducer did not trigger
> crash:
>
> Reported-and-tested-by:
> syzbot+1234691fec1b8ceba8b1@syzkaller.appspotmail.com
>
> Tested on:
>
> commit:         4a1d41e3 net: kasan: kmsan: support CONFIG_GENERIC_CSUM o=
n..
> git tree:       https://github.com/google/kmsan.git master
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da8247e2b2298a=
f08
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D1234691fec1b8ce=
ba8b1
> compiler:       clang version 9.0.0 (/home/glider/llvm/clang
> 80fee25776c2fb61e74c1ecb1a523375c2500b69)
>
> Note: testing is done by a robot and is best-effort only.
>

