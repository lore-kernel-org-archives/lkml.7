Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8DCC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F6020820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdk02O+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbfFJVMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:12:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46344 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFJVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:12:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so5979470pfy.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWP8dsFw0F3yTZsQhxUJkfike3d5mOx2KJytHvDCF4E=;
        b=fdk02O+XIE+KBGHQMntn6hr5EleVtbLxU6LH3jyTkchFMeiAvyYHBSt5PngVd07x+T
         za8zvHXHZ3cSiAx8tIo7Ey/+LUkwkzK3MEQvX1SCNc/BQTA8hV34jHsn/kkFGyCzmVq5
         FA0Q+xbtIVApnAxUHOSBsFGo5iv5slEvmiHYqBDWjHOLP2Eb7Y8cmgPTgMSJV759NWr9
         79zfAf6fe+ZjQ6yW/dxmlF6vAKBcoCE3SBnIc1zXpWyIXb4xoUoS/KkrPbTaxrP09RUJ
         kH5VfXryE97eo3Dm+SVmh8KzYj3Hd6NzMHdwL7ynCIMWr+7+i9bG2NkPUkpTsZJ8z/nz
         do3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWP8dsFw0F3yTZsQhxUJkfike3d5mOx2KJytHvDCF4E=;
        b=F8bL8LeqWa6QObcDD3V4zxdAOs8CDSmZLG3dPscc3TJjKUbqOEkTseprV4s1MLXSmS
         Saq1zNTS47NkFHAbe1L9ahz05krarrKXZqOaVHuVtOCr/P8jgVkTWnrLyMTxF2u2Fx4e
         /NahKAHZrEaz07K1e7yqETwu0svALw1GbnklsP8ExK6GGBAkmgqeistivKcyRfz0uh/4
         I5SHkXjR7agcTET9tItedHWBeucxaQnE/43B2okKql11m2RpAqyi016tIKMXv2Bs5lGN
         Bl4JzM4mVAq4x2RXxt0oT+hdEBJT+HCx6Z27BvcNHm4LhQUeu6G5a6CBDzIotBiJFj2u
         hI3A==
X-Gm-Message-State: APjAAAW0ahu90UHjhr2oTwz9dJgbV3yJKAaTi+L/e6TCjlilusgKrCnL
        e4dFYXxLn+tEKSMdyD6iLGMbi7mPebfBduQ4XTP6Qg==
X-Google-Smtp-Source: APXvYqzCsPYZjA58L3xq+a+pG0OSmittIWxRSp1/J13y4kSZN3EO+wWwoIVfj6V8TvDG5XMzK/8cf5pLSIfu9b8v9A4=
X-Received: by 2002:a65:62cc:: with SMTP id m12mr17217365pgv.237.1560201129633;
 Mon, 10 Jun 2019 14:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190525165802.25944-1-xiyou.wangcong@gmail.com> <20190525183715.0778f5e5@gandalf.local.home>
In-Reply-To: <20190525183715.0778f5e5@gandalf.local.home>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 10 Jun 2019 14:11:57 -0700
Message-ID: <CAM_iQpXg9PrA_T_Argxuc+SST2CqjY=qjQA_pEgBNtC6F_a2Pw@mail.gmail.com>
Subject: Re: [PATCH 0/4] trace: introduce trace event injection
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 3:37 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> Hi Cong,
>
> Thanks for sending these patches, but I just want to let you know that
> it's currently a US holiday, and then afterward I'll be doing quite a
> bit of traveling for the next two weeks. If you don't hear from me in
> after two weeks, please send me a reminder.

This is a reminder after two weeks. :) Please review my patches
when you have a chance.

Thanks.
