Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6106EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3235B2189E
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 21:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="bqB7pni7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbfHFVke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 17:40:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35002 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbfHFVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 17:40:30 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so64249410qke.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 14:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Js86RGa+7gv8Dz+uRj1Z85NVpKzURiNKiRWdZZpNzpY=;
        b=bqB7pni758j//HeQjWeQWyiOkiio/33jFDo5D/Rv43HC0kMCmA5p2jGfzO94R2MA88
         vL5PEaVpJPJLw6FKGxxHf3bsrOfsqZi1ED9Iwni8F9f28HbFNdfGl417EMsohc4D89Do
         5A2M4b8qmq9OHs17lIwFmC47xvsrrFhDGBBQKRkoYDTgEbinjFDvPDorGbk9IXR4GPMx
         /1cbfnsFSxcrAnqgh9Pv2xIuRA/8gBCoQ/X6NHVYHV4PSV54LQ2iY0Uuq1PtYNiVFSAx
         U6l1ta4OkHR2G9J5T9iFhoO8OwpjSEq3ovytdwQup92QaJfsMXvujUcHayqnIm1nHNeo
         ZzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Js86RGa+7gv8Dz+uRj1Z85NVpKzURiNKiRWdZZpNzpY=;
        b=T34FdoV6RK9Jfu+YsZlzbesVHfz9M6QqgNy5NckvAKPYHFxWCodMBRCeLP3heAV+tQ
         ZaSpSuw+QREIrUoSSFHLHodWuHLPGOTojukvERPrb1aXmYbAy39VZBtymYeurXRlHdVi
         5Z7qJREYoaA9icLuZPLmEnA+21vgXMVulwEcARdt7S+QZnzNtDn0YT41kl6ZBfemin80
         pXv+NjGiwFkAl9U1EdAAca90jATYtXMo7Vpb7DQ/Xy6ZrKFc9Y1Bu0DDKr95vje3DdX4
         cv1NFrp7URURHHd3YXaFfpn5K2Oiee0MN0nmVjmsOVbD5Lv64X0wuqRKUfZxDa0sB9Bd
         XX4A==
X-Gm-Message-State: APjAAAWvI0n/0ulyi7+VS9wxKLuPHBfyfkUctNje9GmRf7QdfmtTv/DI
        nkoTBg1bgnFBGf5ULv7jVSNYLS9FJTU=
X-Google-Smtp-Source: APXvYqx2q+8HP8EC16vCqUFUk+3+NZe8oYqCl8kwmI9uG79YCv0SXk/bLnAw8YF+vBdK7leiGMQEMw==
X-Received: by 2002:a37:c81:: with SMTP id 123mr740898qkm.300.1565127629072;
        Tue, 06 Aug 2019 14:40:29 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id e7sm36124885qtp.91.2019.08.06.14.40.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 14:40:28 -0700 (PDT)
Date:   Tue, 6 Aug 2019 14:40:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Hayes Wang <hayeswang@realtek.com>
Cc:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH net-next 2/5] r8152: replace array with linking list for
 rx information
Message-ID: <20190806144003.457b244e@cakuba.netronome.com>
In-Reply-To: <20190806125342.4620a94f@cakuba.netronome.com>
References: <1394712342-15778-289-albertk@realtek.com>
        <1394712342-15778-291-albertk@realtek.com>
        <20190806125342.4620a94f@cakuba.netronome.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Aug 2019 12:53:42 -0700, Jakub Kicinski wrote:
> > @@ -744,6 +745,8 @@ struct r8152 {
> >  		void (*autosuspend_en)(struct r8152 *tp, bool enable);
> >  	} rtl_ops;
> >  
> > +	atomic_t rx_count;  
> 
> I wonder what the advantage of rx_count being atomic is, perhpas it
> could be protected by the same lock as the list head?

Okay, I see you're using it to test the queue length without the lock in
a later patch.
