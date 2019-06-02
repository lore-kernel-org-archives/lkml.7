Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3265BC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC17027884
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 08:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ll60+3BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFBIGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:06:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38317 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfFBIGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 04:06:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id t5so8381731wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:subject:message-id:user-agent:mime-version;
        bh=i/hfo7Of2DjU/8nVgdxSdJ+UmmcoAojSd1TjlivmETA=;
        b=Ll60+3BZiHid5SgkpYwizKijDVwyt1HV2OpUrbc8J8NB8P8r6CkJaxjXsjH35mxsCD
         tAY8qqva2kAsJAXuLW/tH0H22Vrh9LIBQwrRo2l0HFsG0G0RnnYkDhvmnmVKFhV/rUDE
         jN4FSaV7smkDgYCURREGflCB1u2TgSfDqe8W4IWO7djrzgfuOyybdt6OX5BSPbidfAwF
         +lyTjoeZ+pebzC4o5M2gO2ZX5cXaApOwDiyknZZnqqiC1AM1Us07ptkVViKOYJrMDv10
         8iFPjgvLgsXjiPMBOFj79emU3G/kHTaAJz8+2rWoLMuVaeMPiOQmTZBQTGfnzo1dxwdw
         XADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:user-agent
         :mime-version;
        bh=i/hfo7Of2DjU/8nVgdxSdJ+UmmcoAojSd1TjlivmETA=;
        b=B5FL7Iz5suddnuSTzdbeiOLoCN3ueyBI0vrxXQvOV+33WzwPZIQdng5bU7lfrtRKcV
         ult8XEvwUM40WyW8gF21DELN+Hpnp6BQTJMCWDsgzdUDtcg1OGlFQMbnCHL1jY6ZpepE
         dsxr58UbxGAWeaIfEdcdpZjwbDOoszop5WE0xtqVGaUihceqDlvyWaqQZfYrxqseXtUy
         4FUdWbV9SUgp7YKeL4uzC78C1C36S07MN9HrvuAqP7WYB4OxnvBwHja5YT8Z/pJpgMkl
         Q2Ahm5eLw1kwss2UcvmAzSEfLk+6Th8LAB5m6+SvbZ0SrVYB+PTj45L67xHaXMl8rKx1
         IfuA==
X-Gm-Message-State: APjAAAWzaD6/7P7fRtc4J7vcHGD+d4Q9jePEJR1Kacdhh7P/kmpoihG2
        ociAySQBVFwRvoHk3LTeBoOgMrokFnE=
X-Google-Smtp-Source: APXvYqwZ99le5sUXEkN7ObI0zUL2ItWFAbjGlxqe/xcop0Jrfu7KDtSlyao4dJAC/Ft0y4H32SIjeA==
X-Received: by 2002:a1c:6346:: with SMTP id x67mr6301480wmb.16.1559462792596;
        Sun, 02 Jun 2019 01:06:32 -0700 (PDT)
Received: from localhost (217-76-161-89.static.highway.a1.net. [217.76.161.89])
        by smtp.gmail.com with ESMTPSA id l7sm4605025wrt.71.2019.06.02.01.06.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 02 Jun 2019 01:06:32 -0700 (PDT)
Date:   Sun, 2 Jun 2019 01:06:29 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org
Subject: Sorry for the extra noise
Message-ID: <alpine.DEB.2.21.9999.1906020105161.9338@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for the extra noise on the recent DT patch series posts.  It seems 
my patch posting scripts malfunctioned.


- Paul
