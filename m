Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5B0C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B255821743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPmTsZp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGQTXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:23:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41138 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQTXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:23:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so22834958wrm.8;
        Wed, 17 Jul 2019 12:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hpiHEYRlEZt2w2GskvrVYxcc+tHMIKoKWapwH8cdvaQ=;
        b=MPmTsZp8AQDDmm50N28AG4ztujxsCscr4B7Z5Lfh9pkI+Yk8L5YFB1wwkM1OWwjlj1
         DJx0yTpEHTHSdRTdCgMSpoaY/w5rFKS2JrIaRhWy7+vSIE3RJRfYPJFwfAtmlZUI/vrj
         TDHF0CVLt6RVaVsBsDpCkAyJLUODD6F9Cu4c4GrVFN2PJONl6VFejlxASLZyBp76VnC4
         P4VV0Sxc8Z0Qs6nGbHbF/6QNoI2ITSKx2MR42RM4OEiOH9JNu2gp7FW5piY1LG37WDqm
         y8K09oWMnsiZwfE0vsx9w9HVZA4r1fBDeaHnU4tu7bZNLc0CO3Igs/F66whg03p7yZFe
         HSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hpiHEYRlEZt2w2GskvrVYxcc+tHMIKoKWapwH8cdvaQ=;
        b=RpNkYh30YIjtS+8V0cayM0kRnqnfPgp5rvceYPvTmpnHLW+1Hn12ymN7oVmcXRjUA5
         LHWTbiQsc3WEUeucyHekkf+IPsrn1swoskjQibsGx2R0SzmxbLofpoNMAbWwVtlUWNFp
         vmC4rhEBmZuR23tTtF8u1hl5mJfPE5nEKJQy9QCVK8izkfwGiK3ubheRx5dGGReUtOd6
         j4xGX7deT3kPDiChmj5ztnACRXo5eIdu/IOBw07J4XTvucd8TZEt5W/716UXTgtlKSTZ
         Zl2GnDP54wXHyAIR/azka8Cn0aecgKp9gOkKYe7T4snhaENJxpJUztfg6MBlo6WTwX/X
         aQOw==
X-Gm-Message-State: APjAAAUo1WhP/jrXyvbaQhddAhlOUM/J51ga5eVRnAtz9pPw0ADVdwxj
        8lGRijXdKigB1uhdW8MgTDY=
X-Google-Smtp-Source: APXvYqx9XuuAxzpmJBAlpBTixmPKp3yd+efuHgBJqJCfEOSRwAKikxD40sv7bG1uGDj/IW5F+koXjQ==
X-Received: by 2002:adf:a299:: with SMTP id s25mr37148943wra.74.1563391415864;
        Wed, 17 Jul 2019 12:23:35 -0700 (PDT)
Received: from [192.168.2.202] (pD9E5AE2D.dip0.t-ipconnect.de. [217.229.174.45])
        by smtp.gmail.com with ESMTPSA id k17sm26184463wrq.83.2019.07.17.12.23.34
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 12:23:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] input: soc_button_array for newer surface devices
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
References: <20190702003740.75970-1-luzmaximilian@gmail.com>
 <20190702003740.75970-3-luzmaximilian@gmail.com>
 <20190716072135.GA806@penguin>
 <92e13b01-7353-1430-fb38-b5098d509da2@gmail.com>
 <20190716201807.GA584@penguin>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <fbcb6b9d-01b4-43d3-a177-342d88120a4b@gmail.com>
Date:   Wed, 17 Jul 2019 21:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716201807.GA584@penguin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/19 10:18 PM, Dmitry Torokhov wrote:
> OK, fair enough. By the way, I see you are adding some #ifdef
> CONFIG_ACPI and stubbing out new functions, but the driver does not
> really work without ACPI (acpi_match_device() will fail in this case I
> would think and that will cause probe() to abort). So maybe we just add
> depends on ACPI to the driver's Kconfig entry?

Makes sense, I can change that too.

Maximilian
