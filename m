Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EECCFC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4904214DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 22:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573252494;
	bh=UMGc+oOboSnVrmK1rJuIGQoUCl8g28toi/aUBnngA84=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=dnvI7n9CSuV+aWkzX9CQPNCtUHZqScEAHU5H9euhy5qSl2XNMQTnwD3ocmR5LJuwT
	 t8Gre0k9Q9rzDwoQGcHag6W+AwdXUtJlntw3U5zp0Gt30ZCyLBcFH/RXRvOVN02Zh1
	 eQtDqc8m1N3lqYS+EGCsS06PsDIIHILzpYlEql8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfKHWex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 17:34:53 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:41093 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 17:34:53 -0500
Received: by mail-pl1-f175.google.com with SMTP id d29so4775380plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 14:34:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o7QAbx0fcUyZt1Lg0aV7Z0zOlg+OlFcE7YCMw/JcJVY=;
        b=VpU3cwUrWupKVAnkeBW5WGk2vQYAOlGq+uWUoiNnp8+9XCZWzGwwUkaQZjn7Cfq3tJ
         /QrNStUoXfpwEKACW85/+2djwmIAlDYuT3lrF55qu3cV8FLCS22e3SCsDl5a/i9sjA0e
         Qcfo9ZxSrDqkNEbBXa2ZdtsHf6MWZxdjoiWaT/Uk+bLh9T1qqE3GDfT6iLIJTHptfNa2
         JFaBc+KHre/18IlXdQPjnVse9ALZHLsuGegNb7caWZX8ec38/qZIoZpq1CuXGoXHnLDy
         91RWbo3Hx6X5aNq4Xq2GNCxVGNwuE1cEFRX22BRDhzJFOQTwCFafoP7SbXZ3DLB2FDW2
         kkAw==
X-Gm-Message-State: APjAAAW1SOJVF2MA0mc7uStcJYr57czwjSID8y1Pz/C/fYmNeKmIlzJz
        wMfS+YBu85uxuZ6LLO5q2o+mqCP2UxB8Lw==
X-Google-Smtp-Source: APXvYqyScJRjZwBiOmFsFu8EW7O07y5KPs2FXc0mm0vkMrQ8F8LGUtewdrHqmnUUUMnznCUrU6E5kw==
X-Received: by 2002:a17:902:848e:: with SMTP id c14mr13579775plo.62.1573252492649;
        Fri, 08 Nov 2019 14:34:52 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id a16sm7488191pfc.56.2019.11.08.14.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:34:52 -0800 (PST)
Subject: Re: [patch 3/9] x86/cpu: Unify cpu_init()
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20191106193459.581614484@linutronix.de>
 <20191106202806.040475475@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <0a9a1995-d0a3-a3c6-a177-911d7560430c@kernel.org>
Date:   Fri, 8 Nov 2019 14:34:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191106202806.040475475@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/19 11:35 AM, Thomas Gleixner wrote:
> Similar to copy_thread_tls() the 32bit and 64bit implementations of
> cpu_init() are very similar and unification avoids duplicate changes in the
> future.
> 

I believe you :)

Acked-by: Andy Lutomirski <luto@kernel.org>
