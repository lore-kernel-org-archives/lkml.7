Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B36C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16583216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391566AbfETMxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:53:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34225 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbfETMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:53:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id h1so16148099qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNAZcWqflA9IRxmObxU4/lbcnrS1uyVvwLBkqQKN8z8=;
        b=HzSTEqiZQO3w1vdsAkT5r38H7hYuYbds0MWRQpO9CIi0JjAVigJWdQ2FcNiVx1slki
         cx/ht35b5R6DltwMenH7RBNvnfzvb97xOj4ixfl+dUPGy2SRQRXJ0ZvDfVc5ZuspNmqP
         QF8IeRQ6rNXVvMEqzqHRb6wQvgE5vZ2bu2DOBBARq/jbEDmBwJj84KV9BlPPRqDIsUdn
         Dgvl9WR/mc1C9+eeoTAOsfanYo41sCDcpA4vGm665lxjidh1AAV+LD7ukNppOBw7Kzy8
         XznFxeMyMaFlNFS5M4p6wYZylTXj/NQP7YlitFPna6S4Nk6BtLVlptL7SX+408HbOxUa
         +Jig==
X-Gm-Message-State: APjAAAXoe9I3Lhyrv6VWCN8FCSIFXChmtpl1RMf+POSxR2WSFauNDXNi
        OTHKbkNPUTVRIB7OVNu5iU84MQ==
X-Google-Smtp-Source: APXvYqxZc3EADFrIKvZtBidjDNyX7MfQHCtBgDMnAiOTyPCPBnueOwuGeJwhQyllR7iNwwTq6Wygtw==
X-Received: by 2002:ac8:2ea1:: with SMTP id h30mr21686178qta.333.1558356782974;
        Mon, 20 May 2019 05:53:02 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id v3sm13052762qtc.97.2019.05.20.05.53.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 05:53:01 -0700 (PDT)
Date:   Mon, 20 May 2019 08:52:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Message-ID: <20190520085207-mutt-send-email-mst@kernel.org>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 12:29:48AM -0400, Jason Wang wrote:
> Hi:
> 
> This series try to prevent a guest triggerable CPU hogging through
> vhost kthread. This is done by introducing and checking the weight
> after each requrest. The patch has been tested with reproducer of
> vsock and virtio-net. Only compile test is done for vhost-scsi.
> 
> Please review.
> This addresses CVE-2019-3900.

OK I think we should clean this code some more but given
it's a CVE fix maybe it's best to do as a patch on top.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Dave do you want to merge this or should I?

> 
> Changs from V1:
> - fix user-ater-free in vosck patch
> 
> Jason Wang (4):
>   vhost: introduce vhost_exceeds_weight()
>   vhost_net: fix possible infinite loop
>   vhost: vsock: add weight support
>   vhost: scsi: add weight support
> 
>  drivers/vhost/net.c   | 41 ++++++++++++++---------------------------
>  drivers/vhost/scsi.c  | 21 ++++++++++++++-------
>  drivers/vhost/vhost.c | 20 +++++++++++++++++++-
>  drivers/vhost/vhost.h |  5 ++++-
>  drivers/vhost/vsock.c | 28 +++++++++++++++++++++-------
>  5 files changed, 72 insertions(+), 43 deletions(-)
> 
> -- 
> 1.8.3.1
