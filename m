Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF64ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D3B21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHo82XUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbfJINC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:02:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55678 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730901AbfJINC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:02:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so2493986wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 06:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=GHo82XUApFZmoJ9rbUiaxY0lPH5g1hfz9r8MSUnSI3GN9JdNoZQcA4UQ6OJo1rICO0
         qzfEEIaPLpbItb/8PbB0tgtmMY3OvSBeFhFZiL7aO0dIhyWBySy0Gc4iZkpX6vcuzMon
         Wj//7wE6Nd30Th7JDUX9ivMJk8/CkfEoL9COKkOw/OLGxaSlPBMlO4GEdXfniAHaK+uV
         ThL1YwwiUvNrQ4RoX+Gkqtnk4np+XvZsHPcUah8iL/Z2af9/saPP/imUSPit0/RkYjkD
         lCQnoyj1ClCApdV1FAhLZTizqvX7pcIkRlATP26I2RICqhtg4PmooQaeKNBqRXA5MyyA
         j92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6gKyU2lVUG9r8tkVXQwlslVrnGaZcT+vH7d3AbPHYB0=;
        b=GZDh9BQ9xPARU/mCI9JbiBgCn0fTGJR1rM074yj+WfDmG4UoVJGQJ80+UNSMopooib
         yz1RewPfwcp1+HbHe7IyvOU/fnwfJQeq1SD7SyyJUWMOZhf/S9Y9ih8no31Hiomlc7nH
         z/h7ipPOcbykxTqaTlIWlQamtMEQSINHie6QXVuyPI+iR1gOZgK+zkRh/Vj9itj74ikh
         XWKT49PA6XK1YvSG+yWTSTEKZVdVblPs1X+ct7Fh7kRTBIKe0tTAgm1krARZQjuyV1Mi
         BKd2BDjVf5qVYschH6OFjPH8QL/1OwfzitfSQegX8EvaHQWYcl5jI8+PT/vH6TfxDarK
         KsKg==
X-Gm-Message-State: APjAAAUDCWm9T6AOH6Mgdd1OwcK9Za7HosZyRr4NF6rJZWqVOs2qvMD2
        PHOoFMBbmzvDD26ukWEx4lH1X0EhleGaUZP/wSpZaA==
X-Google-Smtp-Source: APXvYqx+LxYtjcQzWODIZ+2Z6/00LXRbD8qwCw7fnhTtTZ7OXnXpkwtdFXmQrWSQSDmS0fILF/nvqqpHFCBNgF8/Vuo=
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr2412915wmj.119.1570626144905;
 Wed, 09 Oct 2019 06:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191008105510.6975-1-javierm@redhat.com> <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
In-Reply-To: <CACdnJusuMQf8B9u83mB2Wye+aZ4aV8v4j2eFrokURHkLGA0G_w@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 9 Oct 2019 15:02:13 +0200
Message-ID: <CAKv+Gu8xgqEqeRPQSyEkcW6q0rosFRsGNdDxfOL2QdQXzkKvWw@mail.gmail.com>
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require CAP_SYS_ADMIN
To:     Matthew Garrett <mjg59@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ivan Hu <ivan.hu@canonical.com>,
        Laszlo Ersek <lersek@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Serge E. Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 at 04:18, Matthew Garrett <mjg59@google.com> wrote:
>
> On Tue, Oct 8, 2019 at 9:55 PM Javier Martinez Canillas
> <javierm@redhat.com> wrote:
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > Acked-by: Laszlo Ersek <lersek@redhat.com>
>
> Acked-by: Matthew Garrett <mjg59@google.com>

Thanks all. Queued as a fix.
