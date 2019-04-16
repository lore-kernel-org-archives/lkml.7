Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B520C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8D8206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSQvJ3UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfDPTfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:35:41 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:42010 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:35:41 -0400
Received: by mail-pl1-f172.google.com with SMTP id cv12so10846212plb.9;
        Tue, 16 Apr 2019 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxhkb6luY3BkKKEiCDaWl+j1GuxV2mQtO3xT/XDaamw=;
        b=uSQvJ3UL7ds+KPVi2ZiimsWPAY04RVDEVo75gUgHLV2ptCUKRI6ifIR0Qc2O+Hrd9n
         Lctd4sD/KYncKVDx/MzM2K9mUSnvm/m6xATZeEM7H56RTGWCA8OwVCeWJqUks48RZ6UB
         gTQ/6ZMv/H0e6VWg3D7MPXwwVgIoPn2BZG4y2RREjQerc2XRdkqbqe7Yt0DFlt+qlHQg
         +4D3mEnaftZfT8XMD/GfyaMX7XSO8e0euCxjvUbU4ZLrlC76KJMwAJo+6Ytqyo/mef/+
         313JP94PLtN4qaxdGN82HL3KzZQvKwFNr6vOD5Ql3FBaJeNR3ASdL32aXEo7FMW1IkMP
         /B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxhkb6luY3BkKKEiCDaWl+j1GuxV2mQtO3xT/XDaamw=;
        b=oEAoVYJW9C7bx2xbc94yaFzuKVHETkl+nMQe7ZlaGZ64ngwsTr2Wy45+uJ9U84mQys
         7tRFfTeTjPnORnaK4J/V0Lmvaw3w/bNCSgs/HcBXrwvHGEGLzGpevBG5OzL0qC1OSj+s
         tyZt2YTY2P44486aVT1RZd7BxyxHLIUI5bYMprFlGQIOo0AMqSslNHTfRDsjfTyadO+l
         aevlMRgifnOUWMKKAmk5wUgRjjgMNJh5yi/0Klw563RvMnN/o/QgdrkDhKD6/rsOfZsc
         phitH6QhH2lqGMnDZfSDSOsOJefmQ2yYYWa8YxOum2TdzNen1GukpNusL8KP1jpZagmz
         KxIw==
X-Gm-Message-State: APjAAAWX1dqnB2AUoz7RQQSCppDMT7W7cL/S05LKWPtMtdCijDYcgjcS
        Re6bBE1NleJjNhBfJGc2EFsVEmr2
X-Google-Smtp-Source: APXvYqxeEj3pke39iCCdbXJqUuzK2NbAFVBn2rZMwgBTa6Gc0U9R5bj/0eaPRBvDIa1tbWjCSVOKLg==
X-Received: by 2002:a17:902:599c:: with SMTP id p28mr21689066pli.70.1555443340718;
        Tue, 16 Apr 2019 12:35:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d8sm51749859pgv.34.2019.04.16.12.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 12:35:39 -0700 (PDT)
Date:   Tue, 16 Apr 2019 12:35:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fix SG list handling in the sparc32 iommu driver
Message-ID: <20190416193538.GA8093@roeck-us.net>
References: <20190416182347.18441-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416182347.18441-1-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:23:38PM +0200, Christoph Hellwig wrote:
> Hi Dave,
> 
> this series fixes some long standing bugs in the sparc32 iommu driver,
> mostly the lack of handling of large sglist offsets in the map_sg
> method, but also a few other smaller bits.  These now show up all the
> time do some block layer changes in linux-next.

For the series on top of next-20190416:

Tested-by: Guenter Roeck <linux@roeck-us.net>

... meaning the sparc boot tests no longer crash with the series applied.

Guenter
