Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DA2ECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57D8206A1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfIKNDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:03:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbfIKNDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:03:18 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E374C065128
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:03:17 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id n125so24880519qkc.16
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sfNjqGMZWLcI3m0N4VrOWVEum1o031nknNQPF2WES8=;
        b=GQC/Wz/VpFLbJ8c3EQZ5alB2VDrsoe28F/uReifmt/Fr23Yl4uSwhHT1XtFqiWqA0n
         jnZRZSLuXXMOfu6b6I/vhQKW6zrBUbmDXQoqXv78ZJjzYlqW7xc7SEL+8dp+kOrRyMrq
         12XObBD5C+arX7THJiLmvVe+c6L8otjE5zrvQmgsfzwaTRnOsevfUv3Je0ItqopSpbV2
         kUkbafDkwkyEatxw2cNBuzwi//3yBw1z1TgUx5/Kzky3NORXFdhs7LxaG7CdbqyiXYdg
         cak/yCWX7jZ+Cs9/3WbvXRNjKEBrQjb1V3Hw2dEEBGcQnfLgZ82iGTHkNUTZVXQkVfon
         Mm4g==
X-Gm-Message-State: APjAAAVt0lIP9ZTFdYmZqFnfQkiMN+K+Jh15HZNCPejtvvt0Azp+P4zM
        RPhUtk5VdJbVhFYIozd+qtBwahfLRe3L4p84glL6Rq/B2tfwhQxSpkS+oHa4nlAmw8KCyApaHKM
        jDBjwDHcdNpVoAHvcY1Eebpsy
X-Received: by 2002:ac8:7242:: with SMTP id l2mr35745592qtp.4.1568206996777;
        Wed, 11 Sep 2019 06:03:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmsmhjoHJTb7z6oORqOFoKPWxTBsyQouHREJ+8K5GPemL48MacSn+bJagBRzKL996ErgPJyA==
X-Received: by 2002:ac8:7242:: with SMTP id l2mr35745571qtp.4.1568206996537;
        Wed, 11 Sep 2019 06:03:16 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id v2sm6615278qtv.22.2019.09.11.06.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 06:03:15 -0700 (PDT)
Date:   Wed, 11 Sep 2019 09:03:10 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911085807-mutt-send-email-mst@kernel.org>
References: <20190911120908.28410-1-mst@redhat.com>
 <20190911121628.GT4023@dhcp22.suse.cz>
 <20190911082236-mutt-send-email-mst@kernel.org>
 <20190911123316.GX4023@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911123316.GX4023@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:33:16PM +0200, Michal Hocko wrote:
> On Wed 11-09-19 08:25:03, Michael S. Tsirkin wrote:
> > On Wed, Sep 11, 2019 at 02:16:28PM +0200, Michal Hocko wrote:
> > > On Wed 11-09-19 08:10:00, Michael S. Tsirkin wrote:
> > > > iovec addresses coming from vhost are assumed to be
> > > > pre-validated, but in fact can be speculated to a value
> > > > out of range.
> > > > 
> > > > Userspace address are later validated with array_index_nospec so we can
> > > > be sure kernel info does not leak through these addresses, but vhost
> > > > must also not leak userspace info outside the allowed memory table to
> > > > guests.
> > > > 
> > > > Following the defence in depth principle, make sure
> > > > the address is not validated out of node range.
> > > > 
> > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Tested-by: Jason Wang <jasowang@redhat.com>
> > > 
> > > no need to mark fo stable? Other spectre fixes tend to be backported
> > > even when the security implications are not really clear. The risk
> > > should be low and better to be covered in case.
> > 
> > This is not really a fix - more a defence in depth thing,
> > quite similar to e.g.  commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
> > x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
> > in scope.
> >
> > That one doesn't seem to be tagged for stable. Was it queued
> > there in practice?
> 
> not marked for stable but it went in. At least to 4.4.

So I guess the answer is I don't know. If you feel it's
justified, then sure, feel free to forward.

-- 
MST
