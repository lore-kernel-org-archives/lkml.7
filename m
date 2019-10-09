Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADBC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD122070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 00:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FYPYWqSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730102AbfJIAvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 20:51:22 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46250 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbfJIAvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 20:51:22 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so1052418ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 17:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EMZtjM31Em1vP/4BHL66TlLSBp4SJ3Jkhr3vg2//7Jg=;
        b=FYPYWqSyx4I3ZdZfLoUgyxUd20pJG/ZUWUmeIssVu39IfkVLIkxhKVy06RoPkesrsm
         hFaWeoAHnxfoYSf8IZwPDCWB1n5+X8KncOA8FGYqRdSWFpoJEys20ueJ1eEmPy/L6dt/
         DyHkVUXmlwQiddd7cu0vt2BJMC51MIyDgimr5t1fA7UaU0hq5EcGEsWQBVyynaW8K+fW
         KBfCdGxTbpLbrr3CKY2Vt+QzyHOMTQjTAKsi7lzyq/8yxweHp2onHOFAs577ckKV94tz
         SiOGqQEafjAzm1mJqRqqJkUy0VQCsoOiHafkVUqLZT5ohXOw3ezyhsJqN/tE9TTThuEw
         QbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EMZtjM31Em1vP/4BHL66TlLSBp4SJ3Jkhr3vg2//7Jg=;
        b=KcQx8CbzSuSnCjgetzT7xZIY1y9/7pJ0SIQNNcXGZzSeQTi9z7UoIi9yPxQbRvWh5T
         8f/Cul/Umx2OIDbJZIB67QpelPPiaJkSVWLwEDepf3/0PNBcUXKLaJSSivG7Tj/BlKVn
         jVodQ2o4oUY93HgEDdV9yuthwadyKg8hGlot5sm8CIKV+5a+DO4cM6ce01YEgY2kFvm8
         jpFmPbrNbi+GtplJAcs2iwo01KS48wC4eU3Gfg3fyh4hVhoi9E/H5oWnfwzVfKz4I5PP
         VASG03dgtm97aMoYHn3/rd1TFNEiD/0OYUzPiS8GRSR97yi6XMXhtOXX9dvPokRDDPRl
         dwhg==
X-Gm-Message-State: APjAAAU39BAbIIw5BPxSOtfeC1B01vERjPP9IBN0WC3a3UCzc6TztGlT
        48s2MWxxAfkg5GS0/WEqABcydw==
X-Google-Smtp-Source: APXvYqx67KnJKfLnhVzjCetf/uH7UeQb+kzcmcUELfUuKW4/Y+MbDnfd/wSipbJOtBrTJKbztJ3S4g==
X-Received: by 2002:a92:5dda:: with SMTP id e87mr627357ilg.216.1570582281295;
        Tue, 08 Oct 2019 17:51:21 -0700 (PDT)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id o187sm363778ila.13.2019.10.08.17.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 17:51:20 -0700 (PDT)
Date:   Tue, 8 Oct 2019 17:51:14 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Valentin Schneider <valentin.schneider@arm.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 6/9] RISC-V: entry: Remove unneeded need_resched()
 loop
In-Reply-To: <20190923143620.29334-7-valentin.schneider@arm.com>
Message-ID: <alpine.DEB.2.21.9999.1910081750550.32458@viisi.sifive.com>
References: <20190923143620.29334-1-valentin.schneider@arm.com> <20190923143620.29334-7-valentin.schneider@arm.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Valentin Schneider wrote:

> Since the enabling and disabling of IRQs within preempt_schedule_irq()
> is contained in a need_resched() loop, we don't need the outer arch
> code loop.
> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org

Thanks, queued for v5.4-rc.


- Paul
