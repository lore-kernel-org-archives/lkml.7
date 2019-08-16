Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348D0C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DED206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565968992;
	bh=8qwXbc/CS+AYit58StQRSk/jZuT4ajmtsNB5kY9pBpc=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vp+GG7VwVFUNByAYmu8dOtl3ltsrWv+2qnAO93UlQMeUfHaf9uKe1A5iEnfFKsYL/
	 QM/h21SpRmCL9ITiMl2vGUvWVVFnNqIZPmq82IdXVAgMPllGYdGiEGVNSmlFV7+EPQ
	 pR3uvUimok90WkN1/y6FthE4D00H2I978Rdt1Hm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfHPPXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 11:23:11 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41009 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfHPPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 11:23:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id m9so2569225pls.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFti+zNvQA9kVdJ6DDIY7OYNLBs2lOCWDTzkw0nUD80=;
        b=JWV0lya2j1L169hy4kTK+7FHHBSdNAPzqKDMbZuNUVaNI7v6M3t7p7GwUmFCtV+iCI
         HTVvE0SON/3pTWju1rY7i4lsEaTauZLTUK2sm+TXtb90eLBKqmyJ7PL+4AUQz8KirrJT
         Yq/BOcqS/u8UwP6j1aCWWk8CNmYQ5DaPE11lBORU19YtXuuR4x54niA/cj+cPN60TVAW
         hOO9DOFH02mmL2RM8LIBilTALPV1UiHoE2s3p8fwvg4sDmyuJSHDJirZ94iiE9Ek+YiD
         DzuselUaKE8Y/ocAP7EPvyRp2D1oYllG1hhU/uN8wDB5Plx4HmsagQWzdXBnxuRXjkxl
         PgXQ==
X-Gm-Message-State: APjAAAU58fAlE8wv/NPujpFmL/ArFC0FN4ejjsXG/1ZPBSKoMcurHI1D
        IGJtx0g98Qrl01+RfSKCkXgVZA==
X-Google-Smtp-Source: APXvYqzsTSLEm9rLzgU+7dBp85epFTFwtYeSb3u6V0/FZQr5/N4HdqlCrBqxgRiqpiiNW0OWSpsxFA==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr10064468pls.189.1565968989996;
        Fri, 16 Aug 2019 08:23:09 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id o24sm14125178pfp.135.2019.08.16.08.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:23:09 -0700 (PDT)
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-24-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b719199a-ed91-610b-38bc-015a0749f600@kernel.org>
Date:   Fri, 16 Aug 2019 08:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815163836.2927-24-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 9:38 AM, Dmitry Safonov wrote:
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.
> 
> Those effects of introducing time namespace are very much unwanted
> having in mind how much work have been spent on micro-optimisation
> vdso code.
> 
> The propose is to allocate a second vdso code with dynamically
> patched out (disabled by static_branch) timens code on boot time.
> 
> Allocate another vdso and copy original code.


I'm unconvinced that any of this magic is wise.  I think you should make 
a special timens vvar page that causes the normal fastpath to fail 
(using a special vclock mode, a special seq value, or a special "last" 
value) and then make the failure path detect that timens is in use and 
use the timens path.


--Andy
