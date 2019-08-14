Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83323C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572962084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 04:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HgkM5fFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfHNEmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 00:42:01 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41608 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfHNEmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 00:42:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so71089261oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zWu5SUa2gWDy2A7vXqugTo7J4wSILytsfZpdfAVTMIo=;
        b=HgkM5fFuFjMEvvdTk7aajxmDKFY+/8DQ+jDApa7K9sWpQ+ZhkCyHQjq04TgpwrACgg
         zBQ9vusEsl8aprB40s5DddqLdh47ZJBNZyPYgE+zuow98FSvbgyELCWlIOWvFV7qt2jP
         Q3KafW+0U+0pk0adaygLa3ee8miDfu+6s+Be9OkuFwaaMqkEkv7GRrG4kxco11F47fGA
         wo9taJBmQZC+Yy4VZsPsexXu0BRQri3E+2CRl3tJ4by46UxGqiZFre4+cTyWjB6siQY1
         yrTabP0U2cGD/J4CgOXs5nHWrqTkkB6R8Vg77DQ6WkljGI3gCP1G9mWp3DQc9K/0ktNA
         bfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zWu5SUa2gWDy2A7vXqugTo7J4wSILytsfZpdfAVTMIo=;
        b=OvjnBhTULtn0eX50yvrQPcvHB1CoDrwzKYmEX8X9/dn8rAcFW+lobhxs2YLxXI3FT3
         skDriEJjTWiZvjEZRjAjti20wUOoH5YeY3teqAWFcfeJO/d07wkSWjiP0Gojrrk+7BhP
         zR3uEYXRRtxJmrL9MPPnLZvE4OdM8fEB9cFMcEscOli6HPg4ROf+9SYgqPtd9F7ZH1Y2
         Ubrr8EbgJkdRreYa6YfqILRex4J1pP0HHxqM6j5JZeaB4nw6BWOFBcQHaYyUNOiVis0p
         65BCCwjWp+nXfREacV0OlzAtQMa71NtSMoLE4ZsPuZnkUwvb4DYRLZRJlu5wV1bMpm/H
         hTjA==
X-Gm-Message-State: APjAAAV5NwbdbO3BqFB2ugg0WSMEygd8bl7EaqChJ8V2tUMZMpxTj6v5
        VLRokQwoqM/raz7AgiEuiV8BiQ==
X-Google-Smtp-Source: APXvYqyLwU3+iARM4Sl8p8WJD8acDem7R6dnM4175yjPenrhI/uqdG67o2+H8iF2eOkz36QcYgnT7w==
X-Received: by 2002:a02:9f19:: with SMTP id z25mr1342269jal.107.1565757719608;
        Tue, 13 Aug 2019 21:41:59 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id x11sm27051947ioh.87.2019.08.13.21.41.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 21:41:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 21:41:58 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] riscv: refactor the IPI code
In-Reply-To: <20190813154747.24256-4-hch@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908132141350.18249@viisi.sifive.com>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-4-hch@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Christoph Hellwig wrote:

> This prepare for adding native non-SBI IPI code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks, queued for v5.4-rc1.


- Paul
