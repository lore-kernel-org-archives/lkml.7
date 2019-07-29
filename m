Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABB5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E692A20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="dtpngQg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfG2J0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:26:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35204 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2J0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:26:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so27279236plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=srGiQVNjwAOax50RydQ1PfgxqcbLD0YwYE2csTRzk1s=;
        b=dtpngQg5aT8DOMu3KuV+tMKmByurBhw07ibSsx1BSdvfmZRiBnrTQnNoFoNmKmmHvD
         3aSKLTShBnhtfXS6N8403ANasdCEyejf7mPsLWgA5pQGOrBXfhIOIfCZay+Rz9xeoIE4
         o3674IPIimGgVczQDWiVDGPdTWXsjDBsOd6qvO4+u/w8ScoJbVzYbqm0yXA1qtAEhrpl
         J493qguINFCvJcfH2z1Mrkb77TCYbWv4jPuqQoVetN47YMcqgJJowYLjc1QpyoIW2VpC
         xGwJlwyuaf0yHVfYGAc4NA5hTAxR4t94qT9cFgPhry5nPjWrYPRZZNgou71N+wgeze+j
         sQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=srGiQVNjwAOax50RydQ1PfgxqcbLD0YwYE2csTRzk1s=;
        b=IPtdWSrmlD8zniB/ICXC3TnGfx7ToOzXRqBl9hYtOsI/3Zo4Uxlib0kU2Ooyp7IVAs
         c6IvGWxvR61qUlgICNKpeVffgUyR8mfRNVxy7aXgopjzb5tqh9KeS8T2t0W3s1ACj7af
         +WQTIQwAcurbSkRJtgi8AhYXnvLaRXp7TtrYljP+z31HCRCMvh5e70eXaOYX5BK5BThb
         VycT8J2+TiHtpjm/VUPgRmPHACGx16jzoaGHX8ozFhuYXUFlT9xH9QlsApOz4v3xsFFf
         nvtmaL/kIun2ffUu+FS+K64d5+XDox/R4G82nYc/gktQZEEPEFKIQLhSGei3GVn0H5/y
         CUxA==
X-Gm-Message-State: APjAAAUl95V2QLplHoeYJPTVnhL8pCylJcO6Zu6OVm9uPOcgh83pir/A
        sLtod9SOzWVEmtoGbAo80PiDUmUv
X-Google-Smtp-Source: APXvYqwoyikOEMNqQ22bUMF08Cs8EF/DXfKuBul4fb4jtN3CJLjOKRYwxN/bxndgIXKm0+wV+8aZZw==
X-Received: by 2002:a17:902:4683:: with SMTP id p3mr100716846pld.31.1564392395736;
        Mon, 29 Jul 2019 02:26:35 -0700 (PDT)
Received: from etsukata.local (fs76eecbcd.tkyc008.ap.nuro.jp. [118.238.203.205])
        by smtp.gmail.com with ESMTPSA id v126sm4499626pgb.23.2019.07.29.02.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 02:26:35 -0700 (PDT)
