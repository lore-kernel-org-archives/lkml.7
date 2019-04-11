Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA679C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34AE217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aX4LqbYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDKJ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:26:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51824 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbfDKJ0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:26:15 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so5786283wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kpnbJINvyluazTcKQdCcW284I70Jq3vMEIBiBBMPXdU=;
        b=aX4LqbYMBp94VLtKg9orbrsjSVeq96wZiSPMuxuFdMiQz7RBvQREYmiaSG54ry4WLo
         QTL2dQZGjymK7TfshdqpDeRI5a+iKGPTst+8As8/vSLTcLg5Fd3GHKBDpnqOqGTKeQab
         nLE+Ei1MG4jjx96bj81DYGX2Bv1E8uqFdx2eK3nb3l3IAidQ1OrCgYs6YCyRQbgidjoB
         HaEwjbtK/JTruzXPF9M1BP8Ipbg/Hv1tL69+X0a5hisgZT7nTpkcf+WZFx3R/ggUWNlV
         bbCbT8V21wOH+xM6FLb/fUHHL8u9k9dvsJdUSUVLAO1LsxrYrtTwiXiUyxjDrtZDWhxr
         3evg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kpnbJINvyluazTcKQdCcW284I70Jq3vMEIBiBBMPXdU=;
        b=gUxwIYd6Ig5DqrFrKbyY5dqH/8pOx7WjNKuwNOr7Df5ni6P7iPEWhDTB8k66zARNuG
         L1AghUCeDj3MOJKGdqH9eCrwut3UExrCTj0LrhGVke91yzpruR4XtbcU0wOtohG4SSfi
         tVqRVpd4PfI2Cxb7OD7NoTq+ri4YZk9k3a6NLUQ3crYvCs9y0JvrWl77VN7PnF6VYEs4
         8PWEQdBifJ3YxLpGDAhp/oW4lTTdfTNu2pDMbsfUQiKCvEEwpbmAZphpex+TIYccwYCM
         rjTDPZwPc2sm212oi+F0IC9oK50gh/YL2G3w2MAqsQCOdzQzQuWMkMpxXn114dSpDicG
         S9VQ==
X-Gm-Message-State: APjAAAWgCq1gvbFFi9iUyRV55tqibi5Q3tgsYKRvYelVwqNq0u10/1Zq
        QNZllfhRQNwhHz5L09n4nnzcX6kHPKE=
X-Google-Smtp-Source: APXvYqx67gAh/TEkLLb5KC+EcWdezIO2ThofCVR0v6Qc0Cx9k8I8ZpY4tXYsIxSYvhL/U/SvFYt1rQ==
X-Received: by 2002:a7b:c769:: with SMTP id x9mr6119503wmk.103.1554974773791;
        Thu, 11 Apr 2019 02:26:13 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b63:dc30:189d:a40c:e37a:dfea? ([2a01:e35:8b63:dc30:189d:a40c:e37a:dfea])
        by smtp.gmail.com with ESMTPSA id g19sm4111075wmh.17.2019.04.11.02.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:26:13 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH linux] objtool: fix pkg-config query in case of
 cross-compilation
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        yamada.masahiro@socionext.com, peterz@infradead.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411083940.3911-1-nicolas.dichtel@6wind.com>
 <4208204.4d101oJ1v5@devpool35>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <cc009072-64d4-4be3-0bb2-20be4d5c357f@6wind.com>
Date:   Thu, 11 Apr 2019 11:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4208204.4d101oJ1v5@devpool35>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 11/04/2019 à 10:52, Rolf Eike Beer a écrit :
> Am Donnerstag, 11. April 2019, 10:39:40 CEST schrieb Nicolas Dichtel:
>> In case of cross-compilation, there may be two pkg-config tools, one for
>> the host and one for the target. Enable to override the default name.
>>
>> Fixes: 056d28d135bc ("objtool: Query pkg-config for libelf location")
>> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> If you do that, you have to fix a lot of other places, too. This starts in 
> scripts/kconfig/ and also includes e.g. tools/testing/.
> 
> Usually you have pkg-config for host and ${target_platform}-pkg-config for the 
My use case was for buildroot, which define pkg-config and host-pkgconf. In
fact, I've just seen that a buildroot patch was accepted for this problem:
https://patchwork.ozlabs.org/patch/1081379/


Regards,
Nicolas
