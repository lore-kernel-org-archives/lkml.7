Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D573C606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CB521537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 01:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw7lPod6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGIBVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:21:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34551 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGIBVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 21:21:49 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so3838286pfo.1;
        Mon, 08 Jul 2019 18:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mOXbH37AQ7tFNQ48gevBCHTUGwe3lcXlgFdj+MBfAMA=;
        b=Qw7lPod6Tqd6EC6IpM86aVJ7jzZ+XVTgerLUgUxf/lu82QMJrHryBxsJLnKvS/dnU5
         4Vx9ELiQEC+xIPFur1hbEUMP2IXxS8MSEVj9Q68Uq7dTxxnmgNZwVPTNU0LTJW0E0TNK
         MznAXMtu6A2gE/etTn/VpvjMx8+StcHFu3rKbYwTOf+blMl3yixfkOg4PArLRbV2+dQr
         A8MGHJoVB14M6mj3Gzgh97fsrVT6RhqtUgzPX8Cg38mBR/pqnnrvXwjPHGXMWkkuY+fP
         VhMfW+v4thtoNKqpIt/FLk47/edFhsOqh4z08ZRapv9B0OaZnjcR7qUVfoj291RDWleV
         /yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mOXbH37AQ7tFNQ48gevBCHTUGwe3lcXlgFdj+MBfAMA=;
        b=HOufi6X2sHMx4q2mCkedzGPkQDPhCb2ThFJyNgND6Oc2jXfkfkfjOcRjKnJ9eQDpRr
         w5gL2FyP731EGTSl+arXUUlRigMFPEXfJbcJJRvS2r73Luw92Yma3WeJKy3CJSDe2Ihh
         bHFUldqAaJjprO1XZ5PSWc/a1eY+cOwzQxnF/3mCkTxmjap4SGkLYhIbhNBVZL8X+j0T
         gp5HnEQbAFM9Y8Yvns3XR7eWq0h/vuwVGEaFJzyyZVRRfU4gGLFiWo7YQYxpov4KhrMt
         LCEaBw606tTG4JBMAaaDWlF8A4uLoY3BJzcEv+fyHJmBZwNvhcky4CwytFCO/cmtxM3k
         00hg==
X-Gm-Message-State: APjAAAUqDqnyyeGt46yvxAIedLpEUIiE/XzWZHW9DDLxr5KD47cSL6Xc
        FZ9sN/vlW2jI0vZj2+fkdHs=
X-Google-Smtp-Source: APXvYqxIHi67pMqcRCDMWMc37kj5NpFfBmAvgo5DlqbmRm54b8mtVASrr9kFkvlal5D29wCnpWIcNw==
X-Received: by 2002:a65:5687:: with SMTP id v7mr27731666pgs.263.1562635309169;
        Mon, 08 Jul 2019 18:21:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26sm30672650pfq.64.2019.07.08.18.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 18:21:47 -0700 (PDT)
Subject: Re: linux-next: manual merge of the tip tree with the hwmon-staging
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabian Schindlatz <fabian.schindlatz@fau.de>,
        Len Brown <len.brown@intel.com>
References: <20190701171524.774dfc75@canb.auug.org.au>
 <20190709101754.1836ac73@canb.auug.org.au>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7ba5d70c-8c48-af5d-a154-f6e11f194746@roeck-us.net>
Date:   Mon, 8 Jul 2019 18:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709101754.1836ac73@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/19 5:17 PM, Stephen Rothwell wrote:
> Hi all,
> 
> On Mon, 1 Jul 2019 17:15:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the tip tree got a conflict in:
>>
>>    drivers/hwmon/coretemp.c
>>
>> between commit:
>>
>>    601fdf7e6635 ("hwmon: Correct struct allocation style")
>>
>> from the hwmon-staging tree and commit:
>>
>>    835896a59b95 ("hwmon/coretemp: Cosmetic: Rename internal variables to zones from packages")
>>
>> from the tip tree.
>>
>> I fixed it up (the comment fixed in the latter was also fixed in the
>> former) and can carry the fix as necessary. This is now fixed as far as
>> linux-next is concerned, but any non trivial conflicts should be mentioned
>> to your upstream maintainer when your tree is submitted for merging.
>> You may also want to consider cooperating with the maintainer of the
>> conflicting tree to minimise any particularly complex conflicts.
> 
> I am still getting this conflict (the commit ids may have changed).
> Just a reminder in case you think Linus may need to know.
> 

Thanks a lot for the reminder.

I had a quick look into the actual conflicts. I thought they are trivial,
but that is not the case. I'll drop commit 601fdf7e6635 from my queue.
In the future, to reduce the chance of similar problems, I won't accept
cosmetic changes to the coretemp driver anymore since I only have limited
if any control over it.

Guenter
