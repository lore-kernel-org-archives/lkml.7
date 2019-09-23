Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E75C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189F721850
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="riX/7Yuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbfIWQO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45342 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388155AbfIWQO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:27 -0400
Received: by mail-lf1-f67.google.com with SMTP id r134so10554666lff.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9wM70GeJDNUGZe5ZLnpg6WVa1oWcgg26Mn74A2MeDw=;
        b=riX/7Yuy0Xbn3hi0u9kl91tN7pbLNX5VzV9CZtxq96y6hfb5qc8xynkUeTiddv9feI
         pGZouRHLz520odaH3C4i5eHcOSU2wmlZUaf/qY0dHC6KhT7T1e+X3e90ezDE21WFKixf
         sr2Yfd0PfwHvhqha2y7y8Irq5FJC1b1UQFSe5zrWLrGUALY7idJ5E+ASJmBUtZuF52CU
         j5CG26LnbkfD/rQhdtKkV0duufWoJHOL2tm4UsXlmYImXzAYTpHkqBfz+mn55cXPh5Eu
         E+y16McKF8A0X+k0OtVoVeHPFhxbfm4A9eIO826OLXfNf3WJIeIQuwNQLFUYoIgTavZ2
         VXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9wM70GeJDNUGZe5ZLnpg6WVa1oWcgg26Mn74A2MeDw=;
        b=OjqjnhEg4Y4pU69hkaz9jE71wQ3vgI0L75FyPWGUqXhxqCH7MIdWruEL/HI7blQQ+r
         imyRkThV40d1VNX+IFI7QpLy9erio2lfgcQZn3MqBz3X8W9UzFX0FOYT5XmkurOOfCTF
         1O9IqHMuoRg5xfAI+79RalAIUewSDoHkwJk09ECslGpztSRutHEik2HVeHt1r0HGOZAB
         +9mXSVtHXzM5ACZGxHKztyt1UOd5BwNiJS0xMl9xl19ewiuZ9o3m96ugMVtvwmz1gaZd
         fmy9ULJZpy82aB+lvWmP3BJdnMgQ4M6Y+dpSbCjZ83+z0WBsIyH5X7IP5sJRcFW5G999
         cDdw==
X-Gm-Message-State: APjAAAUiMlreqNiYSM8F+cgd4V4iPWXxLN84VdPhEVwbYNfB7PyEO5FX
        zFWYre5EK7focXwAMfZCpNn5tDDvfpNRPvMpV1Tq
X-Google-Smtp-Source: APXvYqwsZuFfFsvLiEx7OJoGaffrqtUPaoJCC4yACHsxjkUik2wKo5wKITCfe1sCIjGkA9P19uZ4KflJeEprpYXOUgo=
X-Received: by 2002:a05:6512:202:: with SMTP id a2mr209351lfo.175.1569255265495;
 Mon, 23 Sep 2019 09:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190923155041.GA14807@codemonkey.org.uk>
In-Reply-To: <20190923155041.GA14807@codemonkey.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Sep 2019 12:14:14 -0400
Message-ID: <CAHC9VhTyz7fd+iQaymVXUGFe3ZA5Z_WkJeY_snDYiZ9GP6gCOA@mail.gmail.com>
Subject: Re: ntp audit spew.
To:     Dave Jones <davej@codemonkey.org.uk>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 11:50 AM Dave Jones <davej@codemonkey.org.uk> wrote:
>
> I have some hosts that are constantly spewing audit messages like so:
>
> [46897.591182] audit: type=1333 audit(1569250288.663:220): op=offset old=2543677901372 new=2980866217213
> [46897.591184] audit: type=1333 audit(1569250288.663:221): op=freq old=-2443166611284 new=-2436281764244
> [48850.604005] audit: type=1333 audit(1569252241.675:222): op=offset old=1850302393317 new=3190241577926
> [48850.604008] audit: type=1333 audit(1569252241.675:223): op=freq old=-2436281764244 new=-2413071187316
> [49926.567270] audit: type=1333 audit(1569253317.638:224): op=offset old=2453141035832 new=2372389610455
> [49926.567273] audit: type=1333 audit(1569253317.638:225): op=freq old=-2413071187316 new=-2403561671476
>
> This gets emitted every time ntp makes an adjustment, which is apparently very frequent on some hosts.
>
>
> Audit isn't even enabled on these machines.
>
> # auditctl -l
> No rules

[NOTE: added linux-audit to the CC line]

There is an audit mailing list, please CC it when you have audit
concerns/questions/etc.

What happens when you run 'auditctl -a never,task'?  That *should*
silence those messages as the audit_ntp_log() function has the
requisite audit_dummy_context() check.  FWIW, this is the distro
default for many (most? all?) distros; for example, check
/etc/audit/audit.rules on a stock Fedora system.  A more selective
configuration could simply exclude the TIME_ADJNTPVAL record (type
1333) from the records that the kernel emits.

We could also add a audit_enabled check at the top of
audit_ntp_log()/__audit_ntp_log(), but I imagine some of that depends
on the various security requirements (they can be bizzare and I can't
say I'm up to date on all those - Steve Grubb should be able to
comment on that).

-- 
paul moore
www.paul-moore.com
