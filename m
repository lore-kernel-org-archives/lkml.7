Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6B6C3A5A1
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B2A2341A
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbfHWCwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:52:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40274 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731416AbfHWCwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:52:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id h3so4665121pls.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 19:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsjEFYHyrGgVCCvRlXGASNKdZOa3t1osr8ZE4zyjGFA=;
        b=uYofnmpa/2wk4WPK/nU2tKOXUXHkFAv1GZ2HWSowSktAoUNo5psFNaRPwohjvTicyD
         Eub9rdsh5vxsS4nf1E2LgVzP4gvB5kmi0KLswDKbTTsQvAGxTnF2lxy5coru7519TeuN
         K9ETq1QuWN+TC5NXi0kJh9Vhpso7StqfufL8AtEwljetyra9Fo5E7RSykRbsul9a+4it
         cFcq/RFUUTKb1QuT9v86InGVgJ1kPgs5o2ymTFLsiyXpcVlT37z8Bz7TG83CO/p48o6y
         QrAba0ehc65F6B3ECLXhkMEv+r7TpyJiZSpy80fcB99onEMiEHEzlGHj5bBz73mtJ1CD
         574A==
X-Gm-Message-State: APjAAAWrd0x+/XEuQEXFxRD/4NJbDyrQjX/GEN1AYF0D4cpK5E9GA/ie
        o078uH1xJEdnhQavge7IIiGyDadx
X-Google-Smtp-Source: APXvYqzYllyu+AowB9AkQJiIriO5jx5po3tyFxRYIlq4oot4Ib4PM/wOMPVf1zzBqf1XJeoreiOXlg==
X-Received: by 2002:a17:902:8f85:: with SMTP id z5mr2204532plo.328.1566528738795;
        Thu, 22 Aug 2019 19:52:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4800:973f:a183:2905:6842:b7c? ([2601:647:4800:973f:a183:2905:6842:b7c])
        by smtp.gmail.com with ESMTPSA id d189sm838746pfd.165.2019.08.22.19.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Aug 2019 19:52:18 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] nvme-pci: Add support for variable IO SQ element
 size
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org, Paul Pawlowski <paul@mrarm.io>
References: <20190807075122.6247-1-benh@kernel.crashing.org>
 <20190807075122.6247-3-benh@kernel.crashing.org>
 <20190822002818.GA10391@lst.de>
 <87e1fea1c297ef98f989175b3041c69e8b7de020.camel@kernel.crashing.org>
 <4fc11568-73fe-c8b5-ac29-d49daee9abad@grimberg.me>
 <fb5aa2db6b54edab69a8abad254b346dd3d7b205.camel@kernel.crashing.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8545a898-e80c-5ab6-6f9f-f351955db5f0@grimberg.me>
Date:   Thu, 22 Aug 2019 19:52:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fb5aa2db6b54edab69a8abad254b346dd3d7b205.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I'll fix it. Note that I'm going to take it out of the tree soon
>> because it will have conflicts with Jens for-5.4/block, so we
>> will send it to Jens after the initial merge window, after he
>> rebases off of Linus.
> 
> Conflicts too hard to fixup at merge time ? Otherwise I could just
> rebase on top of Jens and put in a topic branch...

The quirk enumeration conflicts with 5.3-rc. Not a big deal, just
thought it'd be easier to handle that way.

Rebasing on top of Jens won't help because his for-5.4/block which
does not have the rc code yet.
