Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD32C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451B2206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfGaL4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:56:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33328 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGaL4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:56:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so69464034wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 04:56:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GsipjGQz0NsfXLQ8XFAFkWUSQK70K8wFpTawzfLRq9w=;
        b=HEhwT8VxHufvuwAkskc8xwbLVOJHQoZQFToiK4e7w04VbzTVPKJWF67HTrYMCKd1SQ
         KwTj+ssEcxhuMZdE9qQ4uC6xdJ416nN09W+nAMX5rcIttdSuQlIXRyiP8k9/BTzrR6CT
         m8xRTcn6+9rmoWSeKnCrSYehdGnlHgC6RGQ3/gpnCTM8Ps781V4Bh8QBXzMHNwkvxDOu
         1Z/vl6D1LCR/9YkMyg8RPLJ0W2j+Gj7szrRLP13eMVvgfJoOBZnQ6wpfkQjcv2FWn85a
         /JhxUZruooZKW1km8At/6O0zyt2BQm5ZGtxH4GhygI1tjkXhB6+oSB+6RicUed/Xc3Ix
         rb5g==
X-Gm-Message-State: APjAAAVkZePZHPkoGWjZAtzL9sIkQpCMTld7f14WYn1dvT7xNzaFOEH5
        tNrxB3cRtAMmutj918YK4sd3Aw==
X-Google-Smtp-Source: APXvYqxonpUOMbZXSy0s1uYh4dswgT7Zx3y/25h0oxNhiIkDKuA3UjLlPO+Td1lheHyoD55VK21v9w==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr11250162wrp.59.1564574208514;
        Wed, 31 Jul 2019 04:56:48 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host91-203-dynamic.171-212-r.retail.telecomitalia.it. [212.171.203.91])
        by smtp.gmail.com with ESMTPSA id e7sm59756595wmd.0.2019.07.31.04.56.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 04:56:47 -0700 (PDT)
Subject: Re: [RT PATCH] sched/deadline: Make inactive timer run in hardirq
 context
To:     Juri Lelli <juri.lelli@redhat.com>, tglx@linutronix.de,
        bigeasy@linutronix.de, rostedt@goodmis.org
Cc:     linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        williams@redhat.com
References: <20190731103715.4047-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <aec3b51d-3414-6441-f729-8e60dda996ad@redhat.com>
Date:   Wed, 31 Jul 2019 13:56:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731103715.4047-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2019 12:37, Juri Lelli wrote:
> SCHED_DEADLINE inactive timer needs to run in hardirq context (as
> dl_task_timer already does).
> 
> Make it HRTIMER_MODE_REL_HARD.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>

-- Daniel
