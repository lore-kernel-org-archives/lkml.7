Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D458EC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC08822AEC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FV39AKdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbfGWSYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:24:54 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42403 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391475AbfGWSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:24:52 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so19544804pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=b41n3LREvvCVOT99upf2mTScwjCvonjOKLeOr7b3C5o=;
        b=FV39AKdMDQeD6YqtoKQSMhCbjgrTyHJN60X0SWmNCD+O9p2bX6C8qYJz0eINu0Vkyf
         LAbFt2BoaV/5c012dA0FE9DnPmAfbtAoMuMuWTdOwtIgpVHXOPYq/wXTmyg0mmReH1eo
         bP8CKJ5kluT1kIqJojulM3Lhe452qac63uGtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=b41n3LREvvCVOT99upf2mTScwjCvonjOKLeOr7b3C5o=;
        b=peMcRP+oFHolDJKZEom+ObVjy6S+NNzwY4YAQLBBf/BXu6DQn0Sh6EhQDgDUE4ydy8
         QQ7uR9ULDjGapQuExkbowGX06eNJ02V2jwKRvOLJfG6b0aFo4R3F4GplaaxzY0/Ma/AT
         ftZuEZ5xf3V2CuVdaciYgFvagmUKfwp8p9cAESoLz2ZdwYCG1jhCyhtBjgknQAcJ95Xk
         xrEMFnhxqJjTwq1SLxx/Bxy9mxqo03kM/9nkhachmumUpsxBXTqVLA1c2HdwAjZzduKl
         6gFWt0BywAzZn4/Z+sw+10hjpEjIPdEl7RoR1wcGGEpsnpT4x8YMJq3hr5QwXtXVkjMc
         nN7w==
X-Gm-Message-State: APjAAAX6o+ueK4R5DIG1FUpthzC1McW6pTynCYk+hCBH+gHGCsQe+Van
        D2AB70xADzEM9eBf7QUKMuV12g==
X-Google-Smtp-Source: APXvYqx0i7nBRik0fKx4AbxAnDtKCTytjeuS/7WcJwq1Evpncx6GnzRR1koiuEsmKqC3CiPSEsktfA==
X-Received: by 2002:a17:90a:4f0e:: with SMTP id p14mr80829741pjh.40.1563906291568;
        Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t29sm53263348pfq.156.2019.07.23.11.24.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:24:51 -0700 (PDT)
Message-ID: <5d3750f3.1c69fb81.923dc.874d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190722215340.3071-3-ilina@codeaurora.org>
References: <20190722215340.3071-1-ilina@codeaurora.org> <20190722215340.3071-3-ilina@codeaurora.org>
Subject: Re: [PATCH V2 3/4] drivers: qcom: rpmh: switch over from spinlock irq variants
To:     Lina Iyer <ilina@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        mkshah@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 11:24:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-07-22 14:53:39)
> From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
>=20
> Switch over from using _irqsave/_irqrestore variants since we no longer
> race with a lock from the interrupt handler. While we are at it, rename
> the cache_lock to just lock to allow use of the lock to synchronize
> controller access.

Is there a reason why it can't be a mutex now?

>=20
> Signed-off-by: Raju P.L.S.S.S.N <rplsssn@codeaurora.org>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
