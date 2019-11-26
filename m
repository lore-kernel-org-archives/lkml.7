Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43CAC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B16B20722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDlnaR4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfKZOcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:32:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37598 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbfKZOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:32:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so14280695lfp.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=vmcsOh5lAYLTkA1r5fOkkG8vjt4H23S3Hx7zoyejk6g=;
        b=TDlnaR4G+V8dbctPrKpGqDdCxAv1NfiFadLqyL0B6GOBOpzmUqN3NTxmeEx3jKSFYn
         /SKO+knmsyErfSI9gTiSJ1JDX3tFtDL55gvbRY1zNBL0Rgc7Raw1syYsvwPgB0vbSrbn
         bdrrbt7NYTfWmffo2jUe+8fcZumFxb1KsqH71YRVqJBMHTf0UIkU9MzY2FhH8sVAIcP3
         6AAu4vc7hwo8I1Yifatcvqf82V5TRosm2UHKKYLM/BTtJKnafq6a+tyZ3BEBT54myMyu
         Y47th7oNBxu3kdpXDEWSuzAK7fMJ543wfjY7/yaNc/smOWRSD+/SuwHSRGn1uJXVWO8Q
         +JNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=vmcsOh5lAYLTkA1r5fOkkG8vjt4H23S3Hx7zoyejk6g=;
        b=MWY/WvryuY7vVGmoP/uoVL7seSmYQKdV0HCOaiZKEs+82QE+5mCK4XWgb/ZLj/dffM
         XpsMNeS+bfVhVgnmnSWnT4acnISc9GP8x72SfV6wH53mE6MKUkj65mA6z2fUuACvTpdN
         AVHWehWZ3No5B2jJondcp0986OMKeu6PoOD2X0RKeFiDwQwyOhMOp9f9Zfcwk+KcBFwy
         U8rdlB2SM4QbFFIYxcpv/YHol8vdUR+rtGZVGin6u0XnLGfj+zfskN76aKKqkNMm971X
         eO7qyJgQ6xlFhmi6Ji42FQZnW14z3ElTw53pUiXYKjuwTO1ONzB/A1U4iW3Og5/oW9fm
         B0dQ==
X-Gm-Message-State: APjAAAWWKGNEXIQDq9BpNBW2uQXSR+r/Ii7Jr7ZTAtpzxgJRIRzlhBZa
        ofYVodi8fWvsLQ0y5DpV36+q+w2hKl784uza5J2tspti
X-Google-Smtp-Source: APXvYqyYYSGFvgpnlGMtMhydAKxHlxGpGFL1743OnLwYX2mI6CRrR8wLXwD9q723zJTvN/xPz4nJh3WJTjVSAlo9Ryg=
X-Received: by 2002:ac2:4c8e:: with SMTP id d14mr17957334lfl.32.1574778766115;
 Tue, 26 Nov 2019 06:32:46 -0800 (PST)
MIME-Version: 1.0
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Tue, 26 Nov 2019 17:32:35 +0300
Message-ID: <CAE5jQCc_s2KAaPcsK1_ZH-S_JV-FnzYeqCAjnbGrn0XzosntGw@mail.gmail.com>
Subject: Announcing a user-space Linux kernel fuzzer
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     wen.xu@gatech.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is a (yet another) fast Linux kernel fuzzer:
https://github.com/atrosinenko/kbdysch. It is a collection of fuzzing
harnesses utilizing LKL (Linux Kernel Library) as a kernel to be
tested.

While it was developed independently from the Janus fuzzer, it has
some similarities: it uses LKL in user space instead of some VM-based
approaches and it can fuzz file system implementations in a
two-dimensional manner (both mutating the FS image and the syscall
sequence to be invoked).

On the other hand, it much more tends to requiring as less manual
adjustment to new file systems as possible like in "Pulling JPEGs out
of thin air" experiment from the AFL author
(https://lcamtuf.blogspot.com/2014/11/pulling-jpegs-out-of-thin-air.html).

The harnesses currently included can test:
* file system implementation
* use one file system as a model for another (triggering crash when
behaviors differ)
* eBPF verifier
* HID via the /dev/uhid pseudo device

This is still a work-in-progress in the following sense: while the
code in this repository is based on a harness that has found a couple
tens of bugs, this particular code is a *refactored* version behaving
much nicer but "some known bugs removed, some unknown ones
introduced". Specifically, right now it needs some manual fixing of
compile errors of my patched LKL version (but someday it should run on
the vanilla LKL anyway).

Best regards
Anatoly
