Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F4C32753
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 03:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52F02063F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 03:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb0fvx1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfHODOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 23:14:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45995 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHODOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 23:14:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id o13so655332pgp.12;
        Wed, 14 Aug 2019 20:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RTx+dQdBrh00Kn9mHjwvPfU+NaiUOj18Vh2dAGiUWPc=;
        b=Eb0fvx1Eg6BZFhSsKdV62SSGQo19TR7Voq+Ph8h7/AzeS2hsafMg51LallcPXDoqb/
         HA0CNrZkIkCmazMYs24n9ri1VO3DUqmPgGYrDNlpk0S+eaFYjDbkRBIfhnqwlMqPiiit
         uf1vt5LnrR4Genams95bpkhXZd3K3ZPlHxg4aTWCnMNDiCORDji18akynMCU8ofBXzwo
         7jn5rgqb5rEwAH1qfMnRfLErzlTi6Zzc6h047D78Z/jjK7vdI82b+2yWrd1GwrZ6mAhF
         Lhn2RE0MqnGJ0XIAWyqFcFz8Mzcq5582VqIKnfhjdNEh466i0TQ3BdPFED75r0SnlzqQ
         wSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTx+dQdBrh00Kn9mHjwvPfU+NaiUOj18Vh2dAGiUWPc=;
        b=HSrTluH02lk5etiG4k9wrWcHMQejEX5clTa+dA4yeRKe7tcCBf3aUEPP4MJGOIzT3f
         h8MnX02x/Naiw45N0GYxctSDJ5Q5PXUgpCQLcHYG3VMGlxbourzfea3C2VEXORKadYez
         jV/maDlOKYpiz9BdiC0WWV0B9J05vNrCdjns/D7d7URHgpG112T6KTlupW/wvEMJoix4
         cYWKY/cPmTyTxvyvmUSTgGH8SOIDPOfMHyblQJf4TZiKloWUOgzjOhnL2ZJxafwUdmDL
         QIVY0wMAzt7pwTiB09Vihf+aIyeV6DOc5PU62WBScv2e6WJ8Z8uCTmO6kYv3WYFANhKR
         WqeA==
X-Gm-Message-State: APjAAAVMG6ndX0c+Hw+IHpMVdOo/oUkgwHTHTGnZJ58+ol2WkekNZ0cE
        9KknIiyrYNmHpt09mLUrj39iNEGq
X-Google-Smtp-Source: APXvYqz8p5NvUaO1d/1NGQNhozFZSzg90YWYYqpmKrL5wtTFHmpLULND1kxxwaWE+qgK8YFBKSj96w==
X-Received: by 2002:a17:90a:ba93:: with SMTP id t19mr304997pjr.139.1565838845337;
        Wed, 14 Aug 2019 20:14:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11sm1500550pfk.187.2019.08.14.20.14.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 20:14:04 -0700 (PDT)
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
 <87a7cdpi06.wl-ysato@users.sourceforge.jp>
 <ee8b2e37-643d-9b29-b7de-d83c7739c3a0@roeck-us.net>
 <ea8c7d68-d799-6a7e-9606-e011951bf22e@embeddedor.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f07114e2-0b25-9f0e-0c05-b8e61ba673ca@roeck-us.net>
Date:   Wed, 14 Aug 2019 20:14:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ea8c7d68-d799-6a7e-9606-e011951bf22e@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/19 5:59 PM, Gustavo A. R. Silva wrote:
> Guenter,
> 
> On 8/13/19 8:18 AM, Guenter Roeck wrote:
>>
>> Please note that _mainline_ builds are currently broken.
>>
> 
> This should be fixed now:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=41de59634046b19cd53a1983594a95135c656997
> 

Yes, it is.

Thanks!

Guenter

