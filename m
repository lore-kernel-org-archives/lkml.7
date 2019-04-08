Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FDC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BB521473
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="IcPCXuWN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDHPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:53:02 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38639 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfDHPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:53:02 -0400
Received: by mail-lj1-f182.google.com with SMTP id p14so11732389ljg.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 08:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=428MxoPmdfFdLO0ZnEGu1wKnxhHOYMTzNgVe45wSPeg=;
        b=IcPCXuWNc3beaetdh+7XcyO/TOi79e1lhkaGWY616uBzwiuW9qppcsls/VR4e0HtHZ
         5UNAA3xI7LsnsZ3+qliCPc1l4no6Q5Fq3GxcVf0fEQsMrIRm0hR78Mj1nEOVwlc4vyQ0
         a54KqUpKCoQ/QM1MB3nBylx4MiS+FrWrBx2WKHg7pyrrlScEx8hjz0TuR8Y5uow/L9s8
         DzttzBHU4Oj81wwpKOFb//5mMwwqUnZXC1sDDAV8azXgkYCIMrE63tgGCdA0te35Rvv2
         Ff28Yku2BN/ia/KAzfeiXeorhbsoDfmI6koysKmIPltYNlO63pj66t4tQxxrEs1yQVRf
         myBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=428MxoPmdfFdLO0ZnEGu1wKnxhHOYMTzNgVe45wSPeg=;
        b=MkpFcIRSDYRdBg0/psDd9Dt216Qnz54Mv3gfp0AsB4uJyAAilXmLFrAH9/+aAHU4DB
         5EVacnLcQcOxXN/xS9Z18e6Yuj7oOQlh0wa+WW3/ZGuAUB5yLp69ZU+M/ERalaUviELG
         vTpU3sDZgvmCmhAFJl0oZWNhpl52jyPAyc2OKJCM9ilDbei3zjghS7Dolyt7q0M0t6RW
         Xijq9mLAZ8PgQimAj1G1IKChrOiHs5Kxoqr/v2l3PKvjmeXFsB8xv99nRaitybbnb/5L
         lUv/Ml0T8mvzCjhRhyO8tC/OviWNST+9toTwp66a4vRlrPf9kvmg1CSlGb6yVhCivuxZ
         Do2w==
X-Gm-Message-State: APjAAAVD6eN9pVdaHSZoZFEspPUGXwe6CwdqwhHZsUHSJKX7QkNzsm6L
        6nytfgT3UQTIZ0u6YNxuUgLsl/kiPb8=
X-Google-Smtp-Source: APXvYqwIaTAvIlAnm9T6Vg41F+LKWP0AIhn7gELwQO/oIIYJUnOT5aGXlICeD1fC/dFHKB7F4hDA2Q==
X-Received: by 2002:a2e:7007:: with SMTP id l7mr8072769ljc.101.1554738780397;
        Mon, 08 Apr 2019 08:53:00 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.87.219])
        by smtp.gmail.com with ESMTPSA id u17sm6626581lfu.63.2019.04.08.08.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 08:52:59 -0700 (PDT)
Subject: Re: [PATCH] Deferred URB submission for timesharing the DMA channels
 of DWC_OTG host controller in Raspberry PI
To:     "Ramachandran Srinivasan (BRT-SG)" <srinivasan.r@brtchip.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1554724399-2972-1-git-send-email-srinivasan.r@brtchip.com>
 <20190408131245.GC24108@localhost>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <34bac244-3816-115f-4fab-a651ee167cf8@cogentembedded.com>
Date:   Mon, 8 Apr 2019 18:52:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190408131245.GC24108@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2019 04:12 PM, Johan Hovold wrote:

> Make sure to always provide a proper commit message.
> 
>> Signed-off-by: Srinivasan R <srinivasan.r@brtchip.com>

   Also, you have to sign off with your full name.

[...]

MBR, Sergei
