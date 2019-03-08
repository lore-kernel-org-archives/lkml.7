Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A13CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E7820851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbfCHC2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:28:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36592 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:28:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id p25so19691343qtb.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 18:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zKK43uCcWqjLoLEJvg2c7OBgge7uFgnGW1Yv+ah7HRo=;
        b=JqNMnxSVe+OEAsRSz1w+nIKRVyO5phK7rPRzwOrN524mY3ILbBdlYKxsHrGZZ5Yiw1
         llkbcAISvtkTNs+EJSGu5YsNTtQgi9etN56On/uL9v5vxDHCGXnvESY3E4pP+tCdkBo9
         2h3mFo2cao94ewt7i42F696SDZEPR0inYIBC7WpPw4/MmOlYPxzc9Sflp9rTZFVlaZaJ
         91ja2Djlc1dcWAwYrL5Z/8pGbOTlOrrtWYwLzsdbwV7xQuJGPntcUvu4SfUxSMCIIi+r
         PM4b+8F0RD2dsAI1o3J3nNMihz14DeauSe9p7mwY4a1yUvain2+E19an8Ti1y8Q942Y8
         e3yA==
X-Gm-Message-State: APjAAAXjT1kF6DcFzWxGGcIUqw886WAbha8AM60I26SKp6+Gsv4ZjxDu
        9UsfQ3kbDpbGrzK+dvns1DWO7w==
X-Google-Smtp-Source: APXvYqyRVLMras7lNSpHauaLLOEtnihh5o2zR9sVHmfKIk3hSYOwwHqHO8+Xizp0FcO/cSqhDNSk4Q==
X-Received: by 2002:ac8:2297:: with SMTP id f23mr1534205qta.348.1552012096590;
        Thu, 07 Mar 2019 18:28:16 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id x43sm4586211qtc.10.2019.03.07.18.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 18:28:15 -0800 (PST)
Date:   Thu, 7 Mar 2019 21:28:13 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
        pagupta@redhat.com, wei.w.wang@intel.com,
        Yang Zhang <yang.zhang.wz@gmail.com>,
        Rik van Riel <riel@surriel.com>, dodgen@google.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        dhildenb@redhat.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC][Patch v9 2/6] KVM: Enables the kernel to isolate guest
 free pages
Message-ID: <20190307212654-mutt-send-email-mst@kernel.org>
References: <20190306155048.12868-1-nitesh@redhat.com>
 <20190306155048.12868-3-nitesh@redhat.com>
 <CAKgT0UdDohCXZY3q9qhQsHw-2vKp_CAgvf2dd2e6U6KLsAkVng@mail.gmail.com>
 <2d9ae889-a9b9-7969-4455-ff36944f388b@redhat.com>
 <22e4b1cd-38a5-6642-8cbe-d68e4fcbb0b7@redhat.com>
 <CAKgT0UcAqGX26pcQLzFUevHsLu-CtiyOYe15uG3bkhGZ5BJKAg@mail.gmail.com>
 <78b604be-2129-a716-a7a6-f5b382c9fb9c@redhat.com>
 <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uc_z9Vi+JhQcJYX+J9c4J56RRSkzzegbb2=9xO-NY3dgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 02:35:53PM -0800, Alexander Duyck wrote:
> With us hinting currently on MAX_ORDER - 1 pages only that actually
> takes care of the risk of a merge really wiping out any data about
> what has been hinted on and what hasn't.

Oh nice. I had this feeling MAX_ORDER - 1 specifically will
turn out being a better choice than something related to THP.
Now there's an actual reason why this makes things easier!

-- 
MST
