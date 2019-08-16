Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F9CC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489362077C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 08:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uvKLVLzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfHPIzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 04:55:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37535 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfHPIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 04:55:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id z11so820819wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=lsKEtwV9cUqhIfyszvdT0ohPpsXpCYqQnUcZhNTjTyw=;
        b=uvKLVLzDCxJ1PkwWUwT3OTs/EIKOnv9/8aKTIR9zLn86Jqnis+o7NbwwA/+DYYjCsD
         fs6Fuy9zbBuXqqY0cGMecdyEAa23g+a2MSoqn6aWLkoxnIrVgr92nTfvdmPKn8YWP1ia
         Fd0fYMqsp6pMG6aFes2NfPMPRLSF2gdM/MDL7B1Wdre4afdSGw226bPpZbsWYnAfrnsJ
         ATkilL4RVXxhHh2Hmu6JnXCWnnoDRRPxvJnG15umf8bj3RzeNzg4N+lKPSzl2bcmLNqj
         2AEGcFeBY44Meq68TABFRwVf/JqndRpFm50lm5FdQEPJjMrVIe4duL92U3w6YlB2h8Y9
         SWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lsKEtwV9cUqhIfyszvdT0ohPpsXpCYqQnUcZhNTjTyw=;
        b=dhg+K+IPEivIuCZ4C/eUgHUxAOU/J/lApUdOqX9mojnrTNBlliOIjeWIvZCI8KbuD8
         65J12h+aViFN+PzKw/QsYeN2AhdhA/wewENk8LrZGzE2sfxn3zq5mwC/CxeU4qV/FUii
         wB/bL+NpY7HcIC4kjxhJlst491yxAbeNU1kkjykbzXnykcVJuExg15JZK8LoPTg4l0wk
         Ui2ZNarWgP0jwi2af+do2Tw6QJaU4NX9cBXCDckqQngSh6MdodY5b+Yqyys5RvyMZLAX
         6iRv6jLgL785+M2xgqG+b8Gs3NAKw76hcIF9KRpFNnVgPyzdkLMeCu7DhOgrXAlXmT0h
         zRnQ==
X-Gm-Message-State: APjAAAWX8rcxpRreBI+RN8YbFeAZ46IUiXqYGeDfU1D4PVA4O/fSvHqz
        /wac4lBnOBTk2rUZwVg39qZyGw==
X-Google-Smtp-Source: APXvYqyhoghogoAOuZYiUPIxdW9odhnSaGP/Bl2GcuzfEg2gT8QyTm3tcUm6AXnuq95zZdmfw/xI2A==
X-Received: by 2002:a5d:5041:: with SMTP id h1mr10151128wrt.30.1565945751087;
        Fri, 16 Aug 2019 01:55:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id u129sm6073283wmb.12.2019.08.16.01.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2019 01:55:50 -0700 (PDT)
Subject: Re: INFO: rcu detected stall in __do_softirq
To:     syzbot <syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, bp@alien8.de,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkoul@kernel.org, x86@kernel.org, yakui.zhao@intel.com
References: <000000000000b4126c059030cfb6@google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <63c0dc1e-323d-d46e-2d4a-b5b6d6916042@linaro.org>
Date:   Fri, 16 Aug 2019 09:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <000000000000b4126c059030cfb6@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/08/2019 01:10, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 2aeac95d1a4cc85aae57ab842d5c3340df0f817f
> Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Date:   Tue Jun 11 10:40:41 2019 +0000
> 
>      soundwire: add module_sdw_driver helper macro

Not sure how adding a macro with no users triggers this rcu stall.

BTW this was in mainline since rc1.

--srini

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114b45ee600000
> start commit:   882e8691 Add linux-next specific files for 20190801
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=134b45ee600000
> console output: https://syzkaller.appspot.com/x/log.txt?x=154b45ee600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=466b331af3f34e94
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=6593c6b8c8b66a07cd98
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b216b2600000
> 
> Reported-by: syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com
> Fixes: 2aeac95d1a4c ("soundwire: add module_sdw_driver helper macro")
> 
> For information about bisection process see: 
> https://goo.gl/tpsmEJ#bisection
