Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90338C10F13
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56625206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 02:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlM7vMtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDOCcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 22:32:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35125 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfDOCcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 22:32:20 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so7817129pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 19:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ozmvfbqPS3oUzP2leIxEhYwewaS4K5FP1OQ5Cf0v1m0=;
        b=GlM7vMtqQlZDUVYLk1PiRogy8hBPEOAxbw/U3IJEKwNXgomLqL2Obo6Q9q6EHy0y1J
         gr/o0xChG35QVkd+PZRA73SUKpw83Kkw0YpNukvONH+wSPnbzKSHtqOsl5E3kCjorof1
         v2FX7qxXqdGdtmPnRNxTRPIwK1F19f/8LLQ3unS7Za6BVUVTdK+QZcYFj7jWtN9e2cHu
         CCKvaQ0vEpxyGl9RUn86E2Scnb7rnafJAPuNFvXO6ulpHUdmG6fvYrjxpc4FjrwvWbIr
         hVs9p6Z6TxW8yAWYZNfgv9sexHwKNmcSx3x13tendaEzRmgOh2lVla79SyQXzMVaKsen
         hHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ozmvfbqPS3oUzP2leIxEhYwewaS4K5FP1OQ5Cf0v1m0=;
        b=p+U2Gim3oA4XBkNbCnJ622x+qLRQglG84CRhmUdNBbVOuXYdQZ3JB3xTuFg67wczaN
         BtmrT07oZpVJnkUQZfK7+2M4YkyvCmCCvpwq6f4Fas8//Vv5zVyx2Kfna+CTeXz/larN
         Ab/L+YczwdmcgSUWbO1Uxty/eGwsOqQC/k/0Mhq2tzn6YoXbaDB/Gw8JMdfUuEvu1C2y
         8MIqFK1bX7fY619i9SFyHkrm1CElQV5qjH4BhE1SnCXJx3//vdGC/XLZZMChNwix6IL4
         RritHAgZt3Nxphj1L0Jymy2iYuprpMJqZPRWkW5n6XpvXYe9Le8TlUbwzibbQGdWQft0
         T7dw==
X-Gm-Message-State: APjAAAX236iAOytzYqULwWdXK9fjdpw6v/J9rprJEkZnbavAtA1m5STk
        skv9oK2+rPG1zAdC97xQOUk=
X-Google-Smtp-Source: APXvYqxF/UhO0j7jRntqn53FHAY67qcU5ZqzeVK3ps2Lm4BGM57LC65hjK6/FWV6x4d08B3VJAk5sg==
X-Received: by 2002:a63:525f:: with SMTP id s31mr67217174pgl.172.1555295540247;
        Sun, 14 Apr 2019 19:32:20 -0700 (PDT)
Received: from localhost ([39.7.51.30])
        by smtp.gmail.com with ESMTPSA id b16sm64970656pfo.168.2019.04.14.19.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 19:32:19 -0700 (PDT)
Date:   Mon, 15 Apr 2019 11:32:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: tie printk_once / printk_deferred_once into
 .data.once for reset
Message-ID: <20190415023216.GA27063@jagdpanzerIV>
References: <1555121491-31213-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555121491-31213-1-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/12/19 22:11), Paul Gortmaker wrote:
> In commit b1fca27d384e ("kernel debug: support resetting WARN*_ONCE")
> we got the opportunity to reset state on the one shot messages,
> without having to reboot.

Didn't know that.

> However printk_once (printk_deferred_once) live in a different file
> and didn't get the same kind of update/conversion, so they remain
> unconditionally one shot, until the system is rebooted.
> 
> For example, we currently have:
> 
>   sched/rt.c: printk_deferred_once("sched: RT throttling activated\n");
> 
> ..which could reasonably be tripped as someone is testing and tuning
> a new system/workload and their task placements.  For consistency, and
> to avoid reboots in the same vein as the original commit, we make these
> two instances of _once the same as the WARN*_ONCE instances are.

Looks OK to me.

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
