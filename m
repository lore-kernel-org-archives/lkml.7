Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADB4218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iuX4F0h+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfCUQgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:36:25 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45038 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfCUQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:36:25 -0400
Received: by mail-vs1-f67.google.com with SMTP id j184so4033251vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdcQTlIAINGPVpPkA6d3wrWVhVTfoib9Yhk+JeGxrB4=;
        b=iuX4F0h+7qHBvHmEtwtWnWuuVjqJ6L3uyzNWcanZIHrie0GU5HEpnrcrLDgcDhRp9V
         uKez1XkoJ9YJrrY0pbbCbNY27YdntuK7OLaiuWn/acYbjtksiLYQ3hcQ3tR9I/aEHOpO
         ctWoQV0umPUr9+XC57B07nXotO9JJrbMJoYJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdcQTlIAINGPVpPkA6d3wrWVhVTfoib9Yhk+JeGxrB4=;
        b=J08Yo69cv4aA59h4+N4st/waX9xQiiGAoq2fzMYgCSE+rrqKwMvwV77Jvx5f8YsqNI
         R9MUVeRmeLBa01bzUGtSMIKjN2wahZvh67dIJZqholT/5p9kpnqw8CDXOQbOZRaI9Koe
         sTpRplILpVaH1DCww/Hje9BO3Iz3BGNqWYD+MSPLJibgpxrHMBxdrmxBSWxou0u44rE3
         NmTCsomzo2PJaoSio5xGCJj4MmAfe75wxvOx/Zit1FNXjSS7+UrEDWMPiW4oKSZdZOXO
         aqXXuTqpc0qz3iBUKPbyHBAiylT6zPYRcmJartB+jeAFTXa8QibRvt8tT7CoGDtI+tAk
         x+Pg==
X-Gm-Message-State: APjAAAUH3kY5FPiXqfLUZFXuaRc+U6rg0aFezNzn3EFCKYM1mxNC3mhR
        A+S5RU6DLGJWTIEhqZKephANMvkab5K1ew==
X-Google-Smtp-Source: APXvYqyl7zlG8qI3XO/1SkujsUW22rxJdcNbQuT8B8t/c3/nZ3/HIkRAz+JEBUL9Vzv8etRCK5TH9A==
X-Received: by 2002:a67:f694:: with SMTP id n20mr2621048vso.9.1553186183040;
        Thu, 21 Mar 2019 09:36:23 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id t207sm259979vsc.19.2019.03.21.09.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 09:36:22 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id z6so4063501vsc.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:36:21 -0700 (PDT)
X-Received: by 2002:a67:fa94:: with SMTP id f20mr2623709vsq.172.1553186181626;
 Thu, 21 Mar 2019 09:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <ba89a02a-5550-689f-6609-1e8c025f5b91@infradead.org>
In-Reply-To: <ba89a02a-5550-689f-6609-1e8c025f5b91@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 21 Mar 2019 09:36:09 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+9e9GX1qoAw9S0r2yU-1kpqpMF7qKGyNXpBo3AVck5Ag@mail.gmail.com>
Message-ID: <CAGXu5j+9e9GX1qoAw9S0r2yU-1kpqpMF7qKGyNXpBo3AVck5Ag@mail.gmail.com>
Subject: Re: what happened to SECURITY_DAC?
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 5:39 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> wow.  Commit 70b62c25665f636c9f6c700b26af7df296b0887e
> from last Sept. 14, 2018, total commit description says:
>
>     LoadPin: Initialize as ordered LSM
>
>     This converts LoadPin from being a direct "minor" LSM into an ordered LSM.
>
> Nowhere does it say anything like "this also deletes any notions of
> DEFAULT_SECURITY and DAC."

This was a mistaken merge of chunks from a larger series that Casey
and I were working on. It should have been split out.

> Was this deletion a (sekrit) security issue that was not being highlighted on purpose?

No, just an error while refactoring to in creating CONFIG_LSM.

> and what do you recommend for simple DAC-like security?

See CONFIG_LSM. There are some related issues getting discussed here, too:
https://lore.kernel.org/linux-security-module/f23d0fad-dc72-0e53-cac6-31abfd12a050@I-love.SAKURA.ne.jp/


-- 
Kees Cook
