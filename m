Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9CEC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069FF20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ft2ZIUgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729498AbfHOPZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:25:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44664 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfHOPZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:25:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so1175800plr.11;
        Thu, 15 Aug 2019 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AkYthp7LCueG9x2IINcBzpO2jlClSAIZLBrJ2UUQFGE=;
        b=Ft2ZIUgZ5Tm+zKB8GUWHYDJlgKa9TJgKcw7PqXTlwXzTWYw1tAluAzGxaWLoa3B6nE
         sY5iL51DIF2tSJ7ldSn9rAvZ/2/FR6G6wV5hhrgLxQMyBiQdGGy4u3AKEyLlMLjSmMJB
         z9dMsq8xify2qHYL8bbQWWGqqa37K1n+Ve/paDyLaMsRIpgBDeWPXntdc8Sf8zVUqJhi
         OLnlkRQcFTFFF8jin7n2cjjbNz0gQ6ig8u+dF4evbd0KK/xM3u84SuvTebV34P49CBXq
         AEY6K3ijY0Q+cr3PLmu+YAcHg1V5SHy//sx5cWTeVz5n8RqL1VhQdpctfNV4V6k16I2m
         IHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AkYthp7LCueG9x2IINcBzpO2jlClSAIZLBrJ2UUQFGE=;
        b=NAkqMc2EqrAi7hxtpLKdGrvTY59RV6ydkv1lEolYpi87yvgRGy9RLVI3UT5DCVTR19
         B4wOjkd3TFbE4P6PPqGtyUHUUeiTojstjSCXQUOf7voU08WXu34kZro+lyhVrRIYuNRz
         galgucO5sMSlSTrrDAgTa4u4fE02G0Po9FpRU8YYaCi5qu7/5KhJ98VzVjpEMiQUe0Es
         gstmxyjZBz3V7n5xmX7sOa03eAt/7CBiMY+P62s+3KgGUVDAh6L+evDf34ouipvFHOj2
         kZW/bz0JwxRCuk3rfUvhxRhY+RA4a10CSw19lTCBqeQMwEXVaf+npzb8OAD7XgbEYBhI
         db3Q==
X-Gm-Message-State: APjAAAVlRDAGgUj1sjB+iiLy0OiGVIKbVwwIWhg4e+oJrgWXuVo4Hzln
        fFZnhtUC0Lgc0z/BERVh/rU=
X-Google-Smtp-Source: APXvYqy5xv1v79GwuL1+TFWhMNCNXA0yRttfL5Zr+vUkNMu3x3jxt8Ltekrpv45iYEGRHZ1Ac9qvMg==
X-Received: by 2002:a17:902:2ac7:: with SMTP id j65mr4888600plb.242.1565882751110;
        Thu, 15 Aug 2019 08:25:51 -0700 (PDT)
Received: from localhost.localdomain ([125.142.23.13])
        by smtp.gmail.com with ESMTPSA id h70sm2588166pgc.36.2019.08.15.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 08:25:50 -0700 (PDT)
Date:   Fri, 16 Aug 2019 00:25:44 +0900
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     shuah <shuah@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     valentina.manea.m@gmail.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] usbip: Implement SG support
Message-ID: <20190815152544.GA4533@localhost.localdomain>
References: <20190808155435.10050-1-suwan.kim027@gmail.com>
 <20190814131951.GA1437@infradead.org>
 <20190815132356.GB27208@kroah.com>
 <0cf92881-53c7-09d4-18ac-593034a1a56c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cf92881-53c7-09d4-18ac-593034a1a56c@kernel.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 08:10:49AM -0600, shuah wrote:
> On 8/15/19 7:23 AM, Greg KH wrote:
> > On Wed, Aug 14, 2019 at 06:19:51AM -0700, Christoph Hellwig wrote:
> > > FYI, I think my
> > > 
> > >     "usb: add a HCD_DMA flag instead of guestimating DMA capabilities"
> > > 
> > > is the proper core fix for what your patch 1 works around, as the USB
> > > core should not assume DMA capabilities based on the presence of a DMA
> > > mask.
> > 
> > I agree.  Let's wait for Christoph's series to be applied before taking
> > this one.
> > 
> 
> Great. Thanks you both looking at these. Makes sense.

Ok. Then I will drop the patch 1 and leave vhci flags without
including the HCD_DMA flag to skip dma mapping.

BTW, in my patch 2, I set URB_DMA_MAP_SG flag in
vhci_map_urb_for_dma() of patch 1 to tell the server to use SG.
I will fix it by setting URB_DMA_MAP_SG flag in other place and
resend v6. Is it ok?

Regards
Suwan Kim
