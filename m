Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA1BC32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0C820842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 02:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMWOZWdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731887AbfJACvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 22:51:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfJACvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 22:51:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id q21so6833488pfn.11;
        Mon, 30 Sep 2019 19:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7uDOjGLVfsje09d+PM/vZYivc4cjDJ4NCt7g5E7CAYo=;
        b=FMWOZWdmZW+QVz/B4ew4zpGJp9cGSN2ItVMP7p5fJt5gXwZrf3Gn9smWMJEfseSf3o
         gIIfzlxGusDX0xdgaYMS5wGubLejGehTlo+0oedyuuoZPx79tfI92LdmtQy4p777QFd2
         xKxXProXiKpbBlwmzKfMkp1VYVz2eEvwrJ0lZWnWNzB+H0WtH/nusKYtuE+gFg+Oj+GS
         UYQbJwBd9HHHMQvhClp1+jtUeACtil6iVJu6KlPRqvHawirrXFS/YsVcR+1+Ej7xqDm3
         +glVcvkVC0HW/NbLiI+w7oqsWG3zZfN4XnSn0iNAPNthU3HyG+aK3lyzVAb7ubWJYk1g
         1PvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uDOjGLVfsje09d+PM/vZYivc4cjDJ4NCt7g5E7CAYo=;
        b=l6IXjfT7YXo4R20X+oIRXulum8Jdev4Ela/qUT0A3RbNrWwLXU0db7MzSsfs/+YJWH
         gF2Q084XcVMZrQKdJY7XkUEFUpdm+2nlvA1PK0mpE0+BC1vwf2MBFAp4rI6B0u8XhtMB
         W7aymPWXX+8u6t1H399hURFo1CGzfWTWWImsEmvN11KKPT1+hnruhbRj4zsxC3bqkpkk
         VVE8+0nUnLSnoFL1iNihU169yw/dP8c29GF1ohErMe0SeSj3xBhqebWATI+Nof3SgSis
         YLyxmOXgBeMTEMtW6IXs/mIe1WIX7cQqlASnV1GK/t6+YgK6TFjYjs5zYXP4RzRzVHGe
         07kQ==
X-Gm-Message-State: APjAAAWzuwHIL0ZuCtTmL0K50uUvgAiBn7ZEOJWdy9GzIWuSkD1bwqtj
        5Pi9BRE6ImApNcL4t2d92CnK6qdh
X-Google-Smtp-Source: APXvYqzS8aFNlMBE6RnTDrAQiKG47Nby1cenHElVuqWgMDjf3lBsyO4bQpftJXesZe9MXCkYvTg9dA==
X-Received: by 2002:a63:1009:: with SMTP id f9mr27014516pgl.124.1569898292357;
        Mon, 30 Sep 2019 19:51:32 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id k124sm16279188pgc.6.2019.09.30.19.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 19:51:31 -0700 (PDT)
Subject: Re: [PATCH] phy-brcm-usb: Use devm_platform_ioremap_resource() in
 brcm_usb_phy_probe()
To:     Markus Elfring <Markus.Elfring@web.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <88679e6a-6701-7d30-d52e-5e970af4de04@web.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5f3ec750-d295-bf57-39b6-b05ed6f05da1@gmail.com>
Date:   Mon, 30 Sep 2019 19:51:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <88679e6a-6701-7d30-d52e-5e970af4de04@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/2019 9:08 AM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Sep 2019 18:00:14 +0200
> 
> Simplify this function implementation a bit by using
> a known wrapper function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
