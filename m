Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2515D22363
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 16:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="EEDZ6kzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbfKSQRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 11:17:04 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:39509 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSQRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 11:17:03 -0500
Received: by mail-qk1-f175.google.com with SMTP id 15so18300480qkh.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZqRLNz3QoP7lC3GoX4dGbpM/0X+BMWIWcZVOVY7dcIU=;
        b=EEDZ6kzKJxHxR0jYrvurpFG7/VtWy3lmas2bKyDXg0ZIHpu7ZvgPRmxgNIdJ5Trl8o
         2i+mkawUu3GG/1fSr9nzBfLa1IwyzlN5vbaTmoKGke3iU9oK6RwfGr4wkUK2CcZ4XRS4
         T8m6NFVGWYmHUhSii2nMalguQ49rr8DmBIkT46n//mCXFsljMqZhQqpPqcvsVRXp5ZR8
         j3Yz/HgyL4AScR2b/nyEyR8AHVMVBqeRo3TLRgbr+kXQezQzjhiWi7JePw3i6rj+I7Kk
         fXVbFKoYoCJ9W+vXBQuspHHAYavKVmMHwyEXIdioL2V4cpezvpipuNysIJNNSxebF/rO
         m8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqRLNz3QoP7lC3GoX4dGbpM/0X+BMWIWcZVOVY7dcIU=;
        b=Zyctblvd5GYZOJkPFcZ/FROjWDpEum6O7klpERK4jORFStnZs+58mT54JxSwQSnoHd
         YbI7EeIdJKPTeQjIU8ftCaNsrT+IqA4G5gTZOXIeU6tJqzIn1pll4clA5roo5qpfK7Eq
         czkQF9XHp4MfR3WIl8wOd6/mk0eNwXKD7Jf18pVmtmnohr53RVZgee/G9yB9l0sjglr6
         huhiZL0dxG7xnQDSuatHNuV3YU4onBi58ODAC1kpPPosB6LC4GVjSIY2icnl9nkVs6F9
         KIwPsevdZxQswqGZ+fh55wKGEmaUpX6uKy/57QM2t7f0YbjTtQY0kbIZmZvhANIe7yUl
         SMYQ==
X-Gm-Message-State: APjAAAXyNR2hoxntycbMQp3ULTKwMTEekhSsc5ynkZuuk1SsiuEcNjY6
        l7WZn9eXKP0c9H29FAQGvVi9wQ==
X-Google-Smtp-Source: APXvYqw4sM1JFEaj5qBtyeVFL3GFBIz1nwvBoJWPMV830wZLNSSNqslB0uqWWe1hYNiEkrIrWvyc7Q==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr30591722qke.350.1574180221163;
        Tue, 19 Nov 2019 08:17:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::61cf])
        by smtp.gmail.com with ESMTPSA id b3sm9769407qkl.88.2019.11.19.08.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:17:00 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:16:58 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sun Ke <sunke32@huawei.com>, josef@toxicpanda.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, Mike Christie <mchristi@redhat.com>
Subject: Re: [v2] nbd:fix memory leak in nbd_get_socket()
Message-ID: <20191119161658.mmifoeplc5vsdt64@macbook-pro-91.dhcp.thefacebook.com>
References: <1574143751-138680-1-git-send-email-sunke32@huawei.com>
 <d68d17be-0c4e-1286-4327-0e3ba6600eca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68d17be-0c4e-1286-4327-0e3ba6600eca@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 09:13:34AM -0700, Jens Axboe wrote:
> On 11/18/19 11:09 PM, Sun Ke wrote:
> > Before return NULL,put the sock first.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: cf1b2326b734 ("nbd: verify socket is supported during setup")
> > Signed-off-by: Sun Ke <sunke32@huawei.com>
> 
> Please always CC the author of the patch you're fixing.
> 
> Mike, Josef - we probably need to get this upstream ASAP.

Yup sorry got distracted,

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
