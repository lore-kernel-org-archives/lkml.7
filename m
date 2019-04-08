Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B1C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FD021473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PgSR3bmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfDHPDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:03:06 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:44013 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDHPDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:03:06 -0400
Received: by mail-ua1-f47.google.com with SMTP id n16so4382582uae.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GG5EnYnMlbn7HpOwBGU4nQCGdfn3UOPmyGhAFDOMTgc=;
        b=PgSR3bmDXWWuwH3xQHgwQ+UYts1iRpMTckoeVAu0LnkhorNY0kunm0SllpO2mwT0Wf
         qt9/DpfE/vR6Xh+SyS2mlHqbnumjNBp+V7bvUYpKrWLoKUBr5guavjXf51mF5Ku1zObX
         +CraGH8VuQVcZ+c/mlCORZGN/kW+ImY7EzXCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GG5EnYnMlbn7HpOwBGU4nQCGdfn3UOPmyGhAFDOMTgc=;
        b=Sq5QqApVzO/g4l6P9ESSkSl7hJUnmY+hU4EKAO2gIXCUpGN41c4Z2x3PswKYrc+hUP
         co8Iy5D/+HLXtUJGMQW8STmJtW6sH4D0UH84DqhZvL5Jlh8GB7Bb0Zv5w+EHxOuBYkK+
         yiaocz9shrJqYRwtJ8R6gM031zV9duhx+hrm1eCslk28sAC0LvkfYOT2/f6qIFV9jKVQ
         KVGjDvwHLCCERsbJc2A6wCZ0tRFCFLtl8+Oeq5bDXu27lD+WsK0/NlsbnUunuIZfunWy
         boeCk+uY8EYZRCiFRLIcvP3UG4m40v7U5W0vw3dxgZ5OmFJcXby3rVrDsYxiOrwzH3Tv
         GM5Q==
X-Gm-Message-State: APjAAAU2r7Tiq29V3viNX7kvLqHBENtEf0VVR6WBaKr0cPRaRubWUIPG
        F/qMtN1O96H1sYuWaHqueKsKrsU6ObI=
X-Google-Smtp-Source: APXvYqwCAkLoIlJC+d8sDxwmHqlzYgkfvKV2vM1dME8r0YZtVJ717TLtBtLark9G8n6QI71oY3Wk5g==
X-Received: by 2002:ab0:7042:: with SMTP id v2mr15287116ual.101.1554735784719;
        Mon, 08 Apr 2019 08:03:04 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id d6sm2164240uad.10.2019.04.08.08.03.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:03:04 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id c6so4410780uan.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:03:03 -0700 (PDT)
X-Received: by 2002:ab0:a97:: with SMTP id d23mr14537862uak.99.1554735783323;
 Mon, 08 Apr 2019 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com>
In-Reply-To: <CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Apr 2019 08:02:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL8ijV8AXLeeakvP7iXeYGSgyVWOUw+Mp_M0oxL7jf0ZA@mail.gmail.com>
Message-ID: <CAGXu5jL8ijV8AXLeeakvP7iXeYGSgyVWOUw+Mp_M0oxL7jf0ZA@mail.gmail.com>
Subject: Re: [REGRESSION] AppArmor module parameter layout changed with c5459b829b716
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 12:21 AM David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> A recent commit changed how `/sys/module/apparmor/parameters/enabled`
> looks. It was "Y"/"N" before, now it is an integer. I *think* the
> commit that changed this was:

Oooh... the _output_ appears differently based on the type. Argh. Let
me work something up...

> commit c5459b829b716dafd226ad270f25c9a3050f7586
> Author: Kees Cook <keescook@chromium.org>
> Date:   Thu Sep 13 22:28:48 2018 -0700
>
>     LSM: Plumb visibility into optional "enabled" state
>
> I haven't recompiled with a revert, but changing the module-parameter
> type looks like the obvious culprit. I don't see how this change can
> be safe?
>
> This breaks the AppArmor detection of `dbus-broker`. Can the commit be reverted?

Thanks for catching this!

-- 
Kees Cook
