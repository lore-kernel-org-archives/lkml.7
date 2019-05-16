Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F3C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C71520862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 20:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kolivas-org.20150623.gappssmtp.com header.i=@kolivas-org.20150623.gappssmtp.com header.b="JxyD05FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfEPUsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 16:48:15 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:36297 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbfEPUsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 16:48:14 -0400
Received: by mail-lf1-f44.google.com with SMTP id y10so3718753lfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kolivas-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/zfJjbsgjfhcPhz4cNFPAebK7HlMUZRYQ6SujmzDQiE=;
        b=JxyD05FKofY7Pas0O5P80rykIBJ/4NSl+9du3TfMjOJX6Zu1/EdlkEZ29kFevvZS9R
         Dy8QiQ2JrqVPzEMX5KTd+I1SU4Xu8909ecfEhb4OM/XZe3FmrbOIO38DoZI3klEaRWbX
         yNY8zz/Ao7Ic49xkiIfm0OAEgDPWPtMumXvoDgJmbjMvxmEhRFIQcuqjP2HQD+jJVfUO
         KWBCG7YCpXTaf/xwj6E2EIeQ82nTn+e1o5CT4g5R+8N1FDJFLyhPgutdPO4ylP6QQyjl
         0ahfW9LWC4hMGtKAboW2TKB9gP+c1wJ1kkj+vu5xB370VHhDUhbaBtlhyrIKH9qSeygz
         Z5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/zfJjbsgjfhcPhz4cNFPAebK7HlMUZRYQ6SujmzDQiE=;
        b=XHO6js+Y9R2JjDPk2YvPEO73g1uwWMFy4VTDwhspKMwPbuYf0Zne3QqR5pJ2/0PXhm
         8kg61epZkwG4Wvlqdytydbp+qIt4ez8jszZAFdNZdEQLBGk81dfwLxnMyDLCOHKXgrqf
         ataO313Snu89JJbxdGmlQO7y5fTP2l9xKK/Fh8IIbIfyuo5kmmqWSdTik1nyb7uKYYWp
         M10BZoupP+AvmD/hsfsXcQkCqfFZngiawjgmong8NdgC7xb9jjuCLXxSQJNiw/PJMYxH
         yhRQ0XMSoA5y64rM2t9KQldVwzmJ7gB1kFgGZkt6KZ3EUgZpgGGaRuGulATtZ78mIpqL
         62/g==
X-Gm-Message-State: APjAAAWsF97wnZ2uXPf5D2j3EaKUwkDshf1wUMUFLVGZmqfAsfR8TROV
        BGTzxHI5/ZmFxdnaDp5hi/kk6jpmYMgq6oNa010+E8i+1OE=
X-Google-Smtp-Source: APXvYqyStfmGeLBlAymXcQvqe5IKhZdeKkGsEPalzGGEY9n1S5rRgPe8dDVGAxY/5HRqnoPfxO4+eWp60TVHUW3wRa4=
X-Received: by 2002:ac2:4571:: with SMTP id k17mr26302707lfm.133.1558039692425;
 Thu, 16 May 2019 13:48:12 -0700 (PDT)
MIME-Version: 1.0
From:   Con Kolivas <kernel@kolivas.org>
Date:   Fri, 17 May 2019 06:48:01 +1000
Message-ID: <CABqErrE2Sfj0wGFoVgYEu-4rpZ3KwgfHwZdinbip5Wqr=gRoNA@mail.gmail.com>
Subject: linux-5.1-ck1, MuQSS version 0.192 for linux-5.1
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Announcing a new -ck release, 5.1-ck1  with the latest version of the
Multiple Queue Skiplist Scheduler, version 0.192. These are patches
designed to improve system responsiveness and interactivity with
specific emphasis on the desktop, but configurable for any workload.

linux-5.1-ck1:
-ck1 patches:
http://ck.kolivas.org/patches/5.0/5.1/5.1-ck1/
Git tree:
https://github.com/ckolivas/linux/tree/5.1-ck

MuQSS only:
Download:
http://ck.kolivas.org/patches/muqss/5.0/5.1/0001-MultiQueue-Skiplist-Schedu=
ler-version-0.192.patch
Git tree:
https://github.com/ckolivas/linux/tree/5.1-muqss

Blog:
http://ck-hack.blogspot.com/

Web:
http://kernel.kolivas.org


This is mostly a resync from 5.0-ck1 with some build and boot fixes
courtesy of Serge Belyshev (thanks!)

Enjoy!
=E3=81=8A=E6=A5=BD=E3=81=97=E3=81=BF=E4=B8=8B=E3=81=95=E3=81=84
-ck
