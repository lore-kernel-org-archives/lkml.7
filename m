Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24728C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13A72146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="b99hvL0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCMWIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:08:10 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:43284 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfCMWIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:08:10 -0400
Received: by mail-qk1-f171.google.com with SMTP id s26so2131622qkm.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=/qDGw5+rgwnGlzkiXKqOACIK+wIaTMx7JRkJ7TcmLUw=;
        b=b99hvL0tzD+2RlQ79OplublQQ/cMZaaXhiwaJrSjCMvzGrV0npbUMGtjVrbo5pCSgP
         OmBfahqrdAvKNo8Th5waf3rszuqWtW3Oipd/0o1MwWPtatAKOyrD0mgVlCpNAfUlXzqD
         azlqNDvLpBz0tehnobs7HED0+gMwNyRlzYiYtVdtEt1rJGU6DMQtOPKkO6Hxmcggz++4
         COBiMaN73xbtLXWHM8x0do/G+lBHp+osRiJ+duwAWwUY3VzOFa81qK9JDCygYPIhsJ1y
         umWBtPqUZ98axNe0wnKBXdyLDlyC5dmzcTAgd7Py6ZX9WUqbsCrmsuY1P5HmuV4QoDvO
         x9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=/qDGw5+rgwnGlzkiXKqOACIK+wIaTMx7JRkJ7TcmLUw=;
        b=hBNg4ltl5/EXTwNcnuBzRBvInXb+MKmW+Q22iVS1VxX6aE37iTfAeZMiknGjo/HDub
         q3CZwdJSSxbe7hGtPuZ0Z+W5iKRcA9PTsGPNbN2aRVjw38PQSuqhyRdrEI5vYl40c2SC
         5Y3RcrCumBSSoXqwEMt5oxachNrRIfT26v7pnDcfY0eT+BIGnft9Fo8djPgXT+nzeacr
         R28EtyCIdEA5hk4Z2yUFIcfLRz8s7m0tCFiXJalXXlgdulpGcsqX64bUf/cjAa6n63Lz
         TjLOPJ7mA79YBmr2LZwwvIxBn9VxTsQoeZoIxBubrhOcxgD48rDpS9Ktp9DAdS7ln4P4
         xKIg==
X-Gm-Message-State: APjAAAV18ww5Dtv8IuneJ2jUATWCGLcyJCNez5YiFL6ejqB1VPu0L/bj
        8kjdjcVTh9Tx0/A4//1ZzivYYQ==
X-Google-Smtp-Source: APXvYqxihLjxDhrF9y4NHQO0Ldz2sxWpX6ruLQFUyXXhrexIVeftFHMj3ab+nVvvCMhDcGf3HdxQLg==
X-Received: by 2002:a37:c6d0:: with SMTP id s77mr15011864qkl.116.1552514888756;
        Wed, 13 Mar 2019 15:08:08 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w29sm1920517qtk.72.2019.03.13.15.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 15:08:08 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:08:04 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Parav Pandit <parav@mellanox.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.lkml@markovi.net, davem@davemloft.net,
        gregkh@linuxfoundation.org, jiri@mellanox.com,
        kwankhede@nvidia.com, alex.williamson@redhat.com,
        vuhuong@mellanox.com, yuvalav@mellanox.com, kvm@vger.kernel.org
Subject: Re: [RFC net-next v1 0/3] Support mlx5 mediated devices in host
Message-ID: <20190313150804.3702ae47@cakuba.netronome.com>
In-Reply-To: <1552082876-60228-1-git-send-email-parav@mellanox.com>
References: <1552082876-60228-1-git-send-email-parav@mellanox.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 16:07:53 -0600, Parav Pandit wrote:
> Use case:
> ---------
> A user wants to create/delete hardware linked sub devices without
> using SR-IOV.
> These devices for a pci device can be netdev (optional rdma device)
> or other devices. Such sub devices share some of the PCI device
> resources and also have their own dedicated resources.
> A user wants to use this device in a host where PF PCI device exist.
> (not in a guest VM.) A user may want to use such sub device in future
> in guest VM.
> 
> Few examples are:
> 1. netdev having its own txq(s), rq(s) and/or hw offload parameters.
> 2. netdev with switchdev mode using netdev representor

Hi Parav!

Sorry for going quiet, I'm hoping to clarify the use cases and
the devlink part on the other thread with Jiri, and then come back 
to implementation details.

> 3. rdma device with IB link layer and IPoIB netdev
> 4. rdma/RoCE device and a netdev
> 5. rdma device with multiple ports

