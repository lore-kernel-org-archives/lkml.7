Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7C1C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5F321907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/kfyySO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfIRRt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:49:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40103 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfIRRt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:49:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id k9so362043oib.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EvTmrkmexe++tTtuoI1EnQbt2FC53nH3C/ZqyptGsFk=;
        b=o/kfyySO47SUL4Z2aSl/FtPS8Kg/4SOJr0LGnCIePFJEE9n3qIGFFWfc3mwmnXvb25
         sCBA0QkY3YkHwXYKgLoCYjk0Q2vG3P3372kV/xEF1LhGWGcE++i9DBnt3B2Tq5hps/AQ
         vAJGDl9Y9/N9qK8rByaMalh16AYQuRw6xQvyR/PtRnbZMV+3RtfycGlF8tr98qYglzTl
         /qnwalhb/QAb29xfSRDGbkTHyzfnMV9WVdeWkXB/PD29s/52QSXSwVSkmBJQsmMv/loz
         AmwyDkPo1vcNJ6ZVeon0JdFx39ngh2X0KZ3v08ey2Y0B2R9zg3y6uoS+5+NVwu7eZ2MD
         MVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EvTmrkmexe++tTtuoI1EnQbt2FC53nH3C/ZqyptGsFk=;
        b=qkKFVeSxb8aYdgO0oyUuB/LAsDnEqWotMKifydkSZACTJArcGahZENtVmv54pxY0x7
         2PbRfVX9ZVoZEZEadMO3Syv+GUBAIdnhk3Kiv1Omm4D7xKgtyAcHxKziUuM7v0NUx38R
         yowRalVf2Z8K5uYtgUPs5jjWHo4yGtASI9AdbA6kjk7KFkEwv8EptPDDSrN4N7Oyn0t5
         tZUPvNvg6kppamVg+Jg4qHRk7sZ4szvhtxjizZS/NzvdgpPV+IiRxLKydD2zOer9D22V
         0iRIgylzQ+4vD7OGkw8ALHDN6g9UcL7txFGyemgztpIC8JJl4dUy9XuS6cTDYhjMhwU5
         HO+w==
X-Gm-Message-State: APjAAAWoWepSz15UpSp5IvHHeDtOPiEDOPICGIR+7AtnDMkA8tE/k6vS
        JehaUVT5777ccBM05c5Q8M9tHNyf
X-Google-Smtp-Source: APXvYqzIcKhB3nwa/7KYEEQPM0fk0Ih+/PiZKeMat+9FdLjvzl2NkftCqMj2i+394O7PAf1UkBn6lQ==
X-Received: by 2002:aca:53c7:: with SMTP id h190mr3217599oib.35.1568828997330;
        Wed, 18 Sep 2019 10:49:57 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id a2sm1863154otq.5.2019.09.18.10.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:49:56 -0700 (PDT)
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
 <20190918164518.GA19222@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
Date:   Wed, 18 Sep 2019 12:49:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918164518.GA19222@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/19 11:45 AM, Christoph Hellwig wrote:
> On Wed, Sep 18, 2019 at 11:41:21AM -0500, Larry Finger wrote:
>> In commit 185be15143aa ("x86/mm: Remove set_pages_x() and set_pages_nx()"),
>> the wrappers were removed as they did not provide a real benefit over
>> set_memory_x() and set_memory_nx(). This change causes a problem because
>> the wrappers were exported, but the underlying routines were not. As a
>> result, external modules that used the wrappers would need to recreate
>> a significant part of memory management.
> 
> And external modules do not matter for mainline decisions.  In fact
> ensuring random modules can't mess with the NX state was one of the
> reasons for this patch, as that is a security issue waiting to happen.
> 

Christoph,

Is there approved way for pages to be set to be executable by an external module 
that would not be a security issue?

Larry

