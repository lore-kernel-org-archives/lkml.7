Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D4EC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C89206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBM1Ql6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfG2S4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:56:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34210 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfG2S4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:56:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id 31so63030670wrm.1;
        Mon, 29 Jul 2019 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=viNWj7QSl5eXBQLwIiIJURQ7BqkryWItxzxR053POoE=;
        b=iBM1Ql6MMj2c+lpTQEfES1rIfYBllfIrg9cF2k5hW4W4vOeKNeKtHqZFRB4HAS6R4I
         UYntbDoSehibASOSB0AXboFXqe8zWqgd7XmuWmkU+T+uXffiyaTlQ/9Jb0oXic+Zms8n
         Wjx7i88yy14UEwdSH6MJObTJfh2rDrELr57F8X06mUPRj2AkbTaMI+BdHa+c/GwvUQEP
         CEslgDbHoDdGwjpb7nmIzSaJUwd5WEDB+Suk4E0k2sld76piK9E33tU89P5RlxjtD1aj
         Lns3mSIJWD0RIVeTe4LGphm9b2zAdwQZolhXTHNUC3uzBEECnADLGlahn17XjFCkpUIk
         ypsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=viNWj7QSl5eXBQLwIiIJURQ7BqkryWItxzxR053POoE=;
        b=pS/QElHtgqLtuReXZ0SvZlACBieUqMVVl7QLfA6p+NfjMeCLVtFbCp+7cVJT0ld6Ob
         TEbc0zS4gY3bpYwE7HZQqc7bHEr9tNNBsiOQpds4mEmwKJE3Ouo7qUaqXAB09oMyj41j
         kJxs2zvnUR3UqyP3g4e2RMQUkLVVEnzxr6w2rLSLtMFvSONNQrRtb/GdMr0dhLiXpCf6
         KOnuAqWw5sq3mH1pkI0Ah2UVgDdc4yU7FKOafMn7h8/WZIukB5XO4XvyWpS7VmCP8e8B
         JITpxZ34HRNeux9tFdruKbNntBIBLlTE+/3xd3k/ffabMHA4d/pOgJVC7HRZKrz8OkEA
         /d/g==
X-Gm-Message-State: APjAAAVnd9Del0JK+6Di1gtgcznfVG52oVmMytJPuArypwQUAL5f1Qgp
        zhK0ohXgLP0WyPb9jOSiyAoq1VZD
X-Google-Smtp-Source: APXvYqwJ+CMh8AV0qYmBcRmXTZwWCQGrLxbq94gDs+1dJHZdL1PaBvVgUPoNFn0JKHV67H0AZBf7Ng==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11mr41025705wrt.294.1564426575046;
        Mon, 29 Jul 2019 11:56:15 -0700 (PDT)
Received: from ?IPv6:2001:a61:3aff:2d01:3e8:cefd:7d80:b611? ([2001:a61:3aff:2d01:3e8:cefd:7d80:b611])
        by smtp.gmail.com with ESMTPSA id s188sm51672276wmf.40.2019.07.29.11.56.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 11:56:14 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Error (?) in man page for ppoll(2)
To:     Alan Stern <stern@rowland.harvard.edu>
References: <Pine.LNX.4.44L0.1907290921180.20498-100000@netrider.rowland.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <0afd8564-d9b2-0055-3a09-075e1d0d0ad8@gmail.com>
Date:   Mon, 29 Jul 2019 20:56:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1907290921180.20498-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> +The timeout value expressed in
>> +.IR *ip
>> +is invalid (nragtive).
> ----------------^^^
> 
> Typo.  Otherwise, I approve of the patch.

Thanks! Fixed.

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
