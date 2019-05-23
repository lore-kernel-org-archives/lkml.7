Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F316FC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0365217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 20:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="YPrDeiqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfEWUak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 16:30:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51203 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387611AbfEWUaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 16:30:39 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so12129628itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=esXE7VyxJb6rAT63aVBp9x3aUrgExnflSSGBrK7zs30=;
        b=YPrDeiqYX+ljC715jVDoKLiKQ3PL6KXs/CvUm+UbwlILdY6vZ3OHIsSKN0qTKQaj1X
         rFPYBRjoGU2l1h7yDCCgFalBJ1XPQQBaC0KGq1lTlb68+0r/tSGDpKix1PPTagkPdO+7
         9Y5tU+fCJV+NPp+1KoPiPCuhz2Mwvf1SzMdp9YfGsqTnnHsclxG0B83a78oVVVOZE6rl
         BRGVIESfN45Ljb0vd2YbnopirBZfc325rrOSc007vvOc9ZhNXmkKEiEAbIbhnPmHqYyh
         qCW9Zq1f/rWUtGmvegjCxL571S+jqGsS2IWxDIYUkf4/+It7SUPvSsX+psqD9SRjAbwv
         zqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=esXE7VyxJb6rAT63aVBp9x3aUrgExnflSSGBrK7zs30=;
        b=ITVVntBetRS5C2WqETxaj2lGgqfy7tvGUTq74ROiBY+ph+wTSP5ibez8hKJT4mT/HG
         OLNV341EfWM4rYeUakFFBjol9I6rxGWEkX5yZlthOAyQ2n6IZzdbbrtJ5skAesX9vb7X
         HHbcz3USRrby4rQxR/dVwSAqfqVFZJpyyRYp8DgoiTLQDvxm0LnrtUOpK3cKUXWR/IxK
         ZKWsp06NgLWA5SyuvSg0wz13eKHwmrS9IH4JqY3H8/KrZnyUfagm7ObxszDHzi+D2jAg
         EmcVpnuxrnykHoGNIOv7YAPnUQ2+CvbNY5qcUO35gM3+u6NdEuj0sxgGEE0DVgTs7Z1o
         eghA==
X-Gm-Message-State: APjAAAXSqBlM28KLd9NHA7vbEF3Wro82PmnbQYsWMqb5UqZrS/cH4Fhb
        4Phq88ymE5HCDz5lNsl6eF9SnA==
X-Google-Smtp-Source: APXvYqyC2di9u7e+938/0ozSEw7Wt/A9fDiowmUG/7iPQo5YGA0jt8SgX/qofm6gVoXsLvmtHl8kpg==
X-Received: by 2002:a24:a004:: with SMTP id o4mr14558440ite.167.1558643438897;
        Thu, 23 May 2019 13:30:38 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id r3sm223692iom.30.2019.05.23.13.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 13:30:38 -0700 (PDT)
Date:   Thu, 23 May 2019 13:30:37 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alan Mikhak <alan.mikhak@sifive.com>
cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com
Subject: Re: [PATCH 2/2] tools: PCI: Fix compiler warning in pcitest
In-Reply-To: <1558642464-9946-3-git-send-email-alan.mikhak@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1905231330010.31734@viisi.sifive.com>
References: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com> <1558642464-9946-3-git-send-email-alan.mikhak@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Alan Mikhak wrote:

> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Fixes: fbca0b284bd0 ("tools: PCI: Add 'h' in optstring of getopt()")

Same comments here as on the other patch - please drop the From: line 
(since it's in the message header) and move the Fixes: line down with the 
Signed-off-by:.


- Paul
