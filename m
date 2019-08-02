Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358C421773
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DPV0TMNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbfHBJ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:26:25 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:46789 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730881AbfHBJ0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:26:24 -0400
Received: by mail-wr1-f52.google.com with SMTP id z1so76418182wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=qhrlOJ2JM4o+i+Qmz94W6ZJfxQ+QxCzhzVh/WMOBHD8=;
        b=DPV0TMNIGP+dn31KaFIVyjWR7xjvq11adkL8AFnvyuiarba1hsyFcForhFCDi2k1uu
         nU8hd3kwVXSZn1JJ0COsa8bIVq5VjzGjpNvIblO5qS/fUWEpAgJnkg9TiN1/xLFGHpN0
         VqoV3bXPqo3WsuBzmElotp0RVler2IAaYPu1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=qhrlOJ2JM4o+i+Qmz94W6ZJfxQ+QxCzhzVh/WMOBHD8=;
        b=POweXn28fqQUfnGz+f9URQ/UFxY3pGpwun2k7HAHV1pW/1PbtrHD5kiVrX11ECwMHv
         pf6una7iiOUbFY/1l0HtQ2KTHxd5Zl5l6oc7jPDnOUxCr2Cj+TsPVStKKIqlSoLhJCdD
         BY721xWE7SBAghb6cw+tanGMDRwA3sHuIUPSe27RaEnI8umPJK0mEgqsHmyRkVFzyj2C
         xd+ZK9ALnuRvUMRQ1E/JskfWkzvYOiNJ6/pTOYkpAk7cRUpfvKzIdYXHG5Ym8Hb5Fq69
         1q/qofsPUBT4hB9TFlFavCQXDfn0urSBU3rgsUkilCnfFF6/W8ZyFV/Kfkdc0b7K5Bsx
         IJyA==
X-Gm-Message-State: APjAAAXetEN+oRemzw3Mdm3OZfvjOxZuJYNm3NpBq2yLbqujSwn7s4lR
        U7Ks+6Vrf1RqQYAjHAgq1wU0cZwwENMLCQ==
X-Google-Smtp-Source: APXvYqwGwZ0VocLa/XZEhbbscLUKhSQpVrSnkUqTkyidP3sq0h/jBqG+vUTf2i+Pf3pVB1PBRh/Vlg==
X-Received: by 2002:adf:fdcc:: with SMTP id i12mr25246427wrs.88.1564737982495;
        Fri, 02 Aug 2019 02:26:22 -0700 (PDT)
Received: from [10.230.40.234] ([192.19.215.250])
        by smtp.gmail.com with ESMTPSA id y16sm78599834wrw.33.2019.08.02.02.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 02:26:21 -0700 (PDT)
To:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: [BUILD REGRESSION] building single .ko not working in 5.3-rc1
Message-ID: <9c4425f0-3428-214b-a4f2-237bbae2f495@broadcom.com>
Date:   Fri, 2 Aug 2019 11:26:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In previous kernel versions I could do:

make M=net/wireless cfg80211.ko

However, in 5.3-rc1 I now get:

$ make M=net/wireless cfg80211.ko
make[1]: *** No rule to make target `cfg80211.ko'.  Stop.
make: *** [sub-make] Error 2

The 'modules' target is working, but sometimes there are multiple 
modules and I only want to build just one explicitly. Can this option be 
restored?

Regards,
Arend
