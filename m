Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFF22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 16:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCSQ3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 12:29:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39554 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCSQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 12:29:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so4299735pfo.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 09:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LPies90VT1NVL24926JTgMhRAjh15ELsRkRi/Gfyqzo=;
        b=uKn7vEOAFufQIImu2aNLXUqzKprAgfKQtV/HepFlGw0AvuCVC+f9oAqNGAlYPEiET5
         cjZiuTz93iOE2tctnAYp/Shrmqq9fmG1Eh33KlR7eiAH2FNkZc2xmALPZI9vfs4/XB8E
         PCiZxzQJwNY+K2Oe1+h4Nxg/IiTtmC/UQhx1l8S4itVnvUWmH6n73kVFWIEFZWlVJqEI
         3HSte9iSaz04kD4+1as7Io4Ff74yOJyE411xKGbWDppDcI9L+R/qub4LCU1tVODLkFmu
         rbFWuvD23nd9NX1EqIlOh881XvcZ6Q3SBCAFhhrJl4ReT4cWAwVrWgzFXqYkrdt/CytH
         /Bgg==
X-Gm-Message-State: APjAAAXuVYXJWMMBIo8Kmzc7eXvbONgCqzi3D4pulg6BqJhahyzcb0+9
        +5RvhAfnA2wboAQnt18y0fQ=
X-Google-Smtp-Source: APXvYqyiUtuP0joSPijUmdJLrJuJu79Rs54VBpAXmfEGLgUtq+wbAAFDnUOYA1uRZQnl7VY1ibKh9Q==
X-Received: by 2002:a63:5817:: with SMTP id m23mr24045521pgb.166.1553012969385;
        Tue, 19 Mar 2019 09:29:29 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j4sm20850588pfn.132.2019.03.19.09.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 09:29:28 -0700 (PDT)
Message-ID: <1553012967.152266.48.camel@acm.org>
Subject: Re: [PATCH v2 19/19] locking/lockdep: Change if to else-if when
 checking bfs errors
From:   Bart Van Assche <bvanassche@acm.org>
To:     Yuyang Du <duyuyang@gmail.com>, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org
Cc:     ming.lei@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 09:29:27 -0700
In-Reply-To: <20190318085733.3143-20-duyuyang@gmail.com>
References: <20190318085733.3143-1-duyuyang@gmail.com>
         <20190318085733.3143-20-duyuyang@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-18 at 16:57 +-0800, Yuyang Du wrote:
+AD4 -       if (ret +ADw 0) +AHs
+AD4 +-       if (unlikely(ret +ADw 0)) +AHs
+AD4                 print+AF8-bfs+AF8-bug(ret)+ADs
+AD4                 return 0+ADs
+AD4         +AH0
+AD4 -       if (ret +AD0APQ 1)
+AD4 +-       else if (ret +AD0APQ 1)
+AD4                 return ret+ADs

Have you verified this patch series with checkpatch? Checkpatch should have
reported that you are changing code that conforms to the coding style into
code that does not conform to the kernel coding style. Checkpatch should have
reported the following:

+ACI-else is not generally useful after a break or return+ACI

Thanks,

Bart.
