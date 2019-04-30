Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D6DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C384220835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 14:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCrcJ8Gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfD3OWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 10:22:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41762 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfD3OWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 10:22:54 -0400
Received: by mail-ot1-f68.google.com with SMTP id g8so11053006otl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GhLbsCh+7+3dT0yeAZbUcY/AwuBdniC8c1Doy2RANbs=;
        b=LCrcJ8GqxP81DA7QCA7VLz3LgfcMmrt5jZfwdg6KQT5IJtjVfMjw8a5ENUnbY4V2ij
         6n0+9c5ovtEZgIcDXqUDnatVZpQqCl2uNf41zOQjbrEDfTemi+w71bQA++j963lMO8G1
         /6X4cFT7Hi5vA4h9u+M4cyw421qbK6HJwDRx1yx1G+socY34I4ae0YFrQB1vu8IhzM0/
         ep8BmjeQFWT1KBmWQrnlCYaEaGsc2co7YFHaA1F4HFd/gzt+YKvoadVwDxK92vDT8TLG
         GN9DsHIsYcAqcNHkxChgwBu7b1xt7ZpmPccxx4i82KUfzpYQO957H9K8oae6sGtEA5L5
         3P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GhLbsCh+7+3dT0yeAZbUcY/AwuBdniC8c1Doy2RANbs=;
        b=Rm4DlBPL5V/5Oj/NqestCRXreZR/06qLLlLz6saPd8lsq3fFqQxdTazXuUJ3MYAYak
         c8aFJyXVrBgOlgpInGxPvicByRVNlJQVriEyCWjg8pX24/4NkkVGTmmud4XdyClzGRQc
         TILFyUmJ1MLkQWmUTz63lS+eApmUNYz1iGhTet1ffx4VWnOp2uD/zrUduKx2Y2nN/bkk
         AkRGwJRsdP6Fkive0FePsnrSt30/E8t+qy8KVeSOtYJehjBMFVM1jjvZs0Z4+4bFFCrh
         OKe10SHUWgpNJRIiSIolrJiSp5BwWv6vf//s/YKOihw0dMdSLNjqbfxirjeSTj4R4TMN
         Q3ww==
X-Gm-Message-State: APjAAAWPJZrOkXPixGD6IkYf4d7P34UCmvJ/sMA16o3Ao/1vyvX0VwKt
        QbIQIkiQuGuhf2JYi41wcgl6posLh6yGOu5/mZW08A==
X-Google-Smtp-Source: APXvYqyEHmAehKZR1imvGsb8Kcy0DWzhy/Ln6QcqM8WmdKbxc6yx1si6SIMEV9sm/IfM6bunmGW7SK5AOOSBXMRPo2M=
X-Received: by 2002:a9d:6318:: with SMTP id q24mr2794428otk.95.1556634173787;
 Tue, 30 Apr 2019 07:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <1556517940-13725-1-git-send-email-hofrat@osadl.org>
 <CAGngYiVDFL1fm2oKALXORNziX6pdcBBNtp7rSnj_FBdr6u4j5w@mail.gmail.com>
 <20190430022238.GA22593@osadl.at> <20190430030223.GE23075@ZenIV.linux.org.uk>
 <20190430033310.GB23144@osadl.at> <20190430041934.GI23075@ZenIV.linux.org.uk>
 <CAGngYiVSg86X+jD+hgwwrOYX82Fu3OWSLygwGFzyc9wYq6AesQ@mail.gmail.com> <20190430140339.GA18986@kroah.com>
In-Reply-To: <20190430140339.GA18986@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 30 Apr 2019 10:22:42 -0400
Message-ID: <CAGngYiXbSBuce2HmbHH4kUbe2ShgheML=bp+AJ-3O+FE+37ZRw@mail.gmail.com>
Subject: Re: [PATCH V2] staging: fieldbus: anybus-s: force endiannes annotation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, devel@driverdev.osuosl.org,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 10:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Keep it bus-endian, as that's the "normal" way bus structures work (like
> PCI and USB for example), and that should be in a documented, and
> consistent, form, right?
>
> Then do the conversion when you access the field from within the kernel.

Ah ok, it's like a standard way of implementing a bus. Sounds good, I'll
spin a patch to conform to it. And while I'm at it, I'll rename fieldbus_type
because it can be confused with another fieldbus_type within the
fieldbus_dev core.
