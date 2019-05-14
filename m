Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906E22166E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md6ODv8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfENTVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:21:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50372 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfENTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:21:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so245120wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TyQg6f0OJ6dAGw5yrCbYEVxxVDCUP9/3cMho82DumbU=;
        b=Md6ODv8PHqVlM8VhkCCTBJe4zwUbLWmROcbyoH5rEta+xEBGECWsj1mo+zrFPO/mQ1
         VJT9HRY3qom7dvcjsYdrO1roSUUDrns2pST7nPKfkPfTWeA69oZaSjrwRd+i0c+C9j5o
         9xNufAvvmiYk9f/9O3qnmDoBnfUcklBuIgLQamZ37kmjE/pXqZbq2hPHdbRO6s1iNPa+
         /+Cv2WTUZCHgbyoUSgp2cgNDBQoYpfjtS8iFsJvBmVI5ggjEFgVOttuhhCTlG7yDMWax
         +VVDhT9eWXlM9dGa8+xTc5f+7IVHL1RMTvuxGCEse/HN6j7I4poiy/1AwAADb9O9mTOB
         PqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TyQg6f0OJ6dAGw5yrCbYEVxxVDCUP9/3cMho82DumbU=;
        b=ckiw1nHEbPhhCfLZX78BasP2qK6dZtKlRFnjljc/tV+JXxa+G/4ECCVN1OQZHpW625
         GBdNrdmiViXM2ac4DHJnZCXMVCPchPoAKOBxDpgPRe34ksnuPXA9XQUmBiMVU4H0kZ89
         /av9YkRnjDzACUj/dSdkRqUbe2aZCy28jB8TIyME7RKllvf++LAM8ISZXH1G1OBWsi5S
         MhDs6Kql61rgaffS+/avkVxsnk4UC5bU8GboM0fQ9Ol0DV+z+8kXIj3lIrJmYT6a+m0w
         gaUR9+yormOqBm07vuOwDHXjCXERXDStVsY55Ocfx33Rzk46pb+KZ9su9ONNCsy2h4so
         71rQ==
X-Gm-Message-State: APjAAAVSLUC3Osnmx8PEc2pGzjTiWlMb/3+vIQyJOkcu77PywaL4rMmt
        JrsRqXtctaSmYMOePVXA2A==
X-Google-Smtp-Source: APXvYqxT/XrnGrvsDC62E49I/umpW6KPAHNZM788E8NSVS5U8tX6QZ5Ttxr02GHu5u0AThcvFsgRKQ==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr19329357wmj.121.1557861694703;
        Tue, 14 May 2019 12:21:34 -0700 (PDT)
Received: from [192.168.1.99] ([92.117.184.230])
        by smtp.googlemail.com with ESMTPSA id l2sm6049718wmf.16.2019.05.14.12.21.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:21:34 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Some new features for the latency tracers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190513215008.11256-1-viktor.rosendahl@gmail.com>
 <20190514125103.64d778d6@oasis.local.home>
From:   Viktor Rosendahl <viktor.rosendahl@gmail.com>
Message-ID: <b117ed30-f94c-2b80-4184-69ff98ce47c8@gmail.com>
Date:   Tue, 14 May 2019 21:21:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514125103.64d778d6@oasis.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/19 6:51 PM, Steven Rostedt wrote:

> Hi Viktor,
> 
> Note, as the merge window is open and I'm also currently at a
> conference, it may be a while before I can take a look at this. If you
> don't hear something from me in 10 days, feel free to send me a ping.
> 
> -- Steve
> 
> 

Hi Steve,

Ok, good to know.

I discovered a couple of annoying issues with this v3 of the series, so 
I will probably send out v4 soon.

best regards,

Viktor

