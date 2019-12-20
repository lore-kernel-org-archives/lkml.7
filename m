Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EB1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D26A206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 18:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD2MJT6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTSyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 13:54:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44497 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbfLTSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 13:54:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so10387073wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 10:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TrbY94qgfc3+UcgXhbi/ANI583h6IbUS67gFLb/gN+k=;
        b=QD2MJT6wmUkO2cdIzOyTv5s0LB/DXWT0yKNT9MrizoxAgozyKGi5dHk0OfhInu6d0A
         1x7OmPHwUpoxTnRjYPTQ5Ek4QEd0dBQN9/23kwBZkK9e+FKLLgSlbJmdX1y4i2Oz5BcS
         T5PTC+WIG497h/2donR358VhmJHjLuj/0+jFilop20MDhPgxqLayu5dkHCabQaWXPxO0
         t6V0805n3k8iUft06jNYxNLDXraw4cHUh5+G4NBVS/F6onSXK25nfIta6PdBH+5K55UG
         RdYeD6qzwvBkCKlGbh1XObUi957mv73Offsy/+g9KCz25hjw4dIRxzCAEp9p3W4nZNPl
         lHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TrbY94qgfc3+UcgXhbi/ANI583h6IbUS67gFLb/gN+k=;
        b=jN5FfOUlKkEJ+iDrIW7x6faa9liMensipzE8EVsGCKifdYCw2HtFVDRlXwEjJl8qs0
         C779vSswZjY2xRHAJPpESPZLeNuvaZipQteCTl+Tw3SsgChwJDyjRB6hOKWnKeuNqrT3
         0TxsbzlLApRjKUZHCisqLx/6HIXHXFnt6qytnSeqxDcyQEb4fQTmIWwysfdUdKeVRBMH
         w9Z67P1APwKTUtWCYiuN/Dibni7Rg5KAR5/DOphSXyZNIz5jkMTAx7DXqC1m159fSUml
         A4jCvfkfUc5QtRevkJixT/26mCPLjkHKulgC072Hmag+QW97DPAMHgeJZolFgIJj4Ih3
         CVow==
X-Gm-Message-State: APjAAAVRcxWi+YB+hK4lu3cm026b6BBMaOjSRbGLdRJummAQLU1nVwe3
        dgJ6Me0qnX5lvj9cmJ0vcgo=
X-Google-Smtp-Source: APXvYqz1odYwpyJ7ltBG2KoCmQclnoyc7ENMv/Njh/Miu9dGxzlMXF1dWCYbUmed76MksXEvNsR11g==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr17390983wrh.121.1576868049922;
        Fri, 20 Dec 2019 10:54:09 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q8sm10256857wmq.3.2019.12.20.10.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 10:54:09 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc:     Justin Chen <justinpopo6@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: brcmstb: Add debug UART entry for 7216
Date:   Fri, 20 Dec 2019 10:54:06 -0800
Message-Id: <20191220185406.1886-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210224859.30899-1-f.fainelli@gmail.com>
References: <20191210224859.30899-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 14:48:56 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> 7216 has the same memory map as 7278 and the same physical address for
> the UART, alias the definition accordingly.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> [florian: expand commit message]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to soc/next, thanks!
--
Florian
