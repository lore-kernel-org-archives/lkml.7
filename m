Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F4DC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E509C2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569262257;
	bh=KvD6fLRfhprsPZVrNJfg2XWPRxn7aB8JcuChWQAo+ds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F/RK1sOR6linww8FinsQYBMPYmIHFCxXmarHJ4ljgb66QyxEepCaIROq6JrpZrVgY
	 qF4tFCs3e5dBgQU5TbpOsyBjMTVeObAOPSsbLixzjOEE1YCLBZSG/TA8gEYczZOXwJ
	 kN1n2QxEehEusG0UJDF9KH8tIXBhlFDKckw+NGN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440340AbfIWSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:10:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438090AbfIWSKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:10:55 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96E38217D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 18:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569262254;
        bh=KvD6fLRfhprsPZVrNJfg2XWPRxn7aB8JcuChWQAo+ds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IVINVMwHkmOGlL9HB6FsXvXgTEt4qN0WNsr4IiDVesseU4+3q7uCkMQcKNwpGdg2d
         J3y8XC/51i2cJ9QJKID8vEcuEXNznBSaSAXO19DXUc7sb09owap0iaGKIboe/1ViLG
         UAn0vEAhfyga9uRhfMhYmrPbiCT5n/Kofi2iKYh8=
Received: by mail-wr1-f50.google.com with SMTP id h7so15037385wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:10:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUr0wyCErjQUmSxGTqaA+y9c+gkRdx+oa1DT8d/Kz4a6coZ70Zb
        e7wON/m9shObLeG0Fn9or2rcTF9MwhyC8ii/P+CmGQ==
X-Google-Smtp-Source: APXvYqxMf22Qtxv28RvJGcXj21jvydzNhjpv9uM730jDDQc2vs1JXzrHu+IVI390PKNLgCUZzPg1mLn6U2pUMtf/oYU=
X-Received: by 2002:a5d:4c92:: with SMTP id z18mr501724wrs.111.1569262253107;
 Mon, 23 Sep 2019 11:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190923003846.GB15734@shao2-debian> <871rw7l9dv.fsf@rpws.prws.suse.cz>
 <20190923153908.GA379@dell5510>
In-Reply-To: <20190923153908.GA379@dell5510>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 11:10:41 -0700
X-Gmail-Original-Message-ID: <CALCETrWCQyh=QkLU-Zcy7ijb8butWGddvPiuaPuu0-tLd+ur-w@mail.gmail.com>
Message-ID: <CALCETrWCQyh=QkLU-Zcy7ijb8butWGddvPiuaPuu0-tLd+ur-w@mail.gmail.com>
Subject: Re: [LTP] 12abeb544d: ltp.read_all_dev.fail
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Richard Palethorpe <rpalethorpe@suse.de>, ltp@lists.linux.it,
        Andy Lutomirski <luto@kernel.org>, LKP <lkp@01.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 8:39 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi,
>
> > > FYI, we noticed the following commit (built with gcc-7):
>
> > > commit: 12abeb544d548f55f56323fc6e5e6c0fb74f58e1 ("horrible test hack")
> > > https://kernel.googlesource.com/pub/scm/linux/kernel/git/luto/linux.git random/kill-it
>
> ...
> > > tst_test.c:1108: INFO: Timeout per run is 0h 05m 00s
> > > Test timeouted, sending SIGKILL!
> > > tst_test.c:1148: INFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > > tst_test.c:1149: BROK: Test killed! (timeout?)
>
> > So perhaps this is caused by reads of /dev/random hanging?
>
> > At any rate,
> > I suppose this is intended to deliberately break something, so we can
> > ignore it.
> Yep, I'd ignore it, [1] really looks like the commit description "horrible test hack" :)
>

Indeed.  I should have pushed this to my not-for-automated-testing tree.

--Andy
