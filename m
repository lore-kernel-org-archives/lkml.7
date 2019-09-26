Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9540AC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EEF217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tmtc0Nn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbfIZTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:04:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45066 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbfIZTEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:04:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so23373pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PdYLRPjVhmUjIHCvi4UHiPrAhU+guddA20JI/+5rxjY=;
        b=Tmtc0Nn81wHG/k62e+8O6WqFzOrbw0joaXuZw8CeRv4NGBJO34uREGUVrM15NlRNd/
         KXVCm56+bWElYHYeQ0R4kjyNu/FnqC/9+MEKDrqK72lW7/l39xNoG1fS0Zp6CKUdRLsZ
         gXVsZtp5tT32ZBWw5kC+fU1woWzttqHBQPRNrIgNylvWWDlRDJ6vWAz34kj719Yq98p3
         vPKRfVpuDaJP14Ay3aL4z0RQGk3C68gzKCjF47xNVleC3oQoXXVewTZOq4iSAuA8BBDy
         v7MVN7GQVjR3R/y4nGJ8xwBHz5ZnXg5WVCmwB6dZt1h+ke9BhQTtxSVdOqPqRUM8SiAP
         Pe8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=PdYLRPjVhmUjIHCvi4UHiPrAhU+guddA20JI/+5rxjY=;
        b=rpBHnt8o1GfmD2mbXMR023ZPlUIFK+ljjFlYeuIzoMXl8MvnANo3+Ckxg9QpdyHuKh
         2Gyh2OZ/HWEf9BhZTL1g9QQY1HYkgKe7QwJZm+Mr/3OryPBTUlC8kban7Qoicq4HuS8J
         1sBwGSjvn2UB0lhA3uaUGU9V0+hRMQaoqEthh8SpTl2XA21HDVD5qVSQyAqB8Gq6KtTv
         qfLLBjpyYfLTyKc3eYyBXjxwGW00/LdqIbP+QPoVubCyrE3FoOmRiC5NxItzANcNJdp6
         kWl1Vph7XLnS7dDmGA/9EegFcUVIveZEwTsP8J+4HoOUoDTPW6mfuBZVZ4RYXVgJoyzr
         cZyA==
X-Gm-Message-State: APjAAAUZhDZvCPNax71/1eA866PRKmL9GeGzq0xyeu4cNEszVoLTtmwN
        sWdlrGmac7AcckmOlEtV4/j/Qg==
X-Google-Smtp-Source: APXvYqxEUiBxfJzjbBHftgh1abveLyXbMBtk+9b38TLo3+MinOv2vGYAtVPqpE0JbpSEN4PmoAzjcg==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr67402plq.317.1569524683474;
        Thu, 26 Sep 2019 12:04:43 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y15sm24796pfp.111.2019.09.26.12.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 12:04:42 -0700 (PDT)
Date:   Thu, 26 Sep 2019 12:04:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        tglx@linutronix.de, Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm, vmpressure: Fix a signedness bug in
 vmpressure_register_event()
In-Reply-To: <20190925110449.GO3264@mwanda>
Message-ID: <alpine.DEB.2.21.1909261204300.39830@chino.kir.corp.google.com>
References: <20190925110449.GO3264@mwanda>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Sep 2019, Dan Carpenter wrote:

> The "mode" and "level" variables are enums and in this context GCC will
> treat them as unsigned ints so the error handling is never triggered.
> 
> I also removed the bogus initializer because it isn't required any more
> and it's sort of confusing.
> 
> Fixes: 3cadfa2b9497 ("mm/vmpressure.c: convert to use match_string() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: David Rientjes <rientjes@google.com>
