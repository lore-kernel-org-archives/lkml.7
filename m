Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CB4C606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8FE21537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="th85+zag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbfGHPB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:01:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53371 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfGHPB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:01:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id x15so16168061wmj.3;
        Mon, 08 Jul 2019 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cmLrO6SgdZZXRi2BL7k7ekrcbaxMPtoX1gv5vh7hK1o=;
        b=th85+zagNvITYtMuCH1LWJQdl2IZTom7FW0ZixRGwkaOj8abqMmav1hy97sjS9QTQ8
         6LkofalcXyx1O0kMCTwWu7ttv6ZLtLdnWNsQIKXp7ac4BR2/EDRxEpCKVFnNzv7x0KSk
         uxkONO4Zq9mgDvyTcoIsuWcPjKXncKYLV7RmXJwuvNFm7lBHyLbyGzOTk3IzxRj+EkZw
         PTDV7jnzTA/6KyR0ismpoc6Sy0ooleQMOdAqM4WqZ3b2CN3P4pRXGKlJ07iSmXjrXdGQ
         JCgDYcWRVzmYS+VJl2CAAAL64qWlI63WGLA43YkfMqzkEdbpn+z1jzLssGbqHtuiCP/Q
         MOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cmLrO6SgdZZXRi2BL7k7ekrcbaxMPtoX1gv5vh7hK1o=;
        b=ho/eBGzkvZHob1XAuZo/LY/LM6SD/w8Rdu723tgoYc2PK5Ig8f/RlvXybO6FG+38bL
         4PiVryqTYb8pzWzCm/JOdzSFqHctXVmpbbYIff/GApq0n5W/+EMRpJjevuhSz28K6fs9
         gVHzBhe1TODVGO4gQkVna/Dfi9p6FXl8Rn37ZkRjue/MJjV/wO4Iw+Fq01ppIZ3J0xE/
         A26DLlX3c7NzaHxfcGgQUIdrVimrY5wktFbsbtcEn5TdW9KrYlc9QWZKxSTpRwLtDd4f
         uHXFR9w9U6LE6Sfv7Uh07vXoLzegzyFLlsoi83JejBXWhl7i9A7/pstb/xCD3fNTqi/n
         pcpw==
X-Gm-Message-State: APjAAAV8QypK/0mJRosnDfRSkUSbdmriY+DXLrFFdQEvfy+4VuBSvDyw
        2MvHitZricZdwpgO1EzuQU7iGjo1I/DNac0yqnXAvQ==
X-Google-Smtp-Source: APXvYqwOIgYRrvOZ5+Exg2Q/kUvprdasOY1nACej7FCJQHAuiquh9HSp7nkENMPYcuDwuropQdGcJPToQ0yhcmEK2hY=
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr16788036wmm.83.1562598084910;
 Mon, 08 Jul 2019 08:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190705185519.31033-1-tranmanphong@gmail.com> <20190708075255.0f337b28@lwn.net>
In-Reply-To: <20190708075255.0f337b28@lwn.net>
From:   Phong Tran <tranmanphong@gmail.com>
Date:   Mon, 8 Jul 2019 22:01:13 +0700
Message-ID: <CAD3AR6EN7n5KXnJqW0UdgB_eQjuTedB6KdC8sJ_h+MJNKB6ZmA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: usb: convert usb-help to rst
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, mchehab@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 8:52 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Sat,  6 Jul 2019 01:55:19 +0700
> Phong Tran <tranmanphong@gmail.com> wrote:
>
> > Add new index.rst and change usb-help.txt format
> > to rst.
> >
> > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
>
> Thank you for working to make the kernel's documentation better.  That
> said, I really don't think there is value in keeping this document.  It
> hasn't been updated in any useful way in decades, contains broken links,
> and the links that still work are full of obsolete information.  Honestly,
> a better patch would, IMO, just delete this file.
>
@Jonathan Corbet  it's fine to me.

Need ack from you @Greg Kroah-Hartman
if yes, I will send the cleanup patch.

Regards,
Phong.
