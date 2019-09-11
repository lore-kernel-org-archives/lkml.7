Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDCECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E68C2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="gVILecSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfIKLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 07:20:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46264 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 07:20:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so11306775wrq.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 04:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yEm/6Jz34sEd/TPS+tNQ49kUmKwP86ymVLNzLiSgWtk=;
        b=gVILecSBs6QnwsZ+tVcGKZJzUcdF/4UK/rFxniUgqk+meB/ggS8jm3zvQ5AJCIa1vz
         sDvsgTALWTwzFP8qBeo6KtR11dRAVTEe75Ub4+kCj+RKEGe/e5XPTjaPN/ISbMEiJAmb
         yId7phTTN7WWQGvCZrBW4kWBwVd60Bf3vZzwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yEm/6Jz34sEd/TPS+tNQ49kUmKwP86ymVLNzLiSgWtk=;
        b=Cg2AJgVo8w2g4mB2J/ZWb8GA8n/X8BaUZI7ocuV8JA6WbLeqZNCziP2UGk3yn0hc8s
         NuLZVYG+wWH8n5vrdMFtLnfc4vnj/A6RB6ScFCz9FIek/p1OR/gAdnk/iUuEhZtEXLnh
         Dw2EyillDg2FWz/8T5+zAB71YxKEv+xOe6U1rmmExj5U/VsCTxksxS9e28WGkv97zmMs
         5kTGpsTzaB+wH1suKm/9PSg8sBJyOgA7K/jU3pOJZP41g9+MJRNToh3n6RCS/Ok8zxA9
         Bbfit/SRDzU6tZXiznHUDDLmnfcQj2pVi9lopznzo1VVGm9NYhIIeRtXf5w3XDKrHreQ
         k+iA==
X-Gm-Message-State: APjAAAUxJ2UaOrZzF8oxRbVRdPMbrDPJPk/5WBMF+/wJr4g9Quor81MU
        8xPI8Ld94Y1eThhtLRDflHhpKA==
X-Google-Smtp-Source: APXvYqz4mviNdySjKkAku5DXmhzwzhVEEIpdN3y03EfYJn20mk48h91uhFgTy4RUInZl9y0ayE/Tmg==
X-Received: by 2002:a05:6000:1632:: with SMTP id v18mr12353420wrb.233.1568200850794;
        Wed, 11 Sep 2019 04:20:50 -0700 (PDT)
Received: from localhost ([148.69.85.38])
        by smtp.gmail.com with ESMTPSA id r9sm35678905wra.19.2019.09.11.04.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 04:20:50 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        aryabinin@virtuozzo.com, glider@google.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        dvyukov@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v7 0/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <d43cba17-ef1f-b715-e826-5325432042dd@c-s.fr>
References: <20190903145536.3390-1-dja@axtens.net> <d43cba17-ef1f-b715-e826-5325432042dd@c-s.fr>
Date:   Wed, 11 Sep 2019 21:20:49 +1000
Message-ID: <87ftl39izy.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

> Are any other patches required prior to this series ? I have tried to 
> apply it on later powerpc/merge branch without success:

It applies on the latest linux-next. I didn't base it on powerpc/*
because it's generic.

Regards,
Daniel
