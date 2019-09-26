Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F5C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCAD217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfIZN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbfIZN0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:26:31 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DB1EE8E3C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 13:26:30 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id x77so2340568qka.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 06:26:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3FZ5vxqz4dbTcE/RzDr2BQP/Lbs5fzn9d+anVsPrI4=;
        b=To1zICr8nEt1UkWk4XC7JH0hcVrqZA2D5+SdtfwRPO8WaR8Errs75+HAo7AkLuwxZU
         Q76cbvIM8Jew87q9Lz6hzgdd2e9XcC6VNRejRmvOeCoM+R5iNEDsYBEOpcgtrqEHhl7T
         bLI5V0Agv79MlKUvGOGsOFfu4U3xd2X3PXnZKVqazjuBoU2l0BfIijbIbi+48ohq6DpI
         iNbspj2DvqxE8cPv3e2AbzhklKTPxfaspy0C6nNWyKGgQI1uegQiqq/ytAG1h1uxfB36
         0cORZJmiD4xjNgC1SWHAZgvW2S662dkGz/lR+UJuy5NJD3GjFonwXiUdDvyjFD65mpuC
         d2/Q==
X-Gm-Message-State: APjAAAWHG9hOOY81C11wUg4MFsH4CbK0+SKFZpeXJuPivz2wbRP7NTVo
        ce6E8LOlqIbfvY7g941JwOlh4at5636J15HjlrJ7PAjdsWM6fgVZ+fQ2cjTV2mz5RQX4Df/Ay7A
        YJO4hRblT6JyNaDPZWPxPBOVH
X-Received: by 2002:a05:620a:12b6:: with SMTP id x22mr3187484qki.495.1569504390224;
        Thu, 26 Sep 2019 06:26:30 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxOqinr5Q60U60VCr+5JVsP4K+bDRuObBU2H89+wefW4qdAMViXRd1NNdEtJnFrqVLkASlPsw==
X-Received: by 2002:a05:620a:12b6:: with SMTP id x22mr3187461qki.495.1569504389940;
        Thu, 26 Sep 2019 06:26:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id c12sm968131qkc.81.2019.09.26.06.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 06:26:28 -0700 (PDT)
Date:   Thu, 26 Sep 2019 09:26:22 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, alex.williamson@redhat.com,
        maxime.coquelin@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, dan.daly@intel.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        lingshan.zhu@intel.com
Subject: Re: [PATCH] vhost: introduce mdev based hardware backend
Message-ID: <20190926091945-mutt-send-email-mst@kernel.org>
References: <20190926045427.4973-1-tiwei.bie@intel.com>
 <20190926042156-mutt-send-email-mst@kernel.org>
 <20190926131439.GA11652@___>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926131439.GA11652@___>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 09:14:39PM +0800, Tiwei Bie wrote:
> > 4. Does device need to limit max ring size?
> > 5. Does device need to limit max number of queues?
> 
> I think so. It's helpful to have ioctls to report the max
> ring size and max number of queues.

Also, let's not repeat the vhost net mistakes, let's lock
everything to the order required by the virtio spec,
checking status bits at each step.
E.g.:
	set backend features
	set features
	detect and program vqs
	enable vqs
	enable driver

and check status at each step to force the correct order.
e.g. don't allow enabling vqs after driver ok, etc

-- 
MST
