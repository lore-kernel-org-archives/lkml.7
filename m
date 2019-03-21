Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62751C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30973218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwoBvfFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfCUDc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:32:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUDc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:32:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id g8so3297812pgf.2;
        Wed, 20 Mar 2019 20:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5r6j8I2I+OzEPbQQ1uCH+FOL0KDb76b0jbq75BNqSY=;
        b=BwoBvfFMZIi2wAGzhGGBtT7e47mkCDhqJi5HhIoYonMkwGpg3P4fkZHDCKGxzlOc3V
         zFqFXRb5eRhpq477luRoRbC06H9BgBqsteqxfRS7LpfUNJXqQuZxowx/ZWw5g8Yww14F
         AIM3On52XCp2K6OTWTekuIic4BGQb5F1Q8+S3KPCzK2248VB+5fHJ6IFdl1iYArx9mZ8
         vhRdgvjmLgLfwPM0VJ7ypC1jmoE112M3O63lVNRuQKmPdsXQBOAQ38U4fZUwbsnPTUI6
         oX0QJIltJDXWwf+t9lhTmi7b5wlgBsbG97H0Te9f6dBUIAKCCcHvXerXMFrqAPP9iTFS
         vsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5r6j8I2I+OzEPbQQ1uCH+FOL0KDb76b0jbq75BNqSY=;
        b=VOREgvfE7KC4OMysCfLVUtF5iOz6vJCCwmm+ZBM7NAlCi4d5jqeUOb+pEJyk7kF1HF
         UaEgMH2Shjorvj6uX5x6vUOU1W3W1iuhAahaPOgJEg+ekZ34dYi7SPfr2dpvQ2E7fprF
         7q6Icslm1Uoteu/8WdZQJ7IDQThzx3/EfpyyFR6uhL8Juk/OnrttwJAewpAtAFXk0lx5
         47nJ+JUEOBdh6AXiONTHAJE33qHB7WCR7dG5O8pKT++ffdT7Ml32oxfAQBzV9qKxlrGJ
         +78BfTX9VTSasFHZQfuL8kU800/l6LE/gDOAS2z4TKpAIQWSO3FfnAUfFpHr1ot8BUrV
         RJtQ==
X-Gm-Message-State: APjAAAWVk28zHs+E7iVAHYS1s2zeZkXxdRWz0Co5osyzbGKAIqczPb/D
        10cX+K2EzO4CpS70t3sg0vTW11/H
X-Google-Smtp-Source: APXvYqxJQVriP3gCxUd88AIy8GSXjVXZLtuwC5HfMQUTYt1+dUz1Mw4eyTfpsMAkC6xJxWdZ3UFvtQ==
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr1322797plf.320.1553139177561;
        Wed, 20 Mar 2019 20:32:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::c891])
        by smtp.gmail.com with ESMTPSA id v1sm5092902pff.9.2019.03.20.20.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 20:32:56 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:32:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: Add arm target register
 definitions
Message-ID: <20190321033253.24t6i36tbcujnrzo@ast-mbp.dhcp.thefacebook.com>
References: <20190320101054.1880-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320101054.1880-1-adrian.ratiu@collabora.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 12:10:54PM +0200, Adrian Ratiu wrote:
> eBPF "restricted C" code can be compiled with LLVM/clang using target
> triplets like armv7l-unknown-linux-gnueabihf and loaded/run with small
> cross-compiled gobpf/elf [1] programs without requiring a full BCC
> port which is also undesirable on small embedded systems due to its
> size footprint. The only missing pieces are these helper macros which
> otherwise have to be redefined by each eBPF arm program.
> 
> [1] https://github.com/iovisor/gobpf/tree/master/elf
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Applied, Thanks

