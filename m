Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABA4C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725CA2199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bobcopeland-com.20150623.gappssmtp.com header.i=@bobcopeland-com.20150623.gappssmtp.com header.b="Wcpa+zd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfGVNPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:15:17 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36744 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbfGVNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:15:17 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so73837324iom.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobcopeland-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wx9SyeoJ6bopQ0LK9VAuarkTsmpo5gRoZq5M1GPeLrc=;
        b=Wcpa+zd6tDcQ0dGSUugww0xoYTTyNeM9+WiwSTZpdRPJmwcy0nvkR9fK17ChRr4LAA
         btyuKhkE3X0jcMpTt4d/jYCpKkj6EaHnSsV3bOoLRbHtpwOACVjpvjaiBcgAsxJUaziU
         ScJMY+NztDCZZIxKwU1qmHcxjdsgcJjJC1fdQe88uGYpdnQY3SH1GPA/pWbnzZRpA/Vu
         6PMyUO9qQLCHp8vUDaQ4L1mvNasRkujRB7zrnREM/eUXU252h2rS5ISf/GJAfWvdFK8r
         XavWl5Ny5XJT+IBLPW/TFLyAsWKPy3le7VSZBjtgL3Rc9tvbWrtlJPOkrQcRA4/nzFjL
         9u7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wx9SyeoJ6bopQ0LK9VAuarkTsmpo5gRoZq5M1GPeLrc=;
        b=LM69hA0CJ3j50a4/u1bAo2vD+oxffvhV3251CcRGkyRnf0vVOXIpXtrkzonDTvR60D
         76W8kKaaDB2AdgX3iQHwAvQiGowUyBz0mFCLhfnqWfD4N5Zv2II5cQMarKWJZj1AI2ua
         ART3cLW+LCVmI57HcETnpyL1Ke1gNNX8SW4RthJ9y4bIZLPT4Gg/frU9//tW1qyRSUfp
         No5oQD9xFvOThpKW+6s8y+QoqLzbKia1zIt0ESSD+HL/McKVTvyCa6iYtbDHeyErZTHp
         Ql0L33Vi80ebDx195rLYyOrtsc3IbTTCYnynKTY8TWB4YefOQTgT5imIj8Y/ctwo+cv7
         34+w==
X-Gm-Message-State: APjAAAUI3XS9vv+mQ9vKoxwGB9UzJKlyw2K0bt9oxSUZqWqUr2dz/cpB
        LgRT/I+OVVvoinRYb2FtTy0=
X-Google-Smtp-Source: APXvYqwnERlCETxwl4vIMdIpEgAzvUBTTh3Vy7/hnl5fp1nFFBlUVeyU/eZNhfGHOtYkHyMeBOyeaA==
X-Received: by 2002:a02:b016:: with SMTP id p22mr26829456jah.121.1563801316371;
        Mon, 22 Jul 2019 06:15:16 -0700 (PDT)
Received: from hash ([2607:fea8:5ac0:1dd8:230:48ff:fe9d:9c89])
        by smtp.gmail.com with ESMTPSA id l5sm70493781ioq.83.2019.07.22.06.15.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 06:15:15 -0700 (PDT)
Received: from bob by hash with local (Exim 4.92)
        (envelope-from <me@bobcopeland.com>)
        id 1hpY9r-0005EC-6z; Mon, 22 Jul 2019 09:15:15 -0400
Date:   Mon, 22 Jul 2019 09:15:15 -0400
From:   Bob Copeland <me@bobcopeland.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/omfs: make use of kmemdup
Message-ID: <20190722131515.GB5252@localhost>
References: <20190721112326.GA5927@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112326.GA5927@hari-Inspiron-1545>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 04:53:27PM +0530, Hariprasad Kelam wrote:
> kmalloc + memcpy can be replaced with kmemdup.
> 
> fix below issue reported by coccicheck
> ./fs/omfs/inode.c:366:9-16: WARNING opportunity for kmemdup
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Thanks!

Acked-by: Bob Copeland <me@bobcopeland.com>

-- 
Bob Copeland %% https://bobcopeland.com/
