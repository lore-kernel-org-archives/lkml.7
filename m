Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D7C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90354217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyGZWwej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfDHO6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:58:03 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:40750 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfDHO6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:58:02 -0400
Received: by mail-wr1-f45.google.com with SMTP id h4so16785972wre.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+PDgDdD4gApq7T8FqVSucVJO54FwJkc2LI+UKrVhvQM=;
        b=oyGZWwej2wwNrWuKqe/NXE8/ePtL8Oedc5Iqe9aEFNusRZWMpKfxuPUUNN2bPL5Ngn
         Lrisr08KgiQeUM9FVXAJTPQ2V8RzP7mvVcUvFOIPiw7HF3insjlezvOvA05p9eO6VYy5
         MooTh5rhmRdFs299+v2j7pCrAeN7eSe3mku0UvPBg7tzsTGDi1HXwtA9Ou8xIKFLnz1m
         OXkZ51iLIBI4MZ6H4ndp81WjIVSDS1PQWjBaHmHAzMNM6K1Z/jnIU1AirO3rwvW5QW8N
         YJwU6LmpPxIMkrdbeRTAoqkDd1bEE7IOSniP0bv9p/ng2pKoVJb9e3hAjLpDJLjVfM/M
         2tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+PDgDdD4gApq7T8FqVSucVJO54FwJkc2LI+UKrVhvQM=;
        b=pkV3XX2HBzlIlzSNLBuia8ZPWnTQk3tsuKu/WsR1sqK/LInwHFSOYUh7vjt66woAJY
         a7GUWHBgm4o88q1JeQlJ9u3vfOQe07EIwpq6R8BmQImmFJcFz7cXPxU0y2xKMJIBfCUZ
         bjqs+9sXhUD5z6SZrZeHvB/Mbz5K7E3QsodzvjRPtzWSc4g7Q0wYh2XyFc/Riz4I8ZtM
         18yq3IcZoDJGQ/tdnf9JJipRBnLYjg/j9qwy1NfK6uM8bi73EtO2vkAHPX7pLjRzqV8X
         T7dPTPGqTsVFbgRu07dpiaOhBG1BDvRaAjnuyWn/soq0xG2JrUxbn7A5mHONAnQ0+VxA
         ofnw==
X-Gm-Message-State: APjAAAUrcALs4K939TGRscdJe/NilxZV8+2Xx23Pq1ke7EmU/wKMZEv4
        ZW+Dw5RwRw9+AqtSazKoVbZX5lLAQcT6/djwRRs1oY6+
X-Google-Smtp-Source: APXvYqytUmel+7AtxAIUGPDDVTxcKQsR7+Ex1JcqLRJ1xfm3a8okOYi5x9os0XwWmwB8OpJoxmxPalnc0LsGlchnkQ4=
X-Received: by 2002:adf:f488:: with SMTP id l8mr18257431wro.213.1554735479363;
 Mon, 08 Apr 2019 07:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVW2X6G=qukJTrZuUevcnrOiuShJGxnxVaqyONNxv+RYg@mail.gmail.com>
 <e5d3d2fc-874c-a8e3-1320-f9396a3621b5@redhat.com> <99dde862-6aee-65a0-8b39-33b8ac10df45@redhat.com>
 <CA+icZUUw3SgyCdk9fyv+mVUGDepDNGj8Bm7t0WWOE3Q0sHJs4Q@mail.gmail.com>
 <863a33cf-0a1a-17af-0ea8-42e288f8a1fd@redhat.com> <CA+icZUVvtLkNNor+9wQy1_bt=NfRAfJD9f_daqX2Da=EcdjAaA@mail.gmail.com>
 <5c5c169d-3bad-9e34-8c56-bedca3e5ae08@redhat.com> <CA+icZUUk8jhGqsu65A8oHFcqzrqNRon+riPff9aJu2UFLXL7wQ@mail.gmail.com>
In-Reply-To: <CA+icZUUk8jhGqsu65A8oHFcqzrqNRon+riPff9aJu2UFLXL7wQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 8 Apr 2019 16:57:48 +0200
Message-ID: <CA+icZUVy0-F7==ES2ar+0LumE3LTv8jye8LAz=DHAoDZKiyC5A@mail.gmail.com>
Subject: Re: CBL issue #431: lld: x86_64: sysfs: cannot create duplicate
 filename $module/.rodata.cst{16,32}
To:     Denys Vlasenko <dvlasenk@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have arch/x86/crypto/chacha-avx2-x86_64.S and
arch/x86/crypto/chacha-avx512vl-x86_64.S:

.rodata.cst32.CTR2BL
.rodata.cst32.CTR4BL
.rodata.cst32.CTR2BL
.rodata.cst32.CTR4BL

...and in arch/x86/crypto/sha256-avx2-asm.S and
arch/x86/crypto/sha512-avx2-asm.S:

.rodata.cst32.PSHUFFLE_BYTE_FLIP_MASK

Correct?

- Sedat -
