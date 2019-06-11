Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4045AC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1921C2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OwgPYvEw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406699AbfFKR5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:57:52 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:40757 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406287AbfFKR5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:57:52 -0400
Received: by mail-vs1-f68.google.com with SMTP id a186so6612743vsd.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W78vNdRb2sj//mar9C9WOm+vUoDh7CmPtoHO17hZmow=;
        b=OwgPYvEwWNzHH1rU/JM3v4PPm4KuyLGfughySV2S5B8izLITroNIGMNRXMLWMwPswX
         yVrA2EPdi6B+FMygVs219bUE7PWdJqBEcCSF37KFWf/kZjtfsOayCgCnh4+vuugPv6/n
         Gg4WAI4KXhhJae6wLK4rlJh/0FjeS14HHtJpsjCbvTiUoub6avt8k4ohE1AQI/ALgL8I
         D9hflDmuDLeno10Iz36THLWonrCRv4BY/91OHMsu95r6D0D1wqy5RYYPAdIBJqkBs5Nt
         XLl3Ut2sj+gS3oIrmX3mmZd8xjDPOoMS5SYRkLEZuQBXjqN4hI7+QR8dBZynFXSAJ9xP
         MAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W78vNdRb2sj//mar9C9WOm+vUoDh7CmPtoHO17hZmow=;
        b=J8+x1sLHSr/8a3Chxvbbas4buY17nwdTW7yQDZYbcJ1uWkuIgtSTQQjHOrH1B9VK6w
         J5mxJOpHFfDy3nXuCP2Rf7xtXT2OupiRjgE/3sC4b+KSPUujCwEUnzKhXW0LALktm9a9
         N9A3mtcOliKGKGn2AQdUGkZCdyrYlPE5SCo8JbGxzM7EdvKoLJlRGi/UsP1z5g1kxdYV
         Wznu+Mp3J+XJgFI8NLDcLBsH/kV+TGCPWaZQMUwpb/+LPoxgjwTXIouMSX1rhAXQwqZJ
         qeddmsSI9bGAx4Ok3hLEn5hD2yvimBUgWlE2ItsdzweEK/1TSV9a2PpsAhQAQUrnjT0Y
         c0cQ==
X-Gm-Message-State: APjAAAVF5CGF7s8O3L5Ae3/YRyHHIFMRhKCKq1Y7ET7CiFBfnNNpDgbs
        kFIyAXkn+c/xC14oRzuweHiv1A==
X-Google-Smtp-Source: APXvYqyKE42rA0LVHFpQ2EDtYDUQhgh9MLakJH0QnCzVIyHNHTCTXSEa96fwSV1kF9vLNraHFiJzmQ==
X-Received: by 2002:a67:ec42:: with SMTP id z2mr24618084vso.218.1560275871110;
        Tue, 11 Jun 2019 10:57:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id o66sm4591320vke.17.2019.06.11.10.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Jun 2019 10:57:50 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hal1p-0005Cb-ON; Tue, 11 Jun 2019 14:57:49 -0300
Date:   Tue, 11 Jun 2019 14:57:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20190611175749.GA29375@ziepe.ca>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca>
 <20190610184853.GG63833@gmail.com>
 <20190610194732.GH18468@ziepe.ca>
 <20190610204523.GK63833@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610204523.GK63833@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 01:45:24PM -0700, Eric Biggers wrote:
> On Mon, Jun 10, 2019 at 04:47:32PM -0300, Jason Gunthorpe wrote:
> > 
> > There are many unfixed syzkaller bugs in rdma_cm, so I'm not surprised
> > it is still happening..
> > 
> > Nobody has stepped forward to work on this code, and it is not a
> > simple mess to understand, let alone try to fix.
> > 
> 
> But people still use it, right?  Do they not care that it's spewing syzbot
> reports?  Are they depending on the kernel to provide any security properties?

Yes, it should be fixed.

Jason
