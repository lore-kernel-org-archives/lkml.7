Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D027C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3683E20673
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="C3LPbh6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfFHJCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:02:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43989 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfFHJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:02:39 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so3728911ljv.10
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JzD57XsNsm4T7ciYV5qAxbKzPpS/622/plyPfoUuaT0=;
        b=C3LPbh6zTpgqdqk1OabHi1qwjbCKMi4gaYbeys2nVnl4pGPLey+8dynI2K7xi1sOZ7
         7kilIHsGQHMsO/3CXODaKyLGjL76aSAuP0ZePR37J1FBBHcGCFtn6dZ8seqkOkeg5Yf+
         FpY98pgGt3qKKyFs+HgKMTnQYuFHs52bDgm4hJm6XtEpCGU4Bt6QtWOzUmdBOt7Mx6F+
         ZfVl2tZIh0kDg5Q+V51yF3WglMFURPFUYppddySrGiVfe/1+LPDLvM6TufL1jAHMd/LW
         CV3O53V1ZewQUQs373j540+TLC2t2WEfg9hSnDOZ44mBhwJrzMDzoHS8POF74kVghPGC
         QKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JzD57XsNsm4T7ciYV5qAxbKzPpS/622/plyPfoUuaT0=;
        b=kx9YwUfk+X3BC3be0Zx0fXyQID6adPq3iETN3iH5Rl2iNoXCW8jykmADZgrhJwfTL0
         IMdHe4GpBKxlJWqyACT7hcVQUbMIBCAvj/BceBOkl5l6D0JvWUHFstnKpgYkD9n8IhS2
         75VWqci9s4uNmhkqrSIdBVqnWwl3So0YQ0XbgEh9eDMfYg8t2xkif4RzmxegDPDjdbTB
         EayVUpkBq3HUYGAanEK+2Z5ePkqk+2Mzpd2JFstjwXfz164i6DmQC8uqEI9fXE0aTQY/
         2grAf2XAL2Ss9Tn5qDXK3+8XOHVCHHS86uxVVqqmOcecUkqIUjjjlhZpPRgZrwH39HA9
         arBw==
X-Gm-Message-State: APjAAAUdf0C40nWkRoTej2BpYimmWry9P2Vs57UWVmmUNt89ciQLJawD
        FWmWAffVpmiA0ZhFLzb1TOOvjVxpz4M=
X-Google-Smtp-Source: APXvYqyd/kqa4qiFi5uydOKSbaqImtCipAE28cplnv2D2I+Q+J4RNDokGouhWvLF1V62y8Gj1urz4A==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr31017948ljj.147.1559984556669;
        Sat, 08 Jun 2019 02:02:36 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.83.119])
        by smtp.gmail.com with ESMTPSA id t13sm771408lji.47.2019.06.08.02.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:02:35 -0700 (PDT)
Subject: Re: [PATCH trivial] qed: Spelling s/configuraion/configuration/
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Kosina <trivial@kernel.org>
Cc:     GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190607112516.13717-1-geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <115096b5-8614-7f0e-e49b-0a71555f18d7@cogentembedded.com>
Date:   Sat, 8 Jun 2019 12:02:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190607112516.13717-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    Again, typo in the subject. :-)

On 07.06.2019 14:25, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be
[...]

MBR, Sergei
