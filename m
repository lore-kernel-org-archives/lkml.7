Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8D1C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B92086A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 01:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raEt+MWE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfLABDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 20:03:32 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:36294 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfLABDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:03:32 -0500
Received: by mail-wr1-f54.google.com with SMTP id z3so39489906wru.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 17:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YRFgTSLDohc/KFkzl595Zseo2nKNVwU7sSyGnuw6Qw0=;
        b=raEt+MWE1hHo04FOPqeAHHVx+v7uSrAnx85gzepDWon7G4c+ofd5/fPaYtHAwGd/Pq
         PJVW0btTfhzlKy/hMa85ZUAdGcGKjeWEor6WkAm9NmGD+wVOMw4g8kO429ix7LilB3SZ
         hrkghSBpEprhBFJBvzVWAZ2xIIVhB3SMUN9a9ZRm1usqEGCB5UTZEIBXDNzAryAaei6l
         6J6n9Rr2zxC5ogwrIFTXA+qpvaKYwG/76aAEI+ibcfIIXJZWtpSifp4LRTkP+z6BWRs3
         XV9q/G3TZ8bp2ql01X0aNp8YM9AFqe8Q4RPfnxSYOjbHizye88vHiZNmwhnHu795Aq5a
         xlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YRFgTSLDohc/KFkzl595Zseo2nKNVwU7sSyGnuw6Qw0=;
        b=uGMUbuK78raL0Z0i4PMSDg+u5oDGC+Z6rMC9FVyC7cvd3lv77+Niu2j8lqyQm6P02h
         bIl9ZuiXtX9IC4P0uygdyLj7htwf8DA17efYMVaOVe3SZKVxZRGQd6PLaOvCmXBddh6V
         OWiBInAabviYmFbHe98sqwslVEC/baPk5SgN/HuOp4GNhF5HfMItwDLQm4wf4Ulb5SkP
         ftM21vuTLk7Ky9WOWwEiKRNPT8R/p9/senUKZP5xOoCSYTdhn+0HQaeOE6hoTZqqdzyf
         gkHZOMDvc3MvAp6XSkmzX82H8wGnRA//5CmGLkEl2oyiLa2lIHxoPqQMwlO+TaDmB/iG
         AFzw==
X-Gm-Message-State: APjAAAXZU+2WumLdUhRM1wRENvM+SDxamVxn0e0C0rnXy/GO6DNNQ2To
        hwAflWFlPyvEDqnGqz26xM3izA6Tv8+y8mJTpoL/smFgXBUsLA==
X-Google-Smtp-Source: APXvYqysKBIqycvNU7wGz1IWO6QfhRK9GjQi831wM28gMQ5+wtfVorluIgfYwxz13f1wczv/NAwDDTggmFIi7EkTEZM=
X-Received: by 2002:a5d:6284:: with SMTP id k4mr45296479wru.398.1575162209409;
 Sat, 30 Nov 2019 17:03:29 -0800 (PST)
MIME-Version: 1.0
References: <201912010830.w1kwu40L%lkp@intel.com> <CAD9cdQ7+BtONYX-HUXYE1k2wRYAeccjAgjSA9MPqXJUTK03pUg@mail.gmail.com>
 <CAD9cdQ44G0BeH8tnb8yPXuLBGonMT2RM6gu0fk_awB73WrvQgw@mail.gmail.com> <CAD9cdQ7hTr2T-Gm91CB=0wv=FhgEQdm+JSmyNamP7J9NdkmTNQ@mail.gmail.com>
In-Reply-To: <CAD9cdQ7hTr2T-Gm91CB=0wv=FhgEQdm+JSmyNamP7J9NdkmTNQ@mail.gmail.com>
From:   Rainer Sickinger <rainersickinger.official@gmail.com>
Date:   Sun, 1 Dec 2019 02:03:21 +0100
Message-ID: <CAD9cdQ5_U_9tTQJUf9orC+fvMO5wZ+mMjNc=H0wFo6N_d-Cq6w@mail.gmail.com>
Subject: Re: {standard input}:211: Error: operand out of range (128 is not
 between -128 and 127)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rainer
