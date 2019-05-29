Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABDBC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB93241E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 21:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ba3srmf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfE2VLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 17:11:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40553 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2VLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 17:11:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so612486pgm.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=HbBIKpJ1V87/XwhjrPhv8viXHcfTQeqI4PjBeSTg0Gw=;
        b=Ba3srmf7dzvoQQJfIF/Nc/363r3WxrkxUxwT1YX1SdakmHjJrUsGhqH349Q4UarhU2
         MnNR1ppijSniN3N2dYXoH/VQWbC/KlBv2pVrxgIo1zsJans2j1koEH7lhZNMwOTVt498
         b9oC/t55egmakJMdUNpD3fnO087XYBxrNh4fgOoedVsfyR3R7OtARZHJy1CdAoL426O0
         bnrVOTy3RZNYL04h2sYGYSeQVopdPZZiEwNmTyIKgjGy50InFP010uUQ0cS2p8Dx/Qf3
         YW2pP/9v1SEatT92/tdzFONInXTeYiQ5zR18fN8Wq8yy5PgtpDQlV86SlqHnyRyzFuJ8
         fZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=HbBIKpJ1V87/XwhjrPhv8viXHcfTQeqI4PjBeSTg0Gw=;
        b=bBMkd2vOVVgJ4UMLc/27dWLQxV578s99gmEipWCYa3s3KlGzTRyZW/YZb1hEAm82Ra
         i1sqkUeo1QaCvIXkuITrxmWqfNzQyvlxUpIYXCFvivOaK8QId2xsj7k+WuhfQlvCnW5x
         w+GTFuNf2OZ+vfTDDhWNPFsrzQQFZ2bkXFMv3A88t9ELkF7n1dC1+AbOo48cpp4va4qk
         +tdFZpwIL/nMiUq9Q0Xn90QE903nJ73Fnhn6+z4r0AtwnWDPA3S9J8nRjk5wiXiblDYa
         CWvZ9/soor+ilTl2DHXx+VY1IkmYOSWN4GuD0wxMN3xWS19uUFdmBEsvdnipiZjhMN2x
         Nskw==
X-Gm-Message-State: APjAAAV1pcgz60NgrkU9+JIQyDVWcFz5lQjqZhBT194WLsQ6aUhBEVMf
        RrluShIdkzX+zEz6idbd39mUOw==
X-Google-Smtp-Source: APXvYqzTnXpZgzkW6k+/y8HaHDmKbpmti34vXP5d5BqOgLp6sX6O8OvIESbX9SWawKH50J31fhg/sA==
X-Received: by 2002:a63:de53:: with SMTP id y19mr64382pgi.166.1559164308033;
        Wed, 29 May 2019 14:11:48 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x18sm712793pfj.17.2019.05.29.14.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 14:11:47 -0700 (PDT)
Date:   Wed, 29 May 2019 14:11:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL
In-Reply-To: <20190529062316.GA3997@infradead.org>
Message-ID: <alpine.DEB.2.21.1905291410300.242480@chino.kir.corp.google.com>
References: <20190529013540.GA20273@hari-Inspiron-1545> <20190529062316.GA3997@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2019, Christoph Hellwig wrote:

> > wd719x_chip_init is getting called in interrupt disabled
> > mode(spin_lock_irqsave) , so we need to GFP_ATOMIC instead
> > of GFP_KERNEL.
> > 
> > Issue identified by coccicheck
> 
> I don't think request_firmware is any more happy being called under
> a spinlock.  The right fix is to not hold a spinlock over the board
> initialization.
> 

Right, and not even wd719x_chip_init() is always called in this context 
otherwise wd719x_board_found() would also need the same change.
