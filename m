Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D33C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28323206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 11:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItWbbzGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbfFTLxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 07:53:38 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46414 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfFTLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 07:53:38 -0400
Received: by mail-wr1-f45.google.com with SMTP id n4so2674993wrw.13;
        Thu, 20 Jun 2019 04:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DzXIFr4xpMaoqcvmMD6Y3L9RwZI57+sATCLsoy+cRzg=;
        b=ItWbbzGzt127AnUo3b1QNKeHcVzCyxNoczZr6Po8pGkGXeKKRdVSizZl+milvkrIJw
         zAIBfCtEV0zH0JUA31aNSEeiKoSCp/QU33wWM82AO6Kw9ZOMuFA1ZxvM33L4LbavwNQq
         qm6vz9spXht8Bvfq1X4E8CHwO8MDerp1do+GPrf6G5ybCNLoleXNqCWrZPaZScUOCvxX
         5tEO/duFkHWIRESjY3mbtN9Oyn48SjxmIzrPlGq6dkXlSKgNThNhOVxvYRGbMOzSbObb
         kNtxX425jVKmoWYjZ2fLprRc67Xp9D44aAtdl5Z2fZcluwZGuUvcOXnIRBGKDt3TYCL9
         MO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DzXIFr4xpMaoqcvmMD6Y3L9RwZI57+sATCLsoy+cRzg=;
        b=gm/2mI66OmV25qu+viszEYE+4673PFlUhulUKzjl0rFB1hydQHLR5/vKvCIEr9sJDA
         ceAdECxEqiium4Th5WxeVStcRzcNZQqKWuO5xGlIGK0oNN0Qsr4WO28jdrijTGfzBgX9
         DcoJ49Lles/rcn9gOm9bb0+gcXVGl93Ihho1wgJO96zmtuf2UfCjTM3Yer65Wckgbwb2
         7E5Bh4BMpazh1DDtm0LDOU0YNwZUhbbjw39QlewNjVLvjJGPOXHYc9b7u2xXbmvZ+RlJ
         Bq7ordMRaUCrPVzmfISiNi2YPFseo2FHwHKFBx3AJW4wWzFkonVxK8LbNRHDA0UClRCH
         JwKA==
X-Gm-Message-State: APjAAAW9swPTtMWRRMaJEpbPP7HQBjClY+bnMv4HF/zBruGlg3jIax5i
        G90F4LMjrbgbE3M68uNWKL4=
X-Google-Smtp-Source: APXvYqyz3gfr76cwBWbLPTdPXD9DBLN+xaYaNgSvrBZCTiwWDNH9/zGlwG37VfGWnrLpqpxW2Ro2/A==
X-Received: by 2002:adf:f050:: with SMTP id t16mr72562715wro.99.1561031616401;
        Thu, 20 Jun 2019 04:53:36 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5A621.dip0.t-ipconnect.de. [217.229.166.33])
        by smtp.gmail.com with ESMTPSA id j32sm17707632wrj.43.2019.06.20.04.53.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 04:53:35 -0700 (PDT)
Subject: Re: [RFC 0/2] Support for buttons on newer MS Surface devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
References: <20190516142523.117978-1-luzmaximilian@gmail.com>
 <a0f93af3-c587-40d5-2a85-fdc0f9e6b79f@gmail.com>
 <e8bb212c-9894-d244-4ee1-617df3952a53@gmail.com>
 <CAHp75Vcf79a2_3VGfju237omDjmnhCYN18u+=m_n-tjxZUxt4A@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <c573b2ff-c323-677a-5ead-d696eb755f1d@gmail.com>
Date:   Thu, 20 Jun 2019 13:53:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcf79a2_3VGfju237omDjmnhCYN18u+=m_n-tjxZUxt4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/19 7:53 AM, Andy Shevchenko wrote:
> No top post, please.

Sorry, will do better!

> And yes, submit it as a series. Also Cc to Benjamin Tissoires.

Done.

Thank you,
Maximilian
