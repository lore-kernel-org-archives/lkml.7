Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92577C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650EB2133F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 15:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XPnzdde1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfJBPLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 11:11:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36110 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfJBPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 11:11:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id j11so3858130plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 08:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9nWn38buM/4T/AKqINYRkYr3VyumpV3BT15lao/Piw=;
        b=XPnzdde173lm9zRUQ18sUcRC14N6t/0IJ2sdAei/F4xJYWHAI5BXDJETzMzdp+ooli
         ExQEKR+calO6Wvt9U/U6JpwnubDxFvETjsKQ3QnZUFGw55YimnSfO62it6zWbaUhmBor
         q/Hzrte7ei5hWHDO0DmIC/mA57pNvGWsidgCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9nWn38buM/4T/AKqINYRkYr3VyumpV3BT15lao/Piw=;
        b=klbiWf1+7kqHVMc+GBt1U080ezBkVikGtUMFgsISWCg1e89Bk0zIPMhoKCs/D98Bv3
         WwUBZlDVbhXXndCE6rV31QaHbWovO8xd4PJwYj6qai/x+PYGwODhG01pNEhZ2r9BlJOR
         KQP8/KJ8mbaQxDFzRK6mcELjlUPLICP2648k8X/7X42TI2DBYjI04kRPQcKz5arm52Hw
         v8rOgHx1yypVzJHKGUt3QKqfN9AAS19/FadEudw9rxMNX+QVrPEeFjXDg3yMquJHC4EB
         a5FZFuj0+eOu+JmrbPVZFcsM8RSVxWW6CKZ+H6JpmpTrsGW7e7zuGUJTOpcT307avjv+
         WwWQ==
X-Gm-Message-State: APjAAAWlCxqhpR8WiZ81gYjbzMVkyyq9NE0uV9vtogNNtde9H2U1nE0L
        NE5AkRFRw2c4i6j9p5/f8Ph+TQ==
X-Google-Smtp-Source: APXvYqwQNvtL47FRvYlwpsl0MoYYZ8wF7D42Tv5pAM9vqYvJ9M9HUsQP8CD9stCXY/I6xxy7ioeIkg==
X-Received: by 2002:a17:902:5a89:: with SMTP id r9mr4041301pli.206.1570029078602;
        Wed, 02 Oct 2019 08:11:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s5sm5716903pjn.24.2019.10.02.08.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 08:11:17 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:11:16 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] tools/memory-model/Documentation: Fix typos in
 explanation.txt
Message-ID: <20191002151116.GA88588@google.com>
References: <20191001210123.GA41667@google.com>
 <Pine.LNX.4.44L0.1910021012541.1552-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910021012541.1552-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2019 at 10:13:43AM -0400, Alan Stern wrote:
> On Tue, 1 Oct 2019, Joel Fernandes wrote:
> 
> > On Tue, Oct 01, 2019 at 01:39:47PM -0400, Alan Stern wrote:
> > > This patch fixes a few minor typos and improves word usage in a few
> > > places in the Linux Kernel Memory Model's explanation.txt file.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > 
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Joel, if you're sufficiently interested in all this stuff, would you 
> like to add yourself as a maintainer for the LKMM?

Absolutely I am quite interested. I will submit a patch for this. Thanks for
the suggestion, Alan!

thanks,

 - Joel

