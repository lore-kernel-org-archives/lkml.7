Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1C6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AA722ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="c5R5bL+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfGXQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:53:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:53:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so21506495pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=/6dHe5N7XGzJMTeT13e63PRDUIMz76zdv5Ig0oiXBDs=;
        b=c5R5bL+94MO/tiZpYHceuOOJ4pDqDaAqKI79pGgbQ3hRWblNVPM1wEBpOWShzp4JrW
         a1eYIt77Xz50jOpTia5iZdau+ynVq7ii3VjX6iGG2J+8izcDXKyGety2ifhyTDjh6jCj
         Hm5b3zwI2uAYG4yuCpIJxtyQ0g7xlgk4V30vYYhgKBqJl7rZrulpnyUuVd72VokBy4qL
         HUFBWNShWnvsOXyuCjTdEq3XDeG9lDCKA6thApkomT751L/hvSe7PmkqAq45wV+JE7IU
         QtuQQw2oTKqIKbMXJ0vPipk/UXD/aCitGR55+kQcwRWmS61BLPcNgL8Rsj1kAi0/j9tJ
         Wfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=/6dHe5N7XGzJMTeT13e63PRDUIMz76zdv5Ig0oiXBDs=;
        b=slPpDSOrTCtEhGOZkPBWYQC5Q2O1Bpjm5+3DevXswmInw26K0UWNakCmn3Kh1Ir5Mw
         aI2t8yK9C6vFcVFrY9gEVsSkCQveK5243q4RsLKAefU2cHxRTsSrJQn3Z/VPUmDhLFE2
         QQxJ0H+hXektuZa+Gnwr7mpXKLuy664KdG8nyDoYjiodTZ1LmHI/nCzmJT4B3Pe1BYV6
         sTigetkdMowHnxqrMOGHY7/tnrtCGerFJEjwiWlLS2XEMYO882/5U0S6UrmvXjcOPCHh
         Gx7U6d9Vtl5/KlAnAVPpwzDKHeqNHUmK9CyDZgn4HmcTxnHih2AKmL4JGsNeUXikD/2a
         R77Q==
X-Gm-Message-State: APjAAAXOp9LpLAsGSXIZ+CukSiBDrReyqe3pkNxlDr4kK/nkpszkdBSD
        WJLNot68l281PaTn61oXZuU=
X-Google-Smtp-Source: APXvYqysLzlNEq51DdxReWz4dfSxNanv1GpI4EeAG7Zf+3MfJV32v94v1OwKZyF1793+7wCG+KmLZQ==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr11966032pfn.98.1563987227909;
        Wed, 24 Jul 2019 09:53:47 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id q126sm2974497pfb.56.2019.07.24.09.53.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 09:53:47 -0700 (PDT)
Date:   Wed, 24 Jul 2019 18:53:39 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190724164816.201099-1-joel@joelfernandes.org>
References: <20190724164816.201099-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pidfd: Add warning if exit_state is 0 during notification
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <3724AB8D-81A8-40B7-A025-95CD6BAAA6D8@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2019 6:48:16 PM GMT+02:00, "Joel Fernandes (Google)" <joel@joel=
fernandes=2Eorg> wrote:
>Previously a condition got missed where the pidfd waiters are awakened
>before the exit_state gets set=2E This can result in a missed
>notification
>[1] and the polling thread waiting forever=2E
>
>It is fixed now, however it would be nice to avoid this kind of issue
>going unnoticed in the future=2E So just add a warning to catch it in the
>future=2E
>
>[1]
>https://lore=2Ekernel=2Eorg/lkml/20190717172100=2E261204-1-joel@joelferna=
ndes=2Eorg/
>
>Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes=2Eorg>
>---
> kernel/signal=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/kernel/signal=2Ec b/kernel/signal=2Ec
>index 91b789dd6e72=2E=2E349f5a67f100 100644
>--- a/kernel/signal=2Ec
>+++ b/kernel/signal=2Ec
>@@ -1885,6 +1885,7 @@ static void do_notify_pidfd(struct task_struct
>*task)
> {
> 	struct pid *pid;
>=20
>+	WARN_ON(task->exit_state =3D=3D 0);
> 	pid =3D task_pid(task);
> 	wake_up_all(&pid->wait_pidfd);
> }

Makes sense to me=2E
I'm picking this up unless someone sees a problem with this patch=2E

Reviewed-by: Christian Brauner <christian@brauner=2Eio>
