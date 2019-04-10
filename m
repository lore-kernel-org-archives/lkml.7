Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D74B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtGDGEOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfDJSVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:21:38 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33728 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbfDJSVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:21:38 -0400
Received: by mail-vs1-f67.google.com with SMTP id a190so1959700vsd.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cja3R3p21UXnsf4jp1j6UW2X7hhQXngQByR/XkQ7/d0=;
        b=BtGDGEOp0xliko79Vrb2m+YkM9JRr3L4IhxNxzoU3ORU6lsSrDEPLtLuVwJ0P5ljUP
         JzRHPdYhQ/dXgCM+3jCzBato2MNeP+wV4z6c8noa3IEbciuzTudHBluOkvDmbpLTgnN/
         CPFAi+gK4567BFfr3DM2bUiahfm2hmo3+4Sfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cja3R3p21UXnsf4jp1j6UW2X7hhQXngQByR/XkQ7/d0=;
        b=QctbAKm1Ymkfg4/zZZEUTEZWAapAwyTiVJ7+M2Dd1/VnClpwCi4hP3uWe4PBS0uLGg
         /D5Yy26U2Y7I1FqP9fISWgJO60Hids/KWpqw62mtRVMTSdXTrZOBMTLn8OHUOIbe23GV
         8gU6TYEcIktRslFdHXdIiweCHWTUk380/2jwMMr/7+ER1KyyUbTBg3hoJxdWH73f8pS+
         HyD3NgWKNZDY1+8pmkIFuwDJTWudezasNylYlPa2Gg1AyTW/ICoZDYtu4qsRhPphD6EC
         p0Vr2c3/Gw/UpOk6Pjp9JEA+AlnJwgAXY43W4IdmH5n5JsdbB9OVrffaMkfDk3o87BA6
         /f9w==
X-Gm-Message-State: APjAAAWYp6oqbj0mym8+ujrNyk0R8su4rK6Mn4kRmJ50/HYi+EV/FQf0
        EEf2G06HrIZJjP7Su/BHaAJSIBeI/5c=
X-Google-Smtp-Source: APXvYqw4fCSf/wtYqw5SqSrS+JLWA6PnI3gGsA3wZu8HvMUsZvQ2M5nP19fnD+jjpzAUAG615Kyr1Q==
X-Received: by 2002:a67:8c0a:: with SMTP id o10mr24112716vsd.74.1554920496329;
        Wed, 10 Apr 2019 11:21:36 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id q128sm9835549vke.2.2019.04.10.11.21.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:21:35 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id d15so783827vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 11:21:35 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr25025647vkp.24.1554920494773;
 Wed, 10 Apr 2019 11:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com> <20190410174800.GA259061@google.com>
In-Reply-To: <20190410174800.GA259061@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:21:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
Message-ID: <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init sections
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 10:48 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> Thanks, if you are Ok with it, I will add your Reviewed-by tag as well.

With those fixes, absolutely. :) Thanks!

-- 
Kees Cook
