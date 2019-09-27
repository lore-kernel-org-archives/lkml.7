Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A5CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD29217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1EKSGrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbfI0I7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:59:16 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39771 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0I7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:59:16 -0400
Received: by mail-wm1-f52.google.com with SMTP id v17so5297683wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 01:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tNF0gT64dteptCicFixUzKp0+ngnIZBYeMCP9JMRvz8=;
        b=W1EKSGrvi5u5fblYEDRskbG4MDTxt8ynUMPlosjMY+a5t1Ur01lNeAS8HyJ4Zd7HX8
         liSaDghQF5XuQ5HQiQeOI7WsN3ZOAQXJBAeqOXV9Dalb9oaNRHNMUEGh89vL8fx5IXMy
         774dpjFn5lAOETOY9r1sTMuh1jCdwhpyxJS6a/qpo68lBAkuIxkg2aMQi9lZu82SNXH8
         dXzJqyoft4LkCqHt6xgoMJxrV7bbEILlKGA+E+GW4xK8yruesn3vonmPKHSgSciGILZt
         2iCLNDobZxc88xD1FTSWVS7OIPj3MURaCZPI1gqZ7aOYKN99DDUSMj2yAanyn00lXC/N
         i4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tNF0gT64dteptCicFixUzKp0+ngnIZBYeMCP9JMRvz8=;
        b=p23Mf9weT1g4qJGfe59Fw7f64CPmFvxtxPBDCRlQt1k3VSNS9KVlJRCifmMcZg3V+6
         /yFLDgLzCpaaq1F4IbfjTCF//iWlPKGJZGXtG0zLZ/KBXOPKzOfLKErGONp0PoIMOpcX
         kEo6kBJnq3og2hqCea+vZkwiYebegTruefQq122fRKH8+/2yw2wsZ4LI/wFPAn5urgpc
         ReMQNnWNGdjT9x0odQi3CbmNuzCvJri/pqZLYp2QXJCFzsDq9n3jj+epxdT8qhSErPAU
         GgJeovnbZXA+mU0IN1JXGJytqJN//YYmx6L6paP/BEIIMy7TD0coS39HY3+P8XyBLgu5
         z2gQ==
X-Gm-Message-State: APjAAAU1pkKl8PuyfYksHwBnaIHaN8cPanzN5QwWVpnPHTDZBRo5eTP1
        qkKJG7/tkkCFXlKlwJqo0ZM=
X-Google-Smtp-Source: APXvYqxqtdj8ae9Q07DRGPdfHA7L66mKQNS5k/9L+5VOkhM60c3iHL7PqqLjngUo0kSB0gKtsciqrQ==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr6393188wmb.60.1569574752545;
        Fri, 27 Sep 2019 01:59:12 -0700 (PDT)
Received: from andrea (userh626.uk.uudial.com. [194.69.102.253])
        by smtp.gmail.com with ESMTPSA id z125sm9719718wme.37.2019.09.27.01.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:59:11 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:59:05 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation for plain accesses and data races
Message-ID: <20190927085905.GA11454@andrea>
References: <Pine.LNX.4.44L0.1909061405560.1627-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1909061405560.1627-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 02:11:29PM -0400, Alan Stern wrote:
> Folks:
> 
> I have spent some time writing up a section for 
> tools/memory-model/Documentation/explanation.txt on plain accesses and 
> data races.  The initial version is below.
> 
> I'm afraid it's rather long and perhaps gets too bogged down in 
> complexities.  On the other hand, this is a complicated topic so to 
> some extent this is unavoidable.
> 
> In any case, I'd like to hear your comments and reviews.

Thank you for writing this up, Alan, and sorry for the delayed reply.

The section looks great to me, and I have no further suggestions besides
the minor fixes which have been already pointed out in the thread.

Looking forward to your v2 (an actual patch),

  Andrea
