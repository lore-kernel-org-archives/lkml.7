Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50273C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108E9215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 18:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VwHl/+4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfJDS0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 14:26:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46763 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfJDS0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:26:36 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so15496772ioo.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t8xd02zwYHFR1ug6Lij1NLvXJ514TyN1QMbUlSxJFp0=;
        b=VwHl/+4fKaaoT18gaA2dUh9WuS55xSFNwQIk7B6CLpOS0MlU/jrzqwld7gUOK+i+0V
         HBgZMsMLNgy6AooThDGrQ6+Kj3qP89muwCvmBepqtwruQwi38NqihJ0a6BNfbmo3zS4I
         q77DTbCddQ5FaiPNELBaw3+MWJTTiWmZLObKL/0kvwcnvD6nBamAigdfsUqCW5C6d0DM
         HpDjfoACTEgMWNLe0drc1TQ68Ov+HVBBkdNks2nPqY9GTFGdwJYROmso6i6SPUVIrFUP
         6W21rrj49NcOiYjVseux4Y4HwXDYTPCUmP2k2ipY/kU93RXkj64OxkXzyaJWOGeJoql9
         z/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t8xd02zwYHFR1ug6Lij1NLvXJ514TyN1QMbUlSxJFp0=;
        b=XDJUpTS+2z4mbaPrrMIUKVhAduiMjp4YIXg2GXUtPmgzp7sKzTNBe/momREr5xIvS+
         CWHnl+6zxpVUgO8TeYSZk1bXYuqST/75+lujbIf2p3OX6sTNafUqNJtTicYxLddGB2A2
         v5MBDGmQp1oafrdmC4aWxOs8IcCg7pQIKOQG1Ae9oJiQKbNc4xsnymrSY4OTYhWPyR3q
         aWA9W+1ZZSI7XaF+i/DtrMLaZUCySRRZotlUpjv1gJUF8B5KJvPRt+qGHxJMPeX4QsRe
         sz0mKr6Jo67LOSZC/PsPT4GrfoHhlNHdujmheYR5/ftGjtxFkXXW2z+iNA0TqM9g+VQM
         wWJw==
X-Gm-Message-State: APjAAAUGEbmg4G3y1WKkNyK1t83kY33BtiLAihGi1HXWWriLhXieqxF+
        LMJSVcgAY7MJBtER1jyk9o1wdw==
X-Google-Smtp-Source: APXvYqyzR0J5thuev/aaZSAW6LUCDh4I7Z/+jk8Q170nxQE+KqajfQzX0PhTAamMU6fO0fFmqLEmeA==
X-Received: by 2002:a92:4050:: with SMTP id n77mr16315409ila.219.1570213596150;
        Fri, 04 Oct 2019 11:26:36 -0700 (PDT)
Received: from localhost (67-0-10-3.albq.qwest.net. [67.0.10.3])
        by smtp.gmail.com with ESMTPSA id 13sm2839063ilz.54.2019.10.04.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:26:35 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:26:34 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Vincent Chen <vincent.chen@sifive.com>
cc:     linux-riscv@lists.infradead.org, palmer@sifive.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rsicv: avoid sending a SIGTRAP to a user thread
 trapped in WARN()
In-Reply-To: <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1910041126220.15827@viisi.sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com> <1569199517-5884-3-git-send-email-vincent.chen@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2019, Vincent Chen wrote:

> On RISC-V, when the kernel runs code on behalf of a user thread, and the
> kernel executes a WARN() or WARN_ON(), the user thread will be sent
> a bogus SIGTRAP.  Fix the RISC-V kernel code to not send a SIGTRAP when
> a WARN()/WARN_ON() is executed.
> 
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>

Thanks, queued for v5.4-rc.


- Paul
