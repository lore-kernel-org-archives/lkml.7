Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305D7C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1A72183F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beqB2zJv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfDTM2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:28:32 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35828 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfDTM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:28:32 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so3760086plp.2;
        Sat, 20 Apr 2019 05:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WkfhWDKqFomaa6wxQ2Ft8GRHbvQJRT/WkoJZGmXUAqk=;
        b=beqB2zJvds5eLtIZGDVvyD3sPhVZE5X0QvE1IRtBnsdpeijIALXJ4HsorD30BaxkG7
         kWQzhaHbFi7YtWz+dpW/7CeuyGGjNBrIwiNKAOKtUUGyHftNC2vcwwCrMcgLZ1wkAP47
         AmryxUC47IFYyjNfaoWwwon39CFTLcT3TiBPvgKqI2yHl3M9uhKVdZFMYpITc38wPezq
         oqHz/pVDdkoBtOlEFkwLaBvXDH3uZWaca+cszR5dGEJUGyE+np237leEeB1D1cMn/+9a
         P2YmUbyts32gRQlV/47wZkVNvMNNs1MGV3aolVre2w1hoiOMCjtc5sgMjZMDtoEjpvfD
         12jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WkfhWDKqFomaa6wxQ2Ft8GRHbvQJRT/WkoJZGmXUAqk=;
        b=XyoVnWMnFhaO+O33RnX83P+XiZ3t/EmYKOvWBhqpqpvULBfI2M3gltcc4AUdasEJ5n
         s/26aRX0g9vzzG8mXLmnoYR38eVENwiHRSQayjJ+7WyezZeDE2hjtROhYYPpZgxb+Iu9
         Te0VEZSP5WN6iTY3em/w0AGcgOa9WyZPYCSZvsKZwaNoUdweYHc8LCvdIPv1CNKQw31f
         Mj5OR3yCHXfPq0SQTirVthlUKv021YYPMb3GIXf+o3Sx+u5K5gQ3LRleKLVU1RV3Z0+k
         6jpIMii7YSrtr/T20wUOzcCgzZLPWRWSoC+lcNZkZh6qHMX7eoeDZALvHKHDA4bywmyU
         lpyQ==
X-Gm-Message-State: APjAAAVEoX6gOAzj8WrkV7jUCkd9CVi3MIdo7Bls1XpL3toN1ehuYnkk
        yvC/kZEd2RVMO4QD5Tm1w5M=
X-Google-Smtp-Source: APXvYqxoE0B8kiGnj1jGvp4fWfb6SKZGf4W59ptiqgr2YLlIiycZyYQ4LMbMobIReQS3BrKrMoIQ5g==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr9213560plt.59.1555763311972;
        Sat, 20 Apr 2019 05:28:31 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.32])
        by smtp.gmail.com with ESMTPSA id w21sm10087265pfn.48.2019.04.20.05.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 05:28:31 -0700 (PDT)
Date:   Sat, 20 Apr 2019 17:58:23 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190420122823.GB18303@bharath12345-Inspiron-5559>
References: <20190418160436.781762249@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built and booted on my x86 machine.
Observed no dmesg regressions.
