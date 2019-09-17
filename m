Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A62CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3939E2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 13:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="omYgqw8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfIQNGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 09:06:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34798 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfIQNGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 09:06:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b128so2162149pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WXjXRRZVUtfs/NBrDnZYybzMPZ6/z0w4LM5WT5/NCRQ=;
        b=omYgqw8vdfnj/BCBVa1dOTzudnQP5nkVtJFH3xIKULtQccr7vaMsLTP7PJXl9Q2zl3
         7D24zqIl32IA95y/AwPX+xT2g4nafqjDlKqfLWxr/+VyincN0GvtdSZpsPecKJzhwJ4L
         CADxDXeu2PDy9N69XBQxGxEM+3gU1iQNPQ9HAyJVzwC9lnvz8M6g7L4OggQqcKIzz0ux
         fmHTBVxd5RUs6ly2//g4N2DGKTobnrs7Nlv3MlriISjsPoXgwGNHY35Lq0sqb4kxBjD+
         7oE94QLYmWCIbkpJ0FrM60EtPxDoTuZPda3RiU5HaTf0E/H1N4mrmHqOeEFQcNBc3phG
         /38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXjXRRZVUtfs/NBrDnZYybzMPZ6/z0w4LM5WT5/NCRQ=;
        b=OlfR85ixqtOTpxBN2rZ78/ua7q/0JYbABghFHbrpTrHxnzY0yCDPGp41WZDRHHIC/X
         UL6LlUNB3h5weAaqQQQo4FvFPs5kuPmLOdDlw/8Qa0BcxRVnR/HUJDzGn0oQICY0P/dN
         RgmKv+OOFf8/fl6M7qNoL7Z6ADWAP8F9EER9eeN6occF1bcW7/RDBMUujJfMbaGTp+C6
         sUpnoG7kekHM6vt+Z3rUMbAE2qux9yxuzCGYatxKLJaSB3UUeYNXz9yZrtyW5GwbczcC
         W92YzoDJNpVDqTGik0dXnBx5qqEnz307jHRFigVH9fIc5LPMqYNXzVFsYACNPxJzDYIa
         3Imw==
X-Gm-Message-State: APjAAAWTTFjqGJw/I1uOx6ngerpfJNZUTGU3+KNbNAGPTRhkqOe+3E4s
        r0n3j5+05Hy9Q1BeoPCYqYY=
X-Google-Smtp-Source: APXvYqxAxKAlWk/RgxHRu6VyLU4cD/6/OLBd2BUHkdqZBaygYNSzcKt+lb4z/NdiZOCfXU7nPVITJw==
X-Received: by 2002:a17:90a:3450:: with SMTP id o74mr4938289pjb.5.1568725564878;
        Tue, 17 Sep 2019 06:06:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v68sm4023845pfv.47.2019.09.17.06.06.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 06:06:02 -0700 (PDT)
Subject: Re: [PATCH 0/6] ARM, arm64: Remove arm_pm_restart()
To:     Arnd Bergmann <arnd@arndb.de>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20170130110512.6943-1-thierry.reding@gmail.com>
 <20190914152544.GA17499@roeck-us.net>
 <CAK8P3a3G_9EeK-Xp7ZeA0EN7WNzrL7AxoQcNZ8z-oe5NsTYW6g@mail.gmail.com>
 <056ccf5c-6c6c-090b-6ca1-ab666021db48@roeck-us.net>
 <20190916134920.GA18267@ulmo> <20190916154336.GA6628@roeck-us.net>
 <20190916155031.GE7488@ulmo>
 <CAK8P3a1EZi5apOm90B6YW2GzFXsirz5wk-D66daR20oj_TLXNg@mail.gmail.com>
 <20190916202809.GA42800@mithrandir>
 <CAK8P3a2y9OYL-pm38rcGvgzvjgErCUC1ckjVXhd3mb=YEXiD_g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <d6507fae-d0a6-00f4-4259-4084b6a442d8@roeck-us.net>
Date:   Tue, 17 Sep 2019 06:06:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2y9OYL-pm38rcGvgzvjgErCUC1ckjVXhd3mb=YEXiD_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/19 12:01 AM, Arnd Bergmann wrote:
> On Mon, Sep 16, 2019 at 10:28 PM Thierry Reding
> <thierry.reding@gmail.com> wrote:
>>
>> All of the patches beyond the 6 in this set rely on the system reset and
>> power "framework". I don't think there was broad concensus on that idea
>> yet.
> 
> Ok, I see.
> 
>> If you think it's worth another try I'm happy to send the patches
>> out again.
> 
> Maybe do that after we pull the first set into arm-soc then. If
> we can reach consensus, I can merge them as a follow-up,
> either through the soc tree as a new subsystem or through
> the asm-generic tree as cross-architecture work.
> 

I'd suggest to keep the two patch sets separate, though, and apply
the 6 system reset patches either way.

Thanks,
Guenter
