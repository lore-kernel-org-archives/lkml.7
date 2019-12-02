Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F09C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A61920881
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhg7kidX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfLBCji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:39:38 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40362 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfLBCji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:39:38 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so1752346pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 18:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1iMy/g9YGMXihL3KFD6JnGWxzeczwW30x7YIZgG/lhs=;
        b=Fhg7kidXIGrn5mrMNNKhvVNhK4LwTFnZUXn11cuhpTjHwsWeM7WV8Ig1DF8y8/Uc8F
         b5ZQ9knEHPUJ/2F8Dh9QMvyDt3tPLGshzVZgEXn694X5WcRT9ZnPGCltRKOBOTJO3nfB
         wmsX5EhWcjvEvzqEe+hKtujgQ6P3cY6KhF1w7XEu2umtt1wggs5u3WOe4YTDOq4V6h+1
         o+Qi3LKHyRgpCWUlG0asZtWlrxURdShHfXZzBop4bWc0wmtAL3TiIVJSQHKpGulreT4R
         gdQxBLT83tGkXJX1fxVDKMEBeR7mQjIT5fFQ9Rm2pZ9Ro2Ame7dki2Pr1c7W/VYX1uCg
         oLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1iMy/g9YGMXihL3KFD6JnGWxzeczwW30x7YIZgG/lhs=;
        b=BfxxXzNI6ygoGPhao+vjQqMHFuvGnJkhbSO3C/LI7WwPaUke5t0QEpTQWA/OrEo0TK
         ghllLDZQI527WMI4M4QFSS10hXcOh3aDQs5RX9d+HfLWy+7/sMmricWQlu+UL9TtDOEo
         3PWiLAO3ZzInI10kckCUE4sAHe6LbAgMWhSCd0qX4hkgwWtV9EHwJ22HvLByEDevXOu+
         pKh6BktPcMsQd9H0OROkZTD9+yHRxh8dZBpgn1U91uOErwqsSwNB4ea7+KEblvYWesup
         zYnG/I+PloxrONbX3ygAj3OZcRHbP8/UgIlBKNnxo0Cutgamj5C8nyeXmk497zCQHMst
         SuYw==
X-Gm-Message-State: APjAAAWFK+2RoyQ/FVhp1jnVgnkMQ+n0LFsYxfDSDClUKDF0Y7y3bbAK
        tfpNOe9HIJ2GWU6NF4uAIMM=
X-Google-Smtp-Source: APXvYqz1Q5f07XbWlipzs/83sFv/U2nSN7W+P/QpbFtjm5ESZF6NXEeLYrSW9BX9VipBPIXG5YGYbw==
X-Received: by 2002:aa7:96b0:: with SMTP id g16mr21720056pfk.99.1575254377653;
        Sun, 01 Dec 2019 18:39:37 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:250d:e71d:5a0a:9afe])
        by smtp.gmail.com with ESMTPSA id p5sm32002655pgj.63.2019.12.01.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 18:39:36 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:39:34 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Chanho Min <chanho.min@lge.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, seungho1.park@lge.com,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Jinsuk Choi <jjinsuk.choi@lge.com>
Subject: Re: [PATCH] mm/zsmalloc.c: fix the migrated zspage statistics.
Message-ID: <20191202023934.GA93017@google.com>
References: <1574990967-23391-1-git-send-email-chanho.min@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574990967-23391-1-git-send-email-chanho.min@lge.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (19/11/29 10:29), Chanho Min wrote:
> When zspage is migrated to the other zone, the zone page state should
> be updated as well.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>
> Signed-off-by: Jinsuk Choi <jjinsuk.choi@lge.com>

Looks good to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