Subject: Re: [PATCH] sched/core: Remove the unused schedule_user() function
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     tglx@linutronix.de, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
References: <20190727165513.25636-1-devel@etsukata.com>
 <20190729083039.kwamco7q6glsoo6e@e107158-lin.cambridge.arm.com>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 mQINBFydxe0BEAC2IUPqvxwzh0TS8DvqmjU+pycCq4xToLnCTy9gfmHd/mJWGykQJ7SXXFg2
 bTAp8XcITVEDvhMUc0G4l+RBYkArwkaMHO5iM4a7+Gnn6beV1CL/dk9Wu5gkThgL11bhyKmQ
 Ub1duuVkX3fN2cRW2DrHsTp+Bxd/pq5rrKAbA/LIFmF4Oipapgr69I5wUeYywpzPFuaVkoZc
 oLdAscwEvPImSOAAJN0sesBW9sBAH34P+xaW2/Mug5aNUm/K6whApeFV/qz2UuOGjzY4fbYw
 AjK1ALIK8rdeAPxvp2e1dXrj29YrIZ2DkzdR0Y9O8Lfz1Pp5aQ+pwUQzn2vWA3R45IItVtV5
 8v04N/F7rc/1OHFpgFtzgAO2M51XiIPdbSmF/WuWPsdEHWgpVW3H/I8amstfH519Xb/AOKYQ
 7a14/3EESVuqXyyfCdTVnBNRRY0qXJ7mA0oParMD8XKMOVLj6Nlvs2Zh2LjNJhUDsssKNBg+
 sMKiaeSV8dtcbH2XCc2GDKsYbrIKG3cu5nZl8xjlM3WdtdvqWpuHj6KTYBQgsXngBA7TDZWT
 /ccYyEQpUdtCqPwV0BPho6pr8Ug6J99b1KyZKd/z3iQNHYYh3Iy08wIfUHEXoFiYhMtbfKtW
 21B/27EABXMHYnvekhJkVA9E4sfGlDZypU7hWEoiGnAZLCkr2QARAQABtCNFaWljaGkgVHN1
 a2F0YSA8ZGV2ZWxAZXRzdWthdGEuY29tPokCVAQTAQgAPhYhBKeOigYiCRnByygZ7IOzEG5q
 Kr5hBQJcncXtAhsjBQkJZgGABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIOzEG5qKr5h
 UvMP/RIo3iIID+XjPPQOjX26wfLrAapgKkBF2KlenVXpEua8UUY0NV4l1l796TrMWtlRS0B1
 ikGKDcsbP4eQFLrmguaNMihr89YQzM2rwFlloSH8R3bTkub2if/5RCJj2kPXEjgwCb7tofDN
 Hz7hjZOQUYNo3yiyeED/mtJGR05+twMJzedehBHxoEFb3cWXT/aD2fsYdZzRqw74rBAdlTnD
 q0aaJJ/WOP7zSwodQLwTjTxF4WorDY31Q1EqqJun6jErHviWu7mYfSSRc4q8tzh8XfIP7WZV
 O9jB+gYTZxhbgXdxZurV3hiwHgKPgC6Q2bSP6vRgSbzNhvS+jc05JWCWMnpe8kdRyViHKIfm
 y0Kap32OwRP5x+t0y52jLryxvBfUF3xGI78Qx9f8L5l56GQlGkgBH5X2u109XvqD+aed5aPk
 mUSsvO94Mv6ABoGe3Im0nfI07oxwIp79etG1kBE9q4kGiWQ8/7Uhc2JR6a/vIceCVJDyagll
 D7UvNITbFvhsTh6KaDnZQYiGMja2FxXN6sCvjyr+hrya/sqBZPQqXzpvfBq5nLm1rAvJojqM
 7HA9742wG3GmdwogdbUrcAv6x3mpon12D0guT+4bz5LTCfFFTCBdPLv7OsQEhphsxChGsdt2
 +rFD48wXU6E8XNDcWxbGH0/tJ05ozhqyipAWNrImuQINBFydxe0BEAC6RXbHZqOo8+AL/smo
 2ft3vqoaE3Za3XHRzNEkLPXCDNjeUKq3/APd9/yVKN6pdkQHdwvOaTu7wwCyc/sgQn8toN1g
 tVTYltW9AbqluHDkzTpsQ+KQUTNVBFtcTM4sMQlEscVds4AcJFlc+LRpcKdVBWHD0BZiZEKM
 /yojmJNN9nr+rp1bkfTnSes8tquUU3JSKLJ01IUlxVMtHPRTT/RBRkujSOCk0wcXh1DmWmgs
 y9qxLtbV8dIh2e8TQIxb3wgTeOEJYhLkFcVoEYPUajHNyNork5fpHNEBoWGIY9VqsA38BNH6
 TZLQjA/6ERvjzDXm+lY7L11ErKpqbHkajliL/J/bYqIebKaQNCO14iT62qsYh/hWTPsEEK5S
 m8T92IDapRCge/hQMuWOzpVyp3ubN0M98PC9MF+tYXQg3kuNoEa/8isArhuv/kQWD0odW4aH
 3VaUufI+Gy5YmjRQckSHrG5sTTnh13EI5coVIo+HFLBSRBqTkrRjfcnPHvDamcteuzKFkk+m
 uGO4xa6/vacR8cZB/GJ7bLJqNdaJSVDDXc+UYXiN1AITMtUYQoP6fEtw1tKjVbv3gc52kHG6
 Q71FFJU0f08/S3VnyCCjQMy4alQVan3DSjykYNC8ND0lovMtgmSCf4PmGlxCbninP5OU+4y3
 MRo74kGnhqpc9/djiQARAQABiQI8BBgBCAAmFiEEp46KBiIJGcHLKBnsg7MQbmoqvmEFAlyd
 xe0CGwwFCQlmAYAACgkQg7MQbmoqvmGAUA/+P1OdZ6bAnodkAuFmR9h3Tyl+29X5tQ6CCQfp
 RRMqn9y7e1s2Sq5lBKS85YPZpLJ0mkk9CovJb6pVxU2fv5VfL1XMKGmnaD9RGTgsxSoRsRtc
 kB+sdbi5YDsjqOd4NfHvHDpPLcB6dW0BAC3tUOKClMmIFy2RZGz5r/6sWwoDWzJE0YTe63ig
 h64atJYiVqPo4Bt928xC/WEmgWiYoG+TqTFqaK3RbbgNCyyEEW6eJhmKQh1gP0Y9udnjFoaB
 oJGweB++KV1u6eDqjgCmrN603ZIg1Jo2cmJoQK59SNHy/C+g462NF5OTO/hGEYJMRMH+Fmi2
 LyGDIRHkhnZxS12suGxka1Gll0tNyOXA88T2Z9wjOsSHxenGTDv2kP5uNDw+gCZynBvKMnW4
 8rI3fWjNe5s1rK9a/z/K3Bhk/ojDEJHSeXEr3siS2/6E4UhDNXd/ZGZi5fRI2lo8Cp+oTS0Q
 m6FIxqnoPWVCsi1XJdSSQtTMxU0qesAjRXTPE76lMdUQkYZ/Ux1rbzYAgWFatvx4aUntR+1N
 2aCDuAIID8CNIhx40fGfdxVa4Rf7vfZ1e7/mK5lDZVnWwTOJFNouvlILKLcDPNO51R5XKsc1
 zxZwI+P1sTpSBI/KtFfphfaN93H3dLiy26D1P8ShFz6IEfTgK4OVWhqCaOe9oTXTwwNzBQ4=
