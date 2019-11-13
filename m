Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BEFC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDB4222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573606796;
	bh=4yb7lHvzpbKW8T+vAxn8lrwtcnJIt7w1XfolQKSalHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JYL3Rgxd6Tp9vie3UpWAWAaJw2E9+2pnyjhdgTXOZTY3O7J+F1DvF00lIoczJIW4y
	 MEE0Hl83T8CNL+fpNkwX1UXZ5Kkz2hCyJy76ypxuNhd3JdKgs6ZZqvkDOoY+EO6ihd
	 QpS1MXYa/T3W+0CNxJw9e7EcHUIzV81505s2Tgsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfKMA7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:59:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfKMA7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 19:59:54 -0500
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1907D21A49;
        Wed, 13 Nov 2019 00:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573606794;
        bh=4yb7lHvzpbKW8T+vAxn8lrwtcnJIt7w1XfolQKSalHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJuvo9RjvuXk1csk0IjP8HgMsg3QrX+FO4QOK52XFbZ7rda76fIOFWiyhvKCJ+BEM
         fqMgQ9J9nRcO8NCM6Wr6uss6xlhl+oJebbpuDISQTaepRw5EqxggjI/lHDpRXztM1w
         ClsqQsIkzJsN2ZpAobgaX4SKMy0wZRoFcvSA+D9A=
Received: by mail-vs1-f50.google.com with SMTP id b16so203077vso.10;
        Tue, 12 Nov 2019 16:59:54 -0800 (PST)
X-Gm-Message-State: APjAAAUXof7eO2DkG2BDJ4+CczGHaLo4PexSMzbeQeHnuwEWRSPUPosq
        DWRumo16D/wO3ipllwhay1NhCUGQCI8t9CcTFR8=
X-Google-Smtp-Source: APXvYqxzhCiicadbSiGv+3jSbe/M5DxJ56s7Ccvpv1M88wusxemgOfgl/SvhuajmiHgEoWhrEcK34Lzh+HPvO2wYK9g=
X-Received: by 2002:a05:6102:302f:: with SMTP id v15mr337333vsa.122.1573606793255;
 Tue, 12 Nov 2019 16:59:53 -0800 (PST)
MIME-Version: 1.0
References: <ed51f7dd-50a2-fbf5-7ea8-4bab6d48279e@gmail.com> <20191113003524.GQ11244@42.do-not-panic.com>
In-Reply-To: <20191113003524.GQ11244@42.do-not-panic.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Tue, 12 Nov 2019 16:59:41 -0800
X-Gmail-Original-Message-ID: <CAB=NE6XNWSPQhDkGDpL_VC-4U10bGKs6K4gzzegVQR5D41+edw@mail.gmail.com>
Message-ID: <CAB=NE6XNWSPQhDkGDpL_VC-4U10bGKs6K4gzzegVQR5D41+edw@mail.gmail.com>
Subject: Re: [PATCH] proc: Allow restricting permissions in /proc/sys
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also, while at it. Please add a test cases for all of this. There is
tools/testing/selftests/sysctl/ and the respective lib/test_sysctl.c.

  Luis
