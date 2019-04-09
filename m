Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F72C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51752084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ci3YXYPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfDIUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:55:51 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33321 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfDIUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:55:51 -0400
Received: by mail-vk1-f193.google.com with SMTP id x194so73674vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZSrBQKpQd+adpCbhGYkyPOgmdo9uCPs8DR7ZiCGabo=;
        b=ci3YXYPxT6IWOfTme6bKOV/WcqJ1xHLV+6vYN329Lht7HzSfZ7oeN40siOZdIAuLfo
         T0EkSo4YAdsaw1Vw29vU46gHvr3HJITv/qkxqUkowaHgM/iRoK2vvvctzbqGLJ8sT8fi
         kwYf8rX43hUhe+vq8BCA0zSCSj33jxxMAyYEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZSrBQKpQd+adpCbhGYkyPOgmdo9uCPs8DR7ZiCGabo=;
        b=N5cs3YdZLTbmjxCX0PXUPJsaTuEZUzzH0H/B3Q6YThzUIKyi8nvSBPGTul6E61PCu0
         UMqfagwBiwhT4dNEfJj2gGaL/3sIAmUHqnNHuCsJg5MJq7f4acpCF93wsiwTHOq2j2RU
         M+YByqpKqKZajk8erR1EsifuDxXFQ/NfHTEd0fFQ4QekL9GWrBFiLxGM/4I3i7+l+r+B
         DtvqAKTKg3L7oA7UcTqmP9G2V39mWeetryl8t6UWOLuddBbNVZzuhPTeEdT0R9XTNHUe
         Qq6AL/YE5E/q4GrPwPAizG0EmwuEwRB2IvuZeN0T2zRKOe8QxgoRGjIukLKLT4KqZIxq
         04Yw==
X-Gm-Message-State: APjAAAU0bbrsADWchytZB5mPdErA2RxPlluq07UfzMrH7Hqttaa2c1tb
        NK/8Tpsk0tjDA1t7/kCd+flInzNp1+s=
X-Google-Smtp-Source: APXvYqx6hIOivfBUpg2cil3yx0ZxWLA4NRZSdP0dS6x7hi8vD/vrIAspKMjmmzH6LgX3qcrEua4NTw==
X-Received: by 2002:a1f:7d4e:: with SMTP id y75mr21216435vkc.53.1554843349775;
        Tue, 09 Apr 2019 13:55:49 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id b81sm5991763vkf.47.2019.04.09.13.55.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 13:55:48 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id s63so58700vkg.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 13:55:48 -0700 (PDT)
X-Received: by 2002:a1f:2443:: with SMTP id k64mr14154520vkk.47.1554843343804;
 Tue, 09 Apr 2019 13:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190408160706.GA18786@beast> <CADyDSO4NkEY-SPT-abnyRXT9kGWhF8LbU3XQGNp-5k_15debDg@mail.gmail.com>
 <CAGXu5j+g8tPrDAYVKv26ci6zvGuvC1TMXto7weVP2QBymMRjhw@mail.gmail.com> <alpine.LRH.2.21.1904100611310.7633@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904100611310.7633@namei.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 9 Apr 2019 13:55:31 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJjaW3yayq+R9xk30h5s+u8vGptKi73o5fGK5nA4W=soA@mail.gmail.com>
Message-ID: <CAGXu5jJjaW3yayq+R9xk30h5s+u8vGptKi73o5fGK5nA4W=soA@mail.gmail.com>
Subject: Re: [PATCH] apparmor: Restore Y/N in /sys for apparmor's "enabled"
To:     James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 9, 2019 at 1:12 PM James Morris <jmorris@namei.org> wrote:
> Actually, JJ usually submits directly to Linus.

Ah! Right; I forgot. John, can you take and send this?

-- 
Kees Cook
