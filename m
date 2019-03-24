Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9CCC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B5E2133D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="mZ81QrQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfCXUsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:48:04 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:42799 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfCXUsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:48:04 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 34d5742e
        for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 20:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=LixV6Hl3KLHD9vhRxzJjKZmKu28=; b=mZ81Qr
        QciJXXmPLvB08EvMdrD0E+9yTLxM3+sHXd+c2KHtNUdEK1vrTVMLruAu19fMNQFC
        zyXi33bxNI8CWLMcJlLeyqsfbDpKLwbvBM5Q/SVO839ycEmjSpaIGc+Xpc0DvWH2
        wHHsXgzMYOdi3pRRhp31CQ36GQNcuR6jp+jOR0q1E8IAdLOAAS0M63w1r/PUpTen
        mLisvjhPXWQvPlZbh3u4auai0+3SIQ77+T6w+H0SHuk3ULRfCtn33lpwdRkMecON
        JmmnGksCuRqMXNqO79vsmtfu0M55nzP22j/et1tWuDxtR59UiEf0xXckvMgDSkOI
        bA5+sb2Xqx5QWiPw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 021fd5ec (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 20:25:59 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id t206so5419008oib.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 13:48:02 -0700 (PDT)
X-Gm-Message-State: APjAAAVQIUkArVOiUoni3YwJOvaOSczO+DJHRxwr4nDov3BIADZx6Kem
        LPY6Bd8oC2VD8sM+I2XbtwjKgJ99Aa5FWmJ7jwU=
X-Google-Smtp-Source: APXvYqzA+AYwpEQdAK6HnhOXA53S+3G+T997aXonMR3neb1Zs2ATi2yRVULjkAeArRZ7sttuhWPkYkokgFWBJp1Oyg0=
X-Received: by 2002:aca:550c:: with SMTP id j12mr9696195oib.52.1553460481491;
 Sun, 24 Mar 2019 13:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <201903241244.x2OCiL8P011277@sdf.org>
In-Reply-To: <201903241244.x2OCiL8P011277@sdf.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 24 Mar 2019 21:47:50 +0100
X-Gmail-Original-Message-ID: <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
Message-ID: <CAHmME9p3TR6ESekKRQxFsfQe3rZp7T4-4WLOn-SL98zUnAo2DQ@mail.gmail.com>
Subject: Re: [RFC PATCH] random: add get_random_max() function
To:     George Spelvin <lkml@sdf.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I generally use a slightly simpler algorithm in various different projects:

//[0, bound)
static unsigned long random_bounded(unsigned long bound)
{
       unsigned long ret;
       const unsigned long max_mod_bound = (1 + ~bound) % bound;

       if (bound < 2)
               return 0;
       do
               ret = random_integer();
       while (ret < max_mod_bound);
       return ret % bound;
}

//[min, max_plus_one)
static unsigned long random_range(unsigned long min, unsigned long max_plus_one)
{
       return random_bounded(max_plus_one - min) + min;
}

Is the motivation behind using Lemire that you avoid the division (via
the modulo) in favor of a multiplication?
