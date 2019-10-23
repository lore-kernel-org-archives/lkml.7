Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170ABCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5021925
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6IWwyvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbfJWRmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:42:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731112AbfJWRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:42:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id g7so4142828wmk.4;
        Wed, 23 Oct 2019 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qyufOw3HRZ5Y+yJocgS7vdEDGBbk3VE9ga0vjTsSbTQ=;
        b=F6IWwyvR76H6/j/VtUC5EBPTbqS+a55iPP3aSdS1XpvvK5b53hVUMZJmZ9W3nschI4
         x5FTXPz57+PPBt/lG3PBlGHebT2wZkd0BtjvTwpM8JP7ZqGFIs+wVVKThyHQGjjKcHTU
         EiJQuhgocG8nBomI2q3BDjBRuEUVrS0Cx0icvcbfjIjOCfW59mT6FPLla+KvOLaU7HF/
         JaSLYYSKdDFsvEzcmqZVQn6y3cFWZ6nH+pcMZYPQX6eWWkLk9MMxVkVvlk547nUPqFCe
         MTGULciOp9fD0ckimYut8f7bTUFqmI1+kPyeMr+rlNkN5TJo8rqK+mCYuJAKsbz3A6cw
         BKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qyufOw3HRZ5Y+yJocgS7vdEDGBbk3VE9ga0vjTsSbTQ=;
        b=AT0rQsGLKkR2owsQoFpXxhuEXzvDp0Dc/rjPCQ6foe4KKUYXvsauCAtKQ1EJ8IEcGf
         IOKXWEQ9cxrm/egOhleHqlv5uhx4DHi7Lsp+VYmkvxcnywntJGUmWzlp0yymM5yH6vue
         JhOeBa2jUozr5rUIY1cXarKUohUkK6ks7wHmkGSHT6GE49qOYpb24OOUbWIDTVBqkk1N
         nl26TmzF4OUQUgrIisHoHu+8TiNoAXuPl4P4h9Y7Gs75LCBWvMpFwSI/g77Xwlv65148
         VpSmXxrvqfMw/5di4tCvTpsKck3Nk3NJpLV57CRN+Vp1sZHIjkk7lfDHzNF1c4lPwI++
         w1CQ==
X-Gm-Message-State: APjAAAVErMWiIWql1IqooOujIQLruAJgvmwtTbUjxjf/EjKEzCYBru+t
        rAISR9qiVj89nX/gWpFvFtTgGTFn
X-Google-Smtp-Source: APXvYqzV3LbOWAqCLGm0AsZaPgIlWEQdvlIrvLWPLD7WRj1pK0qJQkyQ/7osnO05sUmPsw0AcVfEPw==
X-Received: by 2002:a1c:e40b:: with SMTP id b11mr999746wmh.152.1571852549878;
        Wed, 23 Oct 2019 10:42:29 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id w22sm7695035wmi.7.2019.10.23.10.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 10:42:29 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, mark.rutland@arm.com, rjui@broadcom.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH] ARM: dts: bcm: HR2: add label to sp805 watchdog
Date:   Wed, 23 Oct 2019 10:42:25 -0700
Message-Id: <20191023174225.14337-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191022221956.10746-1-chris.packham@alliedtelesis.co.nz>
References: <20191022221956.10746-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2019 11:19:56 +1300, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:
> This allows boards the option of adding properties or disabling the
> watchdog entirely.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---

Applied to devicetree/next, thanks!
--
Florian
