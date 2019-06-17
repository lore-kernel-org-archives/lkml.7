Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E317C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9308208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdgzdUvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfFQQel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:34:41 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45391 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:34:41 -0400
Received: by mail-yw1-f67.google.com with SMTP id m16so5314233ywh.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEK5GNX+bpuZoHRuSIOctjT4p8HV7L7yjo7PKrt7yMM=;
        b=LdgzdUvhXoujW3ZWbkm/kXvsk1qk43c26d0kJcUSENWLRDMOPQDQU/wSA7S/rXbuE0
         uIBdXqu41j1eWF1RnIP41nvBBJMw9KMOxCEOEYkzYsUffj+xurBfqo6FCRWaWpf1UlO0
         8dUmGxd3Gz6cTk5B4+Nh2ukxD1LG7z2baJFebhFkV8LRCc3TFhLkvZGUo/g28Q8Jjsbd
         8U0yrkYb55ySqHXZtzGalTtXQjFsWahA6RpenEFrZ1s3SUukOZMpYnue4mWgqhtjdQJb
         rxfMJ0mkXpCY9gVdjsmVVeEFBfAWkx+hDUt3C3P0jEqX0F66qapjuzg0sbn0K+2ufHy3
         kLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEK5GNX+bpuZoHRuSIOctjT4p8HV7L7yjo7PKrt7yMM=;
        b=ZLIGG7ILXoKmLx3ZQe1x2geOq5XU7FzfDNVE8V/C1f7BlBlsQkbZI4XPDsjjQM+uvZ
         T3gss5/XixnU9/i2NgyLXShFajjCFZD/el7J+dVsykva+I/22+BbGJNr5V5CfPRR/G7Q
         PgHwJbFaGQPQVW3Hpv/z3hhpKx5C8eiXnqZrJJxqA0FLwKhuEqA6y/5seLArtI5ynf58
         bcNJluHg5V1EngeV1F9D1eg5/dUQk+O9yX8MrDQp1I78VdxCNS4raIIBaj4n+7pQGk7J
         E/jtUmfumTqFcxiy8Of6NfWvKfWB64cGqZ/vC+O/9xiuYBLjjr4sulOblMHFURQbin6s
         nK0Q==
X-Gm-Message-State: APjAAAUjzhg5lUWM32FE+glyz1xwRn/uC7lsErbZR2Y5pFyjOKcHkIk9
        Z5LBt4ev0aV26cFRDwRDi7se51ZHlCJtLoR090M=
X-Google-Smtp-Source: APXvYqzBeJroxdFku0ZxAcZgl9tc8mc6sC9mL3HZZZMtnEuibKjB+aB56FKg3LDiUTOZt4g+RC/rTOiUNe4tYcKNOVA=
X-Received: by 2002:a81:204:: with SMTP id 4mr14725817ywc.107.1560789280508;
 Mon, 17 Jun 2019 09:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <1560694321-31380-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1560694321-31380-1-git-send-email-linux@roeck-us.net>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 17 Jun 2019 09:34:28 -0700
Message-ID: <CAMo8BfJMUOmF_Py1wtWCKHG=S=ckrq0-K8DFHFmaDr22BUU6QA@mail.gmail.com>
Subject: Re: [PATCH] xtensa/PCI: Remove unused variable
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 7:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> gcc reports:
>
> arch/xtensa/kernel/pci.c:40:32: warning:
>         'pci_ctrl_tail' defined but not used
>
> which is indeed the case.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/xtensa/kernel/pci.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to my xtensa tree.

-- 
Thanks.
-- Max
