Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE90C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8626520870
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="H/CtL92d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfHYTn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:43:56 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36206 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728798AbfHYTnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:43:55 -0400
Received: by mail-qk1-f196.google.com with SMTP id d23so12549061qko.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 12:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=an1FIlEKWSveTYRtKx/MAhX6QOyzHQ+HmT6tijG1CoU=;
        b=H/CtL92dRjtqaqTSw5ZV8yAF7wwnoMNJDw5+1G2x1xYVO4VZ5Axmeomj9wnZjYj0Bn
         DJeBgZKNZrSGGpP23n/5gmDTErHwMcxq5clo0Ka7OjcWbyx3iOt6rLhHo3VdBM6m3S4O
         4apWmmag+k9tSp9q0N0DJsKghleivIZcC/WUKJygWOpXdFRGdKFJ3A4QIseoaPzp1y+W
         bsrWpp8MBMSXrrwxjfswhTZkAi9WdFPRChIrnZhIveybUkuJpuwjopjVoUQEsc3BK4E4
         Ffmt6RjnN2yK8JXD1JU+T/ooXcfin6oBE6oKUEAYrCuKMc7sWB+JR7LXHyOxdun80blm
         c/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=an1FIlEKWSveTYRtKx/MAhX6QOyzHQ+HmT6tijG1CoU=;
        b=LSWiaZB+PoqZgHp4LNOY+vf34peIidEokE6o5s177jnofJgtvyE2P27rqxvdef2363
         EMWk2xj/A74reXAhjzpenV3Hv9Qq6raEDau3aiWvVKOtuvHmL4ig5AuHBXXcGYJATQHO
         KEcKjKy1c7KgyxUmkbcVdWkLx7vHbWNxTjM8T44ezyzvIONKSpzc91VNfL7cL8dkgYkj
         3MoB/BMRny5lIhahZpXdNiXCj5/5HgX3SqtH4gZBg9x/uzKh/gPdm6rY4NYaS0Bhg6eB
         zmtEQZqJ2ghMpTLcNLH1R0+PSJx2IY/ng+pylIawlilDgYVBSFIZFZCw6VeWLZr+0bg5
         pV+Q==
X-Gm-Message-State: APjAAAUTCvwUeD5I8P56m0lOtgGkCDGuQblSPFsxxzsHGgpJMXQT9YGt
        GfHrAGc8SrCM/KJysRRtNIItPg==
X-Google-Smtp-Source: APXvYqyeePQR7OY4N4F1qeJT/FsWbjdRPS6PWObROL9BhBIeseBdRAEdKEA0Qhs+v4zckxA/WT6gmg==
X-Received: by 2002:a37:680e:: with SMTP id d14mr13582652qkc.207.1566762234759;
        Sun, 25 Aug 2019 12:43:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-216-168.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.216.168])
        by smtp.gmail.com with ESMTPSA id n62sm5439100qkd.124.2019.08.25.12.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Aug 2019 12:43:54 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1i1yQc-0005rq-1g; Sun, 25 Aug 2019 16:43:54 -0300
Date:   Sun, 25 Aug 2019 16:43:54 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] IB/mlx5: Convert to use vm_map_pages_zero()
Message-ID: <20190825194354.GC21239@ziepe.ca>
References: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566713247-23873-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 11:37:27AM +0530, Souptick Joarder wrote:
> First, length passed to mmap is checked explicitly against
> PAGE_SIZE.
> 
> Second, if vma->vm_pgoff is passed as non zero, it would return
> error. It appears like driver is expecting vma->vm_pgoff to
> be passed as 0 always.

? pg_off is not zero

Jason
