Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C718C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312AC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5ldiDES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbfEMQSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:18:40 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45444 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbfEMQSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:18:37 -0400
Received: by mail-ua1-f67.google.com with SMTP id n7so5019034uap.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=L3LU3ww7WrkzHMtYsuuf2zQt4k+sdxI7TqmkMgaJQWU=;
        b=G5ldiDESrOvAWWdLZwcE9A08+emS6Z8k1ss9348TCBOVWo0b+kvZ33MIL8uwQFrWvB
         NQBx7bOD2QELaIzDyc8VnPKPk1lg5TsWLykqG6uOl/t2SD8cBr3w5RgoO8CN0li4eUrc
         K4lKdveXJgH9wFsSlk11ljnT2LZTAuYXihltQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=L3LU3ww7WrkzHMtYsuuf2zQt4k+sdxI7TqmkMgaJQWU=;
        b=oey/y+r3ySFayYQ+OxJquNnIXCpuHeFa/IMU9BKex6crHiqNyijbjZbCsmDmDJ1UnU
         DKK+Nbqx3kziC/TTBmoAfnmKFD0ie+XWO7qnQ90HC0zKJdR28iVMEPrf4Ut+ThGY7O5r
         JlFey2mcnM2TaPokwEqtyKFtHlk3mkip3y5vhnD85MROWsN0cxcmIXIHUdHLum/AYazB
         w++spRknZwkPZMp0QtoS6vGsmZo39qY9XceG2o2fqnfbzau1yb7HA1LFUivVocSVt0dJ
         fawkJt/Heez/uGlypB8lEnXsw+6f9W2emYGXh7rExKQaQ6y9DQ8svwoZwLJQ4/05I+zd
         BCvA==
X-Gm-Message-State: APjAAAWQFuuJyslZMcoG08782lUui1j9ZMxyVdEh7xlx7PPnfzEJsfX3
        rqCD6QrcqgEIwNC7+NukbpH+cI+ZK30=
X-Google-Smtp-Source: APXvYqwhLczgLZ30WyCtHCFiwgsEc/9gkqSv6mVJ6nt3K/58QiAZvTDXEhl6YBl6CpdcC4rYskqecg==
X-Received: by 2002:a9f:3731:: with SMTP id z46mr1773207uad.16.1557764315574;
        Mon, 13 May 2019 09:18:35 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id v141sm7477090vsc.8.2019.05.13.09.18.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 09:18:34 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id g16so5035576uad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 09:18:34 -0700 (PDT)
X-Received: by 2002:ab0:2709:: with SMTP id s9mr13325214uao.21.1557764314196;
 Mon, 13 May 2019 09:18:34 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 13 May 2019 09:18:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
Message-ID: <CAD=FV=VOAjgdrvkK8YKPP-8zqwPpo39rA43JH2BCeYLB0UkgAQ@mail.gmail.com>
Subject: Problems caused by dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues
To:     Tim Murray <timmurray@google.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        LKML <linux-kernel@vger.kernel.org>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wanted to jump on the bandwagon of people reporting problems with
commit a1b89132dc4f ("dm crypt: use WQ_HIGHPRI for the IO and crypt
workqueues").

Specifically I've been tracking down communication errors when talking
to our Embedded Controller (EC) over SPI.  I found that communication
errors happened _much_ more frequently on newer kernels than older
ones.  Using ftrace I managed to track the problem down to the dm
crypt patch.  ...and, indeed, reverting that patch gets rid of the
vast majority of my errors.

If you want to see the ftrace of my high priority worker getting
blocked for 7.5 ms, you can see:

https://bugs.chromium.org/p/chromium/issues/attachmentText?aid=392715


In my case I'm looking at solving my problems by bumping the CrOS EC
transfers fully up to real time priority.  ...but given that there are
other reports of problems with the dm-crypt priority (notably I found
https://bugzilla.kernel.org/show_bug.cgi?id=199857) maybe we should
also come up with a different solution for dm-crypt?


Thanks!

-Doug
