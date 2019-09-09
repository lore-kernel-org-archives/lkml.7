Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261F0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F144C21920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 11:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDd8X9zc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404502AbfIILyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 07:54:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39300 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404309AbfIILyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 07:54:06 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so27927702iob.6;
        Mon, 09 Sep 2019 04:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q+FVrqN+TPgVuaJbEMEH4wOrjm4xLEXbmHAWOrXAKL4=;
        b=VDd8X9zcdNLDRoJOUphP05A0tGYAcRtCichkpvkySC3B2yJlXLh6eB6Q5Yc4gCuqej
         +kA5Rr4Ch0sn1C20GDNoq/Ek7yQTbRsdY6oJyCEoh7acVqLTGppu+Z6BYAKDDP7ECJFe
         JjpTzBVM8Vo922kxFrZ8NZoCvZ7Cia0mz8utakq7eHe7hsh8gdWoDJuQHNLXfcBHt6Mc
         1tQ8Ma8U+aBt9hpTILWqwmRgr9IBZsQiI3SXuh6SgTaUtQ9OrqdseupTzVS3T1FXkSiF
         FXBj55oCIcLNhCZHBPI8Q1qqYcpYmfmDpbM5GuvDoYEF4NeCXSQ43bJMtc08O9FlXe10
         MRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q+FVrqN+TPgVuaJbEMEH4wOrjm4xLEXbmHAWOrXAKL4=;
        b=k2GQwVSpQTkvJiZ1gsg4PkNlH4LgpUvxu6Grl6x4S7W929fGi3BN1H6ZPCTno9z1vi
         mWzOU3PoxF+0h79fytvJfRtAhvHDCivOmzFdERf4C0VgQ8UrzQwfpmbTDo6ogkw55E4Z
         LVg1GtPfpOlP9nPtDySnh2JMNZzNzkO35++arKvywpRUF6cpQF+HVgipH6d8u59e4371
         biNzSnML6tv3y7zJhEftj50sMjcs04a1RjoA4qzU6YziI0Z4TToVHcJ2Vh3bLEd/Bwwv
         x3pYdEMBAtyo1pVRUslFS/NQT/F9w+cwwucZptTQ/PGepoUSAEvwwVw4N7lcSOTOB0w1
         6tcQ==
X-Gm-Message-State: APjAAAUOABqrjBVW55Ap+8buaWT1aOlxEmEj09e6lJE0ivMptzTBwN6O
        GSEsMCHXypD29wkwKCi6W1+ZecDqwmivejObGUQ=
X-Google-Smtp-Source: APXvYqyEx6LU/OST6+fUfCh4+zHDIfeEbtFGTFgt/Tb6wja+aAz6+MPQhsJFSIA+xIrZc/v9eoeTiTaJB7tXTaeJ2VI=
X-Received: by 2002:a02:3b6f:: with SMTP id i47mr546015jaf.24.1568030046006;
 Mon, 09 Sep 2019 04:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566936978-28519-1-git-send-email-peng.fan@nxp.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Mon, 9 Sep 2019 19:44:04 +0800
Message-ID: <CAA+hA=QeVphhsmuuM6XQhku7XVi+858nRrJ3jCneP+bRWBbNAw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: lpcg: write twice when writing lpcg regs
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 4:19 PM Peng Fan <peng.fan@nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> There is hardware issue that:
> The output clock the LPCG cell will not turn back on as expected,
> even though a read of the IPG registers in the LPCG indicates that
> the clock should be enabled.
>
> The software workaround is to write twice to enable the LPCG clock
> output.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Aisheng
