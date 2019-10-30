Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D46ECA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B41220874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sqZ7uuLJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfJ3KZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:25:28 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]:40182 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:25:27 -0400
Received: by mail-qt1-f179.google.com with SMTP id o49so2457075qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 03:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9hYolxApZ/voYxD7XS53KDc3a6r4YHM/nktkVUKF4bg=;
        b=sqZ7uuLJqy730ZPYSTR3LHmqWEKUT8SAed5nP4lEaiR0imK6och+z0G4ydgFDSC4R8
         CNWFzVe4eXEN7/5UJawavpoFt20OD5sT6lGoWKWAzT20pqBI0EspLjYfGQ5u2cjXeyFB
         mVmfgG41vaTH+sG5M30eJrVnnTYMJ5BtCc7KLg2cLLeR7NaYyqI687dkc/3qWhT1JVt/
         zQnIy5qKzlC4yAenkBP77ubVrnfVPZltYQ1NTzPNoClZVq9BKJpGdWdgEvtJVyHSi4lX
         cx2FVaZcsh9EX9lQtuwmVSZ8I6AfgdBoHUU86wXoWPV7D6z743C9IdiQyOoaqLPRqti6
         lzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9hYolxApZ/voYxD7XS53KDc3a6r4YHM/nktkVUKF4bg=;
        b=aFNl+9MRRyHwtD/MvxbI4A2SWTBFMk1Zh5+fTbiW6GOFf4+Y7AT5XlTrhU19Ni9ul8
         oI5CejJ5P7Fx8kpEOMM8u9nkd2+eqb0FFxVjcWKB47pZjcsZIP5l4Z7KjzUgko82u6Cm
         k6UM0FuKxqVIQosnvd9mTPh1NOKrrIiTtGk40uhSYN3HouPDU4nZjvPUYBnAHcCBLbO7
         LCxwdAw+hDewsuc+7H9eApbA5/jgDEfsH78w6q1Rx/3pkFGFznfFC3aLLAJCZm4IARbU
         ZSRAzmeiCyE/M1fdHmuzIQLJmyCuN6zhgaBr4hRJfCXL+t1pJpHQjBPJF3A0cxXW2Lc2
         V/hg==
X-Gm-Message-State: APjAAAUSOvoAYEfe80V6dCCeIiZYJG0vKhZp2ZhdiQqSG/tQ/SQ7uFo0
        dRaLPw9JRvu1cLS3IHLKhXfX4TjPXRTTe+2vk/epFw==
X-Google-Smtp-Source: APXvYqzNfLMLIkciJzW8nsmVfiUh78OIF1sL++gBSs7L09dwfMzhLoANZOYDahvQhclKEA2zZZCa7WDy2c6dLP7Vl2g=
X-Received: by 2002:a0c:b0fa:: with SMTP id p55mr28866680qvc.239.1572431126096;
 Wed, 30 Oct 2019 03:25:26 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 30 Oct 2019 18:25:14 +0800
Message-ID: <CAB4CAwcMqyOLJFPcVyoGuiXo-ujeyzL2TJkpZ3qAc1HymJ2x7A@mail.gmail.com>
Subject: Unexpected screen flicker during i915 initialization
To:     Jani Nikula <jani.nikula@intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        David Airlie <airlied@linux.ie>, daniel@ffwll.ch,
        intel-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,
    We have 2 laptops, ASUS Z406MA and Acer TravelMate B118, both
powered by the same Intel N5000 GemniLake CPU. On the Acer laptop, the
panel will blink once during boot which never happens on the ASUS
laptop. It caught my attention and I find the difference between them
but I need help for more information,

    The major difference happens in bxt_sanitize_cdclk() on the
following condition check.
        if (cdctl == expected)
                /* All well; nothing to sanitize */
                return;

    On the problematic Acer laptop, the value of cdctl is 0x27a while
the same cdctl is 0x278 on ASUS machine. Due to the 0x27a is not equal
to the expected value 0x278 so it needs to be sanitized by assigning
-1 to  dev_priv->cdclk.hw.vco. Then the consequent bxt_set_cdclk()
will force the full PLL disable and enable. And that's the flicker
(blink) we observed during boot.

    Although I can't find the definition about the BIT(2) of CDCLK_CTL
which cause this difference. Can anyone suggest what exactly the
problem is and how should we deal with it? Thanks.

Chris
