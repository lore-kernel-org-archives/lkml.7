Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F25C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19C42168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="WiZsgOsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391569AbfEXNDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:03:53 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:32845 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391045AbfEXNDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:03:53 -0400
Received: by mail-vs1-f66.google.com with SMTP id y6so5696694vsb.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=KcPmbyibdqAT5dLGgtd63X88pXr4pKrXTknXOQxeESw=;
        b=WiZsgOsYKVga2yuO45vXnXafsBvDBdA4NbRmkhm3xOWepLJ9Wt9UfvxgZNxmg/V0f5
         RP4j6s+eLn2Fd0CRZfB8+zwZK2TiUTQPHJBTgDOzUkI+bdPwU+QFZLoGlkwgHCnxLFVI
         /QlOJY5/VOV8ztZnEJskA//ZxjYOjLWU62HJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=KcPmbyibdqAT5dLGgtd63X88pXr4pKrXTknXOQxeESw=;
        b=F9q6GWa7iG2CzLkn/7DmKd/O84kPE2yMN1htIM6K6lmWrwL4NgNQfog6CdnyIaa378
         DrkUs5X0GTGgnmSj7DUB/KMTtCpsC37JkGd/KghktF7vJT7zgt0Pzr/i+I7Gcbqt4dwy
         u1morsqTSqu5xqy3mCA5kRGoJgI9lQh+aq+Wy1k2ViHgEvHlzjfDTT3h7t7q3iCrHzB3
         ZUYw5fTJZ1TlTNT9R3FW4jUZc6wCqXFBisZoxauQLunRG7rBIdybJnC+LWK40FqQIkqN
         DRM6djOuODOQkb9dTkHmImcnFLvfLcNm2KBtwIQ1+x7r8bFnNXou2wGpJPUz8KSws5PW
         Dv2g==
X-Gm-Message-State: APjAAAXH/wVUYThxMIq50HoN2lHr3jxVLQfeZIy/Z1qNK324IiN0mMS1
        fo8cmmVodxd4IphZw9ZC/4ooCA==
X-Google-Smtp-Source: APXvYqxO9MIT9DNETxDepK0T8hBHVJqIJItVPv+uqV0CU3IxdWOG3zrgHDRzUv2tWboO1SdPSMuYsg==
X-Received: by 2002:a67:ebc5:: with SMTP id y5mr49136058vso.34.1558703032326;
        Fri, 24 May 2019 06:03:52 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id r200sm1622044vkf.45.2019.05.24.06.03.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 24 May 2019 06:03:51 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 24 May 2019 09:03:46 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Kan Liang <kan.liang@linux.intel.com>
cc:     ak@linux.intel.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        jolsa@redhat.com, eranian@google.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] perf/x86: Disable non generic regs for software/probe
 events
In-Reply-To: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1905240902420.8774@macbook-air>
References: <1558636616-4891-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I've run the fuzzer overnight with both patches applied and have not seen 
any issues.

Vince
