Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEF3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A25120663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lqt/2/49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfHMR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:28:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39001 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfHMR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:28:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so107070794qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yv80EgLntszbP6TTSuSNcZVmW18fS3ZlkdDQEp8VgVs=;
        b=lqt/2/49srXKrh03BepDy8ewMxZilLS+HF5Q8tjtdHvoJ25v94i337rLbGfBQBoz/j
         5uYxhwEWDC8JbXTGO2wGuWUVicwKMYYnHxP/T3omg+jGHWt24eTisq6cOOxrucgpbgSh
         8Mb/Awr7Rmu8FNYwp+TcxQa6QTZClGnK11eXgIW5t/08reYP4+p1NqlrgI23LOM0GHo8
         n7d81aO680+1ETTNoz6Wa61+xadQDDkvkchWGDNhievj3RYAfSAZreip61Gfk44AZ1jB
         YwiKiYEcLje4kz8vDVfAsbXgTFXB7fDxFacz9pKXyv8gEhsUDse/aDpxMvCISOtnoNYG
         3pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yv80EgLntszbP6TTSuSNcZVmW18fS3ZlkdDQEp8VgVs=;
        b=BUeEoaTXmco5vhGv3QWlIjC4NCRXob995qpUencllFbud7cd3Ar/4rVEdeUUFd0Wgq
         de9RFgmvMZ3PBwOqB3+xFYBFOl86/U+9pDrAkenKY0K0FcGDYDOwJh7sk2udLy+jnmtI
         OCHOiRKB/aeT1KxkpWg3jqretS5glJijsaj6FNlYzawZTsr2Hc8e3pZb62JYYOzQju5C
         lq/TAOyTOnyqkGJdR+IjByM/Q1haWYh0jUDeFTX5SaRbGlM9fTr9pTJrYnT9u8a/McJb
         forClsYu/mJbxFq4p2ckZJJqmSvfm1th/d8FV15usu1+zzJGsjx6gR4pIdM1pJxcXX22
         wCcA==
X-Gm-Message-State: APjAAAVIC/mtphhYMuJy8BEHSUBgLWBiCemxU30AYQSv8ZKpfap7xGL3
        dCvS46rvekLxdOxJwyaYd+CjhMFqLGGHl2Kd+nwUbw==
X-Google-Smtp-Source: APXvYqwjzhV0kDofeJYBNfZiu4sKgLdBAjdHPNSXHEraksdZW2nTzfcS4y9kTvM4BM8tj6/KYmHQMElrErf5PqkmmgQ=
X-Received: by 2002:ac8:6c9:: with SMTP id j9mr3573806qth.76.1565717315175;
 Tue, 13 Aug 2019 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190613184923.245935-1-nhuck@google.com> <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
In-Reply-To: <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 13 Aug 2019 10:28:24 -0700
Message-ID: <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up to see if this patch is going to be accepted.
