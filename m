Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E7C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792D220652
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtW8rkXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfECL1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:27:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34834 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:27:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so6319987wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qT8fctyh/NTtgLpBOVz/YqcyXidYhaHzijOB2ar/c2Y=;
        b=HtW8rkXO6GVnxXCxg9W+TehfpHqgFJ4BDrZWs1UpshGfMMBH1Hp7Sb2G5AupRSuOtO
         9gsCEo/dUNF5WwRryKFg5rQifBtBv8IMx6mg5yfbXdETsXOzH6UGEFgfs8oGxnAM2f0d
         dJliHrIRRP5r1jrPfvgeKQKmlBRA0NXNqmZi1Gkp0aqeZsufMMHbLobNLpsAewm1vaSg
         TEqQPmEydFQ4oU9Nhaf5qq1Jjg/fVH3VIAZJ83mlx0Od4+kWZsdnbKgnINlL/C5TUhBB
         coNkicnUrD9SRF1F+vLTVGdoGkPTJl7VR+0PKuGYG8v3SwFNnnMbf3qugIhae8yLffil
         czbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qT8fctyh/NTtgLpBOVz/YqcyXidYhaHzijOB2ar/c2Y=;
        b=L13kzh0RUSvquO+mg5HW53WbtnOkH4OUIDhvRi7U/RwsYc7GyXeT4yLGLyLNjBbLbq
         iS8lWU6dGMA8viR8YoK0wyJwq8qbNvtKgD8LObP/Mn6fQ9spP/+xh+qvjiz9McxQTIBl
         2c0IZLTkpFZlSEXOf+7wGidZLoOUSiMHr7uR794YrkexKC8dpAaPbZ+pCqaFkUk0YRR1
         9vfINhIcjcJBeY7WR+sjLQ2z/nz1bwUNIJEa5hxxhvECAIUDhMYfYz435ztEfQ7pfptr
         eD4uAhwk2OJEhKAgGi4n3fTFHIIbg4DnzT4cxwMBcWd8F1jJmeOBbkAf2I0Ceh4CW9ek
         21vA==
X-Gm-Message-State: APjAAAWtFibts6EVZphCdrkIdpuY6AiQlhx+XmvgUOHWihBiUq7RGmgC
        9E/Bi2EuRFHavtvvBukRV6Q=
X-Google-Smtp-Source: APXvYqw62T5hIXnX6MLwYBTQsAQFn3c0zBFxcl9l5uMqqjVkvyOiVR7Ixq62QGnGKXTaeDyvYXHmaA==
X-Received: by 2002:a05:600c:28c:: with SMTP id 12mr5640674wmk.65.1556882861274;
        Fri, 03 May 2019 04:27:41 -0700 (PDT)
Received: from [192.168.1.4] (ip-86-49-110-70.net.upcbroadband.cz. [86.49.110.70])
        by smtp.gmail.com with ESMTPSA id r9sm1931240wrv.82.2019.05.03.04.27.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 04:27:40 -0700 (PDT)
Subject: Re: [PATCH] mtd: spi-nor: enable 4B opcodes for n25q256a
To:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20190503085327.5180-1-simon.k.r.goldschmidt@gmail.com>
 <8161008c-fafd-a89f-d2d8-413224844cd2@gmail.com>
 <CAAh8qsyBHCD9o_wyk6cHxyxagpQvX0dtXxy_P4KqZgoeU8VrEg@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <4ff197be-6ede-6644-d135-b13aab590bb6@gmail.com>
Date:   Fri, 3 May 2019 13:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAh8qsyBHCD9o_wyk6cHxyxagpQvX0dtXxy_P4KqZgoeU8VrEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/19 12:37 PM, Simon Goldschmidt wrote:
> On Fri, May 3, 2019 at 12:00 PM Marek Vasut <marek.vasut@gmail.com> wrote:
>>
>> On 5/3/19 10:53 AM, Simon Goldschmidt wrote:
>>> Tested on socfpga cyclone5 where this is required to ensure that the
>>> boot rom can access this flash after warm reboot.
>>
>> Are you sure _all_ variants of the N25Q256 support 4NB opcodes ?
>> I think there were some which didn't, but I might be wrong.
> 
> Oh, damn, you're right. The documentation [1] statest that 4-byte erase and
> program opcodes are only supported for part numbers N25Q256A83ESF40x,
> N25Q256A83E1240x and N25QA83ESFA0F.

;-)

> Any idea of how I can still enable 4-byte opcodes for my chip?
Maybe SFDP tables contains some information whether the chip supports
the 4B opcodes ?

-- 
Best regards,
Marek Vasut
