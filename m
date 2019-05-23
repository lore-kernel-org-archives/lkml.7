Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6521FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F1B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbfEWRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:22:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45362 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbfEWRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:22:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id j1so4265812qkk.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 10:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=orxdKAeTGhuAr1KDO8ykLR98bbgYAJIpSNP1r+lkby0=;
        b=HKokpVPLyUhQbCG8I0zrY5OWJ0B4QJ8T1RrbuYYqt+l82bgRYvZ2QIVObhGkYyUdWg
         8YyaWQESHx3GnTs2vvnLA3E2RFiy1VbrmHpftDu1sVDHGzR4nWYHipTdw/4LXBDCfPns
         M+YlXt47XJgnBr9igTcI3VWSUlqTKfkub1e1261Yw8I5QYCeLOyjeSiWqcfbDnwS0ayj
         PozKUEcxDzYSKlSdAR0eJ2XZWUtJ2kDqIVA9IDrcp4zK0ahRkkZdt1S4Hoqt2NiLHMT6
         t5X0rbar+EXpvWWjO72cRGN1ypbsN3ZG6q8v3lYXEicdRQIwu/j1TqaFhZDcBtPYUlkL
         bIRw==
X-Gm-Message-State: APjAAAWSgRJDvJAr65EdDUEEgMOj5jWsAF36VMulQ4xdBrd15EJbBxHu
        OzIs6o/pqaTVfz4G+gOVEwn37g==
X-Google-Smtp-Source: APXvYqykamv1Wqqs833PdyLZedOafUeo+CHIJkq0yhHSr/u9oMeUTX6fQlKnQFFG/JvpWeUzz3qZdw==
X-Received: by 2002:a05:620a:1084:: with SMTP id g4mr75399078qkk.228.1558632157708;
        Thu, 23 May 2019 10:22:37 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id x30sm18102171qtx.35.2019.05.23.10.22.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 10:22:36 -0700 (PDT)
Date:   Thu, 23 May 2019 13:22:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        stefanha@redhat.com
Subject: Re: [PATCH V2 0/4] Prevent vhost kthread from hogging CPU
Message-ID: <20190523132228-mutt-send-email-mst@kernel.org>
References: <1558067392-11740-1-git-send-email-jasowang@redhat.com>
 <20190518.132712.1971625204431294331.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518.132712.1971625204431294331.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 01:27:12PM -0700, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Fri, 17 May 2019 00:29:48 -0400
> 
> > Hi:
> > 
> > This series try to prevent a guest triggerable CPU hogging through
> > vhost kthread. This is done by introducing and checking the weight
> > after each requrest. The patch has been tested with reproducer of
> > vsock and virtio-net. Only compile test is done for vhost-scsi.
> > 
> > Please review.
> > 
> > This addresses CVE-2019-3900.
> > 
> > Changs from V1:
> > - fix user-ater-free in vosck patch
> 
> I am assuming that not only will mst review this, it will also go via
> his tree rather than mine.
> 
> Thanks.

Will do.

