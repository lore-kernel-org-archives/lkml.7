Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5E0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE71121A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 10:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3a+bu6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfJCKNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 06:13:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50923 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfJCKNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 06:13:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id 5so1818563wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 03:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gLie/wPthUNcRkmzcpllWvzG+LJZRRQUUjyfYnhUrss=;
        b=F3a+bu6a97dkaGxIejSa6AxDdBjDxElUNO9VsUvks+VUt9OAxEiBoCm0rf4jF3TPPV
         LApMgyiVu2nrxV4T2JB+QQ4zEqhQVKkATrRi0GlvLslrrtMEWGjAkDjTRKgYvjhYziVB
         WbCJEoSdXMbWXDOdOm0uZGWZpc1fQ6g5sfm9E3zIb4bA4JvPQijXFykO1NJ6FnSkZclH
         0OSLvt5RtKIxY1I524JyiZua6rM0Ox6ll1S+LPN3eQw38Ew5qLwQInAACNz0m9OGzbZr
         fA75bVN/9K8ynzaeRLbaevmpoEBgGscqw39X2poXvmGldCp32v84fS4PgiSIeol2xQ1E
         DngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gLie/wPthUNcRkmzcpllWvzG+LJZRRQUUjyfYnhUrss=;
        b=QM8UmzE5u9huo7ivRVoA8DvNbrCy8rjSKPlc5tAHO8+1kn3+QfD/9gP+aCL6wuc28F
         +JSPXqyy7Sc7F5O6Dw4CqMJaWKU1r9f3d9PooM9Wq7hhq7vxQpDYq6qXo6gyRNJtpnoJ
         UpBVhbGaGYkixOFoM1jMncqq0JUkxu4jjqzrdYA8c+fpzOoNCo7OM4V0mUk62sFEZcCf
         EGqqH7PXrrpJqcRXsdSpDn0NJfKd38U9IRZ7Ee7hVC212fsa+ZsY2eKkSuvmdsK+KBX9
         DhLDyipDtNltx8ndJF1YoFSQKODPgWF6qQQ1ZOmXG3pRFcT1E+b0FcJoKnnkiup9sR+x
         OW1Q==
X-Gm-Message-State: APjAAAXJoX7oLWl6IecjG7JPxmTVNVSbODuzPwO1auKe0+ZAg2pDj648
        L2cdnlv9ubQE+z4dUeI2ntM=
X-Google-Smtp-Source: APXvYqyRYZ8V0tp2POdStaZY+ZMlwMLKcF2cid2fkgqMJOVAmYdZBy2D4NILJj8bSi1ASkJeO8oaqw==
X-Received: by 2002:a7b:cb0e:: with SMTP id u14mr6924543wmj.115.1570097617242;
        Thu, 03 Oct 2019 03:13:37 -0700 (PDT)
Received: from andrea.guest.corp.microsoft.com ([2a01:110:8012:1010:414b:bdc7:a2f9:15b6])
        by smtp.gmail.com with ESMTPSA id w12sm3280187wrg.47.2019.10.03.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:13:36 -0700 (PDT)
Date:   Thu, 3 Oct 2019 12:13:30 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
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
Subject: Re: [PATCH 3/3] tools/memory-model/Documentation: Add plain accesses
 and data races to explanation.txt
Message-ID: <20191003101330.GA11363@andrea.guest.corp.microsoft.com>
References: <Pine.LNX.4.44L0.1910011338240.1991-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1910011338240.1991-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:40:19PM -0400, Alan Stern wrote:
> This patch updates the Linux Kernel Memory Model's explanation.txt
> file by adding a section devoted to the model's handling of plain
> accesses and data-race detection.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

For the entire series,

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea
