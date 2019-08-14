Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DACC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478E8208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUrbF4Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfHNJDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:03:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36854 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfHNJDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:03:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id g4so3965665plo.3;
        Wed, 14 Aug 2019 02:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+xayDP2oypqDVXTm/RH82wgRTkmtKwwjJXMVRTlgmYg=;
        b=AUrbF4GxYP1s1KQrRCOaA8ks7gKQwS1xC10NQXqkVLagBjt5EQcwJgZVd3GlZktdGn
         P06ovTLVoEmSDD6+Eoh6Cp9+vlFkxjBhfDN3hjECcKw/W9aF2wn4gXcti9vSpiAzqZkb
         E1+W+AoxiB8w/g0St/9i/lORg0LE32jIclhkdtzj9/uHsq0rJuVUATlHiGozXirQ7uIm
         47FvGgq1mQ8FuyPClAxm6QzMvmFjmyFvjhj1eXt5LZblicwly4thclRRocrGPmBgJYOf
         hzbEWJU4fZSe5peZTXX5k8OgEwYumZxq2ka8F20LQcvToi3SIOea4+ptiwmfB9ifQ79/
         j7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+xayDP2oypqDVXTm/RH82wgRTkmtKwwjJXMVRTlgmYg=;
        b=TNVCNJFQ8zRvwlOsseY2wSfFCaO3kfOyieHn83pewjRV+/VyPLuC9q8xc3WP8j1M6v
         gUJKI3cC45Stk61ImSEGZ66J7dWC2Ta3A0m4CaYV69fd7LIZLB/uGqzZrk4NDjH7MDHJ
         O4wbbmImdFrpQrVuRCE7XmRVmR63EG1R2xUNHTWkgRvE6q+dR4Lf17klf/2HJem2QZpT
         0UZLRdzuyNMCx/imOFHdPCgDzLXFZdMylUqVtu0og/GNorr0tUUHg6RGhDSQXvBL4aV7
         SXCjogOmEckhLIFWoNfARgTEIgFm9kVTo5xg/pKf3mSe5xhIDFpEVP3nRrexHdQ8n9CD
         RcBw==
X-Gm-Message-State: APjAAAUcxwt/br/ZPDgpGxzF8mXJcfJeJlUwRTWJiQYbQ6XO0gEBqU9O
        Afyy/v9ikSNvPrkWOutfe3BKzhuVCD/TbQ==
X-Google-Smtp-Source: APXvYqwkDH7HjHvSzr/Gy4L3yRkRgLxGCrIVojIgFFlPYrKL0oB+Qcqvd0VeMJpiLf+z/Fof8EZleQ==
X-Received: by 2002:a17:902:8d91:: with SMTP id v17mr23960022plo.88.1565773387060;
        Wed, 14 Aug 2019 02:03:07 -0700 (PDT)
Received: from [192.168.68.119] (203-219-253-117.static.tpgi.com.au. [203.219.253.117])
        by smtp.gmail.com with ESMTPSA id j6sm10350514pjd.19.2019.08.14.02.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 02:03:06 -0700 (PDT)
Subject: Re: [PATCH v9 1/7] powerpc/mce: Schedule work from irq_work
To:     Santosh Sivaraj <santosh@fossix.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        christophe leroy <christophe.leroy@c-s.fr>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        stable@vger.kernel.org
References: <20190812092236.16648-1-santosh@fossix.org>
 <20190812092236.16648-2-santosh@fossix.org>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <f82b6fb7-23a9-7400-6c29-74701455a8dc@gmail.com>
Date:   Wed, 14 Aug 2019 19:02:56 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812092236.16648-2-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/19 7:22 pm, Santosh Sivaraj wrote:
> schedule_work() cannot be called from MCE exception context as MCE can
> interrupt even in interrupt disabled context.
> 
> fixes: 733e4a4c ("powerpc/mce: hookup memory_failure for UE errors")
> Suggested-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
> Cc: stable@vger.kernel.org # v4.15+
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
