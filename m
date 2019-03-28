Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC999C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06F120643
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbfC1BYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:24:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:53032 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfC1BYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:24:02 -0400
Received: by mail-it1-f200.google.com with SMTP id 73so1815216itl.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 18:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=x700fXUW2AaUEwDlRROlDcXF0jPVAP0RcQC2HFLTwCE=;
        b=GgqVobZHt2GAAOkcz3BbnsJzZeFKkcqfR/NCz/mGPVkFTkBHTBbch3Lfi3WT/5jaMd
         mgkIWNvHinQ5B8FWd118Ph65UPOgqxv1QCzJunYeGcXgYm5Tnt+NfoKrqmZk2R/ymYts
         3tnS0ucPNYwj/l6GlOk4MDcPvucZqcBXWO5rIcZ+SEH15tXZdgMLQ/4yu2rH18ii+mxW
         futRZU5KIwJ0PQ2/MOuiwYXLgtW2rQrWB7YljmjsjGEZPZ5mdWGtJHcsIvnoDZqRIh9d
         /8toFRZkR2eCpTMzeEKOJiJGxGbgQGZcI/o9j+l9TZz/o61nstLfDLL54kZMalrkEJ4Y
         bYIg==
X-Gm-Message-State: APjAAAUq4Gzw0+YwEGHzWh7+oi02uMUTV1nz2wB4kFLQTp3+qkWGoiVu
        LTkZ2ENvdRiEdqJVVIHEMlVaAIsuiNiOmpo1xEp6wA8TzV/D
X-Google-Smtp-Source: APXvYqwO1g1uXAzpbYDpEwzNYtSF13PgKlokCKvbbel+mgkEvTQw+iPPcqWVtwAhlCsHJkLjA7PHwtZI7pcx3Wmzr8n9NhDW6qSg
MIME-Version: 1.0
X-Received: by 2002:a6b:251:: with SMTP id 78mr2817850ioc.39.1553736241460;
 Wed, 27 Mar 2019 18:24:01 -0700 (PDT)
Date:   Wed, 27 Mar 2019 18:24:01 -0700
In-Reply-To: <000000000000f1be430578524a20@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf3ccd05851d68a7@google.com>
Subject: Re: INFO: task hung in evdev_release
From:   syzbot <syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        devicetree@vger.kernel.org, dmitry.torokhov@gmail.com,
        jbrunet@baylibre.com, lgirdwood@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, rydberg@bitmath.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb
Author: Jerome Brunet <jbrunet@baylibre.com>
Date:   Tue Jul 17 15:42:50 2018 +0000

     ASoC: meson: add axg fifos DT binding documentation

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13fba69b200000
start commit:   9dcd936c Merge tag 'for-4.19/dm-fixes-4' of git://git.kern..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1007a69b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=17fba69b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88e9a8a39dc0be2d
dashboard link: https://syzkaller.appspot.com/bug?extid=a979743610b4755d4d57
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fcd826400000

Reported-by: syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com
Fixes: e32d99af6830 ("ASoC: meson: add axg fifos DT binding documentation")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
