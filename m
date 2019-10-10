Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86D21835
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9hVV+E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfJJUEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:04:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:04:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so7461714ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vNAkVByxwPtj47oxh98xv0GNfuNUm1Vy9lgUWGV2Qmo=;
        b=u9hVV+E3ZunE59sLzfkY+4ImFrvA16AquH47JmeGhtlvu3jWShqzBOWm7YyGfokRAS
         tn8X4hStXltCKlJKMnh9JcUa8GVzJ+MxoJ5Cne0x+A9ZcEomA/3/GfSDCL1+2uibmlRz
         SSdNt7XeaRog9G99v8IaqCfxnP3D9xYV54jE2nZiah2uznevCJp9XBfHNx8qXNLfK5Nw
         y3+Rel4ftgbbE2+y9U+ceeT1qxkDuDbJ3i02Su4CVh0fx7D1ZBXxvyZR5nsEQ2DRRIKC
         RSBWiIhsvWTkZgKeBUMkqCyd1SWxsvqQ1DwmfsOt/TYOvydomTkG5N3DJRY/Kap7SSHv
         A0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vNAkVByxwPtj47oxh98xv0GNfuNUm1Vy9lgUWGV2Qmo=;
        b=NM8K9R996vXPdVsIEat+kS9Lpz3VRVWrWt/ksPWvUp1E9ED+ZbSMguO7xywQNVLDQc
         Na3B9yg7e5h0md6hlFIfIq2WdCLk5P48j9xtPZ59PyGMo3+9V8bqDt9DojFLplvvPV0f
         bXDvpFZZSoRHrY8Ih8uLnTSuzIjWCPUGWVzc361gdAYZBjJkJdgs+4h+nOoRMyGEm+YP
         OL9U9uPj0axmcnSJ6wPpOiPA4wM16jY2rpRdB0V69X0dLH1qvtfcI0eKT1q8vF5vqcVc
         oNT0pFOlJ2xzM0+BdHdNe4JnLHRiKeLrNl+mYFuY53kWKBEBiUhs/Z30vkNcEQqt9gEU
         q0Vw==
X-Gm-Message-State: APjAAAVjfRBY1dkAgUSi+eaXi+/C5XURvXN5roWUC8UMktxSc6DBS6j1
        dRT1pEK4Rdeyx7lYwpfVexkg3QP785FNdQ==
X-Google-Smtp-Source: APXvYqz3NjfB0tQpVZRLiMxA+kFCIJ+uOCfqM6jrEJCnVfaz74fPH8QJt3Xqmfz1pA4clneR2cHXJQ==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr7433890ljg.14.1570737871799;
        Thu, 10 Oct 2019 13:04:31 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X (c188-150-241-161.bredband.comhem.se. [188.150.241.161])
        by smtp.gmail.com with ESMTPSA id 126sm2222558lfh.45.2019.10.10.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:04:30 -0700 (PDT)
Date:   Thu, 10 Oct 2019 23:04:14 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        Theodore Ts'o <tytso@thunk.org>
Subject: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
Message-Id: <20191010230414.647c29f34665ca26103879c4@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coming patchset is a new take on the old issue: ZRAM can currently be used only with zsmalloc even though this may not be the optimal combination for some configurations. The previous (unsuccessful) attempt dates back to 2015 [1] and is notable for the heated discussions it has caused.

The patchset in [1] had basically the only goal of enabling ZRAM/zbud combo which had a very narrow use case. Things have changed substantially since then, and now, with z3fold used widely as a zswap backend, I, as the z3fold maintainer, am getting requests to re-interate on making it possible to use ZRAM with any zpool-compatible backend, first of all z3fold.

The preliminary results for this work have been delivered at Linux Plumbers this year [2]. The talk at LPC, though having attracted limited interest, ended in a consensus to continue the work and pursue the goal of decoupling ZRAM from zsmalloc.

The current patchset has been stress tested on arm64 and x86_64 devices, including the Dell laptop I'm writing this message on now, not to mention several QEmu confugirations.

[1] https://lkml.org/lkml/2015/9/14/356
[2] https://linuxplumbersconf.org/event/4/contributions/551/
