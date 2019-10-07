Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDE1ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A742067B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TqBUntmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfJGQbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:31:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36458 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:31:01 -0400
Received: by mail-io1-f66.google.com with SMTP id b136so29975038iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UMUq0E3/yM6gzt+2eUBeAxMv0c8zmA9olT58MxNzCf4=;
        b=TqBUntmK2QBZxPdl52tmQ1CH3bubuXA3aGv/7uJurB+oOFTrLd0+OMsPYlOtAJVxEe
         ogaV8bF+iofd4SQogXiN6BHm3mqpl16VmHLga2A8t+smqY+S6JF2RJNntJV92/KkV5VT
         ch6UVRZ/IhWuo2X4uJhW9gm2GJ6IjstIBRLWVMlRAu6dIiefTvxBWI1Bae+Zq0hin5QL
         aiKOVxZt1ANCnkjth9NxrFAJAaUnfABOAOqBXv+gp8FY1qyLv0spJReqrFNACN4HHaku
         87DtigPQlxUKBvKH589Nwq1htOEiy8HFoFrygHKS8Hbgko1LD2yqw3REtjhKAUChJb0f
         r8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UMUq0E3/yM6gzt+2eUBeAxMv0c8zmA9olT58MxNzCf4=;
        b=Dy5/J5FTPpnyDl6bA98MkyRaLTo6qMLDWtQxPpzxKN0plOliNj0jRrAM3fVC+jRlb8
         +YaehyUj/BHmcaDfZYk3+Qx8Ro9J4mWCg6ebLZpC7vQ3LRKyZ1i8J80kS53E6byLr+Im
         mfmxopLLVkRWBps6cx3tJz+8OTOlhYNJPENXDm+cuMh9izzTLNBntm9Z04Y68Ot7Ut69
         GrMeQQQ03U02uqAILESWz7aMMnaJoZ6YOZp3tkIct0mX7eOAZVSkNqFmtFTLQ7e1DM5Q
         NhtP9iWaVokeWotUsWg9dUTmYJ8dXAyQc9csJll3jxwVZfI2uTmIIeKqRmOmUG74P/Kk
         PY5g==
X-Gm-Message-State: APjAAAWJ1Y0fMZzRHcL91ifnvdbyAbxkxlWyDdPKiVaWYssENl3rxykQ
        Qk+WiPp12f1gUhQWEWXPVA1qVI74cqQ=
X-Google-Smtp-Source: APXvYqyIj50zi9T4D7DSBrj4lwQDXM2+L6ujaji4sPoloVTJdqqvpCSohRbq3EGKz1CJAvFsfAjowQ==
X-Received: by 2002:a02:7044:: with SMTP id f65mr13349434jac.37.1570465859146;
        Mon, 07 Oct 2019 09:30:59 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id t4sm6535770iln.82.2019.10.07.09.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 09:30:58 -0700 (PDT)
Date:   Mon, 7 Oct 2019 09:30:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Vincent Chen <vincent.chen@sifive.com>,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu
Subject: Re: [PATCH 4/4] riscv: remove the switch statement in
 do_trap_break()
In-Reply-To: <20191007161050.GA20596@infradead.org>
Message-ID: <alpine.DEB.2.21.9999.1910070930270.10936@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-5-git-send-email-vincent.chen@sifive.com> <20190927224711.GI4700@infradead.org> <alpine.DEB.2.21.9999.1910070906570.10936@viisi.sifive.com>
 <20191007161050.GA20596@infradead.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2019, Christoph Hellwig wrote:

> On Mon, Oct 07, 2019 at 09:08:23AM -0700, Paul Walmsley wrote:
> >  		force_sig_fault(SIGTRAP, TRAP_BRKPT,
> >  				(void __user *)(regs->sepc));
> 
> No nee for the extra braces, which also means it all fits onto a single
> line.  

Good point, will drop the extra parens and remove the braces.


- Paul
