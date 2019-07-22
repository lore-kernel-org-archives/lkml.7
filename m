Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7999C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C361B21994
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/C/Qyee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfGVHbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:31:48 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36052 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGVHbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:31:48 -0400
Received: by mail-io1-f47.google.com with SMTP id o9so71864042iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goM7DFQaf6yBihv7hYKIqrgRbj96aT6x15Ur8xgtkLU=;
        b=e/C/QyeeWDa6zq+nDkcLUZ5Exo4cc7mnQg9NAgvaz/ZyM1R6o28D2ZEv26f9ZTWUBL
         iHu76n6WOhKYmjVoS8rN01eVUUGVKnGiSqh2KcJ3xnQz5OSa3GafZFXARBPLK3i+3pZ7
         COdo9q+mP/JKIQDIH4hyek/cbxEeeqxhcJv8JunZgUDvI2lYHQ+qbWq37a+uoWiHxa7A
         XCm4m01SMs7QwH6zhwzjiRmKoYdAstz/4cppv/p9Uxd+BR9E3vgTfjTnVujYA5Fp7kM3
         JBG5AacCR2DOqhiBvsGz+kPkCgAL3/HO49rWOthn+2jBUJ6t5TG13JkXryYrxMeWV4KP
         Y84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goM7DFQaf6yBihv7hYKIqrgRbj96aT6x15Ur8xgtkLU=;
        b=W6NcC5PUH/OU/r4G4y/nOZvltWycUc6NJi6ZmL3ufq/JXiquMjIj9Ygl6GdPMI1JEm
         pRDLWwK688ZsE0u89bQSNFbg399Tr11kKDn5Fw0lHrGtXAP5J5kQt3ZfkZ8sHcbW6EWw
         qHPMDJZzeqjvff5/tth9G1ojrfXSC7gtPv1VHwPud57hBCrQhv4n5dlNRufZuH75T//X
         BMLcw+5SuKBnwlXVOkUJ0eiKXmUSEr+kheKEkf7UL/7CzvmYnMnVc7usLdF+iYDkbqTf
         zMqicEu0/iCQRcLJxWjbsJyt0sEMIGAxT9ZZ0FRKw2y7KK3thONMzKaWUGnemejc16S0
         fHYg==
X-Gm-Message-State: APjAAAWwMLrITzo+RfS9e/72Mk7TZg4XXPvDJts+E+WyYdePS8lFZOyA
        OgiuUi3DFZyxpux0e/UZfpYvPV8TtTH87RqUqiA=
X-Google-Smtp-Source: APXvYqzz19Lo/4a4R605hYUOywL4Adj3EdnkvL66AHSn4jeJsq/EpCbHEulJWsRKqwZcAY2Q16lQD7xW/cl7a5YfLAM=
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr70371567jaq.43.1563780707278;
 Mon, 22 Jul 2019 00:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN9mYmBD-4GaaeW_NrDu+FDXLzr_6x+XNxfmFV6QkYCDg@mail.gmail.com>
 <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
In-Reply-To: <CAC=cRTMz5S636Wfqdn3UGbzwzJ+v_M46_juSfoouRLS1H62orQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 22 Jul 2019 12:31:36 +0500
Message-ID: <CABXGCsOo-4CJicvTQm4jF4iDSqM8ic+0+HEEqP+632KfCntU+w@mail.gmail.com>
Subject: Re: kernel BUG at mm/swap_state.c:170!
To:     huang ying <huang.ying.caritas@gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2019 at 06:37, huang ying <huang.ying.caritas@gmail.com> wrote:
>
> I am trying to reproduce this bug.  Can you give me some information
> about your test case?

It not easy, but I try to explain:

1. I have the system with 32Gb RAM, 64GB swap and after boot, I always
launch follow applications:
    a. Google Chrome dev channel
        Note: here you should have 3 windows full of tabs on my
monitor 118 tabs in each window.
        Don't worry modern Chrome browser is wise and load tabs only on demand.
        We will use this feature later (on the last step).
    b. Firefox Nightly ASAN this build with enabled address sanitizer.
    c. Virtual Machine Manager (virt-manager) and start a virtual
machine with Windows 10 (2048 MiB RAM allocated)
    d. Evolution
    e. Steam client
    f. Telegram client
    g. DeadBeef music player

After all launched applications 15GB RAM should be allocated.

2. This step the most difficult, because we should by using Firefox
allocated 27-28GB RAM.
    I use the infinite scroll on sites Facebook, VK, Pinterest, Tumblr
and open many tabs in Firefox as I could.
    Note: our goal is 27-28GB allocated RAM in the system.

3. When we hit our goal in the second step now go to Google Chrome and
click as fast as you can on all unloaded tabs.
    As usual, after 60 tabs this issue usually happens. 100%
reproducible for me.

Of course, I tried to simplify my workflow case by using stress-ng but
without success.

I hope it will help to make autotests.

--
Best Regards,
Mike Gavrilov.
