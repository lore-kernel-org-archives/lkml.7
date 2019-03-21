Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD9E20657
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsdDywo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfCUS4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:56:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44966 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfCUS4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:56:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so4861942pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kserF2iaci/KOWtI34oBz8Vmnrme0LJZiffuYVYtgAI=;
        b=IsdDywo2ll7b4Xp7xlPXfwPFLrWPReH9O0EV0tIHS042TDYmU62L2gRSbdJRehzURN
         J6iImWQryiatihmtKA6EiZP7BQHqEzaaRuAZPhm6ymyge59F1AfTu1DVbd3pYDPjhP0E
         AJCDc9BVCqxqiZS3TmIZ19wLBoPhzDWxXzvS+by27OMChcolNNoCyVnVWo/j5EUBNvwv
         +bqy31Hp04fdXCJLxRIYMAQofeE2EnGqkDhviKNgS7yxaGCeddGS8/ulkAZS2d9aGpVJ
         JJjUjCFxsnLvnK9CZprb70A4kqzhtnuiMx691lo5nMkQf9bnrl27puaEWBXH6GCLjgoD
         wvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kserF2iaci/KOWtI34oBz8Vmnrme0LJZiffuYVYtgAI=;
        b=Vw+zfzECN8xyW8XbEzwjHYye0o4nykmJF4ehZc+XPhoKQiFJaM8iVLrD+GF5ZsaFtV
         hQouUVuGfutg3F98IH17sgqG4hm+k3cZSrxy4l56mdFvFbg6PCWwrRj9Y8s5bheXH2lI
         nFmdXxHHmau8EX/rmAi4DWL40LbmDGrwxozGKI043MkuR792g6zNGMEjRLXVqaB9A4oP
         Z+Cc4Jh9t3Ho00j8yy0HZv29fDoHP+QWkrTyG0knRWECFDNexnZDy595We5XdTsxouM3
         2PAxHS9meDp29Z1DyNK9mpzMIygC1FiZiKMW8CHUdgrrhfpuR/M5tQdhaHUlSSswtvcU
         Nq9A==
X-Gm-Message-State: APjAAAWeKsgbreacb0W756xx1gJOF6EJesab7bOQNebhAxi+Lfa4ZJox
        ImClP6ia9BvP2Fvwda1scyY=
X-Google-Smtp-Source: APXvYqwtEsX7YGDBG9FWRbMJrujy/9wJTwUTUt966DZFpsBJRDhOFOeSn6w+Foff1xcPkRvVSPWYzQ==
X-Received: by 2002:a63:234c:: with SMTP id u12mr4827201pgm.282.1553194144569;
        Thu, 21 Mar 2019 11:49:04 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id y16sm6617280pfe.116.2019.03.21.11.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 11:49:04 -0700 (PDT)
Date:   Fri, 22 Mar 2019 00:18:58 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     christian@lkamp.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: ralink-gdma: Prefer u32 over uint32_t
Message-ID: <20190321184858.GA9217@bharath12345-Inspiron-5559>
References: <20190321183710.GA8472@bharath12345-Inspiron-5559>
 <20190321184609.GB16785@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321184609.GB16785@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 07:46:09PM +0100, Greg KH wrote:
> On Fri, Mar 22, 2019 at 12:07:10AM +0530, Bharath Vedartham wrote:
> > Change uint32_t to u32
> 
> That says _what_ you did, but _why_ are you doing this?  That's the main
> content a changelog text should have in it.
> 
> thanks,
> 
> greg k-h
That was a checkpatch.pl warning! I forgot to mention that! It fixed a
checkpatch.pl warning. I ll write better changelogs from my next commit
on. Thanks for the feedback!


