Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00482C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B740220883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJYjmgh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfDHHV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:21:27 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:45733 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfDHHV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:21:27 -0400
Received: by mail-io1-f45.google.com with SMTP id s7so10116450iom.12;
        Mon, 08 Apr 2019 00:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hyhNPMHVMQMWjlYRq6ApiDESt59FD7YPy2Dj6OkTqHw=;
        b=rJYjmgh35aIjpllE9sM9jac6hnTst+bvKDKFeuWmz6DqKbke2bnKI1FoIpWkIb7gfJ
         4MciNnFUKG2B7lw9asx78pz48I2dAuKoRLixifCZTaW9+REfD9ryqb943qwTkslZkRvo
         CFDXkx1+XP1M3CeWcsqXDhA4sgW2hmZaiQUb0M428FTwLhwrnO+uozTPnmR0jsV9KsIJ
         TqWgdsltE2f2j1EWtyQUUJsszCH2iS0FQwfWhQQbzDMccK7bvUUPguvAovoA8MKJj7dV
         XNftFFKEkA62IXu9bvucOWFC11Rt7Go8WQA3S2sE8JNv7buLXdZENz25CkIVrW24Uif/
         I8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hyhNPMHVMQMWjlYRq6ApiDESt59FD7YPy2Dj6OkTqHw=;
        b=DlbVbJhbpeKVjgwCsby7XbNlllyelbxm6JS8meoHSBy7fd469QA4dXaWNKEeZm0xl0
         LbIU9cToJcfxP1VuYMRwM4atsRUpgHi17nG26drYadQ9Il3DcQY32D7snWIHN9p5HkkE
         cgKXIagscsy/O5bm8qsV7u2GrEWOmHgtn5JMYgtpkKAx0ZsKlG9fg4KLyoWqmSOCjxyo
         iFJjWDPrUUPn/KEMk4vZp9kVYNCFf2CnhGrKMtSU/61r7VqrENPpJmWOBQOpcLKsoD2r
         Jx5OQt4Zhf6iafxqoGgqJWur3xd8lEeCSsd4fIVrzkbCuGiwo7zs9G74LF49QPQWXacg
         3rmw==
X-Gm-Message-State: APjAAAVrYLMHNEqDm71hXzPXs0G1aSK77jCWzy9d3P5JK6WgHy7kamKT
        53bfNJ2q72kdH7Jw79bCNDOSsDzfGDADGw0DruRKqVKT+DI=
X-Google-Smtp-Source: APXvYqxYm4u699D6MfjTeITziSplyKn8sEt7CI+fms+8TeorDqWI0J0hJo0VdysuCLO8SV1nCLDMEz0dT8DwxZa1/Vs=
X-Received: by 2002:a6b:cd89:: with SMTP id d131mr18607268iog.213.1554708086032;
 Mon, 08 Apr 2019 00:21:26 -0700 (PDT)
MIME-Version: 1.0
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Mon, 8 Apr 2019 09:21:13 +0200
Message-ID: <CADyDSO6k8vYb1eryT4g6+EHrLCvb68GAbHVWuULkYjcZcYNhhw@mail.gmail.com>
Subject: [REGRESSION] AppArmor module parameter layout changed with c5459b829b716
To:     linux-kernel@vger.kernel.org
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

A recent commit changed how `/sys/module/apparmor/parameters/enabled`
looks. It was "Y"/"N" before, now it is an integer. I *think* the
commit that changed this was:

commit c5459b829b716dafd226ad270f25c9a3050f7586
Author: Kees Cook <keescook@chromium.org>
Date:   Thu Sep 13 22:28:48 2018 -0700

    LSM: Plumb visibility into optional "enabled" state

I haven't recompiled with a revert, but changing the module-parameter
type looks like the obvious culprit. I don't see how this change can
be safe?

This breaks the AppArmor detection of `dbus-broker`. Can the commit be reverted?

Thanks
David
