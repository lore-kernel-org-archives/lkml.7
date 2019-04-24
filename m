Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DACC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE834218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="Kk0JP4fx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfDXOED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:04:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36813 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfDXOEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:04:00 -0400
Received: by mail-io1-f66.google.com with SMTP id d19so11685611ioc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=PqXEjNxslUg0+S8sYhHG+ogG8LevC+eadB4uRbvqHk4=;
        b=Kk0JP4fx2jiSaWqZ/AfgndAKBk6y4vpHAMPTbFyEwajqLLDjrYCcL1DmiBOpXZe39Z
         dFkl+YBl6K5WlgysVlPWSKpo1adeIFtjJ6w7/Y2LXSjuoRBtFbzZaLRDhS2an6oMUknG
         mViTe+RUCvsdlvZLTiJbldJzUGd4MlXlffkSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=PqXEjNxslUg0+S8sYhHG+ogG8LevC+eadB4uRbvqHk4=;
        b=UPB9MrPKCIZiOKDvAaHhQy5UtrITBeDtX5hF+ikAWbFlxnI+zrwSAbeVz5QAPGe+dh
         3SqTA0l9zz8x5KCbkQ5PzZyOIKsfnl8Rsenpwdv+BSQTqRQCyCErZsoef9kzdam7R6dO
         tqy8yzc6KKcItpoAzxCjClrDrKNVN1f42jiK/D4aw+jfd5xGEVia0haKXI4c58fWfGJZ
         ZBV7A8oq8HyiYTLqUqh93uVLkVQBAqeuFXOse/lJwwF+htR+1iEXUFk8RHU5sxZhqzf8
         KHbEzhhPEbFxEM4hm4Xu1tbijiAJC6lRbD3nG0lBmobq5YpZS/aepWLQov8lnIudAvS+
         nEkQ==
X-Gm-Message-State: APjAAAUBwCJgfSjV0x6BdHMKjKDw40a09YHY0Zb98+TiALRcQ55Dr82A
        ATYOrI9Cwe62EeLXSVceeMuQEA==
X-Google-Smtp-Source: APXvYqwAozdpkiJUfInxG3MA7O96btTpTwj76Ws6GIpisA9lNc3A0y1RjbzHSe/ZjPJaQBdTlxwAOQ==
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr14948868iok.274.1556114638916;
        Wed, 24 Apr 2019 07:03:58 -0700 (PDT)
Received: from swap-tester ([178.128.225.14])
        by smtp.gmail.com with ESMTPSA id i11sm8607926itb.3.2019.04.24.07.03.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 07:03:58 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Aubrey Li <aubrey.intel@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH v2 15/17] sched: Trivial forced-newidle balancer
Date:   Wed, 24 Apr 2019 14:03:55 +0000
Message-Id: <20190424140355.17357-1-vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAERHkrtP90QJCc-xxqxJbiWg+0jod_U2i-tHayw=Wd+WRDdTFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the hard lockup is reproducible with v2, could you please share more
details about the lockup?

Thanks
