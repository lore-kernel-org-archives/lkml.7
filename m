Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF3C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54898222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V9nBP4cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLSSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:25:15 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46199 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSSZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:25:14 -0500
Received: by mail-qt1-f194.google.com with SMTP id 38so5819255qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1wbEmZyh69FxPHvZMGNLVUp72qy8Qf/muGKAoj7XDfg=;
        b=V9nBP4csbVK/v9fr2ruWreq4kfAqbjElnswpw8VAmId7qRQciZLEv0HUTAcTIETfPm
         TNQ+fd+c4E82jjfPv8enquk2LE2BPncsV+dkTs/VgzYPpVXujrzmT+TO+JtPG84PKe1n
         iglq2DsPN5mSR4yA4F3sW664HfXWwXyZ76V6gxZmLT1bnZ3H57tvI1iG+1Pxybh8mFk3
         KKWNfbnRw8VOwitEm60KWVQHu2Ip7j3a0VVRaKY8gS3vNN2ZcIPRW8T230RfBO8KfhU/
         pXpF489I6+5CWj+6hfiai6ezhVSnH0ZlaKAz2XhPGPWInDMwWrlFRxdvPOHre7wntX8J
         tuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1wbEmZyh69FxPHvZMGNLVUp72qy8Qf/muGKAoj7XDfg=;
        b=mS7FlmmjZlrZe3sUw8CacJnI37FhZV6SX/WEA9t7mguQgJjvQUtfM+ivfK0tbmZAI8
         nXvy/MY5+pRy1deU72PUA/K+6SGyKANRHl/xhXbDIUz0yLwIW4yN8J3xUlgMZaftaZsE
         aGZdd92IyWC81BuHPVkGXIvuU/LTkahNBDe6EkOyiT7BFy3PsR6/yIdk2YIp//TCO/YI
         TANLSof40es1l941HU/IOgUXQ4/jF3xMoP0yh18uLuy+0u6lsq7MfxKr2f7y1kmXEkxT
         eXciOzkvXa6qQvkyxHHvzH0+W7ImyIYV79DvIFx4hWwgowEvuesDSyemvm493599qdA5
         btQQ==
X-Gm-Message-State: APjAAAW6eceoiu0kDgNRTXlxLhQ1f8ID9O/PRJixQzoDsS3AOQNeIhVo
        EyOr3EzzkcEsN00CnR6p4djd2g==
X-Google-Smtp-Source: APXvYqx/szkVU3xnR6S7kaiRH8PbEblL2+ypiIKPes+go0u6FfiNrftcFSirfXeFVHDYuf+DexALbQ==
X-Received: by 2002:ac8:7a70:: with SMTP id w16mr8268613qtt.154.1576779913587;
        Thu, 19 Dec 2019 10:25:13 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id l19sm2098280qtq.48.2019.12.19.10.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 10:25:12 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ii0U3-0007Z2-SU; Thu, 19 Dec 2019 14:25:11 -0400
Date:   Thu, 19 Dec 2019 14:25:11 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Rao Shoaib <rao.shoaib@oracle.com>
Cc:     monis@mellanox.com, dledford@redhat.com, sean.hefty@intel.com,
        hal.rosenstock@gmail.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] Introduce maximum WQE size to check limits
Message-ID: <20191219182511.GI17227@ziepe.ca>
References: <1574106879-19211-1-git-send-email-rao.shoaib@oracle.com>
 <1574106879-19211-2-git-send-email-rao.shoaib@oracle.com>
 <20191119203138.GA13145@ziepe.ca>
 <44d1242a-fc32-9918-dd53-cd27ebf61811@oracle.com>
 <20191119231334.GO4991@ziepe.ca>
 <dff3da9b-06a3-3904-e9eb-7feaa1ae9e01@oracle.com>
 <20191120000840.GQ4991@ziepe.ca>
 <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccceac68-db4f-77a3-500d-12f60a8a1354@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 11:38:52AM -0800, Rao Shoaib wrote:
> Any update on my patch?
> 
> If there is some change needed please let me know.

You need to repost it with the comments addressed

https://patchwork.kernel.org/patch/11250179/

Jason

