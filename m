Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4FFC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A4721920
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TtZYR2EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406074AbfIGPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 11:02:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43132 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391215AbfIGPCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 11:02:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id b2so8504710otq.10;
        Sat, 07 Sep 2019 08:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQuUa7SD4x8TPRd4rEMdVFipQdAElSjSwWznDJwYZRs=;
        b=TtZYR2EFApgjge1T6n3joQtpMqyYmTxuLma+kCVNN7wn/Td2sozX4uMMJyJOBh7cW4
         kuejU+OweVVkrAGmTKoS9jy8O7VSEzhwrKsu/XQYz4JGiLlb4/v9Oj2K61iItcV03uxD
         XGbdCpzAYDZDHIfItszdiml7ALRrPBQy7oYrMe1M0q9v5OmefhcPQP6bdBjS2OFHuIHp
         s2aIyVQhQV7q5e5QDOqkOc5hFXeTww48b2ucrRtyI2y5k+8+dElAjTG39dpzMzVHV+ZF
         8mGjwrC0tO9qU5v86blecaWHXjKJC2KfzoeW8mWAmuyr6tKzygm8r2rBxPtqpw1GAF8z
         ByfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQuUa7SD4x8TPRd4rEMdVFipQdAElSjSwWznDJwYZRs=;
        b=b0l7Rd5eJHMRAw5GyE2p+BAv99UVQQHRVLuwARkAHjabdqYJ4KyU+KdLUsh0oMh+Wu
         6HwZ6ilvHbXYYXdzegOZiIRm6po/cO8GyAurfI2QaWpVPSXS71EfciIt80v7nebsrnq5
         5dUrpud8ETgRQNYlSJJJxMdHnBFIQVe+KLBDTujFbUAbUz8tEzdi/pfXfp9cjapfI2qw
         x5Yv3VY4Ulb2BSqsE5oB9AyYOlWpbKtRG77XY/Cjy69blUB6nVxcZYZJEnPlW2ohlL1b
         lOF2L0t0mY+05pnC2Bm59F7+xbIVi3wwsEzu1a3wpuOZBfDSjZYmMxIsMSXyfRrWv76J
         RFRA==
X-Gm-Message-State: APjAAAW0LE3wJCn7sCO1jrHI+8Bb9S9eH7R1zkwQipOwuateUZBJh4qj
        GcRl1dYep7hEELnkNShfiBmNyLNsKJ143m6gCSs=
X-Google-Smtp-Source: APXvYqzw933n7nrVPDE4QwDETJQm86n4LQrpvyL7WcPRzCKuuvqnDMkVghSGxwDP0EhrM2T8GOZ8diF0Pz2476G3pcE=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr12429347otk.81.1567868537282;
 Sat, 07 Sep 2019 08:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com>
 <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com> <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com>
In-Reply-To: <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 7 Sep 2019 17:02:06 +0200
Message-ID: <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

On Fri, Sep 6, 2019 at 7:58 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
[...]
> > also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
> > aren't there any busses defined in the A1 SoC implementation or are
> > were you planning to add them later?
> Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
> Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
OK, thank you for the explanation
since you're going to re-send the patch anyways: can you please
include the apb_32b bus?
all other upstream Amlogic .dts are using the bus definitions, so that
will make A1 consistent with the other SoCs


Martin
