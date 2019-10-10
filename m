Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A02C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E8A2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 08:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389545AbfJJIrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:47:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23141 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389525AbfJJIrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:47:49 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B63A75704
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:47:49 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w8so2415723wrm.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 01:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yMEA1vwAxxDR9KMsFNEltEDGLvMYr7N57Wh6Y66WRc0=;
        b=Q0PHALrzz7qhpLZtfY7tFckoj2EONf+aIXTctf8NsWIm9AiQ5G4O4HAqh+oKl+X2Gy
         PUZTkYUvORdNg/KUxgPKmaiyBP82LZdxMVtT39gqmtGApIJGRpvPKzQu81MQySJq9Fxw
         uUjGoctZ7/zieGiyrR8AEBLlxPYpifvUSD71Sszom2tkeVu4B+g+AYOyIxJIzPQXZ7KF
         Myc7tyEXDhUOISJ38Eahj0CFAXGIJ+XZqSdpXCm7ilcBs/ZWKADhl8GeWw62//d2ToXk
         nXmEMdgNOfFS21UqqkOCXjYzzDA1C7TwWUduJNk3kLNkFkeRUqLwXQEZ+eTk5/A+PBYV
         ucww==
X-Gm-Message-State: APjAAAWwBII3PWuQsadUULPogld0+CvLre3E78JvoNUmDtb0vf+q8Cma
        h7nYKqnNE0tfDah+rQUb7E5NLzwRm3Wo7fKgbNcx214bVvivkrmJZSSnTmBRxqxtQhU+Fw3vFRW
        2FUa0qNsbCQNBzXqFr21ub68b
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr6460273wmk.135.1570697267773;
        Thu, 10 Oct 2019 01:47:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwGlOe+0u6KXBMrN0A6Ztn9RSeVar+fTIwwT5kQa51LZTkc+efRSchIZ3bkrYo/CFxMwyo8bg==
X-Received: by 2002:a7b:c7d4:: with SMTP id z20mr6460257wmk.135.1570697267541;
        Thu, 10 Oct 2019 01:47:47 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id z9sm5103737wrp.26.2019.10.10.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 01:47:46 -0700 (PDT)
Date:   Thu, 10 Oct 2019 10:47:44 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     netdev@vger.kernel.org, kvm <kvm@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] VSOCK: add AF_VSOCK test cases
Message-ID: <20191010084744.n46t3ryv7rilkpk2@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <20190801152541.245833-8-sgarzare@redhat.com>
 <CAGxU2F4N5ACePf6YLQCBFMHPu8wDLScF+AGQ2==JAuBUj0GB-A@mail.gmail.com>
 <20191009151503.GA13568@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009151503.GA13568@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2019 at 04:15:03PM +0100, Stefan Hajnoczi wrote:
> On Wed, Oct 09, 2019 at 12:03:53PM +0200, Stefano Garzarella wrote:
> > Hi Stefan,
> > I'm thinking about dividing this test into single applications, one
> > for each test, do you think it makes sense?
> > Or is it just a useless complication?
> 
> I don't mind either way but personally I would leave it as a single
> program.
> 

Okay, since I had the doubt it was a useless complication and you prefer
a single application, I continue on this way :-)

Thanks,
Stefano