Message-ID: <45747e8a-7296-2988-5c19-c6cb4cb5334b@etsukata.com>
Date:   Mon, 29 Jul 2019 18:26:32 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729083039.kwamco7q6glsoo6e@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/07/29 17:30, Qais Yousef wrote:
> On 07/28/19 01:55, Eiichi Tsukata wrote:
>> Since commit 02bc7768fe44 ("x86/asm/entry/64: Migrate error and IRQ exit
>> work to C and remove old assembly code"), it's no longer used.
> 
> It seems to me that powerpc and sparc are still using it?
> 
> $ git grep SCHEDULE_USER
> arch/powerpc/include/asm/context_tracking.h:#define SCHEDULE_USER bl    schedule_user
> arch/powerpc/include/asm/context_tracking.h:#define SCHEDULE_USER bl    schedule
> arch/powerpc/kernel/entry_64.S: SCHEDULE_USER
> arch/sparc/kernel/rtrap_64.S:# define SCHEDULE_USER schedule_user
> arch/sparc/kernel/rtrap_64.S:# define SCHEDULE_USER schedule
> arch/sparc/kernel/rtrap_64.S:           call                    SCHEDULE_USER
> 
> Cheers
> 
> --
> Qais Yousef
> 

Sorry, I misused cscope. The function is still used as you say.

Thanks

Eiichi
