Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D40C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256EC222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WZFzVAbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLSRjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:39:12 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56812 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbfLSRjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 12:39:12 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47dzdW3BGVz9vbXk
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 17:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id S5REBf1zvEd9 for <linux-kernel@vger.kernel.org>;
        Thu, 19 Dec 2019 11:39:11 -0600 (CST)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47dzdW20SNz9vbY6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 11:39:11 -0600 (CST)
Received: by mail-yb1-f199.google.com with SMTP id a14so4630851ybh.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 09:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=subject:to:cc:references:in-reply-to:from:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=AzwXwPyqLdMgiqxoaURBqE7zGRBLFphXTk6J0tyQ+1Q=;
        b=WZFzVAbwy+PD3mfPyPnG/lqPzt5jire3SR0Dmi4ESDMbYrL0YMqDXS/gnwFGLUOpJX
         Aph8hlbuNcPcKp1ouVSPSXKSu3cYdI1TbqcG5bChV3gwEvctRuldGeFualjy82R6o9g4
         itwTPUbaq0V5y5zcTp6RzoR8KklzaE7+9TwCIgaR5odfvBOPFtgZrIk2SJKQTlaS5mFX
         HCyYhhPuNqm3lZQjg/w+e8k/ksVL+X0kVSQJlkSYxsoQ2cO9SQKhWCyr51NhBd4yXCpC
         4Z/X7zfDYL0K3qYHVxReQo67gdRjwVE64kFRNu6kDtVAvaoQWhMQqyfKOuiusJ2tiBQv
         DkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:in-reply-to:from
         :message-id:date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=AzwXwPyqLdMgiqxoaURBqE7zGRBLFphXTk6J0tyQ+1Q=;
        b=SAd4bT+W4wBOnabLQHKnr7DA3k4LcgA8M8Wy378ebK0sjUwz9MgOmUKIly34lVoZ7X
         Jhi9jHbhQq7V+98IBt1n4hRzUf+0oLIITSuY8LQ8jAHzTEL+Io+bVay4WtBHAWc13XgF
         HGkASbLB8hX+Aw1nr5/vYH8YvBs84KcYZHvAHJA17ZiUHb60LYJ5sCDm1AzoJIZ/4rDZ
         8t3OWLdiTL5lvbolX6mpCbRk3JOGiZu4t+gYd3sVSVZkhKaT1tk7sCgP6ruoT1kJ0lho
         /kZmKfNJK5A3xj59izbjZHRLXiMCSU9JeiT1VZQQX7kN0qgZSd5LTOCP5DRueSv8/p9j
         m/7g==
X-Gm-Message-State: APjAAAWJJRnfby++7h85qr+JFsSMhkHA4kLOyD8e77OZF+GGsigQtefH
        arRfVvptOD5o23Y4zGANts+mCvkku+e2gwNq7jEcclicKvTTWy+ZMKM1YEBgXVjABjD10l7PUuY
        K5Uh44RCPN2Bj37RcFtKssiqtVnBIJhWCIwie4oZv5BpkyzTrarFPRRyhhmUe+1ZaoZ7DeZrTwf
        Tw
X-Received: by 2002:a81:6707:: with SMTP id b7mr7101435ywc.36.1576777150521;
        Thu, 19 Dec 2019 09:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzP14w1/YKStiE4g89ZmMAeIFFU+TvL1hgLMP0XOo/Xbf7zuSSnJT6rWdWDvw3RwIwm9Zx+oA==
X-Received: by 2002:a81:6707:: with SMTP id b7mr7101408ywc.36.1576777150217;
        Thu, 19 Dec 2019 09:39:10 -0800 (PST)
Received: from [128.101.106.66] (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id q1sm2854283ywa.82.2019.12.19.09.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 09:39:09 -0800 (PST)
Subject: Re: [PATCH] bpf: Replace BUG_ON when fp_old is NULL
To:     Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song <yhs@fb.com>
Cc:     "kjlu@umn.edu" <kjlu@umn.edu>, Alexei Starovoitov <ast@kernel.org>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191215154432.22399-1-pakki001@umn.edu>
 <98c13b9c-a73a-6203-4ea1-6b1180d87d97@fb.com>
 <566f206c-f133-6f68-c257-2c0b3ec462fa@iogearbox.net>
In-Reply-To: <566f206c-f133-6f68-c257-2c0b3ec462fa@iogearbox.net>
From:   Aditya Pakki <pakki001@umn.edu>
Message-ID: <51dcca79-f819-8ebb-308e-210a0d76b1cc@umn.edu>
Date:   Thu, 19 Dec 2019 11:39:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/19 5:17 AM, Daniel Borkmann wrote:
> On 12/15/19 11:08 PM, Yonghong Song wrote:
>> On 12/15/19 7:44 AM, Aditya Pakki wrote:
>>> If fp_old is NULL in bpf_prog_realloc, the program does an assertion
>>> and crashes. However, we can continue execution by returning NULL to
>>> the upper callers. The patch fixes this issue.
>>
>> Could you share how to reproduce the assertion and crash? I would
>> like to understand the problem first before making changes in the code.
>> Thanks!
> 
> Fully agree, Aditya, please elaborate if you have seen a crash!

Thanks for your responses Alexei and Daniel. We identified this issue via static analysis
and have not seen a crash. However, by looking at the callers of bpf_prog_realloc, I do 
agree that fp_old is never NULL. 

Would you recommend removing the BUG_ON assertion altogether ?
