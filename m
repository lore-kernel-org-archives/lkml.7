Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490DC2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qB+JNVLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfC1Qry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:47:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43640 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1Qry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:47:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id g7so14490113lfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KnSk1RAVrjD3u+Wg1UFj1SvQu3NzuuXIrTD/Ljzv/pQ=;
        b=qB+JNVLb4WubV6HONxWEjmhvheE5dnl55H5KXeafFoWuLlj4+LEoqaEMT0+e3USL6F
         A1yqynFudkA+gYEm3oPKXajT6v9t5Dq822LYojx2p2VuFXVh8td+xNNr7CoCoQK5O1yU
         t7PLFYPphL7BPUijEBnldKZ75EDRFToipezzPAibBCmTPmtTRlb2sYmbeakdQbMDOWVY
         YYKqFnXf+jeCyJgCYBuBSINXDk/SSyFrob6aSbe4jJvGjaTfqHiXfm2uzBRU2Nc3KeMn
         C3EPdt8+vMXlCSoYSHFwvRiRo3pffEp9/RbSGiFd6vF4Pz9nw8Q+2imYxNIqorDGl6Yb
         5xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KnSk1RAVrjD3u+Wg1UFj1SvQu3NzuuXIrTD/Ljzv/pQ=;
        b=PZVf4ppAtVIi6MJRwTdLNyjz050CDEjif5TI93iSGRXiUv1bq0fRAtLRqxEjAFp8Lp
         4hh/IOxLU2GNpMyauTRdp1gRwJ+8eIMBdPJFOD3Z2Q7xvXWgbCBpm4JsdFRTunOL0qpx
         UQuEXbgLNjy1qqeyiUe930iq7PvbCtsuPAh2S5Wt548U+aQOQH8oBTyjTiXLCwn0tF1r
         ALx+Jq/MSzw5mi8SRc+o6Lde4IowMa0v6pHcjCjeQWlNDWpSr2/fISJYOgb41Ql/qT/a
         Lqi4vB7iwLdiQw/+4XAEjRraC5wpI1653nSei1g5RzW6Wo7/4UP8KZyVUa2oX1slj8UM
         zojQ==
X-Gm-Message-State: APjAAAVeN87ehVu6OjkGVs0KtlUqP9Aa7SJHbv8kxlufSUzzL/x2fayM
        9rblwQGvw2dfiIVSh2lUKmzdJ3PylwaDtHCNsELUXA==
X-Google-Smtp-Source: APXvYqxZEx3vvBKxGIO5Y0wLEThZPRz4tfAqeJvh763Gymi2U8kEoxjkxfhjIXfsnvtltKVtiWuX+5d/oteaHJ7b44w=
X-Received: by 2002:ac2:5961:: with SMTP id h1mr17586131lfp.167.1553791672415;
 Thu, 28 Mar 2019 09:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000086d87305801011c4@google.com> <0000000000001d3a060583d187dd@google.com>
 <CAHp75VcBAxcB8G1Dr2-nPF6N9W27O=BY4buORs_nqTM=md1=oQ@mail.gmail.com>
In-Reply-To: <CAHp75VcBAxcB8G1Dr2-nPF6N9W27O=BY4buORs_nqTM=md1=oQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:47:40 +0100
Message-ID: <CACRpkdZ0H-zmaeM02=OhFCwW914_qYoxNMJReERFcZPtgz3FwA@mail.gmail.com>
Subject: Re: general protection fault in __bfs (2)
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     syzbot <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        "H. Peter Anvin" <hpa@zytor.com>, jon.maloy@ericsson.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Brown, Len" <len.brown@intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        netdev <netdev@vger.kernel.org>, puwen@hygon.cn,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        tipc-discussion@lists.sourceforge.net,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 11, 2019 at 3:27 PM syzbot
> <syzbot+c58fa3b1231d2ea0c4d3@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 2646b90de5c3492db2ead71337fd4c7d7f549ebe
> > Author: Linus Walleij <linus.walleij@linaro.org>
> > Date:   Fri Oct 26 08:41:22 2018 +0000
> >
> >      gpio: Add global TODO file for GPIO
>
> AI is not ready to conqueror the world!

Haha yeah it feels good that syzbot seems wrong... this time :D

Yours,
Linus Walleij
