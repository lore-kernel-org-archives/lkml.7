Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81F5C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10EF2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="nOdet9eA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfFXExR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 00:53:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46006 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfFXExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 00:53:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id s22so8774831qkj.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y0BJHsATprHz9BlZ2Zq4EaUx+W8nGpAFxZthEBJpaX8=;
        b=nOdet9eAi4tj4B/QEvX7l1aV396PF8sazYCdAbC6yqcsOwO5H0GPwRcviJB8Fw/BAA
         DR++ztDBrNbDmV2FVQdM2Ix00sIcHnh1qobvBKaZSgZJqS6molOw/Ig/zVeCQdtGmfZl
         qKdKbvS7XNl6ASGDuCJeB0n79hpTMw6HrRnW4keFUoFpZA42ikTorRtGaUD3DjV3CBsj
         VJCCjJYuhXPRDwEfX3lDoKTGhCPljNWl1rzFOa75Fz6CfllNtS2hS4n3PWlGH8YDfbiG
         7Y/CT3msQStqTJsNleQFNx3t4ie/5WdfrYoWxvmf7Bz4h1P2QvotKFsfMCzNhclBI4cq
         YE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0BJHsATprHz9BlZ2Zq4EaUx+W8nGpAFxZthEBJpaX8=;
        b=ZgLiYQ2bMuvZsNzUISl8DkfQQEu57IgKvP1beRruwafq2FS1D4x6eAM8OMl6y1l2nD
         JvF7RcxlUNF+SRuZJNeDOwncB8L0Pjb7T6UEkkuSIhMSYItOrxYSDXWWHBR+OXyix91p
         nShLI5OdY2saP30p772Fb1b0CaIMZooNXmxobAV7tF/XN/ClRQ9CSRA5C5hpmDkuWKlX
         KGo+DyUVppd7u4EH6XHDtRLmpvuwP1ti7ZtE/5AV8pkBinw3aFGB8bDyBbsUlK7mdV7A
         doROG99+PMLDly7JeQlLy4ABtYNJ/3/EfbvuLJm+YFn3l6jACHKkgkPeLEQhZHXpEgOs
         yxwg==
X-Gm-Message-State: APjAAAVCE5IV2WbKxXsxBqFjQCHLHFDW+urdaOUq9guSeL907PKCI1PC
        Pg9gUn/q+NHcQgt12LUZa/cZheVBPTK6vsF3j0K/iQ==
X-Google-Smtp-Source: APXvYqyTvn6/nbLisQZCgx/NU1kSk1T6bSBpHRwD2XQcI8koz4Y8w95OaLYUaTVvPgHV5HG/rfDBzBH5Tttjx4jCnRY=
X-Received: by 2002:a05:620a:10b2:: with SMTP id h18mr54579978qkk.14.1561351995747;
 Sun, 23 Jun 2019 21:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190621085840.6341-1-jian-hong@endlessm.com>
In-Reply-To: <20190621085840.6341-1-jian-hong@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 24 Jun 2019 12:53:04 +0800
Message-ID: <CAD8Lp44RP+ugBcDYkap3tUL1NSq+knGJbO9A6UAmCtcjPgxTQQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btrtl: HCI reset on close for RTL8822BE
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian-Hong,

On Fri, Jun 21, 2019 at 4:59 PM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> Realtek RTL8822BE BT chip on ASUS X420FA cannot be turned on correctly
> after on-off several times.  Bluetooth daemon sets BT mode failed when
> this issue happens.
>
> bluetoothd[1576]: Failed to set mode: Failed (0x03)
>
> If BT is tunred off, then turned on again, it works correctly again.
> This patch makes RTL8822BE BT reset on close to fix this issue.

I know we've been trying to understand why Realtek's own bluetooth
driver avoids this bug, but is this solution based upon code in the
vendor driver?
At a glance I can't see the flag (or equivalent) being set there.

Daniel
