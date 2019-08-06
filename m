Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43990C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15537206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 05:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdeC0FJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbfHFFtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 01:49:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42837 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfHFFtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 01:49:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so40854443pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 22:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uvYE7nrJnBQlmcbxz3H63UPfE8YRBopt5KIB26DSah4=;
        b=NdeC0FJH9+Hlx0praiF0UKs2uENSLKhRuLYYPX5PWUvTVIB3Kt9PHiuuJbUB9agSfS
         BE1i+l1rxxWnrkOR6KarFJVJnta5e6gU0nStxUDXtmZmbwLgCH6adUL+JQ8alHYc13Dq
         IdDs0knZ5ETE6HwNep8raP4YAakd+Ux7SSpT65lyVmgsBvOKDxF6PLbc2t4qnG7pFx/k
         mvRWC94RieljBIKN8ejTcNfhdoHO1NTsu+lXwK5QtsLD7hvmC1zjd6Wls+NAg/fl/Nhj
         T6z9FvjfZEg2wj4Jg63I0cmGGZlaQNWJ/LJqVcq+wRlHr4rMSfWk805XiXT9E6dP7ZSh
         4Pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uvYE7nrJnBQlmcbxz3H63UPfE8YRBopt5KIB26DSah4=;
        b=N1bz7BxZYK43McUdh2PY30s50TzNKg+rUzS+tXMgW1Qu8TI+bEzs/A4zOTUTHtAZXL
         2x2MxHlENixsOQa98rwY3gJW4IKgqNEwbuJ6qs5cqzuzGIi+kp8r6uXQi9vwsg15ibRB
         eKZGo1YmZV6/lsNkPRtFPmTjZ6O23McDiJQL4sHbb0yNflXIHsmEAWuJORcplQ1tJvkJ
         0/j7w5e3imBVjHCneGc578ALJ5NPXus5RMF4ap3l/1KKOeLQlqyRbPFlFRCR6sN9pfbI
         aIsqmGt9UWCiBAY3SDUuY8fZkibQeAJhGeDulA1edmyVEUjy74Ha95Va6Q9qupJRDq2i
         MBnQ==
X-Gm-Message-State: APjAAAU+zlb8ICit/tV4irIV9Wm+j/3X0b/3ljZ8kFqVL4BWeKK04TV+
        FqAIETo3S89kKdpjDoc5yMs=
X-Google-Smtp-Source: APXvYqwP9PSzizaUfPFnptDdZml03za3TGNcWXCtkReNEzyNCPM6ATqKcupvDjBhdpOmHah/zcefag==
X-Received: by 2002:a17:90a:384d:: with SMTP id l13mr1425752pjf.86.1565070574630;
        Mon, 05 Aug 2019 22:49:34 -0700 (PDT)
Received: from [192.168.1.2] ([171.61.30.136])
        by smtp.gmail.com with ESMTPSA id x14sm106764131pfq.158.2019.08.05.22.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 22:49:33 -0700 (PDT)
Subject: Re: [PATCH] ARC: unwind: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190805193232.GA12826@embeddedor>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; prefer-encrypt=mutual; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQ
Message-ID: <8516c7c5-bd70-38a9-0583-225689e9e1aa@gmail.com>
Date:   Tue, 6 Aug 2019 11:19:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805193232.GA12826@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/19 1:02 AM, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings (Building: haps_hs_defconfig arc):
> 
> arch/arc/kernel/unwind.c:827:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
> arch/arc/kernel/unwind.c:836:20: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thx for the patch, applied to arc for-curr.

-Vineet
