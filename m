Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB383C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BCA21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 21:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fnCLpA3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfGAVPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 17:15:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45622 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAVPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:15:53 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so32066505ioc.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=a5ZhSFhZxBdLju3tQkiTCWkSZRpiCbvjfP/tPOAL/Uk=;
        b=fnCLpA3PG2kMCVNRsV6ZrFzmWBf/K1XrjTfF4DFj/YjSu0P7yFq7p5Bsw02q15l3b2
         R3yN4d+nVuuGDO890+ttIDI17Z7soQWZZZNzZys9acpTJwCPADRZzRKNEPsFHDX2yGzp
         7DNtbWErvgh1YS+jP4YFCik0PcunOIXXPzQ/QGTeg0Ac58Z/UpfX8wkdJJ4d3oLjY8c4
         DSFVr6g1uzfCYnyL/0qqIwalVnIaOyLRRXrhQwl/z/O0WDFUFmrq25B8r9W1x1O3iNzN
         CBCJuVCh4pvN5Jtmkk25cmLISrDGEfR/1rJ++eq8jqmSIDBg0H8VUF7vsG9HjBNTh3wv
         PpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=a5ZhSFhZxBdLju3tQkiTCWkSZRpiCbvjfP/tPOAL/Uk=;
        b=lnHJOfQN5ul+u6HIsKVikC2OGEdwOqI0G/stPfiFw+6gLB2ZfysObVp4a/R+oXpXVv
         52ZWgIDvnDvs4Osba4Z1rVFZQepdTNxdxAW40EwnP4XItm90FWsP6SLgx6IUpxVRb17P
         P5mxtJ9XMjyREwdrpcqZF6lEf69YBx35+QkpikefKABnvW1oksc13c0F0crvedA6+xiE
         wenyfdIaWAftsdFLJ8X3elgfydzsuqReBlgT/4l7ieJwKTwQIsk231wMLuCpGNz05i0/
         w1aJ0/kM8UNLyq8KBjm5PP84ibD9/a0uAZzKJJDuqCbuOPvV87y9nfte7OvZlve09L0+
         xnxw==
X-Gm-Message-State: APjAAAWqryFC19usnUyZSdpNUhyVs2yKN5otWrHtwGdroVSQhXOAobkU
        X38ruxGbqsE7XpVwMhlSPycP7w==
X-Google-Smtp-Source: APXvYqz8x5IrAI3IeFq7foAQQ9qaB+xTt2PrEVlsjnRtBcKxbInsLarWM+ycJMklAn5HJMHqFxXU2w==
X-Received: by 2002:a02:554a:: with SMTP id e71mr30796296jab.144.1562015751321;
        Mon, 01 Jul 2019 14:15:51 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id m25sm14605769ion.35.2019.07.01.14.15.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:15:50 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:15:50 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@sifive.com, aou@eecs.berkeley.edu, sachin.ghadi@sifive.com
Subject: Re: [PATCH v2] riscv: ccache: Remove unused variable
In-Reply-To: <1561977630-32309-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907011415280.3867@viisi.sifive.com>
References: <1561977630-32309-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jul 2019, Yash Shah wrote:

> Reading the count register clears the interrupt signal. Currently, the
> count registers are read into 'regval' variable but the variable is
> never used. Therefore remove it. V2 of this patch add comments to
> justify the readl calls without checking the return value.
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

Thanks, will try to queue this for v5.2-rc - otherwise, v5.3.


- Paul
