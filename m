Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C17CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E29205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="FvKZArqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfJ3UZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:25:41 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:33281 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ3UZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:25:40 -0400
Received: by mail-qk1-f176.google.com with SMTP id 71so4281240qkl.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=KiFm2XT1/ex9pyBydKszuWy1JMFujhglMV+BmZKuRx8=;
        b=FvKZArqVg5c7lnvj3ny0bJF74EIWJqP3pvXLD4J3+mOSMFEBPxbo9BgJ+KEaSUBze4
         WQJCgxFBT+NqD4gA7Jq74eaTQ5WEKQBfdp2OIYdeB5ad3mh6DB++FjqUOvPK1R1le3Sp
         bkqMApjE3M/tR17+3EgezeNzv7rKXq9DgGfIIxLHN8cVAKKwBm14RymhMm699b0Xtdb5
         ngG/3T7cfsLqIv0E3igR3HK7Lk89z74QBgbw5yPcIXLmLo3lW2Z9KRq/nBUxsdY+AMhM
         EQsrgqvjpSs6pbIeek9OmD3IlDt/4+cU01ZLA5Mo54Rh9KqmlOt0ZJmBbV8KsqYTMu2V
         Ja0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=KiFm2XT1/ex9pyBydKszuWy1JMFujhglMV+BmZKuRx8=;
        b=owTkqPrsaCWJ04WdHfzZ+CPVgX+Z/D1WNa0G+NJ/0jhHk+NpIqg+BOT7Rdn9QsshJE
         vzI40tb8uwmPGdUiM8ck1kwyZvIiZ91DU7eA3pR98Cr21A0rj5bq0ui7DrXc+nqv4cWr
         3pKei9NCqtCzZNH2MxIsePMpnoMKts6IrpeqEmSAtJXQ0TTYDtHjRRYQ7kwjoqo6TKGs
         BOQCyfdieBlJuUuoHiRRMGkLNuAnlwGSmyGrJoavyvjfvqSOpO+gwd3Ng3ySFqVyH60i
         nmaNGaFVVZj4UUDIYpj1Mm30DVldyAY7z2GTb0Cly+MLmFwwBqRx1QIWtT+UCLgRHXaJ
         PFOQ==
X-Gm-Message-State: APjAAAXS+NKVzV4xhYPfGHakjN0RNgiHT68oxqYoe2Ap+wAkSJc+qWuT
        GeNeMNA69Z9WLeWlcLw/8oGLhg==
X-Google-Smtp-Source: APXvYqyx0H3XsyanEpK1jniy58tWKZ3wda42vCC2p7wzRRQRjGWr6vlqi0Sn1CUS/nb0HAADenFj2Q==
X-Received: by 2002:ae9:f204:: with SMTP id m4mr1874942qkg.105.1572467139382;
        Wed, 30 Oct 2019 13:25:39 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q7sm600893qkb.46.2019.10.30.13.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 13:25:38 -0700 (PDT)
Message-ID: <1572467136.5937.107.camel@lca.pw>
Subject: Section mismatch warnings on powerpc
From:   Qian Cai <cai@lca.pw>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 30 Oct 2019 16:25:36 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still see those,

WARNING: vmlinux.o(.text+0x2d04): Section mismatch in reference from the
variable __boot_from_prom to the function .init.text:prom_init()
The function __boot_from_prom() references
the function __init prom_init().
This is often because __boot_from_prom lacks a __init
annotation or the annotation of prom_init is wrong.

WARNING: vmlinux.o(.text+0x2ec8): Section mismatch in reference from the
variable start_here_common to the function .init.text:start_kernel()
The function start_here_common() references
the function __init start_kernel().
This is often because start_here_common lacks a __init
annotation or the annotation of start_kernel is wrong.

There is a patch around,

http://patchwork.ozlabs.org/patch/895442/

Does it still wait for Michael to come with some better names?
