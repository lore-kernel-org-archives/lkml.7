Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C430C3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C990233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbfHVKIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:08:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732938AbfHVKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:08:40 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B172AC08EC17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 10:08:39 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id u21so2743440wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 03:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+QZ6pW149hcLIfsZZS+dKkZglSU+Xi8vHC91tSDHm3c=;
        b=SgQkGq8Niq6XFZY2nHxX+A5Z0J3bu8oSplBLFwPQbMJdSOgO9g9+OaHlg1KNgeb38l
         aJSucUIm5ZG0WPUgOTaOZWoHQSU665XpZegTibOyQVyJY3p/Irqfi/9HKPkA3ZrNVutW
         9Q4GHa6S1TF5LgiuUn4lD+pUpLqjRKttvidgVQcJPTQNvLDIDk5Dx01W1Tp+SPuJthBm
         gAM1LpWVsQ3FMIK/wXGoqsokec3ecB6NEtycboNhJWeDCGfnxSmd9vVJ+wA5+LpqSVr0
         11PpmNwur1zt4G/nOSnjZ4K5gw5l2Pp4Kau3tANLJ0agd0qffKgUHnST9Mvh5dbzO2l5
         k2lA==
X-Gm-Message-State: APjAAAU3pWAwx+eVaoqiFVdTWgNFIm4VcfgV1J2/shpjAxQoh/CDLYIo
        JsRap3uG2A4zBlcWnipN7laLyBLnQOj4rHLLcEkP7COuPYDVe1aakA1MiIpuD3aB5cluH5ctthH
        r0g9ffjRmr8lsycqfyfN4md1d
X-Received: by 2002:a1c:7513:: with SMTP id o19mr5210670wmc.126.1566468518282;
        Thu, 22 Aug 2019 03:08:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx0XnwkglmAIZNRemEqCnbp6/DI7ya5vpk8WBx5UrfbHbyKJgBnEIawFQuaHzBUlbkohxgoxQ==
X-Received: by 2002:a1c:7513:: with SMTP id o19mr5210642wmc.126.1566468518041;
        Thu, 22 Aug 2019 03:08:38 -0700 (PDT)
Received: from steredhat (host80-221-dynamic.18-79-r.retail.telecomitalia.it. [79.18.221.80])
        by smtp.gmail.com with ESMTPSA id o129sm7596453wmb.41.2019.08.22.03.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 03:08:37 -0700 (PDT)
Date:   Thu, 22 Aug 2019 12:08:35 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Jorgen Hansen <jhansen@vmware.com>
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/11] vsock_test: skip read() in test_stream*close
 tests on a VMCI host
Message-ID: <20190822100835.7u27ijlaydk72orv@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <20190801152541.245833-11-sgarzare@redhat.com>
 <20190820083203.GB9855@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820083203.GB9855@stefanha-x1.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 09:32:03AM +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 01, 2019 at 05:25:40PM +0200, Stefano Garzarella wrote:
> > When VMCI transport is used, if the guest closes a connection,
> > all data is gone and EOF is returned, so we should skip the read
> > of data written by the peer before closing the connection.
> 
> All transports should aim for identical semantics.  I think virtio-vsock
> should behave the same as VMCI since userspace applications should be
> transport-independent.

Yes, it is a good point!

> 
> Let's view this as a vsock bug.  Is it feasible to change the VMCI
> behavior so it's more like TCP sockets?  If not, let's change the
> virtio-vsock behavior to be compatible with VMCI.

I'm not sure it is feasible to change the VMCI behavior. IIUC reading the
Jorgen's answer [1], this was a decision made during the implementation.

@Jorgen: please, can you confirm? or not :-)

If it is the case, I'll change virtio-vsock to the same behavior.


Thanks,
Stefano

[1] https://patchwork.ozlabs.org/cover/847998/#1831400
