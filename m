Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D11C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F70218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfGCTUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:20:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40828 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfGCTUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:20:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id e8so3539124otl.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/k104FOahdvu0qyoa9uw+a02NW33+x9nGA9ahr5+Leg=;
        b=o3N+gu42HVbQgeElNgIWf1SGiqlK1sgU5yd42nO4Ku/LOGVNjtgtqEPjiHB6HppawV
         gghT9mGT0C4itg3o6aQ/z+6sW5BIsVZIP6V8j3NJ0ZScXsaormka+mr9/duwBsT2vOXD
         Opwpl/rnrkvKbZ6POElbmM2IMyRaoTFwZFFCB2hQIaFrirbolXyit0ouNE+3KVQRrP68
         sQwR3T1etT5Be6NfRy5h20z3oFecQMgZekQYO50IABa425bhbFwEvlfuXPKnmd+tbqEQ
         jrvEPYRmTQjRsGb8/apkZogcjE8CIUaV0MnOLKKNx4FLwUfAK+43uWrv6S/pIQXKRhqm
         Py4g==
X-Gm-Message-State: APjAAAUtVkSQoQfe9WOsbrtMJr1+S5gIpiAeC1yhziJyoT886v/355oQ
        gXcRIdzDBuGvizr7TWLCbzuLhMNp
X-Google-Smtp-Source: APXvYqyRxZlLqJuCHWnSVxOEe2w6Xjch8rKf1jqpvI/z8B3mwIaTqxXG4PBOhYU5a/nzdHtlBu2JyA==
X-Received: by 2002:a9d:2c41:: with SMTP id f59mr30869696otb.268.1562181606225;
        Wed, 03 Jul 2019 12:20:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id e205sm1088447oia.23.2019.07.03.12.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 12:20:05 -0700 (PDT)
Subject: Re: [PATCH 0/2] Fix use-after-free bug when ports are removed
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703170136.21515-1-logang@deltatee.com>
 <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
 <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e7f0ae6e-9a72-0640-12d3-1683f9950a13@grimberg.me>
Date:   Wed, 3 Jul 2019 12:20:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> Can we handle this in the core instead (also so we'd be consistent
>> across transports)?
> 
> Yes, that would be much better if we can sort out some other issues below...
> 
>> How about this untested patch instead?
> 
> I've found a couple of problems with the patch:
> 
> 1) port->subsystems will always be empty before nvmet_disable_port() is
> called. We'd have to restructure things a little perhaps so that when a
> subsystem is removed from a port, all the active controllers for that
> subsys/port combo would be removed.

Yes, that is better.

> 2) loop needs to call flush_workqueue(nvme_delete_wq) somewhere,
> otherwise there's a small window after the port disappears while
> commands can still be submitted. We can actually still hit the bug with
> a tight loop.

We could simply flush the workqueue in nvme_loop_delete_ctrl for
each controller?

Might be an overkill though, and its risking circular locking in case
we are going via the fatal error path (work context flushing a different 
workqueue always annoys lockdep even when its perfectly safe)

> Maybe there's other cleanup that could be done to solve this: it does
> seem like all three transports need to keep their own lists of open
> controllers and loops through them to delete them. In theory, that could
> be made common so there's common code to manage the list per transport
> which would remove some boiler plate code. If we want to go this route
> though, I'd suggest using my patches as is for now and doing the cleanup
> in the next cycle.

Then please fix tcp as well.
