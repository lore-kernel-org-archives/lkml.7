Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCECC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA682064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKSbCXXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388523AbfGPSpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:45:24 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:43015 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfGPSpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:45:24 -0400
Received: by mail-qk1-f169.google.com with SMTP id m14so15386980qka.10;
        Tue, 16 Jul 2019 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7az2q0dB0BSwS7U65hZNOSCpJ46eheDGCQizNyQywUg=;
        b=KKSbCXXsPw7eulj5BqiRUCGKIXdyOgTWxZFu1BGHqYrEV5GyNcBWh3CjJFN05RCZ5e
         bR3SZ5Jliy0aTW4iAiCg/Bf/aIk/L3mDrwP54Tr0Q60nWuuXGUmG7Uj0nu83Y0jZ2HCx
         8qSxO+jpV1bISA6s+/ikBkwhM9arbPXOiWZL8XyNFIIY0qzL4HHbNbqWr+Umta/fw6qB
         3rDN2d3UbLco6+NZNETKaLHPLnDejOPyzgbELzJF356F180qkHrLiYqf2eiULg7QnN8J
         pSecT/f01qx6/kvkDLpTwpg/RQWP2Dcf1KB5iAhLV4DeUvPhfI0/ff2kChb2+y/XTF88
         xDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7az2q0dB0BSwS7U65hZNOSCpJ46eheDGCQizNyQywUg=;
        b=pHTelQS9KMHew9JyFd9uPNyGlBu+KCMuC5o4JcdTKiN4q/hekb1bF+qUTptiOEVSof
         q1BrN8hSREROgNvMKT7fH8Tc9tsF+VLaFScBiniB2ZXoVj4lqmq2q8QpKF7WGCgEB/pl
         eqPVOU8T8FCYTkUy84hnRkStrfT4DQD2ctpvT5ZDmXA1/4YbdD8kmURWfek/SdTQkcOc
         CkURDmOxuX2KSmZ4cxJ/vY3YrUyhXpVz8opQRlb8oFy9ybTQ+ohbarSlTOzn3Gfvt5By
         jJ6zpl7T1RjQupqt+1qp5i8SJIyW7I1qwLabtpQJi7WeTEcKOx/frApoE/zn1AFJIcXR
         FAGQ==
X-Gm-Message-State: APjAAAUV7qQUyqSVOeEP56a4yqmBFUy13rnCP9+/Ls4Q3QG9YdBk/78r
        KE3Ns+Hj8+NLMaUkG6QmdhH0UJ4j
X-Google-Smtp-Source: APXvYqz6dn+UK5ZHM9TrHbHFLzzSR7b8i/r2rrMAfU97kcEIqASbYVX9JDu2mUcwIKpwYSB9KqFRig==
X-Received: by 2002:a37:a70c:: with SMTP id q12mr21145931qke.118.1563302722903;
        Tue, 16 Jul 2019 11:45:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id t76sm10831682qke.79.2019.07.16.11.45.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:45:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3F32A40340; Tue, 16 Jul 2019 15:45:10 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:45:10 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 3/3] perf script: Improve man page description of metrics
Message-ID: <20190716184510.GD3624@kernel.org>
References: <20190711181922.18765-1-andi@firstfloor.org>
 <20190711181922.18765-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711181922.18765-3-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 11, 2019 at 11:19:22AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Clarify that a metric is based on events, not referring
> to itself. Also some improvements with the sentences.

Thanks, applied.
