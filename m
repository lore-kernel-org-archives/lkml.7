Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F2BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F55121823
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="ZOtyJo+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfLBUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 15:20:43 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40194 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLBUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 15:20:43 -0500
Received: by mail-lf1-f67.google.com with SMTP id y5so896221lfy.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=A7xwm8gC8IFcmIwrDFz1mUiBMU42HvgoLpPYOdX1CWQ=;
        b=ZOtyJo+O+ea+CUdCTEPU394bFqI2NW2JOOFXR228offjrOPoiKp17JEx7YHrvCwtxL
         ayfcNnftnWN18v0ZWzqlEVSXvl0U0g6v+VfVLIsH1m6m9VNtPL7xBsrJ0HhQ/HWCx51P
         Zlt6UvKJNGWGnBcUfO9q/briMSRbhlOnfg3UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7xwm8gC8IFcmIwrDFz1mUiBMU42HvgoLpPYOdX1CWQ=;
        b=ZLbuTd1cuHY/8aPLPpGq1mfAtV2KQ6poKITNP7fRQxyEqAHCW0pMkf1DqkWweVc6AY
         kBSErbHaWtOCBW/NNsMVwjEH3EGIrqynaX6kCSJdwuGHtDwMDCs0YuEKpbgSmkxlQ2rX
         97R3ARWcaMgat+EKujp3fKrW4uSqGod8BHzMajfveiAVTOlz4LQ6kQpN/XDHQGQNRAmJ
         +sDoqMlSmJdUfwQ3dv0FRGLJl1I6yxWj2b8GW9QGaYLkbjp6m0F56L4KxNX8m7GKd7eO
         37Uz9QMcg3HLGXYvVQl8Uf6rpuFdr84zz2nbsryBuL1KDuYF3P8iQTZcQ/fSeMpyt9iY
         OVPw==
X-Gm-Message-State: APjAAAWyzJDflm6taFzLWVzu701fRVpMX6+Yfkn1h/oNlTNRMGqmOaNG
        J+ahii8PoyM6FjXpnM/iGejXQQ==
X-Google-Smtp-Source: APXvYqzYCEj2kZH16mtMuXRGmli0G8tPPG/NBLbJgg0WFCJMLXzE9JuYVqkrlEByD7jomy4ge/9QiA==
X-Received: by 2002:ac2:5462:: with SMTP id e2mr522201lfn.181.1575318041077;
        Mon, 02 Dec 2019 12:20:41 -0800 (PST)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id r4sm272840ljn.64.2019.12.02.12.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 12:20:40 -0800 (PST)
Subject: Re: memory leak in fdb_create (2)
To:     syzbot <syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com>,
        bridge@lists.linux-foundation.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        roopa@cumulusnetworks.com, syzkaller-bugs@googlegroups.com
References: <0000000000001821bf0598bb955c@google.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <76434004-ca0b-0917-78bd-a0332af2a716@cumulusnetworks.com>
Date:   Mon, 2 Dec 2019 22:20:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0000000000001821bf0598bb955c@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2019 19:05, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    ceb30747 Merge tag 'y2038-cleanups-5.5' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=142b3e7ee00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=26f873e40f2b4134
> dashboard link: https://syzkaller.appspot.com/bug?extid=2add91c08eb181fea1bf
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12976feee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10604feee00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2add91c08eb181fea1bf@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888124fa7080 (size 128):
>   comm "syz-executor163", pid 7170, jiffies 4294954254 (age 12.500s)

I'll look into this tomorrow, I think see the issue.

Thanks!
