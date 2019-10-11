Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C71BC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B89220673
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfJKOjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 10:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbfJKOje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 10:39:34 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6BFD2C01FBD9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:39:34 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so2861924wmd.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 07:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=liQbAgHSmXMDz2MwPXfH9RoWMwZsEiL9QVC3TV8t25k=;
        b=ScK6gM3hiL6QAo/BBLSvnRxxUxusAJAeLNyXex0jJ/O4UwgIXyUBFCeGhOhp+XGeIX
         t1pe6F/5NbjJgphjlcZRKw7SatWQlJyYmHv1dA4h++FLkULd201Xb2p9kGa7BS/AKtsB
         ngC3ZcWVi4jGX3h9r1Y6D0/EzrX0TeqnM2oCaGsdYyxreT9xgjeuiWVxCklRbMb9qmgo
         V/VMiECJzqhTQCwogaTJr6STJykGLIsgVyaktjUgOYGKMQKRfFCAqjDOKt8CsgVs/YaS
         u1Oki1eFsSQLjDCBX4pq890r/9cuo7ouuTq0oDr1g3lm9rBGBsYN+fh5k5vzAO5PL1lX
         QlGg==
X-Gm-Message-State: APjAAAUXSiGKruc6y1R+X1Ki6UuYkjiuPeNs9gpaEFQQsONg1cJbE0w9
        qbh0w6psUWu2YQWZV0l6rj15A28o/VnFwyM20LBQURsw4XauVW0nHH2s9zqnKh+QPOLlMxY40Vz
        ZMl0C69s4KPB6sHemWNebRIzI
X-Received: by 2002:a5d:6984:: with SMTP id g4mr13566586wru.43.1570804773107;
        Fri, 11 Oct 2019 07:39:33 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOgGfiWykQOZWxvAQCAQ5lTZZlOEdFhFzDrlVB3KHciz9JN8beokYLGpmV6a5f51pd2LT9pQ==
X-Received: by 2002:a5d:6984:: with SMTP id g4mr13566561wru.43.1570804772906;
        Fri, 11 Oct 2019 07:39:32 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it. [79.52.200.174])
        by smtp.gmail.com with ESMTPSA id u25sm9661696wml.4.2019.10.11.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 07:39:32 -0700 (PDT)
Date:   Fri, 11 Oct 2019 16:39:30 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        Jorgen Hansen <jhansen@vmware.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Adit Ranadive <aditr@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost/vsock: don't allow half-closed socket in
 the host
Message-ID: <20191011143930.hs2pkz5i2bci7igs@steredhat>
References: <20191011130758.22134-1-sgarzare@redhat.com>
 <20191011130758.22134-3-sgarzare@redhat.com>
 <20191011102246-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011102246-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 10:26:34AM -0400, Michael S. Tsirkin wrote:
> On Fri, Oct 11, 2019 at 03:07:58PM +0200, Stefano Garzarella wrote:
> > vmci_transport never allowed half-closed socket on the host side.
> > In order to provide the same behaviour, we changed the
> > vhost_transport_stream_has_data() to return 0 (no data available)
> > if the peer (guest) closed the connection.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> I don't think we should copy bugs like this.
> Applications don't actually depend on this VMCI limitation, in fact
> it looks like a working application can get broken by this.
> 
> So this looks like a userspace visible ABI change
> which we can't really do.
> 
> If it turns out some application cares, it can always
> fully close the connection. Or add an ioctl so the application
> can find out whether half close works.
> 

I got your point.
Discard this patch.

Thanks,
Stefano
