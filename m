Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFB4C33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B345821734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 03:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="LnGpe1iK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgAFDAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 22:00:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35526 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgAFDAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 22:00:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so48109572wro.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 19:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IObTHxdSrTA+4cLb5d5XPNdt7irAzNjJT7xEv05gP2U=;
        b=LnGpe1iKssm4K/tw4IaseYnzPu1obNeWgBStdi3fyjqrOwhDsmG++a+dykUHhdYihU
         i+GaQuNbafyCm5T395xfJ9txQmqWd/nT+d3cLKza7wjhP8HL30ulU8teKkLqRGG6k1O5
         LEHSkt0zzGx3h09dQKoc7bcz5AotP0dRi0fhwA4VcqSG2mkHKCV/z7Z1hfmwKxlnA3Eb
         /8EuTfEsmGNxdKJx6aZvyBGA8oPzi3wWrmRrqJcdjDdlGdxwIYC5lUbUDGMG+stbPqAn
         /FcKYATNIps5xBq84LLZLv5baHL5wQTOG1wIOYiODet0TP3rCqkMcLPGmcCuopuWdFGJ
         aocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IObTHxdSrTA+4cLb5d5XPNdt7irAzNjJT7xEv05gP2U=;
        b=ikzs+AqjxEISBSMphMLUNiD3QARra15asVOGzb/LSysZwc02EiU5cC6lBm5+yeZ54F
         LKXGZqVQAESgYKWshRQa3OBB0uWcbd2HGaTqVhWQCgkGM+1ZRTnUPglpgghgZqzdnLdj
         wb/JGTT/aRfEKZXV2iZ1guA+UL7/LZAtSIX1hpbYRSePRiVAPgXNMvwsKRjLM5/fXM8H
         hQyLmz2zULUyWwh8/VkcrZYT+89N54zvF5OrrDz/1YoLo2GjfUUUIHdCSgs0DuaIzYAq
         ltXctW3WUGt81DJXItZV7jef5UtI807/IL7tTgZEN8Wn4Q9yU35FBKbd6RHSMNfGirSv
         z1AQ==
X-Gm-Message-State: APjAAAWPUSzi91Pw0MSUQ8IbG4FkqqzZmt6dObpX1e3l/7T6c3+dXWcS
        17hk69q3EoUXDVFgTfG4lb68medl10yPUEjMHcLBQw==
X-Google-Smtp-Source: APXvYqwKkrzknw/83vnmM3PEodvoeLd8EHhzBeNAPpBu/M+mPCRybjaV4kVYmIXB2Q9S7tjmgF8MkKKLUPUbNNn+RnU=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr97661644wrn.251.1578279639876;
 Sun, 05 Jan 2020 19:00:39 -0800 (PST)
MIME-Version: 1.0
References: <20200105025215.2522-1-guoren@kernel.org> <20200105025215.2522-2-guoren@kernel.org>
 <20200106024515.GA1021@andestech.com>
In-Reply-To: <20200106024515.GA1021@andestech.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 6 Jan 2020 08:30:29 +0530
Message-ID: <CAAhSdy2N1v20g-WGo99Utrvhj4NXZeFP-is1jqCs9DE_Zs2VKg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: Add vector ISA support
To:     Alan Kao <alankao@andestech.com>
Cc:     guoren@kernel.org, linux-arch@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <ren_guo@c-sky.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 8:15 AM Alan Kao <alankao@andestech.com> wrote:
>
> Hi Guo,
>
> On Sun, Jan 05, 2020 at 10:52:15AM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> > 128bit-vlen and it's based on linux-5.5-rc4.
> >
>
> According to https://lkml.org/lkml/2019/11/22/2169, in which Paul has stated
> that "we plan to only accept patches for new modules or extensions that have
> been frozen or ratified by the RISC-V Foundation."
>
> Is v0.8 ratified enough for now?

As-per the patch acceptance policy, we cannot merge it now (just like KVM
patches) but we can always review and get the patches in final shape
by the time spec is frozen or ratified.

I think we should continue with the patch review and get this series in
good shape.

In fact, having this patches early on LKML is very helpful for people working
on RISC-V vector extension implementation in HW. On this line, this a good
contribution coming at the right time.

Regards,
Anup
