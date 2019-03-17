Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1820811
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 17:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sWK8d3h2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfCQRCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 13:02:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42691 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfCQRCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 13:02:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id i5so12447950oto.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GvtFmK8WPwDLxm6GFd2IG6wzHH/jev3hKLZ2HTiMUng=;
        b=sWK8d3h2JvQ1vNwxcVtUGgQGfUrGmPA7oZJR3hbr4c/2rmVLhk079niCj0a5JXMUap
         GG2DHpblb6SPPllJUgkoD9KplisPBvG4Giq/arTODNGbtfdMRx3DIFnjAHhgLgFqQp4c
         +1EhpTh4w/NX0rWSLc3CcRo2kSBnj6dL9GKqCQjczHa0PY9yAVe/kDDQig6GDiWxiF/u
         2GMWp6phfichQziynTP5ICZMkEkfF2/suIaeOkWi7RpvU4wBMaTLXYi80vS+ugY5Coyl
         rQBT3tvV6mbOPefpML3AE1aE6ydNKPz7HBC4T93TWxRJ0nKf18AUu+VvDx5U7w0H2a5v
         MaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvtFmK8WPwDLxm6GFd2IG6wzHH/jev3hKLZ2HTiMUng=;
        b=tFwVKfZVbUourYYSQo81FCPK5FB1n7fVAQSv9jW1YKRBZyld4p0OW7DB5BCd+WSOHe
         PfNQBssdscJ0Ph/EvIHLXZmJKScV9wv9KrG2j2TlmKfd8aHmaP02icMMWr6UKeVhzfcR
         ENbLi+0uNHJI+DwXzBJTA9wd5mPWMPMIqr+39O4gF7yKjPbc0NhGSmCgSUKG7doF0mHH
         ocN8/yQRAtUfSZ+7cnDLNMyP7rmp/OYx+ybAqo/l2aM0sZRF6lUznPKXMLNunbSIJ/m6
         O4gXVhnEXUPiz+3TKNQKsdZLTEsmTCO8NOwI5SMa3U7xCFThOQbwM+teJDmQzHe1iOnD
         UX9A==
X-Gm-Message-State: APjAAAVDT1RvewFlCrsFpsiIhj9sWzp245Bj/NO5OHQ93M4C7dwB8hxy
        8IOPKdgj+nxXZNRG7ezHbNff42Dr8Dg/fflC/hM=
X-Google-Smtp-Source: APXvYqwXIndgz1WPSiG9/mUm4zs20RaBMqPBDpIgLbxmYwNEHjLGDIlbygRzZk5NHI78CAxC6INzuYiinRPOReAfCoA=
X-Received: by 2002:a9d:7697:: with SMTP id j23mr8016819otl.344.1552842133396;
 Sun, 17 Mar 2019 10:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190313064557.GA14531@unicorn.suse.cz>
In-Reply-To: <20190313064557.GA14531@unicorn.suse.cz>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 17 Mar 2019 17:01:37 +0000
Message-ID: <CADVatmMem3t-Lx42vU+-xN94FW5hbXjaBz3jgW6nkVouyWW-Qg@mail.gmail.com>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current mainline
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michal,

On Wed, Mar 13, 2019 at 6:45 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> Hello,
>
> I encountered a regression in current (post-5.0) mainline kernel which I
> bisected to commit 1aec4211204d ("parport: daisy: use new parport device
> model"). Running "modprobe parport_pc" hangs up:

Can you please send me your .config so that I can test it from my side.

>
> tweed:~ # ps ax | grep modprobe
>  1206 pts/0    D+     0:00 modprobe parport_pc
>  1209 ?        S      0:00 /sbin/modprobe -q -- parport_lowlevel
>  1211 pts/1    S+     0:00 grep modprobe
> tweed:~ # cat /proc/1206/stack
> [<0>] call_usermodehelper_exec+0xc7/0x140
> [<0>] __request_module+0x1a1/0x430
> [<0>] __parport_register_driver+0x142/0x150 [parport]

And also, modprobe is trying to load a dependent module, so it will be
great if you can also do a "lsmod" before doing the modprobe and I can
check what is going wrong.


-- 
Regards
Sudip
