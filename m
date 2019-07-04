Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5164C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7616F218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfGDQbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:31:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43975 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfGDQbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:31:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so5889743edr.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 09:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n8kTCu25pTvc0Y2/fueBvYl5zxx1RQ2B+7nWqH2z7y8=;
        b=kqdNs4NPrkQZq2OYpfG4yGuxedc0gaUiLwXa58tTZQsXPeM7rXuvwsQYAae1/UMfmV
         D2dXclmOK0VGpnu+vbABUWlHYYbzKz3UG2nbZnA/g0Ql4t2/2o7nEIFPnNQs32CwXQW+
         tuOSH/C2zF3R1NhtIVU9NfG2WYqlVzV/LkpguM1C0MVim+9hsnuO7rWIy9/S50ma+JTw
         kxH3Gvuxa0fnOyk1zTQ5X5zVmLxOsi3DRrf/V1jvZfda/8JSPeDJ7LbymLcaA6/8sLzt
         M1IIOY8KfPLC8/g2rFs3wWsT37V1Oz2JRtGUEKRvkX8HpEI/d6a0k+3lORlftaLu3XF6
         SWJA==
X-Gm-Message-State: APjAAAXi5MyahtenZNk/eSPnsH5YQ/Ykj0HApkDoGfnWk6E7cXOdZKAN
        gkrstwr1qc0+0rLcAUDhNoVYICpP
X-Google-Smtp-Source: APXvYqw5vrckgTsSLFHHFv8WQnOVuCrCrmbp8zL3LEAjsFdeezIsagW27b8YRIBS2j0URbgzhDiCEA==
X-Received: by 2002:a50:ad0c:: with SMTP id y12mr48995203edc.25.1562257892139;
        Thu, 04 Jul 2019 09:31:32 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id k51sm1822865edb.7.2019.07.04.09.31.31
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 09:31:31 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH] drm/client: remove the exporting of drm_client_close
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190703170150.32548-1-efremov@linux.com>
 <CACvgo52N5v07qA_afJfw7vo1X6_Gt4cGqBZn3eBzQtokndjWxA@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <86ae7f09-bd79-b621-706c-0a7bff304aba@linux.com>
Date:   Thu, 4 Jul 2019 19:31:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CACvgo52N5v07qA_afJfw7vo1X6_Gt4cGqBZn3eBzQtokndjWxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Out of curiosity: Did you use some tool to spot this?
> 

Just regular expressions:
https://github.com/evdenis/export_checking

But it's not very reliable because of false positives. I think I can try
to implement this kind of check as a part of modpost in addition to
CONFIG_DEBUG_SECTION_MISMATCH.

Denis
