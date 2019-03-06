Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78858C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA622075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTDpQbfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfCFDOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:14:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38665 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfCFDOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:14:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so7142363pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 19:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZx3LPVRYeDN5lTmlindAbMPgNL5491ibVRuhSiXMNY=;
        b=DTDpQbfgbpDWxQ060i05QhSyxl8wezoI40+M3EHG13SJDv2wajZ8tAgrOO97Vmn7gY
         v7RFwNrJ8cjvHOiuErbmIOxUWvQaWJ2lF0bo5K23/GzXlV1DohUVGxtZkVVtHLPhHrCk
         8+6OqB9z+IW7Qq5G2UseQsQb5yF0A6/K3/cIO6qiYpEPvpkYEmoeaEVwEyqsKnJrRCfh
         G6yvfnXLY92IyQETKpnqrv3hOK7z05jC2qNoj8SjCnq3lU0fXt6gKWS/VgpE+GnzXedH
         un059h+NgWI2aRmIk5B+x0EwZzPrUVfrT64dSnn13ZE/UBge0/hviJWtefd4SzcluZXm
         DKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zZx3LPVRYeDN5lTmlindAbMPgNL5491ibVRuhSiXMNY=;
        b=F4szum+1pPhTDq7idVZAk84nx6rUhSWfhHVn3bLdhJUbqMjveWn67kjnwH7Bn1qFZ8
         Z4OqP+l0jqvOsShne+iIhj3kbKyF78jp4+/ulN/KSDOE5mLNoZMT9oFhJJiyCysGCwH9
         t2jt1uDttUQ5wN4ltUBCaX7XeNVaYl9SBaOvo1kPPSRB92Dj/+XeOK0KuGXFVDtLY07N
         AddRmiVend9nsXJkVvTDHZGCrU1WtAXGw7+IZ73ZrXJQ5W9xSBk6NNB4LZ9HxbEkjKJn
         t/Pq7wsQkx4ZIUtdWTYvuF62aZCqXfrrzYoAXuXZspFXAGD+nvrvwge4fUiZccdNIraB
         mlLg==
X-Gm-Message-State: APjAAAUbbRRQ/k39nWGNQXelD1xY1876rksux8mMi3Wwj+qfdwEO0yUZ
        GF8Pcennc1VWjKsg0drUF+4=
X-Google-Smtp-Source: APXvYqzH2HnJgkWhUqiMJdWs0caxZN+R5RsLXt/KTz9ykezNqAe07kslsBmow0RaQKAbmiFNI+EVBg==
X-Received: by 2002:a62:1382:: with SMTP id 2mr4991645pft.157.1551842058129;
        Tue, 05 Mar 2019 19:14:18 -0800 (PST)
Received: from [10.230.28.107] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v186sm610299pfv.184.2019.03.05.19.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 19:14:16 -0800 (PST)
Subject: Re: [PATCH 1/4] ARM: brcmstb: fix a leaked reference by adding
 missing of_node_put
To:     Wen Yang <wen.yang99@zte.com.cn>, linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <140acf36-21df-bdc3-5ad2-b934e521554b@gmail.com>
Date:   Tue, 5 Mar 2019 19:14:18 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2019 3:32 AM, Wen Yang wrote:
> The call to of_get_next_child returns a node pointer with refcount
> incremented thus it must be explicitly decremented after the last
> usage.
> 
> Detected by coccinelle with the following warnings:
> ./arch/arm/mach-bcm/platsmp-brcmstb.c:337:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 329, but without a corresponding object release within this function.
> ./arch/arm/mach-bcm/platsmp-brcmstb.c:341:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 329, but without a corresponding object release within this functio
> ./arch/arm/mach-bcm/bcm63xx_smp.c:150:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.


I would actually lump that in your [PATCH v2 02/15] ARM: bcm: fix a
leaked reference by adding missing of_node_put patch since the subject
of that one is correct.

Thanks!
-- 
Florian
